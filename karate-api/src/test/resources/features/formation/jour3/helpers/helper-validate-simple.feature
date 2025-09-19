Feature: Helper simple - Validation de post

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Valider qu'un post existe et est correct
    # 📝 HELPER SIMPLE: Vérifier qu'un post est valide
    
    Given path '/posts/' + postId
    When method GET
    
    # Validation de base
    * def isValid = responseStatus == 200
    * def message = isValid ? 'Post valide' : 'Post introuvable'
    
    # Si le post existe, vérifier sa structure
    * if (isValid) karate.set('hasTitle', response.title != null)
    * if (isValid) karate.set('hasBody', response.body != null) 
    * if (isValid) karate.set('hasUserId', response.userId != null)
    
    # Message détaillé
    * if (isValid) karate.set('message', 'Post ID ' + postId + ' est valide et complet')
    
    * print 'Validation post', postId + ':', isValid ? 'VALIDE' : 'INVALIDE'