// UI automation tests for KJTipCalculator

function assertEqual(value1, value2, description) {
    if (value1 !== value2) {
        throw new Error("Assertion failed: " + description + "; " + value1 + " != " + value2)
    }
}

var target = UIATarget.localTarget()
var app = target.frontMostApp()
var window = app.mainWindow()

// window.logElementTree()

var textFields = window.textFields()
var buttons = window.buttons()
var staticTexts = window.staticTexts()

var checkSubtotal = textFields["Check subtotal"]
var tipPercentage = textFields["Tip percentage"]
var numberInParty = textFields["Number in party"]
var clearButton = buttons["Clear"]
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

        // Need a short pause before text values are updated
        target.delay(0.1)

        assertEqual("Price", checkSubtotal.value(), "subtotal should be empty, so its value is placeholder text")
        assertEqual("", tip.value(), "tip should be empty")
        assertEqual("", total.value(), "total should be empty")
        assertEqual("", perPerson.value(), "perPerson should be empty")

        UIALogger.logPass(name)
    }
}, {
    name: "Test 1000/18/4",
    test: function(name) {
        checkSubtotal.setValue("1000")
        tipPercentage.setValue("18")
        numberInParty.setValue("4")

        assertEqual("180.00", tip.value(), "calculated tip")
        assertEqual("1180.00", total.value(), "calculated total")
        assertEqual("295.00", perPerson.value(), "calculated split")

        UIALogger.logPass(name)
    }
}, {
    name: "Test 12.34/15/2",
    test: function(name) {
        checkSubtotal.setValue("12.34")
        tipPercentage.setValue(15)
        numberInParty.setValue(2)

        assertEqual("1.85", tip.value(), "calculated tip")
        assertEqual("14.19", total.value(), "calculated total")
        assertEqual("7.10", perPerson.value(), "calculated split")

        UIALogger.logPass(name)
    }
}];

// Run all the test cases
for (var i = 0; i < testCases.length; ++i) {
    var testCase = testCases[i]
    var name = testCase.name
    UIALogger.logStart(name)
    try {
        testCase.test(name)
    } catch (error) {
        UIALogger.logFail(error.message)
    }
}