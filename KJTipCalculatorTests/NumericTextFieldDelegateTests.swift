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
import Foundation
import UIKit
import KJTipCalculator

class NumericTextFieldDelegateTests: XCTestCase {

    var delegate: NumericTextFieldDelegate!
    var textField: UITextField!
    
    override func setUp() {
        super.setUp()
        delegate = NumericTextFieldDelegate(maxLength: 5)
        textField = UITextField()
        textField.delegate = delegate
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAllowAdditionOfNumericCharacters() {
        textField.text = ""
        let allowed = delegate.textField(textField,
            shouldChangeCharactersIn: NSRange(location: 0, length: 0),
            replacementString: "12345")
        XCTAssertTrue(allowed)
    }
    
    func testDisallowAdditionOfTooManyNumericCharacters() {
        textField.text = ""
        let allowed = delegate.textField(textField,
            shouldChangeCharactersIn: NSRange(location:0, length: 0),
            replacementString: "123456")
        XCTAssertFalse(allowed, "should allow no more than 5 characters")
    }
    
    func testDisallowAdditionOfNonnumericCharacters() {
        textField.text = ""
        let allowed = delegate.textField(textField,
            shouldChangeCharactersIn: NSRange(location:0, length: 0),
            replacementString: "z")
        XCTAssertFalse(allowed, "should not allow non-numeric characters")
    }
    
    func testAllowDeletionOfAllCharacters() {
        textField.text = "1"
        let allowed = delegate.textField(textField,
            shouldChangeCharactersIn: NSRange(location:0, length: 1),
            replacementString: "")
        XCTAssertTrue(allowed, "should allow all characters to be deleted")
    }
}
