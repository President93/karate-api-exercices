Feature: Helper - Créer un utilisateur

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Créer un utilisateur avec des données complètes
    # 📝 HELPER: Créer un utilisateur avec validation
    
    Given path '/users'
    And request
    """
    {
      "name": "#(name)",
      "username": "#(username)",
      "email": "#(email)",
      "phone": "01-23-45-67-89",
      "website": "#(username).com",
      "address": {
        "street": "123 Test Street",
        "city": "TestCity",
        "zipcode": "12345"
      },
      "company": {
        "name": "Test Company",
        "catchPhrase": "Testing is key"
      }
    }
    """
    When method POST
    Then status 201
    
    # Variables de retour
    * def user = response
    * def success = true
    
    * print 'Helper: Utilisateur créé -', user.name