Given /^I am on the Main Screen$/ do
  element_exists("view")
  sleep(STEP_PAUSE)
end

When /^all input fields are cleared$/ do
  clear_text("textField marked: 'Check subtotal'")
  clear_text("textField marked: 'Tip percentage'")
  clear_text("textField marked: 'Number in party'")
end

Then /^tip should be "(.*)"$/ do |expected_text|
  actual_text = query("label accessibilityLabel:'Tip'", :text).first
  unless expected_text == actual_text
    fail "Tip is incorrect. Expected '#{expected_text}', but got '#{actual_text}'."
  end
end

Then /^total should be "(.*)"$/ do |expected_text|
  actual_text = query("label accessibilityLabel:'Total'", :text).first
  unless expected_text == actual_text
    fail "Total is incorrect. Expected '#{expected_text}', but got '#{actual_text}'."
  end
end

Then /^per-person should be "(.*)"$/ do |expected_text|
  actual_text = query("label accessibilityLabel:'Per person'", :text).first
  unless expected_text == actual_text
    fail "Per-person is incorrect. Expected '#{expected_text}', but got '#{actual_text}'."
  end
end
