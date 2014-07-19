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

// Wrapper for NSScanner that doesn't allow leading whitespace.
// Returns Optional values rather than using pointer/inout parameters.
struct StrictScanner {
    let scanner: NSScanner
    
    init(string: String) {
        scanner = NSScanner(string: string)
        scanner.charactersToBeSkipped = nil
    }
    
    var atEnd: Bool { return scanner.atEnd }
    
    func scanInteger() -> Int? {
        var value: Int = 0
        if scanner.scanInteger(&value) {
            return value
        }
        return nil
    }
    
    func scanDouble() -> Double? {
        var value: Double = 0
        if scanner.scanDouble(&value) {
            return value
        }
        return nil
    }
}

// Read Int value from String, returning nil if it is not a valid integer string
func integerValueForString(s: String) -> Int? {
    let scanner = StrictScanner(string: s)
    if let result = scanner.scanInteger() {
        if scanner.atEnd {
            return result
        }
    }
    return nil
}

// Read Double value from String, returning nil if it is not a valid floating-point string
func doubleValueForString(s: String) -> Double? {
    let scanner = StrictScanner(string: s)
    if let result = scanner.scanDouble() {
        if scanner.atEnd {
            return result
        }
    }
    return nil
}

// Determine whether given string is a valid integer string
func isValidIntegerString(s: String) -> Bool {
    if let value = integerValueForString(s) {
        return true
    }
    else {
        return false
    }
}

// Determine whether given string is a valid floating-point string
func isValidDoubleString(s: String) -> Bool {
    if let value = doubleValueForString(s) {
        return true
    }
    else {
        return false
    }
}

// Protocol for object with a read-write "text" property
@objc(kjtc_TextSettable)
protocol TextSettable {
    var text: String! { get set }
}

// Return Int value of text property, or nil if empty
func integerValueForText(ts: TextSettable) -> Int? {
    return integerValueForString(ts.text)
}

// Return Double value of text property, or nil if empty
func doubleValueForText(ts: TextSettable) -> Double? {
    return doubleValueForString(ts.text)
}

// Set text property to string representation of given number
func setNumericValueForText(var ts: TextSettable, value: NSNumber) {
    ts.text = value.stringValue
}

// Set text property to string representation of given number using a Double format string ("%f", "%e", "%g", etc.)
func setNumericValueForText(var ts: TextSettable, value: NSNumber, doubleFormat: NSString) {
    ts.text = NSString(format: doubleFormat, value.doubleValue)
}

// Add these methods to UILabel
extension UILabel: TextSettable {
    // Note: Not callable from Objective-C
    func textIntegerValue() -> Int? {
        return integerValueForText(self)
    }
    
    // Note: Not callable from Objective-C
    func textDoubleValue() -> Double? {
        return doubleValueForText(self)
    }
    
    @objc(kjtc_setTextNumericValue:)
    func setTextNumericValue(value: NSNumber) {
        setNumericValueForText(self, value)
    }
    
    @objc(kjtc_setTextNumericValue:doubleFormat:)
    func setTextNumericValue(value: NSNumber, doubleFormat: NSString) {
        setNumericValueForText(self, value, doubleFormat)
    }
}

// Add these methods to UITextField
extension UITextField: TextSettable {
    // Note: Not callable from Objective-C
    func textIntegerValue() -> Int? {
        return integerValueForText(self)
    }
    
    // Note: Not callable from Objective-C
    func textDoubleValue() -> Double? {
        return doubleValueForText(self)
    }
    
    @objc(kjtc_setTextNumericValue:)
    func setTextNumericValue(value: NSNumber) {
        setNumericValueForText(self, value)
    }
    
    @objc(kjtc_setTextNumericValue:doubleFormat:)
    func setTextNumericValue(value: NSNumber, doubleFormat: NSString) {
        setNumericValueForText(self, value, doubleFormat)
    }
}
