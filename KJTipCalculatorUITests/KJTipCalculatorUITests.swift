/*
Copyright (c) 2014, 2015, 2016 Kristopher Johnson

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import XCTest

class KJTipCalculatorUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false

        XCUIApplication().launch()
    }
    
    func testCalculateTip() {
        let app = XCUIApplication()

        let priceTextField = app.textFields["Price"]
        let percentageTextField = app.textFields["Percentage"]
        let numberInPartyTextField = app.textFields["Count"]

        let tipOutputText = app.staticTexts["Tip"]
        let totalOutputText = app.staticTexts["Total"];
        let perPersonOutputText = app.staticTexts["Per person"]

        let clearButton = app.buttons["Clear"]

        let percentageStepper = app.steppers.element(boundBy: 0)
        let percentageDecrementButton = percentageStepper.buttons["Decrement"]
        let percentageIncrementButton = percentageStepper.buttons["Increment"]

        let numberInPartyStepper = app.steppers.element(boundBy: 1)
        let numberInPartyDecrementButton = numberInPartyStepper.buttons["Decrement"]
        let numberInPartyIncrementButton = numberInPartyStepper.buttons["Increment"]

        XCTAssert(priceTextField.exists)
        XCTAssert(percentageTextField.exists)
        XCTAssert(numberInPartyTextField.exists)
        XCTAssert(tipOutputText.exists)
        XCTAssert(totalOutputText.exists)
        XCTAssert(perPersonOutputText.exists)
        XCTAssert(clearButton.exists)
        XCTAssert(percentageStepper.exists)
        XCTAssert(numberInPartyStepper.exists)

        // Initial values
        XCTAssertEqual("Price", priceTextField.value as? String)
        XCTAssertEqual("20", percentageTextField.value as? String)
        XCTAssertEqual("1", numberInPartyTextField.value as? String)
        XCTAssertEqual(" ", tipOutputText.value as? String)
        XCTAssertEqual(" ", totalOutputText.value as? String)
        XCTAssertEqual(" ", perPersonOutputText.value as? String)

        // Enter a subtotal
        priceTextField.typeText("12.34")
        XCTAssertEqual("2.47", tipOutputText.value as? String)
        XCTAssertEqual("14.81", totalOutputText.value as? String)
        XCTAssertEqual("14.81", perPersonOutputText.value as? String)

        // Use stepper to change percentage to 18
        percentageDecrementButton.tap()
        percentageDecrementButton.tap()
        XCTAssertEqual("18", percentageTextField.value as? String)
        XCTAssertEqual("2.22", tipOutputText.value as? String)
        XCTAssertEqual("14.56", totalOutputText.value as? String)
        XCTAssertEqual("14.56", perPersonOutputText.value as? String)

        // Use stepper to change percentage to 19
        percentageIncrementButton.tap()
        XCTAssertEqual("19", percentageTextField.value as? String)
        XCTAssertEqual("2.34", tipOutputText.value as? String)
        XCTAssertEqual("14.68", totalOutputText.value as? String)
        XCTAssertEqual("14.68", perPersonOutputText.value as? String)

        // Use stepper to increase number in party to 3
        numberInPartyIncrementButton.tap()
        numberInPartyIncrementButton.tap()
        XCTAssertEqual("3", numberInPartyTextField.value as? String)
        XCTAssertEqual("4.89", perPersonOutputText.value as? String) // TODO: should this round up to 4.90?

        // Use stepper to decrease number in party to 2
        numberInPartyDecrementButton.tap()
        XCTAssertEqual("2", numberInPartyTextField.value as? String)
        XCTAssertEqual("7.34", perPersonOutputText.value as? String)

        // Clear subtotal (leaves percentage and number in party as-is)
        clearButton.tap()
        XCTAssertEqual("Price", priceTextField.value as? String)
        XCTAssertEqual("19", percentageTextField.value as? String)
        XCTAssertEqual("2", numberInPartyTextField.value as? String)
        XCTAssertEqual(" ", tipOutputText.value as? String)
        XCTAssertEqual(" ", totalOutputText.value as? String)
        XCTAssertEqual(" ", perPersonOutputText.value as? String)

        // Enter a new subtotal
        priceTextField.typeText("43.21")
        XCTAssertEqual("8.21", tipOutputText.value as? String)
        XCTAssertEqual("51.42", totalOutputText.value as? String)
        XCTAssertEqual("25.71", perPersonOutputText.value as? String)
    }
}
