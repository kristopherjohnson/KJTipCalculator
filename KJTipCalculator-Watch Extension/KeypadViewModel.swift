//
//  KeypadViewModel.swift
//  KJTipCalculator
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

/// Delegate for KeypadViewModel.
protocol KeypadViewModelDelegate: class {

    /// Invoked whenever the keypad display changes due to user input.
    func keypadViewModel(keypadViewModel: KeypadViewModel, displayTextDidChange: String)

    /// Invoked when the keypad rejects an
    /// `addDigit()`, `addDecimalPoint()`, or `delete()` call.
    func keypadViewModelRejectedInput()
}

/// View model for the Subtotal entry keypad.
///
/// Provides calculator-like numeric entry.
/// Allows up to four digits to the left of the
/// decimal point, and up to two digits to the
/// right of the decimal point.
final class KeypadViewModel {

    /// Delegate notified as the state changes.
    weak var delegate: KeypadViewModelDelegate? = nil

    /// Return the current displayed value.
    private(set) var displayText = "0"

    /// Get/set the numeric value displayed by the view model.
    var value: Double {
        get {
            return Double(displayText) ?? 0.00
        }
        set {
            let s = String(format: "%01.2f", newValue)
            displayText = (s == "0.00") ? "0" : s
        }
    }

    /// Maximum number of digits before the decimal point.
    static let wholeDigitsMaxCount = 4

    /// Maximum number of digits after the decimal point.
    static let fractionalDigitsMaxCount = 2

    /// Append a digit to the end of the display.
    ///
    /// - parameter digit: A value in the range 0...9.
    func addDigit(digit: Int) {
        if digit < 0 || 9 < digit || !canAcceptAnotherDigit {
            notifyReject()
            return
        }

        if displayText == "0" {
            if digit == 0 {
                return
            }
            else {
                displayText = ""
            }
        }

        let digitUnicodeScalar = UnicodeScalar(
            KeypadViewModel.zeroUnicodeScalar + UInt32(digit))
        displayText.append(digitUnicodeScalar)
        notifyChange()
    }

    /// Add a decimal point to the end of the display.
    func addDecimalPoint() {
        if hasDecimalPoint {
            notifyReject()
            return
        }
        displayText.append(Character("."))
        notifyChange()
    }

    /// Delete the last typed digit or period.
    func delete() {
        if displayText == "0" {
            notifyReject()
            return
        }

        if displayText.characters.count == 1 {
            displayText = "0"
        }
        else {
            displayText.removeAtIndex(displayText.endIndex.predecessor())
        }
        notifyChange()
    }

    /// Clear the display to "0".
    func clear() {
        if !(displayText == "0") {
            displayText = "0"
            notifyChange()
        }
    }

    // MARK: - Private

    private static let zeroUnicodeScalar = UnicodeScalar("0").value

    private var canAcceptAnotherDigit: Bool {
        if hasDecimalPoint {
            return rightOfDecimalPointDigitCount < KeypadViewModel.fractionalDigitsMaxCount
        }
        else {
            return displayText.characters.count < KeypadViewModel.wholeDigitsMaxCount
        }
    }

    private var hasDecimalPoint: Bool {
        return displayText.containsString(".")
    }

    private var rightOfDecimalPointDigitCount: Int {
        let chars = displayText.characters
        if let decimalPointIndex = chars.indexOf(Character(".")) {
            return decimalPointIndex.successor().distanceTo(chars.endIndex)
        }
        else {
            return 0
        }
    }

    private func notifyChange() {
        delegate?.keypadViewModel(self, displayTextDidChange: displayText)
    }

    private func notifyReject() {
        delegate?.keypadViewModelRejectedInput()
    }
}
