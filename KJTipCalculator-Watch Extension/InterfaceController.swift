//
//  InterfaceController.swift
//  KJTipCalculator-Watch Extension
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import WatchKit

final class InterfaceController: WKInterfaceController {

    @IBOutlet var subtotalLabel: WKInterfaceLabel!
    @IBOutlet var subtotalButton: WKInterfaceButton!
    @IBOutlet var tipPercentagePicker: WKInterfacePicker!
    @IBOutlet var numberInPartyPicker: WKInterfacePicker!
    @IBOutlet var tipLabel: WKInterfaceLabel!
    @IBOutlet var totalLabel: WKInterfaceLabel!

    fileprivate var subtotal = 20.00
    fileprivate var tipPercentage = 18
    fileprivate var numberInParty = 1

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        subtotalButton.setBackgroundColor(appTintColor)
        
        let tipPercentageItems: [WKPickerItem] = (1...50).map {
            return pickerItem(title: "\($0)%", caption: "Tip %")
        }
        tipPercentagePicker.setItems(tipPercentageItems)
        tipPercentagePicker.setSelectedItemIndex(tipPercentage - 1)

        let numberInPartyItems: [WKPickerItem] = (1...20).map {
            return pickerItem(title: "\($0)", caption: "Party of")
        }
        numberInPartyPicker.setItems(numberInPartyItems)
        numberInPartyPicker.setSelectedItemIndex(numberInParty - 1)
    }

    override func willActivate() {
        super.willActivate()
        updateOutput()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

    func updateOutput() {
        let tipCalculation = TipCalculation(subtotal: subtotal,
                                            tipPercentage: tipPercentage,
                                            numberInParty: numberInParty)
        subtotalLabel.setText(formatValue(subtotal))
        tipLabel.setText("Tip: \(formatValue(tipCalculation.tip))")
        if numberInParty == 1 {
            totalLabel.setText("Total: \(formatValue(tipCalculation.total))")
        }
        else {
            totalLabel.setText("\(formatValue(tipCalculation.total)) / \(formatValue(tipCalculation.perPerson))")
        }
    }

    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        switch segueIdentifier {
        case "Subtotal":
            return SubtotalInterfaceController.Context(subtotal: subtotal, delegate: self)
        default:
            NSLog("Unknown segue identifier")
            return nil
        }
    }

    @IBAction func tipPercentageWasPicked(_ value: Int) {
        tipPercentage = value + 1
        updateOutput()
    }

    @IBAction func numberInPartyWasPicked(_ value: Int) {
        numberInParty = value + 1
        updateOutput()
    }

    private func pickerItem(title: String, caption: String) -> WKPickerItem {
        let item = WKPickerItem()
        item.title = title
        item.caption = caption
        return item
    }

    private func formatValue(_ value: Double) -> String {
        return String(format: "%01.2f", value)
    }
}

extension InterfaceController: SubtotalInterfaceControllerDelegate {
    func subtotalInterfaceController(_ controller: SubtotalInterfaceController, didUpdateSubtotal subtotal: Double) {
        self.subtotal = subtotal
        updateOutput()
    }
}
