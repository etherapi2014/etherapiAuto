#$for x in {1..1}; do cucumber --tags @Header; done
Feature: stage regression test
  Background: Use staging URL
    Given Use the url as http://54.68.0.140
  @Signup
  Scenario Outline: User sign up as patient
    Given  Verify clicking Sign Up on header menu will load to Have an account?
    Then click on radio button for patient
    Then type <first name>, <last name>, and <email address> in the signup modal
    Given type all required information, verify register mail <email address> receiving confirmation
  Examples:
    |first name|last name|email address|
    |autotest_60|chung|p.etherapi00+auto60@gmail.com|
  @Signin
  Scenario Outline: Signin with valid patient account
    Given Verify clicking Login on header menu will load to Log In
    Given Entering <account> can login successfully
    Then Verify the user <verifyMsg> login successfully
    Then verify patient can logout
    Examples:
    |account                 |verifyMsg                      |
    |p.etherapi00+auto60@gmail.com|autotest_60 chung|
    |p.etherapi00+1@gmail.com|Kathy Perry p.etherapi00+1@gmail.com|
    |p.etherapi00+2@gmail.com|Tim Jackson p.etherapi00+2@gmail.com|
    |p.etherapi00+3@gmail.com|Amanda Lau Zerothreepatient|
  @appointment @patient
  Scenario Outline: client book a session
    Given Verify clicking Login on header menu will load to Log In
    Given Entering <account> can login successfully
    Then Verify the directed page <account> contains <verifyMsg>
    Given Click on the More filter
    Given Click on the Provider Name field, type in <nameForSearch>
    Then Click on the Find a Therapist button on homepage
    Then Click on search results with <nameForVerify>
    Then Click on Request Appointment
    Then Requesting session on 28-Feb-2015, 8pm
    Then Finish the Payment request with Visa, Anthem Blue Cross
    Then Verify the request from <verifyMsg> is pending at 02/28/2015, 8:00 PM
  Examples:
    |account                 |verifyMsg |nameForSearch|nameForVerify                 |
    |p.etherapi00+3@gmail.com|Amanda Lau|Terry |Terry ZerofiveTherpist|
  @Signin @therapist
  Scenario Outline: Signin with valid therapist account
    Given Verify clicking Login on header menu will load to Log In
    Given Entering <account> can login successfully
    Then Verify the directed page <account> contains <verifyMsg>
    Then verify therapist can logout
    Examples:
    |account                 |verifyMsg                           |
    |t.etherapi00+2@gmail.com|Ava Chapell t.etherapi00+2@gmail.com|
    |t.etherapi00+10@gmail.com|t.etherapi00+10 @gmail.com|
    |t.etherapi00+3@gmail.com|Janet Hapkin t.etherapi00+3@gmail.com|
    |t.etherapi00+4@gmail.com|TinaFour t.etherapi00+4@gmail.com|
  @appointment @therapist
  Scenario Outline: Therapist confirm an appointment
    Given Verify clicking Login on header menu will load to Log In
    And Entering t.etherapi00+5@gmail.com can login successfully
    And Verify the directed page t.etherapi00+5@gmail.com contains Terry ZerofiveTherpist
    Then verify user directed to appointment list page
    Then Verify the request from <name> is pending at <date>, <time>
    Then click on confirm the appointment from <name>, pending at <date>, <time>
    Then Verify the appointment from <name> is confirmed at <date>, <time>
    Examples:
    |name|date|time|
    | Amanda Lau|01/28/2015| 1:00 AM|
    #Then verify therapist can logout
  @Header
  Scenario: Verify header menu fixed on top as user scrolling down
    Given verify header is shown
    Then scrolling down to contact-us-session
    Then verify header is shown
  @Header
  Scenario Outline: Verify header elements are functional
    Given  Verify clicking <element> on header menu will load to <location_verify>
    Then Check the modal can be removed
    Given Click logo to the homepage
  Examples:
    |element      |location_verify|
    |Login        |Forgot password?|
    |Contact us   |Feel free to drop us a line       |
    |For Therapist|Build your online therapy practice|
    |Sign Up      |Have an account?|
  @Body
  Scenario Outline: Verify BODY brand links are functional (TC2-TC7)
    Given Clicking <link> on body
    Then Verify the directed page <link> contains <page_verify>
    Then Close new windows
    Examples:
    |link              |page_verify                            |
    #psychology-today could fail
    |psychology-today  |Is It Therapy or Is It a Video Game?   |
    |forbes            |Forbes                                 |
    |health2.0         |eTherapi – Launch!                     |
    |treatment-magazine|Virtual Behavioral Healthcare Platforms|
    |business-times    |Dignity pulls back curtain on new deals|
  @Body
  Scenario Outline: Verify BODY up carousel elements TC10-TC17
   Then Verify the <text> on up carousel by clicking the arrow
   Examples:
   |text|
   | EASY BILLING|
   |FIND THE RIGHT THERAPIST|
   | CONTACT YOUR THERAPIST |
   | LOTS OF CHOICE         |
   | EASY SCHEDULING |
  @Body @need_improvement
  Scenario Outline: Verify BODY up carousel Find a Therapist button TC10-TC17
   Given Click on the arrow <Number> times on up carousel
   Then Click on the Find a Therapist button <Number>
   Then Verify page direct to search page
   Then Click logo to the homepage
   Examples:
   |Number|
   |0|
   |1|
   |2|
   |3|
   |4|
  @Body
  Scenario Outline: Verify Body lower carousel moves as clicking arrow
    Given Click on the arrow <Number> times on lower carousel
    Then Verify the <Text> on lower carousel
    Examples:
    |Number|Text|
    |1|Jennifer Fix|
    |2|Elias Aboujaoude   |
    |3|Jennifer Hoblyn|
    |4|Colleen Long|
  @Footer
  Scenario: Verify footer's phone number
  Given verify header is shown
  Then verify phone number is shown as 1-800-611-0821
  @Footer
  Scenario Outline: Verify company link is valid in footer
  Given click the <linkname> in the footer
  Then Verify the directed page <linkname> contains <verifyMsg>
  Examples:
  |linkname          |verifyMsg                  |
  |Blog              |eTherapi Blog|
  |Help Center       |In short, what is eTherapi?|
  |Contact Us        |Feel free to drop us a line|
  |Terms and Privacy |Terms of Use Agreement     |
  @footer
  Scenario Outline: Test the Discovery link in footer is valid
  Given click the <linkname> in the footer
  Then Verify the directed page <linkname> contains <verifyMsg>
  Examples:
    |linkname         |verifyMsg                  |
    |Find a therapist | Need to talk? |
    |For Therapists   |Build your online therapy practice.|
    |Sign up   |Have an account?|

















