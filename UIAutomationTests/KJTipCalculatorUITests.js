// UI automation tests for KJTipCalculator

var target = UIATarget.localTarget()
var app = target.frontMostApp()
var window = app.mainWindow()

// window.logElementTree()

var textFields = window.textFields()
var checkSubtotal = textFields["Check subtotal"]
var tipPercentage = textFields["Tip percentage"]
var numberInParty = textFields["Number in party"]

var buttons = window.buttons()
var clearButton = buttons["Clear"]

var staticTexts = window.staticTexts()
var tip = staticTexts["Tip"]
var total = staticTexts["Total"]
var perPerson = staticTexts["Per person"]

// Define test cases
//
// Each test case has a name and a test method
var testCases = [{
    name: "Test Clear",
    test: function(name) {
        checkSubtotal.setValue(999)
        target.delay(0.5)

        clearButton.tap()

        target.delay(0.1)

        assertEquals("Price", checkSubtotal.value(), "subtotal should be empty (value should be placeholder text)")
        assertEquals("", tip.value(), "tip should be empty")
        assertEquals("", total.value(), "total should be empty")
        assertEquals("", perPerson.value(), "perPerson should be empty")

        UIALogger.logPass(name)
    }
}, {
    name: "Test 1000/18/4",
    test: function(name) {
        checkSubtotal.setValue("1000")
        tipPercentage.setValue("18")
        numberInParty.setValue("4")

        target.delay(0.1)

        assertEquals("180.00", tip.value(), "calculated tip")
        assertEquals("1180.00", total.value(), "calculated total")
        assertEquals("295.00", perPerson.value(), "calculated split")

        UIALogger.logPass(name)
    }
}, {
    name: "Test 12.34/15/2",
    test: function(name) {
        checkSubtotal.setValue("12.34")
        tipPercentage.setValue(15)
        numberInParty.setValue(2)

        target.delay(0.1)
                 
        assertEquals("1.85", tip.value(), "calculated tip")
        assertEquals("14.19", total.value(), "calculated total")
        assertEquals("7.10", perPerson.value(), "calculated split")

        UIALogger.logPass(name)
    }
}];

function assertEquals(value1, value2, description) {
    if (value1 !== value2) {
        throw new Error("Assertion failed: " + description + "; " + value1 + " != " + value2)
    }
}

function doTestCase(testCase) {
    var name = testCase.name
    UIALogger.logStart(name)
    try {
        testCase.test(name)
    } catch (error) {
        UIALogger.logFail(error.message)
    }
}

// Run all the test cases
for (var i = 0; i < testCases.length; ++i) {
    doTestCase(testCases[i])
}
