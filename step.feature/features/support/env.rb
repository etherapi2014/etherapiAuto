require 'rubygems'
require 'selenium-webdriver'
require 'cucumber'

time=Time.new()
$outfile_name=time.day.to_s+time.hour.to_s+time.min.to_s
$outio = File.open("out"+time.day.to_s+".txt", "a")


####
# Input capabilities for running automation on browserStack (remote browser, not free )
caps = Selenium::WebDriver::Remote::Capabilities.new
#caps['browser'] = 'Chrome'
caps['browser'] = 'Firefox'
caps['browser_version'] = '34.0'
caps['os'] = 'OS X'
caps['os_version'] = 'Yosemite'
caps['resolution'] = '1024x768'
#caps['os'] = 'Windows'
#caps['os_version'] = '7'
caps["browserstack.debug"] = "true"
caps["name"] = "Testing Selenium 2 with Ruby on BrowserStack"

#$driverfx = Selenium::WebDriver.for(:remote,
#                                 :url => "http://teametherapi1:43M94rEUkSEKX8uKvphU@hub.browserstack.com/wd/hub",
#                                 :desired_capabilities => caps)
#####


## running automation on local browser
$driver = Selenium::WebDriver.for :firefox

#$driverch = Selenium::WebDriver.for :chrome
$driverfx.manage.timeouts.script_timeout = 20
$driverfx.manage.timeouts.page_load = 60
$wait5=Selenium::WebDriver::Wait.new(:timeout=>5)
$wait7=Selenium::WebDriver::Wait.new(:timeout=>7)
$wait10=Selenium::WebDriver::Wait.new(:timeout=>10)
$wait20=Selenium::WebDriver::Wait.new(:timeout=>20)