driver=$driverfx
def rendering_page_until check_key
  driver=$driverfx
  results_counts=0
  results_change=1
  results_text=nil
  index_loading_number=0
  page_count=0
  max_search_results=1000
  if check_key.instance_of? String
    until results_change==0 or results_counts >= max_search_results
      element=myfindElement(:css,"div.row div.col-md-4")
      element.location_once_scrolled_into_view
      page_count=page_count+1
      sleep 2
      result_eles=myfindElements(:css,"h3.medium-title a")
      results_flash=result_eles.size
      break unless (index_loading_number..(results_flash-1)).each do |ele|
        results_text=result_eles[ele].text
        break if isContainStr(check_key,results_text)
      end
      index_loading_number=results_flash
      if results_flash>=results_counts
        results_change=results_flash-results_counts
        results_counts=results_flash
      end
    end
    if isContainStr(check_key,results_text)
      puts "found the #{check_key} at #{page_count.to_s} page"
      return true
    else
      return false
    end
  end
  if check_key.instance_of? Fixnum
    until results_change==0 or results_counts>=check_key
      element=driver.find_element(:css,"div.row div.col-md-4")
      element.location_once_scrolled_into_view
      sleep 2
      results_flash=myfindElements(:css,"h3.medium-title").size
      if results_flash>=results_counts
        results_change=results_flash-results_counts
        results_counts=results_flash
      end
    end
    if results_counts>=check_key
      true
    else
      false
    end
  end
end
Given /^Click on the Find a Therapist button on homepage$/ do
  element=myfindElement(:id,"goto-search-btn")
  ensure_click(element)
end
Then /^check search results more then (\d+) names$/ do |expect_result_number|
  #puts "results are #{results_counts} vs #{results_flash}"
  assert(rendering_page_until(expect_result_number.to_i),"search results are not shown")
end

Given /^Click on the (.*) drop list, select the item with text of (.*)$/ do |key_droplist,key_select|
  combo_element=myfindElement(:xpath,"//a[@class='chosen-single chosen-default']/span[contains(text(),'#{key_droplist}')]")
  combo_element.click
  drop_element=myfindElement(:xpath,"//div[@class='chosen-drop']//li[contains(text(),'#{key_select}')]")
  drop_element.click
end
Then /^Check (.*) is in the combo-search-box$/ do|key_select|
  combo_element=myfindElement(:xpath,"//a[@class='chosen-single']/span[contains(text(),'#{key_select}')]")
  assert(combo_element.displayed?,"#{key_select} not selected")
end

Given /^Click on the (.*) filter$/ do |action|
  if action.to_s.eql?("More")
    element=myfindElement(:css,"a.btn.expand")
  elsif action.to_s.eql?("Less")
    element=myfindElement(:css,"a.btn.expand.active")
  end
  element.click
  sleep 2
end
Then /^Verify that (.*) is (.*)$/ do |key_droplist,visibility|
  combo_element=driver.find_elements(:xpath,"//a[@class='chosen-single chosen-default']/span[contains(text(),'#{key_droplist}')]")
  if visibility.to_s.eql?("shown")
    assert(combo_element[0].displayed?,"not found #{key_droplist}")
  elsif visibility.to_s.eql?("invisible")
    assert(not(combo_element[0].displayed?)," #{key_droplist} is still there")
  end
end
Then /^Verify the Magic-search field is (.*)$/ do |visibility|
  magic_element=myfindElements(:id,"magic_search-txt")
  if visibility.eql?("shown")
    assert(magic_element[0].displayed?,"Magic-search is not shown")
  elsif visibility.eql?("invisible")
    assert(not(magic_element[0].displayed?),"Magic-search is still there")
  end
end

Then /^Enter (.*) in the Magic-search field$/ do |keyword|
  magic_element=myfindElement(:id,"magic_search-txt")
  magic_element.send_keys keyword.to_s
end
Then /^verify that (.*) is in the searching results$/ do |verify_text|
  assert(rendering_page_until(verify_text.to_s),"search results are not shown")
end
