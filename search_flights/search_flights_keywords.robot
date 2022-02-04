*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    DateTime

*** Variables ***
${URL}          http://blazedemo.com/
${BROWSER}      Chrome

*** Keywords ***
Open Home Page
    Open browser    ${URL}   ${BROWSER}

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

Verify exposure time is correct
    ${date}=    Get Text    xpath://tr[td="Date"]/td[2]
    ${date}=    Convert Date    ${date}    date_format=%a, %d %b %Y %H:%M:%S %z
    ${today}=    Get Current Date
    ${time_length}=    Subtract Date From Date    ${today}    ${date}
    ${time_delta}=    Convert Time    1 day
    ${isLessThanOneDay}=    Evaluate    ${time_length}<${time_delta}
    Should Be True    ${isLessThanOneDay}

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