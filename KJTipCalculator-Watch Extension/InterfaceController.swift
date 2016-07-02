//
//  InterfaceController.swift
//  KJTipCalculator-Watch Extension
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var tipPercentagePicker: WKInterfacePicker!
    @IBOutlet var numberInPartyPicker: WKInterfacePicker!
    @IBOutlet var tipLabel: WKInterfaceLabel!
    @IBOutlet var totalLabel: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        let tipPercentageItems: [WKPickerItem] = (1...50).map { n in
            let item = WKPickerItem()
            item.title = "\(n)%"
            item.caption = "Tip %"
            return item
        }
        tipPercentagePicker.setItems(tipPercentageItems)
        tipPercentagePicker.setSelectedItemIndex(14) // TODO: Restore

        let numberInPartyItems: [WKPickerItem] = (1...20).map { n in
            let item = WKPickerItem()
            item.title = "\(n)"
            item.caption = "Party of"
            return item
        }
        numberInPartyPicker.setItems(numberInPartyItems)
        numberInPartyPicker.setSelectedItemIndex(0) // TODO: Restore
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
