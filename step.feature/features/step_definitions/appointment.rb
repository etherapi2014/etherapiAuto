#
#
# Those functions can be modified to be suitable for both therapist and patient
#
#
driver=$driverfx
Then /^Click on the Provider Name field, type in (.*)$/ do |nameSearch|
  nameSearchEle=waitToFindElement(:id,"name-txt")
  nameSearchEle.send_keys nameSearch
end
Then /^Click on search results with (.*)$/ do |nameForVerify|
  if(rendering_page_until nameForVerify)
    nameClick=waitToFindElement(:xpath,"//h3[@class='medium-title']/a[contains(text(),'#{nameForVerify}')]")
    nameClick.click
  end
end
Then /^Click on Request Appointment$/ do
  waitUntilEleStable 10
  requestEle=waitToFindElement(:xpath,"//form[@class='form-horizontal']//button[@class='btn btn-info' and contains(text(),'Request Appointment')]")
  requestEle.click
end
Then /^Requesting session on (\d+)-(.*)-(\d+), (.*)$/ do |day,month,year,timeInHour|
  waitUntilEleStable 10
  findDayinCalendar day,month
  selectHr=findVertHour timeInHour
  horizonCoor=waitToFindElement(:xpath,"//th[contains(text(),'/#{day}')]").location
  driver.action.move_to(selectHr, horizonCoor['x']-selectHr.location['x']+20, 10).perform
  driver.action.click.perform
  reqAppoint=waitToFindElement(:id,"schedule-appointment-btn")
  reqAppoint.click
end
Then /^Finish the Payment request with (.*), (.*)$/ do |payType,insurance|
  payDropbox=waitToFindElement(:xpath,"//a[@class='chosen-single chosen-default']/span[contains(text(),'Select Payment Type')]")
  payDropbox.click
  waitToFindElement(:xpath,"//ul[@class='chosen-results']/li[contains(text(),'#{payType}')]").click
  insuranceDropbox=waitToFindElement(:xpath,"//a[@class='chosen-single chosen-default']/span[contains(text(),'Select Insurance Plan')]")
  insuranceDropbox.click
  waitToFindElement(:xpath,"//ul[@class='chosen-results']/li[contains(text(),'#{insurance}')]").click
  waitToFindElement(:id,'term-cb').click
  waitToFindElement(:id,'rules-cb').click
  waitToFindElement(:id,"request-appointment-btn").click
end
Then /^Verify the request of (.*) is pending at (.*), (.*)$/ do |verifyname,verifyDate,verifyHour|
  waitUntilEleStable 10
  verifypendingDate=waitToFindElement(:xpath,"//div[@id='request-section']//span[contains(text(),'#{verifyDate}')]")
  verifypendinghour=waitToFindElement(:xpath,"//div[@id='request-section']//span[contains(text(),'#{verifyHour}')]")
  verifypedningName=waitToFindElement(:xpath,"//div[@id='request-section']//a[contains(text(),'#{verifyname}')]")
  assert((verifypendingDate.displayed?) && (verifypendinghour.displayed?)&& (verifypedningName.displayed?),'request is not pending')
end
Then /^verify user directed to appointment list page$/ do
  listview=waitToFindElement(:css,"div[id='appointments-layout'] li[class='active'] a")
  if listview.text.eql?('List View')
    puts'successfully proceed to check appointment'
  else
    waitToFindElement(:xpath,"//div[@id='appointments-layout']//a[contains(text(),'List View')]").click
  end
end
Then /^click on confirm the appointment from (.*), pending at (.*), (.*)$/ do |verifyname,verifyDate,verifyHour|
  xPath_button="//div[@class='data-row'][.//a[contains(text(),'#{verifyname}')]]"+
        "[.//span[contains(text(),'#{verifyDate}')]]"+
        "[.//span[contains(text(),'#{verifyHour}')]]"+
        "//button[contains(text(),Confirm)]"
  waitToFindElement(:xpath,xPath_button).click
end
Then /^Verify the appointment from (.*) is confirmed at (.*), (.*)$/ do |verifyname,verifyDate,verifyHour|
  confirm_modal=waitToFindElement(:xpath,"//div[@id='confirm-modal']//h3")
  #assert(isContainStr(verifyname,confirm_modal.text),'not found confirmation')
  if isContainStr(verifyname,confirm_modal.text)
    driver.action.send_keys(:escape).perform
  end
  driver.navigate.refresh
  waitUntilEleStable 10
  verifypendingDate=waitToFindElement(:xpath,"//div[@id='upcoming-section']//span[contains(text(),'#{verifyDate}')]")
  verifypendinghour=waitToFindElement(:xpath,"//div[@id='upcoming-section']//span[contains(text(),'#{verifyHour}')]")
  verifypedningName=waitToFindElement(:xpath,"//div[@id='upcoming-section']//a[contains(text(),'#{verifyname}')]")
  assert((verifypendingDate.displayed?) && (verifypendinghour.displayed?)&& (verifypedningName.displayed?),'request is not pending')

end