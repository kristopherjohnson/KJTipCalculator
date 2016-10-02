//
//  KeypadViewModel.swift
//  KJTipCalculator
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

/// Delegate for KeypadViewModel.
protocol KeypadViewModelDelegate: class {

    /// Invoked whenever the keypad display changes due to user input.
    func keypadViewModel(_ keypadViewModel: KeypadViewModel, displayTextDidChange: String)

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
    fileprivate(set) var displayText = "0"

    /// Get/set the numeric value displayed by the view model.
    var value: Double {
        get {
            return Double(displayText) ?? 0.00
        }

        set {
            let textWithDecimalPoint = String(format: "%01.2f", newValue)
            if textWithDecimalPoint.hasSuffix(".00") {
                displayText = String(format: "%d", Int(newValue))
            }
            else {
                displayText = textWithDecimalPoint
            }
        }
    }

    /// Maximum number of digits before the decimal point.
    static let wholeDigitsMaxCount = 4

    /// Maximum number of digits after the decimal point.
    static let fractionalDigitsMaxCount = 2

    /// Append a digit to the end of the display.
    ///
    /// - parameter digit: A value in the range 0...9.
    func addDigit(_ digit: Int) {
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
            KeypadViewModel.zeroUnicodeScalar + UInt32(digit))!
        displayText.append(Character(digitUnicodeScalar))
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
            displayText.remove(at: displayText.characters.index(before: displayText.endIndex))
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

    fileprivate static let zeroUnicodeScalar = UnicodeScalar("0").value

    fileprivate var canAcceptAnotherDigit: Bool {
        if hasDecimalPoint {
            return rightOfDecimalPointDigitCount < KeypadViewModel.fractionalDigitsMaxCount
        }
        else {
            return displayText.characters.count < KeypadViewModel.wholeDigitsMaxCount
        }
    }

    fileprivate var hasDecimalPoint: Bool {
        return displayText.contains(".")
    }

    fileprivate var rightOfDecimalPointDigitCount: Int {
        let chars = displayText.characters
        if let decimalPointIndex = chars.index(of: Character(".")) {
            let nextIndex = chars.index(after: decimalPointIndex)
            return chars.distance(from: nextIndex, to: chars.endIndex)
        }
        else {
            return 0
        }
    }

    fileprivate func notifyChange() {
        delegate?.keypadViewModel(self, displayTextDidChange: displayText)
    }

    fileprivate func notifyReject() {
        delegate?.keypadViewModelRejectedInput()
    }
}
