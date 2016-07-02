//
//  SubtotalInterfaceController.swift
//  KJTipCalculator
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import WatchKit
import Foundation


class SubtotalInterfaceController: WKInterfaceController {

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

    let keypadViewModel = KeypadViewModel()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        keypadViewModel.delegate = self
        
        subtotalLabel.setText(keypadViewModel.displayText)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func keypad0Tapped() {
    }

    @IBAction func keypad1Tapped() {
    }

    @IBAction func keypad2Tapped() {
    }

    @IBAction func keypad3Tapped() {
    }

    @IBAction func keypad4Tapped() {
    }

    @IBAction func keypad5Tapped() {
    }

    @IBAction func keypad6Tapped() {
    }

    @IBAction func keypad7Tapped() {
    }

    @IBAction func keypad8Tapped() {
    }

    @IBAction func keypad9Tapped() {
    }

    @IBAction func keypadPeriodTapped() {
    }

    @IBAction func keypadDeleteTapped() {
    }

    @IBAction func keypadClearTapped() {
    }
}

extension SubtotalInterfaceController: KeypadViewModelDelegate {
    func keypadViewModel(keypadViewModel: KeypadViewModel, displayTextDidChange text: String) {
        subtotalLabel.setText(text)
    }

    func keypadViewModelRejectedInput() {
        // TODO
    }
}