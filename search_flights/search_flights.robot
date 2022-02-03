*** Settings ***
Resource        search_flights_keywords.robot
Library    ../venv/lib/site-packages/robot/libraries/String.py
Library    Collections

*** Variables ***
${departure_city}    Boston
${destination_city}    Cairo

*** Test Cases ***
Page should contain "Welcome to the Simple Travel Agency!"
    Page Should Contain    Welcome to the Simple Travel Agency!

Select "Boston" as the starting city (store this information in the variable)
    Select Departure City    ${departure_city}

Select "Cairo" as the destination (store this information in the variable)
    Select Destination City    ${destination_city}

Check that the Find Flights button is selectable
    Find Flights button is selectable

Press the Find Flights button
    Search For Flights
    
Check that the page says Flights from Boston to Cairo: (check the city names with the variables you created)
    Page Should Contain    Flights from ${departure_city} to ${destination_city}

Check that you have at least one flight choice visible
    There are available Flights

Select one of the flights -> store the price, number and airline of that flight in separate variables
    ${id}    ${airline}    ${price}=    Select first available flight
    Set Global Variable    ${id}
    Set Global Variable    ${airline}
    Set Global Variable    ${price}

On the page that opens, check that the price, airline, and flight number of the trip you stored in the variables can be found on the page (note that here you need to slightly change the information you export to the variable (String library (?))
    @{list}=    Create List    ${id}    ${airline}    ${price}
    Run Keyword And Expect Error    *    Verify flight data is correct    ${list}

Store the total price of the flight in a new variable
Fill in the passenger information on the form (set the month and year of the card as global variables)
Choose Diner's Club as your credit card
Click "Remember me"
Click "Purchase Flight"
Check that the page that opens says "Thank you for your purchase today!"
Check that the exposure time is correct
Check that the total price is correct (should be equal with the variable you stored in previous step)