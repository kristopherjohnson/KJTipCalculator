//
//  KeypadViewModelTests.swift
//  KJTipCalculator
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import XCTest

/// Tests of the KeypadViewModel class.
class KeypadViewModelTests: XCTestCase {

    /// Delegate that keeps track of changes and rejections.
    class TestDelegate: KeypadViewModelDelegate {
        var displayChanges: [String] = []
        var rejectCount = 0

        var changeCount: Int { return displayChanges.count }

        var lastChange: String? { return displayChanges.last }

        func keypadViewModel(keypadViewModel: KeypadViewModel, displayTextDidChange newText: String) {
            displayChanges.append(newText)
        }

        func keypadViewModelRejectedInput() {
            rejectCount += 1
        }
    }

    var keypad: KeypadViewModel!
    var delegate: TestDelegate!

    override func setUp() {
        super.setUp()
        keypad = KeypadViewModel()
        delegate = TestDelegate()
        keypad.delegate = delegate
    }

    override func tearDown() {
        keypad = nil
        delegate = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertEqual(keypad.displayText, "0",
                       "initial state should display '0'")

        keypad.clear()
        XCTAssertEqual(keypad.displayText, "0")
        XCTAssertEqual(delegate.changeCount, 0)
        XCTAssertEqual(delegate.rejectCount, 0)

        keypad.delete()
        XCTAssertEqual(keypad.displayText, "0")
        XCTAssertEqual(delegate.changeCount, 0)
        XCTAssertEqual(delegate.rejectCount, 1,
                       "should reject delete in initial state")

        keypad.addDigit(0)
        XCTAssertEqual(keypad.displayText, "0")
        XCTAssertEqual(delegate.changeCount, 0,
                       "leading zero should be ignored")
        XCTAssertEqual(delegate.rejectCount, 1,
                       "leading zero should be ignored")
    }

    func testAddDigits() {
        keypad.addDigit(1)
        XCTAssertEqual("1", keypad.displayText)
        XCTAssertEqual(1, delegate.changeCount)
        XCTAssertEqual("1", delegate.lastChange)

        keypad.addDigit(2)
        XCTAssertEqual("12", keypad.displayText)
        XCTAssertEqual(2, delegate.changeCount)
        XCTAssertEqual("12", delegate.lastChange)

        keypad.addDigit(3)
        XCTAssertEqual("123", keypad.displayText)
        XCTAssertEqual(3, delegate.changeCount)
        XCTAssertEqual("123", delegate.lastChange)

        keypad.addDigit(4)
        XCTAssertEqual("1234", keypad.displayText)
        XCTAssertEqual(4, delegate.changeCount)
        XCTAssertEqual("1234", delegate.lastChange)
        XCTAssertEqual(0, delegate.rejectCount)

        keypad.addDigit(5)
        XCTAssertEqual("1234", keypad.displayText,
                       "should not allow more than 4 digits")
        XCTAssertEqual(4, delegate.changeCount)
        XCTAssertEqual(1, delegate.rejectCount)
    }

    func testDeleteDigits() {
        keypad.addDigit(1)
        XCTAssertEqual("1", keypad.displayText)
        XCTAssertEqual(1, delegate.changeCount)
        XCTAssertEqual("1", delegate.lastChange)

        keypad.addDigit(2)
        XCTAssertEqual("12", keypad.displayText)
        XCTAssertEqual(2, delegate.changeCount)
        XCTAssertEqual("12", delegate.lastChange)
        
        keypad.delete()
        XCTAssertEqual("1", keypad.displayText)
        XCTAssertEqual(3, delegate.changeCount)
        XCTAssertEqual("1", delegate.lastChange)

        keypad.delete()
        XCTAssertEqual("0", keypad.displayText,
                       "delete of last digit should result in '0' display")
        XCTAssertEqual(4, delegate.changeCount)
        XCTAssertEqual("0", delegate.lastChange)

        keypad.delete()
        XCTAssertEqual(keypad.displayText, "0")
        XCTAssertEqual(delegate.changeCount, 4)
        XCTAssertEqual(delegate.rejectCount, 1,
                       "should reject delete when '0'")
    }

    func testClearDigits() {
        keypad.addDigit(1)
        XCTAssertEqual("1", keypad.displayText)
        XCTAssertEqual(1, delegate.changeCount)
        XCTAssertEqual("1", delegate.lastChange)

        keypad.addDigit(2)
        XCTAssertEqual("12", keypad.displayText)
        XCTAssertEqual(2, delegate.changeCount)
        XCTAssertEqual("12", delegate.lastChange)

        keypad.clear()
        XCTAssertEqual("0", keypad.displayText)
        XCTAssertEqual(3, delegate.changeCount)
        XCTAssertEqual("0", delegate.lastChange)
    }

