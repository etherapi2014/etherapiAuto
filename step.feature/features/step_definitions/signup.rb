pw="12345678"
$extraluserID=''
$name_newuser=''
Then /^click on radio button for (.*)$/ do|client|
  clickMyElement(:id,"#{client}-account")
end
Then /^type (.*), (.*), and (.*) in the signup modal$/ do |firstname, lastname,email|
  range = [*'0'..'9', *'a'..'z']
  $extraluserID=Array.new(6){range.sample}.join
  if firstname.eql?("auto_")
    findElementOne(:id,"first_name").send_keys firstname+$extraluserID.to_s
    findElementOne(:id,"last_name").send_keys lastname
    findElementOne(:id,"email").send_keys email+$extraluserID.to_s+"@gmail.com"
    $name_newuser=firstname+$extraluserID.to_s+" "+lastname
  else
    findElementOne(:id,"first_name").send_keys firstname
    findElementOne(:id,"last_name").send_keys lastname
    findElementOne(:id,"email").send_keys email
  end
end
Then /^type all required information, verify register mail (.*) receiving confirmation$/ do |registemail|
  findElementOne(:id,"password").send_keys pw
  findElementOne(:id,"password_confirmation").send_keys pw
  findElementOne(:css,"div#signup-modal label.switch.switch-primary span").click
  waitToFindElement(:css,"button.btn.btn-sm.btn-info.sign-up-btn").click
  if registemail.eql?('p.etherapi00+')
    email=registemail+$extraluserID.to_s+"@gmail.com"
  else
    email=registemail
  end
  check_confir_mail email
end