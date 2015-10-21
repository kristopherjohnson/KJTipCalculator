Feature: Calculate tip, total, and split
  As a user
  I want to calculate tip and total
  So I can tip appropriately and split the check

Scenario Outline: Calculate tip, total, and split
  Given I am on the Main Screen
  And   all input fields are cleared
  When  I fill in "Check subtotal" with "<subtotal>"
  And   I fill in "Tip percentage" with "<percentage>"
  And   I fill in "Number in party" with "<party>"
  Then  tip should be "<tip>"
  And   total should be "<total>"
  And   per-person should be "<split>"

Examples:
  | subtotal | percentage | party | tip    | total   | split  |
  | 1000     | 18         | 4     | 180.00 | 1180.00 | 295.00 |
  | 12.34    | 15         | 2     | 1.85   | 14.19   | 7.10   |
  |          | 20         | 1     |        |         |        |
  | 1000     |            | 1     |        |         |        |
  | 1000     | 20         |       |        |         |        |
  | 1000     | 20         | 0     |        |         |        |
