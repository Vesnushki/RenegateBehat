Feature: As a user I want to be able to checkout products


  Background:
    Given I go to "product_page" with next parameters:
      |productUrl|mens/headwear/caps/hoover-ii-cap|
      And I believe I am on "product_page"
      And I select any color and size
      And I wait for AJAX
      When I press "add_to_cart" in fieldset "product_info"
      And I wait for AJAX
      Then I should see "You added Hoover II Cap to your shopping cart."

  @1
  Scenario: Guest user checkout with Check Money/order payment method and discount coupon
    When I go to "checkout"
      And I believe I am on "checkout"
      And I wait for AJAX
    Then I wait until I see "Next"
      And I fill in the following into fieldset "shipping_information":
    |shipping_email           |%rand%_guest@guidance.com|
      And I wait for AJAX
      And I fill in the following into fieldset "shipping_information":
    |shipping_first_name      |Test|
    |shipping_last_name       |Test|
    |shipping_company         |Google|
    |shipping_street_address_1|4134 Del Rey Avenue|
    |shipping_city            |Marina Del Rey     |
    |shipping_zip_code        |90292              |
    |shipping_telephone       |310 754 4000       |
    When I select "United States" from "shipping_country" in fieldset "shipping_information"
      And I wait for AJAX
      And I select "California" from "shipping_state" in fieldset "shipping_information"
      #And I set "radio_button" in fieldset "shipping_method"
      And I wait for AJAX
      And I press "shipping_next_button" in fieldset "shipping_method"
      And I wait for AJAX
      And I believe I am on "checkout_payment"
    Then I wait until I see "Apply Gift Card"
      And I set "check_payment" in fieldset "payment_method" with following parameters:
    | paymentID | checkmo |
      And I wait for AJAX
    Then I click on "//span[@id='block-discount-heading']"
      And I wait for AJAX
      And I fill in the following into fieldset "payment_method":
    | discount_code | 123123qa |
      And I press "apply_discount" in fieldset "payment_method"
      And I wait for AJAX
     Then I wait until I see "Discount 123123qa" 
      And I press "place_order" in fieldset "payment_method"
      And I wait for AJAX
    Then I should see "Thank you for your order!"


    @2
  Scenario: Guest user checkout without registration and Check Money/order payment method and gift card
    When I go to "checkout"
      And I believe I am on "checkout"
      And I wait for AJAX
    Then I wait until I see "Next"
      And I fill in the following into fieldset "shipping_information":
    |shipping_email           |%rand%_guest@guidance.com|
      And I wait for AJAX
      And I fill in the following into fieldset "shipping_information":
    |shipping_first_name      |Test|
    |shipping_last_name       |Test|
    |shipping_company         |Google|
    |shipping_street_address_1|4134 Del Rey Avenue|
    |shipping_city            |Marina Del Rey     |
    |shipping_zip_code        |90292              |
    |shipping_telephone       |310 754 4000       |
    When I select "United States" from "shipping_country" in fieldset "shipping_information"
      And I wait for AJAX
      And I select "California" from "shipping_state" in fieldset "shipping_information"
      And I set "radio_button" in fieldset "shipping_method"
      And I wait for AJAX
      And I press "shipping_next_button" in fieldset "shipping_method"
      And I wait for AJAX
      And I believe I am on "checkout_payment"
    Then I wait until I see "Apply Gift Card"
      And I set "check_payment" in fieldset "payment_method" with following parameters:
    | paymentID | checkmo |
      And I wait for AJAX
    Then I click on "//span[@id='block-giftcard-heading']"
      And I wait for AJAX
      And I fill in the following into fieldset "payment_method":
    | gift_card_code | 002GNFDNWNBT |
      And I press "apply_giftcard" in fieldset "payment_method"
      And I wait for AJAX
     Then I wait until I see "Remove Gift Card" 
      And I press "place_order" in fieldset "payment_method"
      And I wait for AJAX
    Then I should see "Thank you for your order!"


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
      And I wait for 10 seconds
      And I set "radio_button_for_login_user" in fieldset "shipping_method"
      And I wait for AJAX
      And I press "shipping_next_button" in fieldset "shipping_method"
      And I wait for AJAX
      And I wait for 10 seconds
      And I believe I am on "checkout_payment"
      Then I wait until I see "Apply Gift Card"
#      And I fill in "payment_email" with "kkatekoss@gmail.com" in fieldset "payment_method"
#      #|payment_email           |kkatekoss@gmail.com|
#      And I wait for AJAX
#     Then I wait until I see "Password"

#      And I fill in "payment_password" with "Kkate123" in fieldset "payment_method"
#    And I fill in the following into fieldset "payment_method":
#     |payment_password        |Kkate123|
#     And I set "radio_button_for_login_user" in fieldset "shipping_method"
#      And I wait for 10 seconds
      #And I press "payment_login" in fieldset "payment_method"
      And I set "check_payment" in fieldset "payment_method" with following parameters:
      | paymentID | paypal_express |
      And I wait for AJAX
      And I wait for 15 seconds
      And I press "continue_to_paypal" in fieldset "payment_method"
      And I wait for AJAX
      And I wait for 10 seconds
      #And I believe I am on "paypal_sandbox"
    Then I wait until I see "Pay with PayPal"
      Given I switch to the iframe
      When I fill PayPal login form
      Then I click on "//button[@id='btnLogin']"
      And I wait for 10 seconds
     Then I click on "//div[@id='button']"
    Then I wait until I see "Review Order"
      And I believe I am on "paypal_express_review"
      And I press "place_order" in fieldset "review_order_paypal"
      And I wait for AJAX
    Then I should see "Thank you for your order!"


      @4
      Scenario: Sign in on checkout and Visa payment method
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
        And I press "shipping_next_button" in fieldset "shipping_method"
        And I wait for AJAX
        And I believe I am on "checkout_payment"
        Then I wait until I see "Apply Gift Card"
        And I set "check_payment" in fieldset "payment_method" with following parameters:
          | paymentID | md_cybersource |
        Then I click on "//*[@id='checkout-payment-method-load']/div/div[1]/div[2]/div[4]/div/button"
        And I wait for AJAX
        Then I should see "Thank you for your order!"
























