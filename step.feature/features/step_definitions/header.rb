
driver=getdriver
When /^verify header is shown$/ do
  element=waitToFindElement(:id,"main-homepage")
  assert(element.displayed?,"header is not shown")
end

Then /^scrolling down to (.*)$/ do |location|
  element=waitToFindElement(:id,"#{location}")
  element.location_once_scrolled_into_view
end
Given /^Click logo to the homepage$/ do
  element1=findElementArray(:css,"a.navbar-brand")
  element2=findElementArray(:css,"a[title='Home']")
  element3=findElementArray(:id,"main-logo")
  if (element1.size >0)
    element1[0].click
  elsif (element2.size >0)
    element2[0].click
  elsif element3.size>0
    element3[0].click
  end
  element=waitToFindElement(:xpath,"//div[@class='col-sm-10 col-sm-offset-1']/h1[contains(text(),'Need to talk?')]")
  assert(element.displayed?,'Homepage is not loaded')
end
Then /^Verify clicking (.*) on header menu will load to (.*)$/ do|ele,verifyMsg|
  waitUntilEleStable 10
  clickMyElement(:xpath,"//ul[@class='nav navbar-nav']//a[contains(text(),'#{ele}')]")
  assert(verifyMsgInPage(verifyMsg) ,"#{verifyMsg} is not shown")

end
Then /^Check the modal can be removed$/ do
  ele=findElementArray(:css,"body.modal-open")
  driver.action.send_keys(:escape).perform if ele.size>0
end