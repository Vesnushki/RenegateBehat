<?php

use Irs\BehatPopupExtension\PopupContext,
    Irs\BehatUimapExtension\Context\UimapContext,
    Irs\BehatUimapExtension\PageSource\TafSource,
    Irs\BehatMagentoExtension\Context\MagentoHooks;

use Behat\Behat\Context\ClosuredContextInterface,
    Behat\Behat\Context\TranslatedContextInterface,
    Behat\Behat\Context\BehatContext,
    Behat\Behat\Exception\PendingException,
    Behat\Gherkin\Node\PyStringNode,
    Behat\Gherkin\Node\TableNode,
    Behat\MinkExtension\Context\MinkAwareInterface;

/**
 * Features context.
 */
class FeatureContext extends BehatContext implements MinkAwareInterface
{
    use /*MagentoHooks,*/ UimapContext, PopupContext;

    /**
     * Initializes context.
     * Every scenario gets it's own context object.
     *
     * @param array $parameters context parameters (set them up through behat.yml)
     */
    public function __construct(array $parameters)
    {
        // Initialize your context here
    }

    /**
     * @AfterScenario @clearCookiesAfterScenario
     */
    public function clearCookiesAfterScenario()
    {
        $this->getSession()->getDriver()->reset();
    }

    /**
     * @Given /^I am logged in to admin panel$/
     */
    public function iAmLoggedInToAdminPanel()
    {
        $this->loadPage('log_in_to_admin');
        $this->visit('log_in_to_admin');
        $this->fillField('user_name', 'admin');
        $this->fillField('password', 'passwd4admin');
        $this->findField('login', 'button', 'log_in')->press();
        $this->assertPageContainsText('Dashboard');
    }

    /**
     * @Then /^I logout from admin panel$/
     */
    public function logoutFromAdminPanel()
    {
        $this->getMink()->assertSession()->elementExists('xpath', "//a[@class = 'link-logout']")->click();
    }

    /**
     * @Then /^I should see \'([^\']*)\' JS alerts$/
     */
    public function iShouldSeeJsAlerts($count)
    {
        $this->getMink()->assertSession()->elementsCount('xpath', "//div[contains(@text, 'This is a required field.')]", $count);
    }

    /**
     * @Then /^I should see \'([^\']*)\' alerts$/
     */
    public function iShouldSeeAlerts($count)
    {
        $this->getMink()->assertSession()->elementsCount('xpath', "//div[@class='mage-error']", $count);
    }

    /**
     * Presses button with specified id|name|title|alt|value.
     *
     * @When /^(?:|I )press "(?P<button>(?:[^"]|\\")*)"$/
     */

    public function pressButton($button)
    {
        $button = $this->fixStepArgument($button);
        $this->getSession()->getPage()->pressButton($button);
    }

    /**
     * Presses button with specified id|name|title|alt|value without fieldset specified
     *
     * @When /^(?:|I )press "(?P<button>(?:[^"]|\\")*)" button$/
     */
    public function pressButtonWithoutFieldset($button)
    {
        $this->pressButton($button);
        //workaround for page load
        $this->waitForSeconds(3);
    }

    /**
     * Presses button with specified id|name|title|alt|value.
     *
     * @When /^I press "([^"]*)" in fieldset "([^"]*)"$/
     */
    public function pressButtonInFieldset($button, $fieldset)
    {
        $this->findField($button,'button', $fieldset)->press();

    }

    /**
     * @When /^(?:|I )select "(?P<text>(?:[^"]|\\")*)" from grid$/
     */
    public function selectElementFromGrid($text)
    {
        $this->getMink()->assertSession()->elementExists('xpath', "//td[contains(text(), '$text')]")->click();
    }

