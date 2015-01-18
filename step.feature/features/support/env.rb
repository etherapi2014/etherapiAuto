require 'rubygems'
require 'selenium-webdriver'
require 'cucumber'

time=Time.new()
$outfile_name=time.day.to_s+time.hour.to_s+time.min.to_s
$outio = File.open("out"+time.day.to_s+".txt", "a")
$driverfx = Selenium::WebDriver.for :firefox
#$driverch = Selenium::WebDriver.for :chrome
$driverfx.manage.timeouts.script_timeout = 20
$driverfx.manage.timeouts.page_load = 20
$wait5=Selenium::WebDriver::Wait.new(:timeout=>5)
$wait7=Selenium::WebDriver::Wait.new(:timeout=>7)
$wait10=Selenium::WebDriver::Wait.new(:timeout=>10)
$wait20=Selenium::WebDriver::Wait.new(:timeout=>20)