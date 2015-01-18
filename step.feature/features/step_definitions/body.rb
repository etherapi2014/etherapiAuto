
driver=$driverfx

Given /^Clicking (.*) on body$/ do |link|
  element=waitToFindElement(:xpath,"//img[contains(@src,'#{link}')]")
  ensure_click_new_page(element)
end
Then /^Verify the directed page (.*) contains (.*)$/ do |link,page_verify|
  waitUntilEleStable 10
  assert(verifyMsgInPage(page_verify),"not direct to #{link}")
end
Then /^Close new windows$/ do
  driver.close
  driver.switch_to.window(driver.window_handles.first)
end
Given /^Click on the arrow (\d+) times on up carousel$/ do |counts|
  element=waitToFindElement(:css,"div.carousel.slide a.right.carousel-control")
  if (counts.to_i>0)
    (1..counts.to_i).each do
      element.click
      sleep 1
    end
  end
end
Then /^Verify the (.*) on up carousel by clicking the arrow$/ do |verifytext|
  ele_right_arrow=waitToFindElement(:css,"div.carousel.slide a.right.carousel-control")
  elements=waitToFindElements(:css,"div.col-md-5 h3")
  shown_element=nil
  (0..4).each do  # loops for clicking the arrow, break loops if shown element's text matches the verifytext
    elements.each do |ele|
      if ele.displayed?
        shown_element=ele
      end
    end
    if (shown_element.text.eql?(verifytext))
      break
    end
    ele_right_arrow.click
    sleep 1
  end
  assert(shown_element.text.eql?(verifytext),"not found #{verifytext}")
end
Then /^Click on the Find a Therapist button (\d+)$/ do |count|
  elements=waitToFindElements(:css,"a[class='btn btn-primary btn-lg']")
  #countnum=0
  #hash = Hash[elements.map.with_index.to_a]
  elements.each do |ele|
    if ele.displayed?
      #puts "where is the visible element? " + hash[ele].to_s + " the button number is "+count.to_s
      ensure_click(ele)
      break
    end
  end
end
Then /^Verify page direct to search page$/ do
  element=waitToFindElement(:css,"div[class='search-result-container full-width']")
  assert(element.displayed?,"not direct to search page")
end
Given /^Click on the arrow (\d+) times on lower carousel$/ do |count|
  if (count.to_i>0)
    element=waitToFindElement(:css,"div.container.inner a.right.carousel-control")
    (1..count.to_i).each do
      element.click
      sleep 1
    end
  end
end
Then /^Verify the (.*) on lower carousel$/ do |verifyText|
  elements=waitToFindElements(:xpath,"//img[@class='img-circle']/following-sibling::strong")
  shown_element=nil
  elements.each do |ele|  # find out which element is visible => shown element
    if ele.displayed?
        shown_element=ele
    end
  end
  assert(isContainStr(verifyText,shown_element.text),"not found #{verifyText}")
end
