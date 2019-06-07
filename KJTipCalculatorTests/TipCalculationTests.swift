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
import KJTipCalculator

class TipCalculationTests: XCTestCase {

    func testTipCalculation15() {
        let calc = TipCalculation(subtotal: 100, tipPercentage: 15, numberInParty: 1)
        XCTAssertEqual(15.0, calc.tip)
        XCTAssertEqual(115.0, calc.total)
        XCTAssertEqual(115.0, calc.perPerson)
    }

    func testTipCalculation20() {
        let calc = TipCalculation(subtotal: 10, tipPercentage: 20, numberInParty: 1)
        XCTAssertEqual(2.0, calc.tip)
        XCTAssertEqual(12.0, calc.total)
        XCTAssertEqual(12.0, calc.perPerson)
    }

    func testTipCalculationSplit() {
        let calc = TipCalculation(subtotal: 100, tipPercentage: 18, numberInParty: 2)
        XCTAssertEqual(18.0, calc.tip)
        XCTAssertEqual(118.0, calc.total)
        XCTAssertEqual(59.0, calc.perPerson)
    }
}