    func testDecimalPoint() {
        keypad.addDigit(7)
        XCTAssertEqual("7", keypad.displayText)
        XCTAssertEqual(1, delegate.changeCount)
        XCTAssertEqual("7", delegate.lastChange)

        keypad.addDigit(8)
        XCTAssertEqual("78", keypad.displayText)
        XCTAssertEqual(2, delegate.changeCount)
        XCTAssertEqual("78", delegate.lastChange)

        keypad.addDigit(9)
        XCTAssertEqual("789", keypad.displayText)
        XCTAssertEqual(3, delegate.changeCount)
        XCTAssertEqual("789", delegate.lastChange)

        keypad.addDecimalPoint()
        XCTAssertEqual("789.", keypad.displayText)
        XCTAssertEqual(4, delegate.changeCount)
        XCTAssertEqual("789.", delegate.lastChange)
        XCTAssertEqual(0, delegate.rejectCount)

        keypad.addDecimalPoint()
        XCTAssertEqual("789.", keypad.displayText)
        XCTAssertEqual(4, delegate.changeCount)
        XCTAssertEqual(1, delegate.rejectCount,
                       "second decimal point should be rejected")

        keypad.delete()
        XCTAssertEqual("789", keypad.displayText)
        XCTAssertEqual(5, delegate.changeCount)
        XCTAssertEqual("789", delegate.lastChange)
        XCTAssertEqual(1, delegate.rejectCount)

        keypad.addDecimalPoint()
        XCTAssertEqual("789.", keypad.displayText)
        XCTAssertEqual(6, delegate.changeCount)
        XCTAssertEqual("789.", delegate.lastChange)
        XCTAssertEqual(1, delegate.rejectCount)
    }

    func testFractional() {
        keypad.addDecimalPoint()
        XCTAssertEqual("0.", keypad.displayText)
        XCTAssertEqual(1, delegate.changeCount)
        XCTAssertEqual("0.", delegate.lastChange)

        keypad.addDigit(5)
        XCTAssertEqual("0.5", keypad.displayText)
        XCTAssertEqual(2, delegate.changeCount)
        XCTAssertEqual("0.5", delegate.lastChange)

        keypad.addDigit(6)
        XCTAssertEqual("0.56", keypad.displayText)
        XCTAssertEqual(3, delegate.changeCount)
        XCTAssertEqual("0.56", delegate.lastChange)

        keypad.addDigit(7)
        XCTAssertEqual("0.56", keypad.displayText,
                       "should not accept more than 2 digits after decimal")
        XCTAssertEqual(3, delegate.changeCount)
        XCTAssertEqual(1, delegate.rejectCount,
                       "should not accept more than 2 digits after decimal")
    }

    func testWholeAndFractional() {
        keypad.addDigit(4)
        keypad.addDigit(3)
        keypad.addDigit(2)
        keypad.addDigit(1)
        XCTAssertEqual("4321", keypad.displayText)
        XCTAssertEqual(4, delegate.changeCount)
        XCTAssertEqual("4321", delegate.lastChange)
        XCTAssertEqual(0, delegate.rejectCount)

        keypad.addDecimalPoint()
        XCTAssertEqual("4321.", keypad.displayText)
        XCTAssertEqual(5, delegate.changeCount)
        XCTAssertEqual("4321.", delegate.lastChange)
        XCTAssertEqual(0, delegate.rejectCount)

        keypad.addDigit(0)
        XCTAssertEqual("4321.0", keypad.displayText)
        XCTAssertEqual(6, delegate.changeCount)
        XCTAssertEqual("4321.0", delegate.lastChange)
        XCTAssertEqual(0, delegate.rejectCount)

        keypad.addDigit(9)
        XCTAssertEqual("4321.09", keypad.displayText)
        XCTAssertEqual(7, delegate.changeCount)
        XCTAssertEqual("4321.09", delegate.lastChange)
        XCTAssertEqual(0, delegate.rejectCount)

        keypad.addDigit(8)
        XCTAssertEqual("4321.09", keypad.displayText,
                       "should reject more than two fractional digits")
        XCTAssertEqual(7, delegate.changeCount)
        XCTAssertEqual("4321.09", delegate.lastChange)
        XCTAssertEqual(1, delegate.rejectCount,
                       "should reject more than two fractional digits")

        keypad.delete()
        XCTAssertEqual("4321.0", keypad.displayText)
        XCTAssertEqual(8, delegate.changeCount)
        XCTAssertEqual("4321.0", delegate.lastChange)
        XCTAssertEqual(1, delegate.rejectCount)
    }

    func testValue() {
        XCTAssertEqual(0.0, keypad.value, "Initial value should be 0.0")

        keypad.value = 0.01
        XCTAssertEqual("0.01", keypad.displayText)
        XCTAssertEqualWithAccuracy(0.01, keypad.value, accuracy: 0.001)

        keypad.value = 9999.99
        XCTAssertEqual("9999.99", keypad.displayText)
        XCTAssertEqualWithAccuracy(9999.99, keypad.value, accuracy: 0.001)

        keypad.value = 0.00
        XCTAssertEqual("0", keypad.displayText)
        XCTAssertEqualWithAccuracy(0.00, keypad.value, accuracy: 0.001)

        keypad.value = 1.23
        XCTAssertEqual("1.23", keypad.displayText)
        XCTAssertEqualWithAccuracy(1.23, keypad.value, accuracy: 0.001)

        keypad.value = 4567.89
        XCTAssertEqual("4567.89", keypad.displayText)
        XCTAssertEqualWithAccuracy(4567.89, keypad.value, accuracy: 0.001)
    }
}
