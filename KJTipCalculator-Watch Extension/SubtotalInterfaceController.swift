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
    func subtotalInterfaceController(_ controller: SubtotalInterfaceController,
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

    fileprivate let viewModel = KeypadViewModel()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

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
        animateButtonTap(keypad0)
        viewModel.addDigit(0)
    }

    @IBAction func keypad1Tapped() {
        animateButtonTap(keypad1)
        viewModel.addDigit(1)
    }

    @IBAction func keypad2Tapped() {
        animateButtonTap(keypad2)
        viewModel.addDigit(2)
    }

    @IBAction func keypad3Tapped() {
        animateButtonTap(keypad3)
        viewModel.addDigit(3)
    }

    @IBAction func keypad4Tapped() {
        animateButtonTap(keypad4)
        viewModel.addDigit(4)
    }

    @IBAction func keypad5Tapped() {
        animateButtonTap(keypad5)
        viewModel.addDigit(5)
    }

    @IBAction func keypad6Tapped() {
        animateButtonTap(keypad6)
        viewModel.addDigit(6)
    }

    @IBAction func keypad7Tapped() {
        animateButtonTap(keypad7)
        viewModel.addDigit(7)
    }

    @IBAction func keypad8Tapped() {
        animateButtonTap(keypad8)
        viewModel.addDigit(8)
    }

    @IBAction func keypad9Tapped() {
        animateButtonTap(keypad9)
        viewModel.addDigit(9)
    }

    @IBAction func keypadPeriodTapped() {
        animateButtonTap(keypadPeriod)
        viewModel.addDecimalPoint()
    }

    @IBAction func keypadDeleteTapped() {
        animateButtonTap(keypadDelete)
        viewModel.delete()
    }

    @IBAction func keypadClearTapped() {
        animateButtonTap(keypadClear)
        viewModel.clear()
    }

    fileprivate func animateButtonTap(_ button: WKInterfaceButton) {
        button.setBackgroundColor(appTintColor)
        animate(withDuration: 0.2) {
            button.setBackgroundColor(nil)
        }
    }

    fileprivate func animateButtonRejection() {
        subtotalLabel.setTextColor(UIColor.red)
        animate(withDuration: 0.1) {
            self.subtotalLabel.setTextColor(UIColor.white)
        }
    }
}

extension SubtotalInterfaceController: KeypadViewModelDelegate {
    func keypadViewModel(_ keypadViewModel: KeypadViewModel, displayTextDidChange text: String) {
        subtotalLabel.setText(text)
        let value = keypadViewModel.value
        delegate?.subtotalInterfaceController(self, didUpdateSubtotal: value)
    }

    func keypadViewModelRejectedInput() {
        animateButtonRejection()
    }
}
