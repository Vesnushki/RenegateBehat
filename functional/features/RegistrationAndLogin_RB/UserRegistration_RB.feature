Feature: As a guest user I want to register on the website
  in order to get access to additional features available for registered users

  @1
  Scenario: User registration with correct information
    Given I am on "register_account"
    When I fill in the following into fieldset "account_info":
      | email                | %rand%_user@guidance.com|
      | first_name           | BehatName               |
      | last_name            | Behat LastName          |
      | password             | 123123qa!               |
      | password_confirmation| 123123qa!               |
    When I check "sign_up_newsletter" in fieldset "account_info"
    When I press "submit" in fieldset "account_info"
    Then I should see "My Dashboard"
    Then I should see "You subscribe to "

  @2
  Scenario: User registration with already registered e-mail
    Given I am on "register_account"
    When I fill in the following into fieldset "account_info":
      | email                | kkatekoss@gmail.com|
      | first_name           | Behat Name|
      | last_name            | Behat Last Name|
      | password             | 123123qa!|
      | password_confirmation| 123123qa!|
    When I press "submit" in fieldset "account_info"
    When I wait for AJAX up to 3 seconds
    Then I should see "There is already an account with this email address. If you are sure that it is your email address, click here to get your password and access your account."
  @3
  Scenario: User registration with correct information
    Given I am on "register_account"
    When I fill in the following into fieldset "account_info":
      | email                | kkatekoss1@gmail.com|
      | first_name           | BehatName               |
      | last_name            | Behat LastName          |
      | password             | 123123qa!               |
      | password_confirmation| 123123qa!               |
    When I check "sign_up_newsletter" in fieldset "account_info"
    When I press "submit" in fieldset "account_info"
    Then I should see "My Dashboard"
    Then I should see "You subscribe to "
