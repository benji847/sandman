*** Settings ***
Library           Selenium2Library
Library           Collections
Library           String
Test Setup        Basic Selenium Test Setup
Test Teardown        Basic Selenium Test Teardown
Resource          ../resources/setups/setups.txt
Resource          ../resources/teardowns/teardowns.txt


*** Test Cases ***
mainFlowTest
    [Documentation]    This is a historic first test
    #Go to website
    Go To    http://automationpractice.com/index.php
   
    #Sign in
    Wait Until Element is Visible    xpath=//a[@class='login']    30s    
    Click Element    xpath=//a[@class='login']
    Input Text    css=#email    paraagq@hotmail.com
    Input Text    css=#passwd    autoPro6
    Click Element    css=#SubmitLogin
  
    #Verifies that the cart is empty
    ${someText}=    Get Text    xpath=//div[@class='shopping_cart']//span[@class="ajax_cart_no_product"]    
    ${status}=    Evaluate    '${someText}'=='(empty)'
    
    
    #Clicks the Women tab
    Wait Until Element is Visible    xpath=//a[@title='Women']    30s
    Click Element    xpath=//a[@title='Women']
    
    #Verifes on Women page
    ${someText}=    Get Text    xpath=//h2[@class="title_block"]
    ${status}=    Evaluate    '${someText}'=='Women'
    
    #Expands on the list for Tops and Dresses
    ${count}=    Get Matching Xpath Count    xpath=//span[contains(concat(' ', @class, ' '), ' grower ')]
    Click Element     xpath=(//span[contains(concat(' ', @class, ' '), ' grower ')])[1]
    Click Element     xpath=(//span[contains(concat(' ', @class, ' '), ' grower ')])[2]
    
    #Verifies there are 7 products
    ${dressesCount}=    Get Matching Xpath Count    xpath=//a[@class='product_img_link']//img[contains(concat(' ', @title, ' '), ' Dress')]
    ${blouseCount}=    Get Matching Xpath Count    xpath=//a[@class='product_img_link']//img[contains(concat(' ', @title, ' '), ' Blouse')] 
    ${shirtcount}=    Get Matching Xpath Count    xpath=//a[@class='product_img_link']//img[contains(concat(' ', @title, ' '), ' T-shirts')] 
    ${itemCount}=    Evaluate    ${dressesCount}+${blouseCount}+${shirtcount}
    ${counterLabel}=    Get Text    xpath=//span[@class='heading-counter']
    ${itemCount}=    Convert To String    ${itemCount}    
    Should Contain    ${counterLabel}    ${itemCount} 
    
    #Adds one item to the Cart
    Mouse Over    xpath=(//a[@class='product_img_link']//img[contains(concat(' ', @title, ' '), ' Dress')])[2]
    Click Element    xpath=//span[text()='Add to cart']
    Wait Until Element is Visible     xpath=//div[@class='clearfix']    30s
    Wait Until Element is Visible    xpath=//div[@class='button-container']//a    30s
    Click Element    xpath=//div[@class='button-container']//a
    
    #Verifies that the cart gets updated
    Wait Until Element is Visible    xpath=//span[@class='ajax_cart_quantity']    30s
    Mouse Over    xpath=//span[@class='ajax_cart_quantity']
    ${productCount}=    Get Text    xpath=//span[@class='ajax_cart_quantity']    
    ${productCount}=    Convert To String    ${productCount}
    ${x}=    Set Variable    1
    ${x}=    Convert To String    ${x}
    Should Be Equal As Strings    ${productCount}    ${x}   
    
    #Logout
    Click Element    xpath=//a[@title='Log me out']
    Wait Until Element is Visible    xpath=//a[@class='login']    30s   
    
   
*** Keywords ***

    
