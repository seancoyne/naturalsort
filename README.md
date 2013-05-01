Natural Sorting Algorithm for ColdFusion

This CFC will allow you to perform a [natural sort](http://sourcefrog.net/projects/natsort/) on a ColdFusion array.

It was based on the [Javascript implementation](http://sourcefrog.net/projects/natsort/natcompare.js) by Kristof Coomans.

This utility uses [QuickSort](www.cflib.org/udf/QuickSort) by James Sleeman to perform the actual sort.

Example Usage:

```cfml
a = ["test11", "test1", "test2"];
sorter = new naturalsort();
sortedArray = sorter.sort(a);
```

This will result in an array in natural order, "test1", "test2", "test11" instead of "test1", "test11", "test2" as would happen with "arraySort()".

Tested on ColdFusion 9, 10 and Railo 4.0.4

To run the unit tests simply edit the Application.cfc and update the path to mxunit to match your system then run http://path/to/naturalsort/naturalsortTest.cfc?method=runTestRemote

Pull requests welcome, be sure the unit tests pass and add any new unit tests as neccessary.