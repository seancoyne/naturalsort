component {

	/*

	naturalsort.cfc -- Perform 'natural order' comparisons of strings in ColdFusion.
	Copyright (C) 2013 by Sean Coyne (sean@n42designs.com)
	http://sourcefrog.net/projects/natsort/

	Based on the Javascript version by Kristof Coomans, of which this is more or less a straight conversion.
	Copyright (C) 2005 by SCK-CEN (Belgian Nucleair Research Centre)
	Written by Kristof Coomans <kristof[dot]coomans[at]sckcen[dot]be>

	Based on the Java version by Pierre-Luc Paour, of which this is more or less a straight conversion.
	Copyright (C) 2003 by Pierre-Luc Paour <natorder@paour.com>

	The Java version was based on the C version by Martin Pool.
	Copyright (C) 2000 by Martin Pool <mbp@humbug.org.au>

	This software is provided 'as-is', without any express or implied
	warranty.  In no event will the authors be held liable for any damages
	arising from the use of this software.

	Permission is granted to anyone to use this software for any purpose,
	including commercial applications, and to alter it and redistribute it
	freely, subject to the following restrictions:

	1. The origin of this software must not be misrepresented; you must not
	claim that you wrote the original software. If you use this software
	in a product, an acknowledgment in the product documentation would be
	appreciated but is not required.
	2. Altered source versions must be plainly marked as such, and must not be
	misrepresented as being the original software.
	3. This notice may not be removed or altered from any source distribution.

	*/

	private boolean function isWhitespaceChar(required string a) {
		return asc(arguments.a) <= 32;
	}

	private boolean function isDigitChar(required string a) {
		var charCode = asc(arguments.a);
		return (charCode >= 48 && charCode <= 57);
	}

	private string function charAt(required string a, required numeric i) {
		if (arguments.i >= len(arguments.a)) {
			return "";
		}
		return arguments.a.charAt(arguments.i);
	}

	private numeric function compareRight(required string a, required string b) {
		var bias = 0;
	    var ia = 0;
	    var ib = 0;

	    // The longest run of digits wins.  That aside, the greatest
	    // value wins, but we can't know that it will until we've scanned
	    // both numbers to know that they have the same magnitude, so we
	    // remember it in BIAS.
	    while (true) {

	        var ca = charAt(a, ia);
	        var cb = charAt(b, ib);

	        if (!isDigitChar(ca) && !isDigitChar(cb)) {
	            return bias;
	        } else if (!isDigitChar(ca)) {
	            return -1;
	        } else if (!isDigitChar(cb)) {
	            return +1;
	        } else if (ca < cb) {
	            if (bias == 0) {
					bias = -1;
	            }
	        } else if (ca > cb) {
	            if (bias == 0) {
	                bias = +1;
	            }
	        } else if (ca == 0 && cb == 0) {
	            return bias;
	        }

	        ia++;
	    	ib++;
	    }
	}

	private numeric function natcompare(required string a, required string b) {
		var ia = 0;
		var ib = 0;

	    while (true) {
	        // only count the number of zeroes leading the last number compared
	        var nza = 0;
	        var nzb = 0;

	        var ca = charAt(a, ia);
	        var cb = charAt(b, ib);

	        // skip over leading spaces or zeros
	        while (len(ca) && (isWhitespaceChar(ca) || ca =='0')) {
	            if (ca == '0') {
	                nza++;
	            } else {
	                // only count consecutive zeroes
	                nza = 0;
	            }

	            ca = charAt(a, ++ia);
	        }

	        while (len(cb) && (isWhitespaceChar(cb) || cb == '0')) {
	            if (cb == '0') {
	                nzb++;
	            } else {
	                // only count consecutive zeroes
	                nzb = 0;
	            }

	            cb = charAt(b, ++ib);
	        }

	        // process run of digits
	        if (isDigitChar(ca) && isDigitChar(cb)) {
	        	var result = compareRight(a.substring(ia), b.substring(ib));
	            if (result != 0) {
	                return result;
	            }
	        }

	        if (ca == 0 && cb == 0) {
	            // The strings compare the same.  Perhaps the caller
	            // will want to call strcmp to break the tie.
	            return nza - nzb;
	        }

	        if (ca < cb) {
	            return -1;
	        } else if (ca > cb) {
	            return +1;
	        }

	        ++ia; 
	        ++ib;
	    }
	}

	public array function sort(required array arr) {
		if (arrayLen(arguments.arr) lt 2) {
			return arguments.arr;
		}
		return quickSort(arguments.arr, natcompare);
	}

	/**
	* Implementation of Hoare's Quicksort algorithm for sorting arrays of arbitrary items.
	* Slight mods by RCamden (added var for comparison).
	* Update my Mark Mandel to use List.addAll() functions.
	* 
	* @param arrayToCompare      The array to be sorted. (Required)
	* @param sorter      The comparison UDF. (Required)
	* @return Returns a sorted array. 
	* @author James Sleeman (james@innovativemedia.co.nz) 
	* @version 3, January 15, 2012 
	*/
	private array function quickSort(required array arrayToCompare, required any sorter) {
		var lesserArray  = ArrayNew(1);
		var greaterArray = ArrayNew(1);
		var pivotArray   = ArrayNew(1);
		var examine      = 2;
		var comparison = 0;

		pivotArray[1]    = arrayToCompare[1];

		if (arrayLen(arrayToCompare) LT 2) {
			return arrayToCompare;
		}

		while(examine LTE arrayLen(arrayToCompare)){
			comparison = arguments.sorter(arrayToCompare[examine], pivotArray[1]);
			switch(comparison) {
				case "-1": {
					arrayAppend(lesserArray, arrayToCompare[examine]);
					break;
				}
				case "0": {
					arrayAppend(pivotArray, arrayToCompare[examine]);
					break;
				}
				case "1": {
					arrayAppend(greaterArray, arrayToCompare[examine]);
					break;
				}
			}
			examine = examine + 1;
		}

		if (arrayLen(lesserArray)) {
			lesserArray  = quickSort(lesserArray, arguments.sorter);
		} else {
			lesserArray = arrayNew(1);
		}

		if (arrayLen(greaterArray)) {
			greaterArray = quickSort(greaterArray, arguments.sorter);
		} else {
			greaterArray = arrayNew(1);
		}

		lesserArray.addAll(pivotArray);
		lesserArray.addAll(greaterArray);

		return lesserArray;
	}
}