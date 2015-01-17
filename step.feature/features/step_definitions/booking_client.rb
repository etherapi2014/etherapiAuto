
def findDayinCalendar findDay,findMonth
  visibledate=myfindElement(:css,"span.fc-header-title h2").text
  visibleMon=visibledate[0..2]
  visibleDay=visibledate.scan /\s\d{1,2}\s/
  while findDay.to_i>visibleDay[1].to_i or not findMonth.eql?(visibleMon)
    nextClick=myfindElement(:css,"span.fc-button.fc-button-next.fc-state-default.fc-corner-right")
    nextClick.click
    visibledate=myfindElement(:css,"span.fc-header-title h2").text
    visibleDay=visibledate.scan /\s\d{1,2}\s/
    visibleMon=visibledate[0..2]
  end
end
def findVertHour hours
  hour=hours.match(/\d{1,2}/)
  if hours.match(/\w{2}$/)[0].eql?('pm')
    hour24=hour[0].to_i+12
  end
  hourEleLocal=hour24*4
  hourtoClick=myfindElement(:css,"tr[class*=fc-slot#{hourEleLocal.to_s}] td")
  hourtoClick.location_once_scrolled_into_view
  sleep 3
  hourtoClick
end
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
