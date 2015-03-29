/*
Copyright (c) 2014, 2015 Kristopher Johnson

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

import Foundation
import UIKit

// Implementation of UITextFieldDelegate that prevents non-numeric characters
// from being entered in a numeric text field.
public class NumericTextFieldDelegate: NSObject, UITextFieldDelegate {
    let maxLength: Int
    let allowDecimal: Bool
    
    public init(maxLength: Int, allowDecimal: Bool = false) {
        self.maxLength = maxLength
        self.allowDecimal = allowDecimal
    }
    
    public func textField(textField: UITextField,
        shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool
    {
        let originalText = textField.text
        let proposedText = (originalText as NSString).stringByReplacingCharactersInRange(range, withString: string) as String
        
        let proposedLength = count(proposedText)
        if proposedLength > maxLength {
            return false
        }
        
        if allowDecimal {
            if proposedLength > 0 && !isValidDoubleString(proposedText) {
                return false
            }
        }
        else {
            if proposedLength > 0 && !isValidIntegerString(proposedText) {
                return false
            }
        }
        
        return true
    }
}