    /**
     * @Given /^I am logged in to frontend as "([^"]*)" with password "([^"]*)"$/
     */
    public function iAmLoggedToFrontend($email, $password)
    {
        $this->visit('customer_login');
        $this->currentPage = $this->getPageSource()->getPageByKey('customer_login');
        $this->fillField('email', $email, 'log_in_customer');
        $this->fillField('password', $password, 'log_in_customer');
        $this->findField('login', 'button', 'log_in_customer')->press();
        $this->currentPage = $this->getPageSource()->getPageByKey('customer_account');
    }

    /**
     * @Given /^I log out from frontend$/
     */
    public function logOutFrontend()
    {
        $this->getMink()->assertSession()->elementExists('xpath', "//a[@title = 'Log Out']")->click();
    }

    /**
     * @Given /^I should be on the "(?P<page>[^"]+)"$/
     */
    public function iShouldBeOn($page)
    {
        $this->assertPageAddress($page);
    }

    /**
     * Goes to page and loads proper page by key.
     *
     * @When /^(?:|I )go to "(?P<page>[^"]+)"$/
     */
    public function goToPage($page)
    {   $this->visit($page);
        $this->loadPage($page);
    }

    /**
     * Fills in form field with specified id|name|label|value.
     *
     *
     * @When /^(?:|I )fill in "(?P<field>(?:[^"]|\\")*)" with "(?P<value>(?:[^"]|\\")*)" in fieldset "(?P<fieldset>(?:[^"]|\\")*)"$/
     * @When /^(?:|I )fill in "(?P<value>(?:[^"]|\\")*)" for "(?P<field>(?:[^"]|\\")*)" in fieldset "(?P<fieldset>(?:[^"]|\\")*)"$/
     * @When /^(?:|I )fill in "(?P<field>(?:[^"]|\\")*)" with "(?P<value>(?:[^"]|\\")*)" in fieldset "(?P<fieldset>(?:[^"]|\\")*)" of tab "(?P<tab>(?:[^"]|\\")*)"$/
     * @When /^(?:|I )fill in "(?P<value>(?:[^"]|\\")*)" for "(?P<field>(?:[^"]|\\")*)" in fieldset "(?P<fieldset>(?:[^"]|\\")*)" of tab "(?P<tab>(?:[^"]|\\")*)"$/
     * @When /^(?:|I )fill in "(?P<field>(?:[^"]|\\")*)" with "(?P<value>(?:[^"]|\\")*)" in fieldset "(?P<fieldset>(?:[^"]|\\")*)" of tab "(?P<tab>(?:[^"]|\\")*)" with following parameters:$/
     * @When /^(?:|I )fill in "(?P<value>(?:[^"]|\\")*)" for "(?P<field>(?:[^"]|\\")*)" in fieldset "(?P<fieldset>(?:[^"]|\\")*)" of tab "(?P<tab>(?:[^"]|\\")*)" with following parameters:$/
     */
    public function fillField($field, $value, $fieldset = null, $tab = null, TableNode $params = null)
    {
        //use $needle expression in the beginning of the line to randomize the string entered with a-z 0-9 characters
        $needle = '%rand%';
        $randomCharactersAmount = 6;
        $randomString = substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyz"), 0, $randomCharactersAmount);

        if(stristr($value, $needle))
        {
            $value=substr_replace($value, $randomString, 0,6);;
        }

        $params = ($params) ? $params->getRowsHash() : array();
        $this->findField($field, 'field', $fieldset, $tab, $params)
            ->setValue($value);
    }

    /**
     * @Given /^I fill in test CC info$/
     */
    public function iFillInTestCcInfo()
    {
        $this->fillField('card_number', '4111111111111111', 'payment_method');
        $this->fillField('card_verification_number', '123', 'payment_method');
        $this->selectOption('credit_card_type', 'VI', 'payment_method');
        $this->selectOption('expiration_month', '5', 'payment_method');
        $this->selectOption('expiration_year', '2018', 'payment_method');
    }

