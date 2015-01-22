
Given /^Click on the Find a Therapist button on homepage$/ do
  element=waitToFindElement(:id,"goto-search-btn")
  ensure_click(element)
end
Then /^check search results more then (\d+) names$/ do |expect_result_number|
  #puts "results are #{results_counts} vs #{results_flash}"
  assert(rendering_page_until(expect_result_number.to_i),"search results are not shown")
end

Given /^Click on the (.*) drop list, select the item with text of (.*)$/ do |key_droplist,key_select|
  combo_element=waitToFindElement(:xpath,"//a[@class='chosen-single chosen-default']/span[contains(text(),'#{key_droplist}')]")
  combo_element.click
  drop_element=waitToFindElement(:xpath,"//div[@class='chosen-drop']//li[contains(text(),'#{key_select}')]")
  drop_element.click
end
Then /^Check (.*) is in the combo-search-box$/ do|key_select|
  combo_element=waitToFindElement(:xpath,"//a[@class='chosen-single']/span[contains(text(),'#{key_select}')]")
  assert(combo_element.displayed?,"#{key_select} not selected")
end

Given /^Click on the (.*) filter$/ do |action|
  if action.to_s.eql?("More")
    element=waitToFindElement(:css,"a.btn.expand")
  elsif action.to_s.eql?("Less")
    element=waitToFindElement(:css,"a.btn.expand.active")
  end
  element.click
  sleep 2
end
Then /^Verify that (.*) is (.*)$/ do |key_droplist,visibility|
  combo_element=findElementArray(:xpath,"//a[@class='chosen-single chosen-default']/span[contains(text(),'#{key_droplist}')]")
  if visibility.to_s.eql?("shown")
    assert(combo_element[0].displayed?,"not found #{key_droplist}")
  elsif visibility.to_s.eql?("invisible")
    assert(not(combo_element[0].displayed?)," #{key_droplist} is still there")
  end
end
Then /^Verify the Magic-search field is (.*)$/ do |visibility|
  magic_element=waitToFindElements(:id,"magic_search-txt")
  if visibility.eql?("shown")
    assert(magic_element[0].displayed?,"Magic-search is not shown")
  elsif visibility.eql?("invisible")
    assert(not(magic_element[0].displayed?),"Magic-search is still there")
  end
end

Then /^Enter (.*) in the Magic-search field$/ do |keyword|
  magic_element=waitToFindElement(:id,"magic_search-txt")
  magic_element.send_keys keyword.to_s
end
Then /^verify that (.*) is in the searching results$/ do |verify_text|
  assert(rendering_page_until(verify_text.to_s),"search results are not shown")
end
