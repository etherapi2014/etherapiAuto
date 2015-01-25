password="12345678"
Given /^Entering (.*) can login successfully$/ do |account|
  emailEle=waitToFindElement(:id,"email_login")
  emailEle.send_keys account
  passEle=waitToFindElement(:id,"password_login")
  passEle.send_keys password
  signin=waitToFindElement(:css,"button.btn.btn-sm.btn-info.login-modal")
  signin.click
end
Then /^Verify the user (.*) login successfully$/ do |verifymsg|
  gettext=waitToFindElement(:css,"nav#main-homepage div#nav a[href*='patient']").text
  assert(isContainStr(gettext,verifymsg),"user not login")
end
Then /^verify (.*) can logout$/ do |user|
  waitUntilEleStable 10
  if user.eql?("patient")
    logout=waitToFindElement(:id,"logout-btn")
  elsif user.eql?("therapist")
    logout=waitToFindElement(:id,"nav-logout")
  end
  logout.click
  waitUntilEleStable 10
  loginele=waitToFindElement(:css,"a.login-btn")
  assert(loginele.displayed?,"not logout successfully")
end