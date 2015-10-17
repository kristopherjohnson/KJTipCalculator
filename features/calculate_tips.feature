Feature: Calculate tips
  As a customer
  I want to calculate tips
  So I can tip appropriately

Scenario: Calculate tip for $1000, 18%, 4 people
  Given I am on the Main Screen
  And all input fields are cleared
  When I fill in text fields as follows:
   | field           | text |
   | Check subtotal  | 1000 |
   | Tip percentage  | 18   |
   | Number in party | 4    |
  Then I see the text "180.00"
  And I see the text "1180.00"
  And I see the text "295.00"

Scenario: Calculate tip for $12.34, 15%, 2 people
  Given I am on the Main Screen
  And all input fields are cleared
  When I fill in text fields as follows:
   | field           | text  |
   | Check subtotal  | 12.34 |
   | Tip percentage  | 15    |
   | Number in party | 2     |
  Then I see the text "1.85"
  And I see the text "14.19"
  And I see the text "7.10"

