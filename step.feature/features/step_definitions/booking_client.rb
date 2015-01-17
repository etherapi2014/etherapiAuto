
Then /^Click on the Provider Name field, type in (.*)$/ do |nameSearch|
  nameSearchEle=myfindElement(:id,"name-txt")
  nameSearchEle.send_keys nameSearch
end
Then /^Click on search results with (.*)$/ do |nameForVerify|
  if(rendering_page_until nameForVerify)
    nameClick=myfindElement(:xpath,"//h3[@class='medium-title']/a[contains(text(),'#{nameForVerify}')]")
    nameClick.click
  end
end
Then /^Click on Request Appointment$/ do
  waitUntilEleStable
  requestEle=myfindElement(:xpath,"//form[@class='form-horizontal']//button[@class='btn btn-info' and contains(text(),'Request Appointment')]")
  requestEle.click
end
Then /^Requesting session on (\d+)-(.*)-(\d+), (.*)$/ do |day,month,year,timeInHour|
  waitUntilEleStable
  findDayinCalendar day,month
  selectHr=findVertHour timeInHour
  horizonCoor=myfindElement(:xpath,"//th[contains(text(),'/#{day}')]").location
  $driverfx.action.move_to(selectHr, horizonCoor['x']-selectHr.location['x']+20, 10).perform
  $driverfx.action.click.perform
  reqAppoint=myfindElement(:id,"schedule-appointment-btn")
  reqAppoint.click
end
Then /^Finish the Payment request with (.*), (.*)$/ do |payType,insurance|
  payDropbox=myfindElement(:xpath,"//a[@class='chosen-single chosen-default']/span[contains(text(),'Select Payment Type')]")
  payDropbox.click
  paymentChoose=myfindElement(:xpath,"//ul[@class='chosen-results']/li[contains(text(),'#{payType}')]").click
  insuranceDropbox=myfindElement(:xpath,"//a[@class='chosen-single chosen-default']/span[contains(text(),'Select Insurance Plan')]")
  insuranceDropbox.click
  insuranceChoose=myfindElement(:xpath,"//ul[@class='chosen-results']/li[contains(text(),'#{insurance}')]").click
  checkAgreeCb=myfindElement(:id,'term-cb').click
  checkAgreePR=myfindElement(:id,'rules-cb').click
  requestBtn=myfindElement(:id,"request-appointment-btn").click
end
Then /^Verify the request is pending at (.*), (.*)$/ do |verifyDate,verifyHour|
  waitUntilEleStable
  verifypendingDate=myfindElement(:xpath,"//div[@id='request-section']//span[contains(text(),'#{verifyDate}')]")
  verifypendinghour=myfindElement(:xpath,"//div[@id='request-section']//span[contains(text(),'#{verifyHour}')]")
  assert((verifypendingDate.displayed?) && (verifypendinghour.displayed?),'request is not pending')
end
