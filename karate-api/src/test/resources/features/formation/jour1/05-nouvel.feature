Feature: 
    Background:
        * url 'http://localhost:3001'


    
Scenario: 
    Given path '/posts'
    And request {"title": 'Titre !', "body": 'Corps !', "userId": 23052003}
    When method POST 
    Then status 201 

    * def x = response.id

    Given path '/posts/' + x
    When method GET
    Then status 200
    * def var1 = response.id
    * print var1
