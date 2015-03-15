// UI automation tests for KJTipCalculator

UIALogger.logDebug("Start script")

function assertEqual(value1, value2, description) {
    if (value1 !== value2) {
        throw new Error("Assertion failed: " + description + "; " + value1 + " != " + value2)
    }
}

var target = UIATarget.localTarget()
var app = target.frontMostApp()
var window = app.mainWindow()

if (true) window.logElementTree()

var checkSubtotal = window.textFields()["Check subtotal"]
var tipPercentage = window.textFields()["Tip percentage"]
var numberInParty = window.textFields()["Number in party"]
var clearButton = window.buttons()["Clear"]
var tip = window.staticTexts()["Tip"]
var total = window.staticTexts()["Total"]
var perPerson = window.staticTexts()["Per person"]

// Define test cases
var testCases = [{
    name: "Basic test",
    test: function(name) {
        checkSubtotal.setValue(1000)
        tipPercentage.setValue(18)
        numberInParty.setValue(4)

        assertEqual("180.00", tip.value(), "calculated tip")
        assertEqual("1180.00", total.value(), "calculated total")
        assertEqual("295.00", perPerson.value(), "calculated split")

        UIALogger.logPass(name)
    }
}, {
    name: "Test Clear button",
    test: function(name) {
        checkSubtotal.setValue(999)
        clearButton.tap()

        // Need a short pause before values are updated
        target.delay(0.1)

        assertEqual("Price", checkSubtotal.value(), "subtotal should be empty, so value is placeholder")
        assertEqual("", tip.value(), "tip should be empty")
        assertEqual("", total.value(), "total should be empty")
        assertEqual("", perPerson.value(), "perPerson should be empty")

        UIALogger.logPass(name)
    }
}]

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