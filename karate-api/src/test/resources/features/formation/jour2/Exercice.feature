Feature:
    Background:
        * url 'http://localhost:3001'



Scenario:
    * def posts = 
        """
        [
        { "title": "Post 1", "body": "Premier post", "userId": 1 },
        { "title": "Post 2", "body": "Deuxième post", "userId": 1 },
        { "title": "Post 3", "body": "Troisième post", "userId": 2 }
        ]
        """
        
        # Premier post
        Given path '/posts'
        And request posts[0]
        When method POST
        Then status 201
        
        # Deuxième post
        Given path '/posts'
        And request posts[1]
        When method POST
        Then status 201

Scenario: Headers et Content-Type
    # 📝 OBJECTIF: Comprendre les headers HTTP
    Given path '/posts'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request 
    """
    {
      "title": "Post avec headers explicites",
      "body": "J'ai spécifié les headers manuellement",
      "userId": 1
    }
    """
    When method POST
    Then status 201
    # 💡 Explication: 
    # - Content-Type = type de données qu'on envoie
    # - Accept = type de réponse qu'on veut recevoir
    