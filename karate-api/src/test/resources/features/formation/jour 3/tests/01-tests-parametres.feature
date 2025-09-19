Feature: JOUR 3 - Tests paramétrés simplifiés (1h)
  # 🎯 Objectif principal: Éliminer la duplication de tests
  # ⏱️ Durée: 1h (temps réduit pour se concentrer sur l'essentiel)

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: ❌ PROBLÈME - Code répétitif (sans Scenario Outline)
    # 📝 DÉMONSTRATION: Répétition = mauvaise pratique
    
    # Tester utilisateur 1
    Given path '/users/1'
    When method GET
    Then status 200
    And match response.name == 'Leanne Graham'
    
    # Tester utilisateur 2  
    Given path '/users/2'
    When method GET 
    Then status 200
    And match response.name == 'Ervin Howell'
    
    # Tester utilisateur 3
    Given path '/users/3'
    When method GET 
    Then status 200
    And match response.name == 'Clementine Bauch'
    
    * print "❌ Imaginez copier-coller ça pour 100 utilisateurs !"

  Scenario Outline: ✅ SOLUTION - Tests paramétrés avec Scenario Outline
    # 📝 OBJECTIF: Un seul test = plusieurs exécutions automatiques
    
    Given path '/users/<userId>'
    When method GET
    Then status 200
    And match response.id == <userId>
    And match response.name == '<expectedName>'
    * print "✅ Utilisateur <userId> testé:", response.name
    
    Examples:
      | userId | expectedName     |
      | 1      | Leanne Graham    |
      | 2      | Ervin Howell     |  
      | 3      | Clementine Bauch |
      | 4      | Patricia Lebsack |
    # 💡 Résultat: 4 tests exécutés avec 10 lignes au lieu de 40+

  Scenario Outline: Créer plusieurs posts en une fois
    # 📝 OBJECTIF: Tests de création avec données variables
    
    Given path '/posts'
    And request
    """
    {
      "title": "<title>",
      "body": "<body>",
      "userId": <userId>
    }
    """
    When method POST
    Then status 201
    And match response.title == '<title>'
    And match response.userId == <userId>
    * print "📄 Post créé:", response.title
    
    Examples:
      | title                | body                        | userId |
      | Article de blog      | Contenu informatif          | 1      |
      | Rapport technique    | Analyse des performances    | 2      |
      | Guide utilisateur    | Mode d'emploi détaillé      | 1      |
    # 💡 Résultat: 3 posts créés automatiquement

  Scenario Outline: Validation métier avec Examples
    # 📝 OBJECTIF: Vérifier des règles business sur plusieurs cas
    
    Given path '/posts'
    And param userId = <userId>
    When method GET
    Then status 200
    And match response == '#[10]'
    And match each response contains { userId: <userId> }
    * print "👤 Utilisateur <userId> a bien", response.length, "posts"
    
    Examples:
      | userId |
      | 1      |
      | 2      |
      | 3      |
    # 💡 Résultat: Validation de cohérence sur 3 utilisateurs

  Scenario: Exercice pratique - À vous de jouer !
    # 📝 MISSION: Créer votre propre Scenario Outline
    # 🎯 CONSIGNE: Tester GET /posts/1, /posts/2, /posts/3
    # ✅ Vérifier que chaque post a un titre et un body non vides
    
    * print "💪 À compléter par le participant..."
    * print "📝 Indice: utilisez <postId> dans Examples"