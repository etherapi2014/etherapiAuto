password="12345678"
Given /^Entering (.*) can login successfully$/ do |account|
  emailEle=myfindElement(:id,"email_login")
  emailEle.send_keys account
  passEle=myfindElement(:id,"password_login")
  passEle.send_keys password
  signin=myfindElement(:css,"button.btn.btn-sm.btn-info.login-modal")
  signin.click
end

Then /^verify (.*) can logout$/ do |user|
  waitUntilEleStable
  if user.eql?("patient")
    logout=myfindElement(:id,"logout-btn")
  elsif user.eql?("therapist")
    logout=myfindElement(:id,"nav-logout")
  end
  logout.click
  waitUntilEleStable
  loginele=myfindElement(:css,"a.login-btn")
  assert(loginele.displayed?,"not logout successfully")
end