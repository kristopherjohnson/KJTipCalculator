/*
Copyright (c) 2014, 2015 Kristopher Johnson

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

extension UIStepper {
    // Set value if proposed new value is within minimumValue...maximumValue
    func ifInRangeSetValue(_ proposedValue: NSNumber) -> Bool {
        let proposed = proposedValue.doubleValue
        if minimumValue <= proposed && proposed <= maximumValue {
            value = proposed
            return true
        }
        else {
            return false
        }
    }
}

// Main view controller
class ViewController: UIViewController {
    
    let currencyFormat: NSString = "%.2f"
    
    let minTipPercentage     = 1
    let defaultTipPercentage = 20
    let maxTipPercentage     = 99
    
    let minNumberInParty     = 1
    let defaultNumberInParty = 1
    let maxNumberInParty     = 99
    
    @IBOutlet var subtotalTextField      : UITextField!
    @IBOutlet var tipPercentageTextField : UITextField!
    @IBOutlet var tipPercentageStepper   : UIStepper!
    @IBOutlet var numberInPartyTextField : UITextField!
    @IBOutlet var numberInPartyStepper   : UIStepper!
    @IBOutlet var tipOutput              : UILabel!
    @IBOutlet var totalOutput            : UILabel!
    @IBOutlet var splitOutput            : UILabel!
    
    var integerTextFieldDelegate = NumericTextFieldDelegate(maxLength: 2)
    var subtotalTextFieldDelegate = NumericTextFieldDelegate(maxLength: 7, allowDecimal: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subtotalTextField.text = ""
        subtotalTextField.delegate = subtotalTextFieldDelegate

        tipPercentageTextField.setTextNumericValue(NSNumber(value: defaultTipPercentage))
        tipPercentageTextField.delegate = integerTextFieldDelegate
        
        tipPercentageStepper.minimumValue = Double(minTipPercentage)
        tipPercentageStepper.maximumValue = Double(maxTipPercentage)
        tipPercentageStepper.value = Double(defaultTipPercentage)
        tipPercentageStepper.incrementImage(for: .normal)?.accessibilityLabel = "Increase tip percentage"
        tipPercentageStepper.decrementImage(for: .normal)?.accessibilityLabel = "Decrease tip percentage"
        
        numberInPartyTextField.setTextNumericValue(NSNumber(value: defaultNumberInParty))
        numberInPartyTextField.delegate = integerTextFieldDelegate
        
        numberInPartyStepper.minimumValue = Double(minNumberInParty)
        numberInPartyStepper.maximumValue = Double(maxNumberInParty)
        numberInPartyStepper.value = Double(defaultNumberInParty)
        numberInPartyStepper.incrementImage(for: .normal)?.accessibilityLabel = "Increase number in party"
        numberInPartyStepper.decrementImage(for: .normal)?.accessibilityLabel = "Decrease number in party"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.tintColor = appTintColor
        updateOutput()
        subtotalTextField.becomeFirstResponder()
    }
    
    @IBAction func clearButtonWasTapped(_ sender: UIButton) {
        subtotalTextField.text = ""
        subtotalTextField.becomeFirstResponder()
        updateOutput()
    }
    
    @IBAction func subtotalTextFieldChanged(_ sender: UITextField) {
        updateOutput()
    }
    
    @IBAction func tipPercentageTextFieldChanged(_ sender: UITextField) {
        if let value = sender.textIntegerValue() {
            tipPercentageStepper.ifInRangeSetValue(NSNumber(value: value))
        }
        updateOutput()
    }
    
    @IBAction func tipPercentageStepperValueChanged(_ sender: UIStepper) {
        tipPercentageTextField.setTextNumericValue(NSNumber(value: sender.value))
        updateOutput()
    }

    @IBAction func numberInPartyTextFieldChanged(_ sender: UITextField) {
        if let value = sender.textIntegerValue() {
            numberInPartyStepper.ifInRangeSetValue(NSNumber(value: value))
        }
        updateOutput()
    }
    
    @IBAction func numberInPartyStepperValueChanged(_ sender: UIStepper) {
        numberInPartyTextField.setTextNumericValue(NSNumber(value: sender.value))
        updateOutput()
    }

    func updateOutput() {
        // If all text fields have valid values, then we can calculate results.
        // Otherwise, set result fields empty.
        
        switch (subtotalTextField.textDoubleValue(),
            tipPercentageTextField.textIntegerValue(),
            numberInPartyTextField.textIntegerValue()) {
            
        case let (.some(subtotal), .some(tipPercentage), .some(numberInParty))
            where subtotal > 0 && tipPercentage > 0 && numberInParty > 0:
            
            let calc = TipCalculation(
                subtotal: subtotal,
                tipPercentage: tipPercentage,
                numberInParty: numberInParty)
            
            setTextForField(tipOutput,   currencyValue: calc.tip)
            setTextForField(totalOutput, currencyValue: calc.total)
            setTextForField(splitOutput, currencyValue: calc.perPerson)
            
        default:
            tipOutput.text = ""
            totalOutput.text = ""
            splitOutput.text = ""
        }
    }
    
    func setTextForField(_ field: TextSettable, currencyValue: Double) {
        field.setTextNumericValue(NSNumber(value: currencyValue), format: currencyFormat)
    }
}

