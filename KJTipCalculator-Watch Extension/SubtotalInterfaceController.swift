//
//  SubtotalInterfaceController.swift
//  KJTipCalculator
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import WatchKit

/// Delegate for SubtotalInterfaceController.
protocol SubtotalInterfaceControllerDelegate: class {

    /// Invoked when the value is changed by the user.
    func subtotalInterfaceController(controller: SubtotalInterfaceController,
                                     didUpdateSubtotal subtotal: Double)
}

/// Interface controller for the Subtotal keypad entry view.
final class SubtotalInterfaceController: WKInterfaceController {

    /// Segue context.
    class Context {
        let subtotal: Double
        let delegate: SubtotalInterfaceControllerDelegate

        init(subtotal: Double, delegate: SubtotalInterfaceControllerDelegate) {
            self.subtotal = subtotal
            self.delegate = delegate
        }
    }
    
    weak var delegate: SubtotalInterfaceControllerDelegate?

    /// The numeric value displayed by the Subtotal keypad view.
    var value: Double {
        get {
            return viewModel.value
        }
        set {
            viewModel.value = newValue
        }
    }

    @IBOutlet var subtotalLabel: WKInterfaceLabel!
    @IBOutlet var keypad0: WKInterfaceButton!
    @IBOutlet var keypad1: WKInterfaceButton!
    @IBOutlet var keypad2: WKInterfaceButton!
    @IBOutlet var keypad3: WKInterfaceButton!
    @IBOutlet var keypad4: WKInterfaceButton!
    @IBOutlet var keypad5: WKInterfaceButton!
    @IBOutlet var keypad6: WKInterfaceButton!
    @IBOutlet var keypad7: WKInterfaceButton!
    @IBOutlet var keypad8: WKInterfaceButton!
    @IBOutlet var keypad9: WKInterfaceButton!
    @IBOutlet var keypadPeriod: WKInterfaceButton!
    @IBOutlet var keypadDelete: WKInterfaceButton!
    @IBOutlet var keypadClear: WKInterfaceButton!

    private let viewModel = KeypadViewModel()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        if let context = context as? Context {
            viewModel.value = context.subtotal
            delegate = context.delegate
        }
        else {
            NSLog("No context for SubtotalInterfaceController")
        }

        viewModel.delegate = self
        subtotalLabel.setText(viewModel.displayText)
    }
    
    // MARK: - Button event handlers

    @IBAction func keypad0Tapped() {
        viewModel.addDigit(0)
    }

    @IBAction func keypad1Tapped() {
        viewModel.addDigit(1)
    }

    @IBAction func keypad2Tapped() {
        viewModel.addDigit(2)
    }

    @IBAction func keypad3Tapped() {
        viewModel.addDigit(3)
    }

    @IBAction func keypad4Tapped() {
        viewModel.addDigit(4)
    }

    @IBAction func keypad5Tapped() {
        viewModel.addDigit(5)
    }

    @IBAction func keypad6Tapped() {
        viewModel.addDigit(6)
    }

    @IBAction func keypad7Tapped() {
        viewModel.addDigit(7)
    }

    @IBAction func keypad8Tapped() {
        viewModel.addDigit(8)
    }

    @IBAction func keypad9Tapped() {
        viewModel.addDigit(9)
    }

    @IBAction func keypadPeriodTapped() {
        viewModel.addDecimalPoint()
    }

    @IBAction func keypadDeleteTapped() {
        viewModel.delete()
    }

    @IBAction func keypadClearTapped() {
        viewModel.clear()
    }
}

extension SubtotalInterfaceController: KeypadViewModelDelegate {
    func keypadViewModel(keypadViewModel: KeypadViewModel, displayTextDidChange text: String) {
        subtotalLabel.setText(text)
        delegate?.subtotalInterfaceController(self, didUpdateSubtotal: keypadViewModel.value)
    }

    func keypadViewModelRejectedInput() {
        // TODO: provide some sort of feedback
    }
}
