Feature: 
    Background:
        * url 'https://jsonplaceholder.typicode.com'
Scenario:
    Given path '/comments'
    When method GET
    Then status 200
    And match response[0] contains {postId: '#number', id: "#number", name: "#string", email: "#present", body :"#string"}