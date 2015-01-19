require 'timeout'
def getdriver
  @driver=$driverfx
end
Given /^Use the url as (.*)$/ do |givenUrl|
  driver=getdriver
  $uRL=givenUrl
  driver.get $uRL
end
## simple assert to veriy test is successfull or not, if not, msg will print
def assert test, msg = nil
  msg ||= "Failed assertion, no message given."
  unless test then
    msg = msg.call if Proc === msg
    raise  msg
  end
  true
end
## until element is found, driver will wait max 20 secs. As soon as it's found , waiting will stop.
def findElementArray *args
  driver=getdriver
  driver.find_elements(*args)
end

def findElementOne *args
  driver=getdriver
  driver.find_element(*args)
end
def waitToFindElement (*args)
  $wait20.until{
    element=findElementOne(*args)
    element if element.displayed?
  }
end
# merge click and waitToFindElement together.
def clickMyElement(*args)
  element=waitToFindElement(*args)
  element.click
end
# keep wait 1 sec until element number in the page is not increased anymore.
def waitUntilEleStable maxwait=1
  eleloading=1
  precount=0
  count=0
  until eleloading==0 or count >= maxwait
    elecount=findElementArray(:xpath,"//*").size
    eleloading=elecount-precount
    precount=elecount
    sleep 1
    count=count+1
  end
end
# keep scrolling down until check_key is found
# check key can be number of search results, or specific string
# welcome to modify this part
def rendering_page_until check_key
  results_counts=0
  results_change=1
  results_text=nil
  index_loading_number=0
  page_count=0
  max_search_results=1000
  if check_key.instance_of? String
    until results_change==0 or results_counts >= max_search_results
      element=waitToFindElement(:css,"div.row div.col-md-4")
      element.location_once_scrolled_into_view
      page_count=page_count+1
      sleep 2
      result_eles=waitToFindElements(:css,"h3.medium-title a")
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
      element=findElementOne(:css,"div.row div.col-md-4")
      element.location_once_scrolled_into_view
      sleep 2
      results_flash=waitToFindElements(:css,"h3.medium-title").size
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
# until 20s is up, find elements
def waitToFindElements *args
  $wait20.until{findElementArray(*args).size>0}
  findElementArray(*args)
end
## until the URL is changed, keep clicking the element, but not more than 5 times
def ensure_click element
  driver=$driverfx
  pageChange=false
  clickMax=5
  clicktime=0
  until pageChange
    urlbeforeClick=driver.current_url
    element.click
    urlafterClick=driver.current_url
    if urlafterClick!=urlbeforeClick
      pageChange=true
    end
    clicktime=clicktime+1
    if clicktime>=clickMax
      puts "Not sure it is directed"
      break
    end
  end
end
# until a new page is opened to another window, the driver will keep clicking the element
def ensure_click_new_page element
  driver=getdriver
  pageChange=false
  clickMax=5
  clicktime=0
  titleBeforeClick=driver.title
  until pageChange
    element.click
    windowlist=driver.window_handles
    driver.switch_to.window(windowlist.last)
    begin
       titleAfterClick=driver.title
    rescue
      driver.action.send_keys(:escape).perform
    end
    if (windowlist.size>1)
      unless titleAfterClick.eql?(titleBeforeClick)
        pageChange=true
      end
      clicktime=clicktime+1
      return false if clicktime>=clickMax
    else
      false
    end
  end
end
# see if a Msg shown in a element's attribution/text inside the page
def verifyMsgInPage msgstr
  eleToVerify=waitToFindElements(:xpath,"//*[contains(text(),\"#{msgstr}\") or contains(@*,\"#{msgstr}\")]")
  if eleToVerify.size>0
    true
  else
    false
  end
end
# find out if a str is in a sentence
def isContainStr(str,sentence)
  if !!(sentence =~ Regexp.new(str, true)) or str.gsub(/\s+/, "").eql?(sentence.gsub(/\s+/, ""))
    true
  end
end
# locate the date for booking inside cal
def findDayinCalendar findDay,findMonth
  visibledate=waitToFindElement(:css,"span.fc-header-title h2").text
  visibleMon=visibledate[0..2]
  visibleDay=visibledate.scan /\s\d{1,2}\s/
  while findDay.to_i>visibleDay[1].to_i or not findMonth.eql?(visibleMon)
    nextClick=waitToFindElement(:css,"span.fc-button.fc-button-next.fc-state-default.fc-corner-right")
    nextClick.click
    visibledate=waitToFindElement(:css,"span.fc-header-title h2").text
    visibleDay=visibledate.scan /\s\d{1,2}\s/
    visibleMon=visibledate[0..2]
  end
end
# find the element for booking hours
def findVertHour hours
  hour=hours.match(/\d{1,2}/)
  if hours.match(/\w{2}$/)[0].eql?('pm')
    hour24=hour[0].to_i+12
  end
  hourEleLocal=hour24*4
  hourtoClick=waitToFindElement(:css,"tr[class*=fc-slot#{hourEleLocal.to_s}] td")
  hourtoClick.location_once_scrolled_into_view
  sleep 3
  hourtoClick
end

# ensure the modal is shown for a element(login modal, sign up modal ) not used
#def ensureModalClick eleClick,*args
#  driver=$driverfx
#  pageChange=false
#  clickMax=5
#  clicktime=0
#  until pageChange
#    begin
#      eleClick.click
#    rescue
#      puts "eleClick meets StaleElementReferenceException"
#    end
#    modalBeforeClick=driver.find_elements(*args)
#    if (modalBeforeClick.size>0)
#      pageChange=true
#    end
#    clicktime=clicktime+1
#    break if clicktime>=clickMax
#  end
#end
#def ModalLoadStatus(*args)
#  ele=waitToFindElement(*args)
#  ele.attribute("class")
#end