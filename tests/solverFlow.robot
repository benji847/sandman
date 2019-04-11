*** Settings ***
Test Setup        Basic Selenium Test Setup
Test Teardown        Basic Selenium Test Teardown
Resource          ../resources/setups/setups.txt
Resource          ../resources/teardowns/teardowns.txt
Resource          ../resources/main/main.txt
Resource          ../resources/navigation_bar/navigationBar.txt
Resource          ../resources/login_widget/loginWidget.txt
Resource          ../resources/shoppingCart_widget/shoppingCart.txt


*** Test Cases ***
mainFlowTest
    [Documentation]    This is a historic first test
    #Go to website
    Go To    http://automationpractice.com/index.php
   
    #Sign in
    Sign In
   
   #Verifies that the cart is empty
    Is Shopping Cart Empty    
    
    #Clicks the Women tab and Verifes on Women page
    ${tabName}=    Set Variable    Women
    Click Tab Bar     ${tabName}

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
    Wait Until Element is Visible     xpath=//div[@class='clearfix']    ${WAIT}
    Wait Until Element is Visible    xpath=//div[@class='button-container']//a    ${WAIT}
    Click Element    xpath=//div[@class='button-container']//a
    
    #Verifies that the cart gets updated
    Wait Until Element is Visible    xpath=//span[@class='ajax_cart_quantity']    ${WAIT}
    Mouse Over    xpath=//span[@class='ajax_cart_quantity']
    ${productCount}=    Get Text    xpath=//span[@class='ajax_cart_quantity']    
    ${productCount}=    Convert To String    ${productCount}
    ${x}=    Set Variable    1
    ${x}=    Convert To String    ${x}
    Should Be Equal As Strings    ${productCount}    ${x}   
    
    #Logout
     Logout
    
   
*** Keywords ***

    
