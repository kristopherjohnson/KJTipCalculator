Given /^I am on the Main Screen$/ do
  element_exists("view")
  sleep(STEP_PAUSE)
end

When /^all input fields are cleared$/ do
  clear_text("textField marked: 'Check subtotal'")
  clear_text("textField marked: 'Tip percentage'")
  clear_text("textField marked: 'Number in party'")
end
