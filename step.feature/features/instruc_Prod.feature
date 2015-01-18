#for x in {1..1}; do cucumber --tags @Header; done
Feature: Prod regression test

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

  @Signin
  Scenario Outline: Signin with valid patient account
    Given Verify clicking Login on header menu will load to Log In
    Given Entering <account> can login successfully
    Then Verify the directed page <account> contains <verifyMsg>
    Then verify patient can logout
    Examples:
    |account                 |verifyMsg         |
    |p.etherapi00+1@gmail.com |Test Rita Zero One|
    |p.etherapi00+2@gmail.com |Test Rita ZeroTwo|
    |p.etherapi00+3@gmail.com |Test ZeroThree|
    #|p.etherapi00+4@gmail.com |Test ZeroFour|
    #|p.etherapi00+5@gmail.com |Test ZeroFive|
    #|p.etherapi00+6@gmail.com |Test ZeroSix|
    #|p.etherapi00+7@gmail.com |Test ZeroSeven|
    #|p.etherapi00+8@gmail.com |ZeroEight p.etherapi00+8@gmail.com|
    #|p.etherapi00+9@gmail.com |Test ZeroNine|
    #|p.etherapi00+10@gmail.com|Test ZeroTen|
    #|p.etherapi00+11@gmail.com|Test Croce|
    #|p.etherapi00+12@gmail.com|Test Croce|
    #|p.etherapi00+13@gmail.com|Test ZeroThirteen|
    #|p.etherapi00+14@gmail.com|Test ZeroFourteen|
    #|p.etherapi00+15@gmail.com|Test ZeroFifteen|
    |p.etherapi00+16@gmail.com|Test ZeroSixteen|
    #|p.etherapi00+17@gmail.com|Test ZeroSeventeen|
    #|p.etherapi00+18@gmail.com|Test ZeroEighteen|
    #|p.etherapi00+19@gmail.com|Test ZeroNineteen|
    #|p.etherapi00+20@gmail.com|Test ZeroTwenty|
    #|p.etherapi00+21@gmail.com|Test ZeroTwentyOne|
    #|p.etherapi00+22@gmail.com|Test ZeroTwentyTwo|
    #|p.etherapi00+23@gmail.com|test patient|
    #|p.etherapi00+24@gmail.com|test rita liang|
  @Signin
  Scenario Outline: Signin with valid therapist account
    Given Verify clicking Login on header menu will load to Log In
    Given Entering <account> can login successfully
    Then Verify the directed page <account> contains <verifyMsg>
    Then verify therapist can logout
    Examples:
    |account                 |verifyMsg                           |
    |t.etherapi00+2@gmail.com|Dr Sharon Young TEST                |
    |t.etherapi00+3@gmail.com|Test t.etherapi00+3@gmail.com Rita Liang|
    |t.etherapi00+4@gmail.com|Test RitaLiang                       |
    |t.etherapi00+5@gmail.com | TEST Eric Glassgold                |
    |t.etherapi00+7@gmail.com | test03 ritaliang                   |
    |t.etherapi00+8@gmail.com | test04 ritaliang                   |
    |t.etherapi00+9@gmail.com | test ritaliang                     |
    #|t.etherapi00+10@gmail.com| Diana Urman                       |
    #|t.etherapi00+11@gmail.com| Eric Glassgold                    |
    #|t.etherapi00+12@gmail.com| Eric Glassgold                    |
    #|t.etherapi00+13@gmail.com| Test Rita Liang                   |
    #|t.etherapi00+14@gmail.com| test rita liang                   |
    #|t.etherapi00+15@gmail.com| test rita liang                   |
    #|t.etherapi00+16@gmail.com| test rita liang                   |
    #|t.etherapi00+17@gmail.com| Test Rita Lian                    |
    #|t.etherapi00+18@gmail.com| Test Glassgold                    |
    #|t.etherapi00+19@gmail.com| test Rita                         |
    #|t.etherapi00+20@gmail.com| William t.etherapi00+10@gmail.com |
    #|t.etherapi00+26@gmail.com| test rita therapist               |
    #|t.etherapi00+29@gmail.com| Tommy t.etherapi00+29@gmail.com   |

  @Body
  Scenario Outline: Verify BODY brand links are functional (TC2-TC7)
    Given Clicking <link> on body
    Then Verify the directed page <link> contains <page_verify>
    Then Close new windows
    Examples:
    |link              |page_verify                            |
   # |psychology-today  |Is It Therapy or Is It a Video Game?   |
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
  @Body
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
  @Body @need_modification
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

  Scenario Outline: Test the Discovery link in footer is valid
  Given click the <linkname> in the footer
  Then Verify the directed page <linkname> contains <verifyMsg>
  Examples:
    |linkname         |verifyMsg                  |
    |Find a therapist | Need to talk? |
    |For Therapists   |Build your online therapy practice.|
    |Sign up   |Have an account?|
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
    Then Finish the Payment request with American, Anthem Blue Cross
    Then Verify the request is pending at 02/28/2015, 8:00 PM
  Examples:
  |account                 |verifyMsg |nameForSearch|nameForVerify |
  #|p.etherapi00+16@gmail.com|Test ZeroSixteen|Edoardo|Edoardo Croce| #this will annoy Edo
  #|p.etherapi00+16@gmail.com|Test ZeroSixteen|eTherapi|Edoardo Croce|
