
driver=$driverfx
time=Time.new()
$outfile_name=time.day.to_s+time.hour.to_s+time.min.to_s
$outio = File.open("out"+time.day.to_s+".txt", "a")
def assert test, msg = nil
  msg ||= "Failed assertion, no message given."
  unless test then
    msg = msg.call if Proc === msg
    raise  msg
  end
  true
end
def myfindElement (*args)
  driver=$driverfx
  $wait20.until{
    element=driver.find_element(*args)
    element if element.displayed?
  }
end
def clickMyElement(*args)
  element=myfindElement(*args)
  element.click
end
def ensureModalClick eleClick,*args
  driver=$driverfx
  pageChange=false
  clickMax=5
  clicktime=0
  until pageChange
    begin
      eleClick.click
    rescue
      puts "eleClick meets StaleElementReferenceException"
    end
    modalBeforeClick=driver.find_elements(*args)
    if (modalBeforeClick.size>0)
      pageChange=true
    end
    clicktime=clicktime+1
    break if clicktime>=clickMax
  end
end
def ModalLoadStatus(*args)
  ele=myfindElement(*args)
  ele.attribute("class")
end
def waitUntilEleStable
  eleloading=1
  precount=0
  until eleloading==0
    elecount=myfindElements(:xpath,"//*").size
    eleloading=elecount-precount
    precount=elecount
    sleep 1
  end
end
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