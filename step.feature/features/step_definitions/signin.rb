password=""
Given /^Entering (.*) can login successfully$/ do |account|
  if account.eql?("p.etherapi00+")
    email=account+$extraluserID.to_s+"@gmail.com"
  else
    email=account
  end
  emailEle=waitToFindElement(:id,"email_login")
  emailEle.send_keys email
  passEle=waitToFindElement(:id,"password_login")
  passEle.send_keys password
  signin=waitToFindElement(:css,"button.btn.btn-sm.btn-info.login-modal")
  signin.click
end
Then /^Verify the user (.*) login successfully$/ do |verifymsg|
  gettext=waitToFindElement(:css,"nav#main-homepage div#nav a[href*='patient']").text
  if $name_newuser.eql?('')
    assert(isContainStr(gettext,verifymsg),"user not login")
  else
    assert(isContainStr(gettext,$name_newuser),"user not login")
    $name_newuser=''
  end
end
Then /^verify user can logout$/ do
  waitUntilEleStable 10
  logout=findElementArray(:id,"logout-btn")
  if logout.size>0
    logout[0].click
  end
  logout=findElementArray(:id,"nav-logout")
  if logout.size>0
    logout[0].click
  end
end
