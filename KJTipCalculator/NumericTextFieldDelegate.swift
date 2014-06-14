/*
Copyright (c) 2014 Kristopher Johnson

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

class NumericTextFieldDelegate: NSObject, UITextFieldDelegate {
    var maxLength: Int
    var allowDecimal: Bool
    
    init(maxLength: Int, allowDecimal: Bool) {
        self.maxLength = maxLength
        self.allowDecimal = allowDecimal
    }
    
    convenience init(maxLength: Int) {
        self.init(maxLength: maxLength, allowDecimal: false)
    }
    
    func textField(textField: UITextField!,
        shouldChangeCharactersInRange range: NSRange,
        replacementString string: String!) -> Bool
    {
        let originalText: NSString = textField.text
        let proposedText: NSString = originalText.stringByReplacingCharactersInRange(range,
            withString: string)
        
        let proposedLength = proposedText.length
        if proposedLength > maxLength {
            return false
        }
        
        if allowDecimal {
            if proposedLength > 0 && !isValidDoubleText(proposedText) {
                return false
            }
        }
        else {
            if proposedLength > 0 && !isValidIntegerText(proposedText) {
                return false
            }
        }
        
        return true
    }
}

