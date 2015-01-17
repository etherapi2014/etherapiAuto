Then /^verify phone number is shown as (.*)$/ do |phone|
  element=myfindElement(:css,"div.number")
  assert(element.text.eql?(phone),"phone number is not in footer")
end
Given /^click the (.*) in the footer$/ do |link|
  eleLink=myfindElement(:xpath,"//ul[@class='footerlinks']//a[contains(text(),'#{link}')]")
  eleLink.click
end
