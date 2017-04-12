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

    @3
    Scenario: Sign in on checkout and PayPal payment method
    When I go to "shopping_cart"
      And I believe I am on "shopping_cart"
      And I wait for AJAX
      And I click on "//input[@title='Checkout with PayPal']"
      And I wait for AJAX
    Then I wait until I see "Pay with PayPal"
      When I choose to pay with PayPal
    Then I wait until I see "PayPal is the safer, easier way to pay"
      And I click on "//input[@id='confirmButtonTop']"
#      Then I wait until I see "Review your information"
#      And I click on "//input[@id='continue']"
    Then I wait until I see "Review Order"
      And I wait for AJAX
      And I believe I am on "paypal_express_review"
    Then I click on "//div[contains(@class, 'box-order-shipping-method')]"
      And I wait for AJAX
    When I select "flatrate_flatrate" from "shipping_method" in fieldset "review_order_paypal"
      And I wait for AJAX
      And I wait for 5 seconds
      And I believe I am on "paypal_express_review"
      And I press "place_order" in fieldset "review_order_paypal"
    Then I wait until I see "Thank you for your order!"
    Then I should see "Thank you for your order!"