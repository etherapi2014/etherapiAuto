
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
  $driverfx.action.move_to(selectHr, horizonCoor['x']-selectHr.location['x']+20, 10).perform
  $driverfx.action.click.perform
  reqAppoint=waitToFindElement(:id,"schedule-appointment-btn")
  reqAppoint.click
end
Then /^Finish the Payment request with (.*), (.*)$/ do |payType,insurance|
  payDropbox=waitToFindElement(:xpath,"//a[@class='chosen-single chosen-default']/span[contains(text(),'Select Payment Type')]")
  payDropbox.click
  paymentChoose=waitToFindElement(:xpath,"//ul[@class='chosen-results']/li[contains(text(),'#{payType}')]").click
  insuranceDropbox=waitToFindElement(:xpath,"//a[@class='chosen-single chosen-default']/span[contains(text(),'Select Insurance Plan')]")
  insuranceDropbox.click
  insuranceChoose=waitToFindElement(:xpath,"//ul[@class='chosen-results']/li[contains(text(),'#{insurance}')]").click
  checkAgreeCb=waitToFindElement(:id,'term-cb').click
  checkAgreePR=waitToFindElement(:id,'rules-cb').click
  requestBtn=waitToFindElement(:id,"request-appointment-btn").click
end
Then /^Verify the request is pending at (.*), (.*)$/ do |verifyDate,verifyHour|
  waitUntilEleStable 10
  verifypendingDate=waitToFindElement(:xpath,"//div[@id='request-section']//span[contains(text(),'#{verifyDate}')]")
  verifypendinghour=waitToFindElement(:xpath,"//div[@id='request-section']//span[contains(text(),'#{verifyHour}')]")
  assert((verifypendingDate.displayed?) && (verifypendinghour.displayed?),'request is not pending')
end
