Feature: As a user I want to be check search functionality

Scenario: As user I want to see result "Jacket"
  Given I am on "home"
  When I fill in the following into fieldset "frontend_header": 
      | search | Jacket |
  When I press "search_button" in fieldset "frontend_header"
  Then I should see "Results for"