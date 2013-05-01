component extends="mxunit.framework.TestCase" {
	
	public void function setup() {
		variables.naturalsort = new naturalsort();
	}

	public void function testSimple() {

		var expected = ["test1", "test2", "test3", "test11"];
		var test = ["test11", "test2", "test1", "test3"];
		var actual = variables.naturalsort.sort(test);

		assertEquals(actual, expected);

	}

	public void function testMedium() {

		var expected = ["test", "test2", "test3", "test11"];
		var test = ["test11", "test2", "test", "test3"];
		var actual = variables.naturalsort.sort(test);

		assertEquals(actual, expected);

	}

	public void function textComplex() {
		var expected = ["s01e1", "s01e02", "s01e11", "s02e03", "s03e10"];
		var test = ["s01e11", "s01e02", "s01e1", "s03e10", "s02e03"];
		var actual = variables.naturalsort.sort(test);
		assertEquals(actual, expected);
	}

	public void function testNoNumbers() {
		var expected = ["a", "b", "c", "d"];
		var test = ["c", "b", "d", "a"];
		var actual = variables.naturalsort.sort(test);

		assertEquals(actual, expected);
	}

	public void function testOneNumber() {
		var expected = ["aaron", "burt", "charlie", "chuck2", "dave"];
		var test = ["charlie", "burt", "dave", "aaron", "chuck2"];
		var actual = variables.naturalsort.sort(test);
		assertEquals(actual, expected);
	}

	public void function testDifferentString() {
		var expected = ["a10", "b1", "c3", "d2"];
		var test = ["b1", "d2", "c3", "a10"];
		var actual = variables.naturalsort.sort(test);
		assertEquals(actual, expected);
	}

	public void function testEmptyArray() {
		var expected = [];
		var test = [];
		var actual = variables.naturalsort.sort(test);
		assertEquals(actual, expected);
	}
		
	public void function testSingleItemArray() {
		var expected = ["test"];
		var test = ["test"];
		var actual = variables.naturalsort.sort(test);
		assertEquals(actual, expected);
	}

}