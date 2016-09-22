Feature: As a user I want to be able to checkout products


  Background:
    Given I go to "product_page" with next parameters:
      |productUrl|catalog/product/view/id/19937/s/adriana-hat/category/90/|
      And I believe I am on "product_page"
      And I select any color and size
      And I wait for AJAX
      When I press "add_to_cart" in fieldset "product_info"
      And I wait for AJAX
      Then I should see "You added Jethro Hat to your shopping cart."
    Given I go to "product_page" with next parameters:
      |productUrl|mens/headwear/caps/fiddler-17298|
      And I believe I am on "product_page"
      And I select any color and size
      And I wait for AJAX
      When I press "add_to_cart" in fieldset "product_info"
      And I wait for AJAX
      Then I should see "You added Fiddler Cap to your shopping cart."
    Given I go to "product_page" with next parameters:
      |productUrl|mens/clothing/tops/howl-s-s-woven|
      And I believe I am on "product_page"
      And I select any color and size
      And I wait for AJAX
      When I press "add_to_cart" in fieldset "product_info"
      And I wait for AJAX
      Then I should see "You added Fiddler Cap to your shopping cart."



    @3
    Scenario: Sign in on checkout and PayPal payment method 
    When I go to "checkout"
      And I believe I am on "checkout"
      And I wait for AJAX
    Then I wait until I see "Next"
      And I fill in the following into fieldset "shipping_information":
    |shipping_email           |kkatekoss@gmail.com|
     And I wait for AJAX
   Then I wait until I see "Password"
      And I fill in the following into fieldset "shipping_information":
    |shipping_password        |Kkate123|
    And I press "shipping_login" in fieldset "shipping_information"
     And I wait for AJAX
     And I set "radio_button_for_login_user" in fieldset "shipping_method"
     And I wait for AJAX
     And I press "shipping_next_button" in fieldset "shipping_method"
      And I wait for AJAX
      And I believe I am on "checkout_payment"
      Then I wait until I see "Apply Gift Card"
      #And I fill in the following into fieldset "payment_method":
      #|payment_email           |kkatekoss@gmail.com|
      #And I wait for AJAX
     # Then I wait until I see "Password"
     # And I fill in the following into fieldset "payment_method":
      #|payment_password        |Kkate123|
     # And I press "payment_login" in fieldset "payment_method"
      And I set "check_payment" in fieldset "payment_method" with following parameters:
      | paymentID | paypal_express |
      And I wait for AJAX
      And I press "continue_to_paypal" in fieldset "payment_method"
      And I wait for AJAX
    Then I wait until I see "Pay with PayPal"
      And I fill in the following into fieldset "paypal_sandbox_login"
      | login_email    | slipknot4@ua.fm |
      | login_password | 12345678        |
      And I press "button_login" in fieldset "paypal_sandbox_login"
    Then I wait until I see "Pay with"
      And I press "button_continue" in fieldset "paypal_sandbox_login"
    Then I wait until I see "Review Order"
      And I believe I am on "paypal_express_review"
      And I press "place_order" in fieldset "review_order_paypal"
      And I wait for AJAX
    Then I should see "Thank you for your order!"


