Feature: Calculate tip, total, and split
  As a user
  I want to calculate tip and total
  So I can tip appropriately and split the check

Scenario: Don't display calculated values if no input
  Given I am on the Main Screen
  Then  check subtotal should be ""
  And   tip should be ""
  And   total should be ""
  And   per-person should be ""

Scenario: Calculate tip for $1000, 18%, 4 people
  Given I am on the Main Screen
  And   all input fields are cleared
  When  I fill in text fields as follows:
   | field           | text |
   | Check subtotal  | 1000 |
   | Tip percentage  | 18   |
   | Number in party | 4    |
  Then  tip should be "180.00"
  And   total should be "1180.00"
  And   per-person should be "295.00"

Scenario: Calculate tip for $12.34, 15%, 2 people
  Given I am on the Main Screen
  And   all input fields are cleared
  When  I fill in text fields as follows:
   | field           | text  |
   | Check subtotal  | 12.34 |
   | Tip percentage  | 15    |
   | Number in party | 2     |
  Then  tip should be "1.85"
  And   total should be "14.19"
  And   per-person should be "7.10"

