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
    #Sign In
   
  
    
    #Clicks the Women tab and Verifes on Women page
    #${tabName}=    Set Variable    Dresses
    #Click Tab Bar     ${tabName}

    Wait Until Element is Visible    xpath=(//a[@title='Dresses' and @class='sf-with-ul'])[2]    ${WAIT}
    Click Element    xpath=(//a[@title='Dresses' and @class='sf-with-ul'])[2]
    
    #click summer dresses
    Wait Until Element is Visible     xpath=(//a[contains(concat(' ', @title, ' '), ' summer')])[1]    ${WAIT}
    Click Element    xpath=(//a[contains(concat(' ', @title, ' '), ' summer')])[1]
    
    #verify count -- check al3 places
    ${summerCount}=    Get Matching Xpath Count    xpath=//div[@class='product-image-container']//img[contains(concat(' ', @title, ' '), ' Printed')] 
    ${counterLabel}=    Get Text    xpath=//span[@class='heading-counter']
    ${summerCount}=    Convert To String    ${summerCount}    
    ${counterLabel}=    Get Text    xpath=//span[@class='heading-counter']   
    Should Contain    ${counterLabel}    ${summerCount} 
    
    ${counterLabel}=    Get Text    xpath=(//div[@class='product-count'])[1]
     Should Contain    ${counterLabel}    ${summerCount} 
     
    ${counterLabel}=    Get Text    xpath=(//div[@class='product-count'])[2]
    Should Contain    ${counterLabel}    ${summerCount} 
    
    
    #verify grid and list
    ${status}=    Set Variable    ${False}
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//*[@id='grid' and @class='selected']
    Run Keyword If    ${status}==${True}    Log Many    grid selected
    Run Keyword If    ${status}==${True}    xpath=//ul[@class='product_list row grid']
    Run Keyword If    ${status}==${True}    Click Element    xpath=//a[@title='List']
    ${status}=    Set Variable    ${False}
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//*[@id='list' and @class='selected']
    Run Keyword If    ${status}==${True}    xpath=//ul[@class='product_list row list']
    
    Run Keyword If    ${status}==${True}    Click Element    xpath=//a[@title='Grid']
    
    
    
    
    
    #Logout
    #Logout
    
   
*** Keywords ***

    
