Feature: As a user I want to be able to add products to cart

  @1
  Scenario: Add product configurable with qty = 1 to cart
    Given I go to "product_page" with next parameters:
      |productUrl|men-s/clothing/jackets/claxton-jacket|
    And I believe I am on "product_page"
    And I select any color and size
    When I press "add_to_cart" in fieldset "product_info"
    And I wait for AJAX
    And I wait for 10 seconds
   # When I hover over the element "//span[@class='counter-number']"
    Then I click on "//span[@class='counter-number']"
    Then I click on "//span[@class='counter-number']"
    And I wait for 10 seconds
    Then I should see "Subtotal"



#  @2
#  Scenario: Add simple product with qty = 1 to cart
#    Given I go to "product_page" with next parameters:
#      | productUrl |test-product-22|
#      And I believe I am on "product_page"
#    When I press "add_to_cart" in fieldset "product_info"
#    And I wait for 10 seconds
#    And I click on "//span[@class='counter-number']"
#    Then I should see "test-product-22"



  @3
  Scenario: Add configurable product with qty = 9 to cart
    Given I go to "product_page" with next parameters:
      | productUrl |men-s/clothing/jackets/claxton-jacket|
    And I believe I am on "product_page"
    And I select any color and size
    When I select "9" from "product_qty" in fieldset "product_info"
    When I press "add_to_cart" in fieldset "product_info"
    And I wait for 5 seconds
    #Then I should see "We don't have as many "CLAXTON JACKET" as you requested."
    Then I should see "We don't have as many"