    /**
     * Checks radio marked as checkbox.
     *
     * @When /^(?:|I )set "(?P<option>(?:[^"]|\\")*)" in fieldset "(?P<fieldset>(?:[^"]|\\")*)"$/
     * @When /^(?:|I )set "(?P<option>(?:[^"]|\\")*)" in fieldset "(?P<fieldset>(?:[^"]|\\")*)" of tab "(?P<tab>(?:[^"]|\\")*)"$/
     * @When /^(?:|I )set "(?P<option>(?:[^"]|\\")*)" in fieldset "(?P<fieldset>(?:[^"]|\\")*)" of tab "(?P<tab>(?:[^"]|\\")*)" with following parameters:$/
     */
    public function setOption($option, $fieldset = null, $tab = null, TableNode $params = null)
    {
        $this->checkOption($option, $fieldset, $tab, $params );
    }

    /**
     * Checks checkbox with specified id|name|label|value.
     *
     * @When /^(?:|I )set "(?P<option>(?:[^"]|\\")*)" in fieldset "(?P<fieldset>(?:[^"]|\\")*)" with following parameters:$/
     */
    public function setOptionInFiedsetWithParams($option, $fieldset, TableNode $params)
    {
        $this->setOption($option, $fieldset, null, $params);
    }

    /**
     * Selects available color and size that are in stock
     *
     * @Given /^I select any color and size$/
     */
    public function iSelectAnyColorAndSize()
    {
        //this cycle should be refactored later. It should calculate available colors by itself
        //current implementation is the fastest
        try {
            $this->getMink()->assertSession()->elementExists(
                'xpath', "//div[@option-id='128']"
            )->click();
        } catch (\Behat\Mink\Exception\ElementNotFoundException $e) {
        }

            //looks for available sizes
        try {
            $this->getMink()->assertSession()->elementExists(
                'xpath', "//div[@option-id='1566']"
            )->click();
        } catch (\Behat\Mink\Exception\ElementNotFoundException $e) {
        }
        
    }
        public function spin ($lambda, $wait = 60)
    {
        for ($i = 0; $i < $wait; $i++)
        {
            try {
                if ($lambda($this)) {
                    return true;
                }
            } catch (Exception $e) {
                print("not visible yet ");
            }

            sleep(5);
        }

//        $backtrace = debug_backtrace();
//
//        throw new Exception(
//            "Timeout thrown by " . $backtrace[1]['class'] . "::" . $backtrace[1]['function'] . "()\n" .
//            $backtrace[1]['file'] . ", line " . $backtrace[1]['line']
//        );
    }

    /**
     * Wait when text present on page
     *
     * @Then /^(?:|I )wait until I see "(?P<text>[^"]*)"$/
     */
    public function iWaitForElement($text){
        $this->spin(function(FeatureContext $context) use ($text){
                try {
                    $context->assertPageContainsText($text);
                    return true;
                }
                catch(\Behat\Mink\Exception\ResponseTextException $e){
                    print_r("AAAAA " +$e);

                }
                return false;
            }
        );
    }

    /**
    * @Then /^I click on "([^"]*)"$/
    */
    public function iClickOn($element)
    {
        $page = $this->getSession()->getPage();
        $findName = $page->find("xpath", $element);
        if (!$findName) {
            throw new Exception($element . " could not be found");
        } else {
            $findName->click();
        }
    }

    /**
     * @When /^(?:|I )fill PayPal login form$/
     */
    public function fillPayPalLoginForm()
    {
        $field_email = $this->getSession()->getPage()->find('xpath', '//input[@id="email"]');
        $field_field = $this->getSession()->getPage()->find('xpath', '//input[@id="password"]');
        $this->fillField($field_email, 'slipknot4@ua.fm');
        $this->fillField($field_field, '12345678');
    }

    /**
     * @Given /^I switch to the iframe$/
     */
    public function iSwitchToIframe()
    {
        $find_iframe = $this->getSession()->getPage()->find('css','#injectedUnifiedLogin iframe');
        $iframeName = $find_iframe->getAttribute('name');
        $this->getSession()->switchToIFrame($iframeName);
    }
}
