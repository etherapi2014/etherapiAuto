pw="12345678"
Then /^click on radio button for (.*)$/ do|client|
  clickMyElement(:id,"#{client}-account")
end
Then /^type (.*), (.*), and (.*) in the signup modal$/ do |firstname, lastname,email|
  findElementOne(:id,"first_name").send_keys firstname
  findElementOne(:id,"last_name").send_keys lastname
  findElementOne(:id,"email").send_keys email
end
Then /^type all required information, verify register mail (.*) receiving confirmation$/ do |registemail|
  findElementOne(:id,"password").send_keys pw
  findElementOne(:id,"password_confirmation").send_keys pw
  findElementOne(:css,"div#signup-modal label.switch.switch-primary span").click
  waitToFindElement(:css,"button.btn.btn-sm.btn-info.sign-up-btn").click
  check_confir_mail registemail
end