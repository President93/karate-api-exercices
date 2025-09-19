Feature: Helper - Créer un album

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Créer un album avec validation
    # 📝 HELPER: Créer un album et retourner le résultat
    
    Given path '/albums'
    And request
    """
    {
      "title": "#(title)",
      "userId": #(userId)
    }
    """
    When method POST
    Then status 201
    
    # Variables de retour
    * def album = response
    * def success = true
    
    * print 'Helper: Album créé -', album.title, 'ID:', album.id