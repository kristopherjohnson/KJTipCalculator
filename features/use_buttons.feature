Feature: Use buttons as shortcuts
  As a user
  I want to use buttons instead of typing numbers
  So I can quickly make adjustments

Scenario: Calculate tip and adjust
  Given I am on the Main Screen
  And   all input fields are cleared
  And   I fill in text fields as follows:
   | field           | text  |
   | Check subtotal  | 10.00 |
   | Tip percentage  | 20    |
   | Number in party | 1     |
  Then  tip should be "2.00"
  And   total should be "12.00"
  And   per-person should be "12.00"

  When  I touch "Increase tip percentage"
  Then  tip percentage should be "21"
  And   tip should be "2.10"
  And   total should be "12.10"
  And   per-person should be "12.10"

  When  I touch "Increase tip percentage"
  Then  tip percentage should be "22"
  And   tip should be "2.20"
  And   total should be "12.20"
  And   per-person should be "12.20"

  When  I touch "Decrease tip percentage"
  And   I touch "Decrease tip percentage"
  And   I touch "Decrease tip percentage"
  Then  tip percentage should be "19"
  And   tip should be "1.90"
  And   total should be "11.90"
  And   per-person should be "11.90"

  When  I touch "Increase number in party"
  Then  number in party should be "2"
  And   per-person should be "5.95"

  When  I touch "Increase number in party"
  And   I touch "Increase number in party"
  Then  number in party should be "4"
  And   per-person should be "2.98"

  When  I touch "Decrease number in party"
  Then  number in party should be "3"
  And   per-person should be "3.97"

  When  I touch "Clear"
  Then  check subtotal should be ""
  And   tip percentage should be "19"
  And   number in party should be "3"
  And   tip should be ""
  And   total should be ""
  And   per-person should be ""

  When   I fill in "Check subtotal" with "15.00"
  Then  tip should be "2.85"
  And   total should be "17.85"
  And   per-person should be "5.95"

