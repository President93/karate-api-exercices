Feature: Helper - Créer un post

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Créer un post avec validation
    # 📝 HELPER: Créer un post et retourner le résultat
    
    Given path '/posts'
    And request
    """
    {
      "title": "#(title)",
      "body": "#(body)",
      "userId": #(userId)
    }
    """
    When method POST
    Then status 201
    
    # Variables de retour
    * def post = response
    * def success = true
    
    * print 'Helper: Post créé -', post.title, 'ID:', post.id