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

class NumericTextTests: XCTestCase {
    
    func testIntegerValueForValidString() {
        let value = integerValueForString("123")
        XCTAssertEqual(123, value!)
    }

    func testNegativeIntegerValueForValidString() {
        let value = integerValueForString("-321")
        XCTAssertEqual(-321, value!)
    }
    
    func testDoubleValueForValidString() {
        let value = doubleValueForString("123.4")
        XCTAssertEqual(123.4, value!)
    }
    
    func testNegativeDoubleValueForValidString() {
        let value = doubleValueForString("-4.321")
        XCTAssertEqual(-4.321, value!)
    }
    
    func testRejectIntegerValueWithLeadingSpace() {
        let value = integerValueForString(" 123")
        XCTAssert(value == nil)
    }
    
    func testRejectDoubleValueWithLeadingSpace() {
        let value = doubleValueForString(" 123.4")
        XCTAssert(value == nil)
    }
    
    func testRejectIntegerValueWithTrailingSpace() {
        let value = integerValueForString("123 ")
        XCTAssert(value == nil)
    }
    
    func testRejectDoubleValueWithTrailingSpace() {
        let value = doubleValueForString("123.4 ")
        XCTAssert(value == nil)
    }
    
    func testRejectIntegerValueWithLeadingNonnumericCharacter() {
        let value = integerValueForString("z123")
        XCTAssert(value == nil)
    }
    
    func testRejectDoubleValueWithLeadingNonnumericCharacter() {
        let value = doubleValueForString("z123.4")
        XCTAssert(value == nil)
    }
    
    func testRejectIntegerValueWithTrailingNonnumericCharacter() {
        let value = integerValueForString("123a")
        XCTAssert(value == nil)
    }
    
    func testRejectDoubleValueWithTrailingNonnumericCharacter() {
        let value = doubleValueForString("123.4a")
        XCTAssert(value == nil)
    }
}
