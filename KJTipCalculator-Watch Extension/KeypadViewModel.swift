//
//  KeypadViewModel.swift
//  KJTipCalculator
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import Foundation

public protocol KeypadViewModelDelegate: class {

    func keypadViewModel(keypadViewModel: KeypadViewModel, displayTextDidChange: String)

    func keypadViewModelRejectedInput()
}

public class KeypadViewModel {

    /// Delegate notified as the state changes.
    public weak var delegate: KeypadViewModelDelegate? = nil

    /// Return the current displayed value.
    public var displayText: String {
        return "0"
    }

    /// Add a digit to the end of the display.
    public func addDigit(digit: Int) {

    }

    /// Add a period at the end of the display.
    public func addPeriod() {

    }

    /// Delete the last typed digit or period.
    public func delete() {

    }

    /// Clear the display to "0".
    public func clear() {

    }
}