
driver=$driverfx
When /^verify header is shown$/ do
  element=myfindElement(:id,"main-homepage")
  assert(element.displayed?,"header is not shown")
end

Then /^scrolling down to (.*)$/ do |location|
  element=myfindElement(:id,"#{location}")
  element.location_once_scrolled_into_view
end
Given /^Click logo to the homepage$/ do
  element1=driver.find_elements(:css,"a.navbar-brand")
  element2=driver.find_elements(:css,"a[title='Home']")
  element3=driver.find_elements(:id,"main-logo")
  #wait[2].until{element.displayed?}
  if (element1.size >0)
    element1[0].click
  elsif (element2.size >0)
    element2[0].click
  elsif element3.size>0
    element3[0].click
  end
  element=myfindElement(:xpath,"//div[@class='col-sm-10 col-sm-offset-1']/h1[contains(text(),'Need to talk?')]")
  assert(element.displayed?,'Homepage is not loaded')
end
Then /^Verify clicking (.*) on header menu will load to (.*)$/ do|ele,verifyMsg|
  waitUntilEleStable
  clickMyElement(:xpath,"//ul[@class='nav navbar-nav']//a[contains(text(),'#{ele}')]")
  assert(verifyMsgInPage(verifyMsg) ,"#{verifyMsg} is not shown")

end
Then /^Check the modal can be removed$/ do
  ele=driver.find_elements(:css,"body.modal-open")
  driver.action.send_keys(:escape).perform if ele.size>0
end