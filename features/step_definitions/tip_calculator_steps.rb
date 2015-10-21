Given /^I am on the Main Screen$/ do
  element_exists("view")
  sleep(STEP_PAUSE)
end

When /^all input fields are cleared$/ do
  clear_text("textField marked: 'Check subtotal'")
  clear_text("textField marked: 'Tip percentage'")
  clear_text("textField marked: 'Number in party'")
end

Then /^check subtotal should be "(.*)"$/ do |expected_text|
  actual_text = query("textField marked: 'Check subtotal'", :text).first
  unless expected_text == actual_text
    fail "Check subtotal is incorrect. Expected '#{expected_text}', but got '#{actual_text}'."
  end
end

Then /^tip percentage should be "(.*)"$/ do |expected_text|
  actual_text = query("textField marked: 'Tip percentage'", :text).first
  unless expected_text == actual_text
    fail "Tip percentage is incorrect. Expected '#{expected_text}', but got '#{actual_text}'."
  end
end

Then /^number in party should be "(.*)"$/ do |expected_text|
  actual_text = query("textField marked: 'Number in party'", :text).first
  unless expected_text == actual_text
    fail "Number in party is incorrect. Expected '#{expected_text}', but got '#{actual_text}'."
  end
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
