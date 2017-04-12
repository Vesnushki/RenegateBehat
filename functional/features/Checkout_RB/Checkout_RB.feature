Feature: As a user I want to be able to checkout products


  Background:
    Given I go to "product_page" with next parameters:
      |productUrl|men-s/clothing/jackets/claxton-jacket|
      And I believe I am on "product_page"
    And I select any color and size
#      And I wait for 5 seconds
#    And I click on "//div[@option-id='2056']"
      When I press "add_to_cart" in fieldset "product_info"
      And I wait for AJAX
      And I wait for 5 seconds


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
     # And I set "radio_button" in fieldset "shipping_method"
      And I wait for AJAX
      And I press "shipping_next_button" in fieldset "shipping_method"
      And I wait for AJAX
      And I believe I am on "checkout_payment"
    Then I wait until I see "Apply Promo Code"
      And I set "check_payment" in fieldset "payment_method" with following parameters:
    | paymentID | md_cybersource |
      And I wait for AJAX
      And I wait for 5 seconds
    Then I click on "//span[@id='block-discount-heading']"
      And I wait for AJAX
      And I fill in the following into fieldset "payment_method":
    | discount_code | 123123qa |
      And I press "apply_discount" in fieldset "payment_method"
      And I wait for AJAX
    Then I wait until I see "Your coupon was successfully applied."
    Then I click on "//div[@class='payment-method _active']//button[span='Place Order']"
      #And I press "place_order" in fieldset "payment_method"
      And I wait for AJAX
    Then I should see "Thank you for your order!"





    @2
  Scenario: Guest user checkout with registration and Check Money/order payment method
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
    When I select "Australia" from "shipping_country" in fieldset "shipping_information"
      And I wait for AJAX
#      And I select "California" from "shipping_state" in fieldset "shipping_information"
      And I set "radio_button" in fieldset "shipping_method"
      And I wait for AJAX
      And I press "shipping_next_button" in fieldset "shipping_method"
      And I wait for AJAX
      And I believe I am on "checkout_payment"
    Then I wait until I see "Apply Promo Code"
      And I set "check_payment" in fieldset "payment_method" with following parameters:
    | paymentID | checkmo |
      And I wait for AJAX
      Then I click on "//div[@class='payment-method _active']//button[span='Place Order']"
      #And I press "place_order" in fieldset "payment_method"
      And I wait for AJAX
    Then I should see "Thank you for your order!"
      And I believe I am on "order_confirmation"
      And I fill in the following into fieldset "create_account":
    | password  |KKate123|
    |confirm_password|KKate123|
      And I click on "//button[@class='action-secondary']"
      And I wait for 10 seconds
      Then I should see "A letter with further instructions will be sent to your email."




























