driver=$driverfx
Before do
  waitUntilEleStable 5
  logout=driver.find_elements(:id,"logout-btn")
  if logout.size>0 #and logout[0].displayed?
    logout[0].click
    waitUntilEleStable 5
  end
end
After do |scenario|
  if File.exist?('report.html')
    File.rename('report.html',"out"+$outfile_name+".html")
  end
  puts "Scenario "+scenario.name+" result is passed? "+scenario.passed?.to_s
  if not scenario.passed?
    $outio.puts "failed  scenario At #{scenario.name}, about #{scenario.exception.message}"
  end

end
at_exit do
  driver.quit
end