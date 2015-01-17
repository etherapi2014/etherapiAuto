require 'rubygems'
require 'selenium-webdriver'
require 'cucumber'
#require 'rspec/expectations'
#require  'minitest/assertions'

$driverfx = Selenium::WebDriver.for :firefox
#$driverch = Selenium::WebDriver.for :chrome
$driverfx.manage.timeouts.implicit_wait = 0
$driverfx.manage.timeouts.script_timeout = 60
$driverfx.manage.timeouts.page_load = 120
$wait5=Selenium::WebDriver::Wait.new(:timeout=>5)
$wait7=Selenium::WebDriver::Wait.new(:timeout=>7)
$wait10=Selenium::WebDriver::Wait.new(:timeout=>10)
$wait20=Selenium::WebDriver::Wait.new(:timeout=>20)