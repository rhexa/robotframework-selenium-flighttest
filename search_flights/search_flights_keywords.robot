*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections

*** Variables ***
${URL}          http://blazedemo.com/
${BROWSER}      Chrome

*** Keywords ***
Open Home Page
    Open browser    ${URL}   ${BROWSER}

Close Browsers
    Close All Browsers

Find Flights button is selectable
    Page Should Contain Button    xpath://input[@value="Find Flights"]

Get Total Price
    ${result}=    Get Text    xpath://div[@class="container"]/p[contains(text(),"Total Cost: ")]/em
    [Return]    ${result}

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

Verify flight data is correct
    [Arguments]    @{args}
    FOR    ${item}    IN    @{args}
        Page Should Contain    ${item}  
    END

Test
    @{res}=    Create List    0    1    2
    [Return]    ${res}