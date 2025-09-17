Feature: 
    Background:
        * url 'https://jsonplaceholder.typicode.com'
Scenario:
    Given path '/albums'
    And param userId = 2
    When method GET
    Then status 200
    And match each response[*].userId == 2