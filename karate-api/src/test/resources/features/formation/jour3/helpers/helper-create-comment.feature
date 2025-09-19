Feature: Helper - Créer un commentaire

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Créer un commentaire avec validation
    # 📝 HELPER: Créer un commentaire et retourner le résultat
    
    Given path '/comments'
    And request
    """
    {
      "name": "#(name)",
      "email": "#(email)", 
      "body": "#(body)",
      "postId": #(postId)
    }
    """
    When method POST
    Then status 201
    
    # Variables de retour
    * def comment = response
    * def success = true
    
    * print 'Helper: Commentaire créé par', comment.name, 'ID:', comment.id