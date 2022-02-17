*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    DateTime
Library    OperatingSystem

*** Variables ***
${URL}          http://blazedemo.com/
${BROWSER}      Chrome
${BROWSER_HEADLESS}   headlesschrome
${ENVIRONMENT}    Production

*** Keywords ***
Open Home Page
    Run Keyword And Return If    '${ENVIRONMENT}' == 'Development'    Open Development
    Open Production
    
Open Development
    Open browser    ${URL}   ${BROWSER}

Open Production
    Open browser    ${URL}   ${BROWSER_HEADLESS}   options=add_argument("--remote-debugging-port=9515");add_argument("--no-sandbox"); add_argument("--disable-dev-shm-usage")

Close Browsers
    Close All Browsers

Click purchase flight
    Click Button    css:input[type="submit"][value="Purchase Flight"]

Click remember me
    Click Element    css:input#rememberMe

Fill in passenger information
    [Arguments]    ${passenger_info}
    Input Text    css:input#inputName    ${passenger_info}[name]
    Input Text    css:input#address    ${passenger_info}[address]
    Input Text    css:input#city    ${passenger_info}[city]
    Input Text    css:input#state    ${passenger_info}[state]
    Input Text    css:input#zipCode    ${passenger_info}[zip]
    Input Text    css:input#creditCardNumber    ${passenger_info}[card_number]
    Input Text    css:input#nameOnCard    ${passenger_info}[name]

Find Flights button is selectable
    Page Should Contain Button    xpath://input[@value="Find Flights"]

Get Total Price
    ${result}=    Get Text    xpath://div[@class="container"]/p[contains(text(),"Total Cost: ")]/em
    [Return]    ${result}

Select card type
    [Arguments]    ${card_type}
    Select From List By Label    css:select#cardType    ${card_type}

Select Departure City
    [Arguments]      ${departure_city}
     Select From List By Value   xpath://select[@name='fromPort']  ${departure_city}

Select Destination City
    [Arguments]      ${destination_city}
    Select From List by Value   xpath://select[@name='toPort']    ${destination_city}

Select first available flight
    ${flight}=  Get WebElement    css:table[class='table']>tbody tr
    ${result}=    Get Text    ${flight}
    @{list}=    Split String   ${result}
    ${id}=    Get From List    ${list}    0
    @{airline_list}=    Get Slice From List    ${list}    1    -5
    ${airline}=    Evaluate    " ".join(${airline_list})
    ${price}=    Get Variable Value    ${list}[-1]
    
    Click Button    xpath://table/tbody/tr[1]/td[1]/input[@type="submit"]
    @{result}=    Create List    ${id}    ${airline}    ${price}
    [Return]    ${result}

Search For Flights
    Click Button    css:input[type='submit']

There are available Flights
    @{flights}=  Get WebElements    css:table[class='table']>tbody tr
    Should Not Be Empty     ${flights}

Verify card expiration time is correct
    [Arguments]    ${month}    ${year}
    ${date}=    Get Text    xpath://tr[td="Expiration"]/td[2]
    ${date}=    Replace String    ${date}    /    ${empty}
    ${date}=    Split String    ${date}
    Should Be Equal    ${month}    ${date}[0]
    Should Be Equal    ${year}    ${date}[1]

Verify flight data is correct
    [Arguments]    @{args}
    FOR    ${item}    IN    @{args}
        Page Should Contain    ${item}  
    END

Verify total price is correct
    [Arguments]    ${price}
    ${temp}=    Get Text    xpath://tr[td="Amount"]/td[2]
    @{temp}=    Split String    ${temp}
    ${temp}=    Set Variable    ${temp}[0]
    Should Be Equal As Strings    ${price}    ${temp}

Test
    @{res}=    Create List    0    1    2
    [Return]    ${res}