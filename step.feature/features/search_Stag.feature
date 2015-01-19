Feature: Stag regression test at Search
  Background: Use staging URL
    Given Use the url as http://54.68.0.140
@Search
Scenario: Verify Search button
Given Click on the Find a Therapist button on homepage
Then check search results more then 100 names
@Search
Scenario Outline: Verify Specialty drop-down in Search
Given Click on the Specialty drop list, select the item with text of <Key_spec>
Then Check <Key_spec> is in the combo-search-box
Examples:
|Key_spec                        |
|	Abandonment	|
|	Abuse	|
|	Addiction	|
|	Adjustment issues	|
|	Affairs	|
|	Aging	|
|	Anger	|
|	Anxiety	|
|	Asperger	|
|	Attachment issues	|
|	Attention deficit	|
|	Autism	|
|	Bipolar	|
|	Blended families/coparenting	|
|	Body image	|
|	Career	|
|	Caregiver issues	|
|	Child or adolescent	|
|	Chronic illness	|
|	Codependency	|
|	Communication issues	|
|	Compulsive behaviors	|
|	Depression	|
|	Diet	|
|	Eating disorders	|
|	Gender issues	|
|	Grief/loss	|
|	Impulse control disorders	|
|	Intimacy	|
|	Learning skills	|
|	LGBT issues	|
|	Military	|
|	Mood disorders	|
|	Multicultural issues	|
|	Obsessive Compulsive Disorder (OCD)	|
|	other	|
|	Panic	|
|	Parenting	|
|	Post partum issues	|
|	Procrastination	|
|	Psych evaluations	|
|	Relationships/Couples/Marriage	|
|	Self esteem	|
|	Self help/Self growth	|
|	Sex	|
|	Sleep	|
|	Spirituality	|
|	Sport	|
|	Stress	|
|	Trauma/Post-Traumatic Stress Disorder (PTSD)|
|	Work-related stress	|
   # other => Other
@Search
Scenario Outline: Verify Insurance Type drop-down in Search
Given Click on the Insurance (if any) drop list, select the item with text of <Key_spec>
Then Check <Key_spec> is in the combo-search-box
Examples:
|Key_spec                       |
| CIGNA                         |
| Connecticut General           |
| EQUICORE                      |
| AmeriChoice of Florida        |
| Definity Services             |
| Ever care                     |
| Ever care creative            |
| OptumHealth Behavior Solutions|
| OptumHealth New Mexico        |
| Ovations                      |
| Pacificare of California      |
| PHP                           |
| Healthease Kids               |
@Search
Scenario Outline: Verify Provider Type drop-down in Search
Given Click on the More filter
Given Click on the Provider Type drop list, select the item with text of <Key_spec>
Then Check <Key_spec> is in the combo-search-box
Examples:
|Key_spec                        |
| All Providers                  |
| Psychiatric Nurse Practitioner |
| Licensed Clinical Social Worker|
| Licensed Professional Counselor|
| Psychiatrist                   |
| Marriage and Family Therapist  |
| Psychologist                   |
@Search
Scenario: Verify More filter can be expanded or close in Search
Given Click on the More filter
Then Verify that Provider Type is shown
Then Verify the Magic-search field is shown
Given Click on the Less filter
Then Verify that Provider Type is invisible
Then Verify the Magic-search field is invisible
@Search
Scenario Outline: Full text search field results verification TC 9.14 and 9.17
Given Click on the More filter
Given Enter <keyword> in the Magic-search field
Then Click on the Find a Therapist button on homepage
Then verify that <verifyMSG> is in the searching results
Examples:
|keyword|verifyMSG|
|  depression|  Awcf Adscf |
|gender issues| Awcf Adscf |
| armenian  | Art Fil|
|Arizona Psychologist|Krishna Therapist |
| elders | Terry t.etherapi00+5@gmail.com |
|children |Terry t.etherapi00+5@gmail.com|
|Aetna    |t.etherapi00+6@gmail.com|