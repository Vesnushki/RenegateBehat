Feature: As a registered user I want to log in to the website
  in order to get access to additional features available for registered users
  @1
  Scenario: User login  with correct data
    Given I am on "customer_login"
    When I fill in the following into fieldset "log_in_customer":
      | email          |kkatekoss@gmail.com|
      | password       |Kkate123|
   When I press "login" in fieldset "log_in_customer"
   Then I should see "My Dashboard"
  @2
  Scenario: User login with wrong password
    Given I am on "customer_login"
    When I fill in the following into fieldset "log_in_customer":
      | email          |kkatekoss@gmail.com|
      | password       |Kkate|
    When I press "login" in fieldset "log_in_customer"
      And I wait for AJAX up to 5 seconds
      And I should see "Invalid login or password."
  @3
  Scenario: User login with empty fields (form validation)
    Given I am on "customer_login"
      And I wait for 5 seconds
    Then I press "login" in fieldset "log_in_customer"
      And I wait for AJAX up to 5 seconds
    Then I should see '2' alerts
  @4
  Scenario: User logout and login as another user (cache validation)
    Given I am logged in to frontend as "kkatekoss@gmail.com" with password "Kkate123"
    Then I should see "kkatekoss@gmail.com"
      And I should see "My Dashboard"
    And I wait for 10 seconds
    Then I click on "//a[contains(.,'Sign In')]"
    And I wait for 10 seconds
    #Then I follow "user" in fieldset "frontend_header"
    Then I click on "//div[@id='ui-id-1']//a[contains(.,'Sign Out')]"
      And I wait for 10 seconds
      And I should be on the "home"
    Then I am on "customer_login"
      And I am logged in to frontend as "kkatekoss1@gmail.com" with password "Kkate123"
    Then I should see "kkatekoss1@gmail.com"
      And I should see "My Dashboard"
  @5
  Scenario: User is redirected to the Registration form from Login page
    Given I am on "customer_login"
    When I follow "create_account" in fieldset "log_in_customer"
    Then I should be on the "register_account"

