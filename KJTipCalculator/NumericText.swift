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

import UIKit

// Read Int value from String, returning nil if it is not a valid integer string
func integerValueForText(s: String) -> Int? {
    let length = countElements(s)
    let scanner = NSScanner(string: s)
    scanner.charactersToBeSkipped = nil
    var value: Int = 0
    if scanner.scanInteger(&value) && (scanner.scanLocation == length) {
        return value
    }
    else {
        return nil
    }
}

// Read Double value from String, returning nil if it is not a valid floating-point string
func doubleValueForText(s: String) -> Double? {
    let length = countElements(s)
    let scanner = NSScanner(string: s)
    scanner.charactersToBeSkipped = nil
    var value: Double = 0.0
    if scanner.scanDouble(&value) && (scanner.scanLocation == length) {
        return value
    }
    else {
        return nil
    }
}

// Determine whether given string is a valid integer string
func isValidIntegerText(s: String) -> Bool {
    if let value = integerValueForText(s) {
        return true
    }
    else {
        return false
    }
}

// Determine whether given string is a valid floating-point string
func isValidDoubleText(s: String) -> Bool {
    if let value = doubleValueForText(s) {
        return true
    }
    else {
        return false
    }
}

// Protocol for object with a read-write "text" property
protocol HasReadWriteTextProperty {
    var text: String! { get set }
}

// Return Int value of text property, or nil if empty
func integerValueForText(hasText: HasReadWriteTextProperty) -> Int? {
    return integerValueForText(hasText.text)
}

// Return Double value of text property, or nil if empty
func doubleValueForText(hasText: HasReadWriteTextProperty) -> Double? {
    return doubleValueForText(hasText.text)
}

// Set text property to string representation of given number
func setNumericValueForText(var hasText: HasReadWriteTextProperty, value: NSNumber) {
    hasText.text = value.stringValue
}

// Set text property to string representation of given number using a Double format string ("%f", "%e", "%g", etc.)
func setNumericValueForText(var hasText: HasReadWriteTextProperty, value: NSNumber, doubleFormat: NSString) {
    hasText.text = NSString(format: doubleFormat, value.doubleValue)
}

// Add these methods to UILabel
extension UILabel: HasReadWriteTextProperty {
    func textIntegerValue() -> Int? {
        return integerValueForText(self)
    }
    func textDoubleValue() -> Double? {
        return doubleValueForText(self)
    }
    func setTextNumericValue(value: NSNumber) {
        setNumericValueForText(self, value)
    }
    func setTextNumericValue(value: NSNumber, doubleFormat: NSString) {
        setNumericValueForText(self, value, doubleFormat)
    }
}

// Add these methods to UITextField
extension UITextField: HasReadWriteTextProperty {
    func textIntegerValue() -> Int? {
        return integerValueForText(self)
    }
    func textDoubleValue() -> Double? {
        return doubleValueForText(self)
    }
    func setTextNumericValue(value: NSNumber) {
        setNumericValueForText(self, value)
    }
    func setTextNumericValue(value: NSNumber, doubleFormat: NSString) {
        setNumericValueForText(self, value, doubleFormat)
    }
}
