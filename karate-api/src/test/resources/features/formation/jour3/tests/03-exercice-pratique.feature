Feature: JOUR 3 - Exercice pratique avec nouveaux endpoints (1h)
  # 🎯 Objectif: Pratiquer avec albums et comments (nouveaux endpoints)
  # 💪 Mission: Créer une galerie photo avec commentaires
  # ⏱️ Durée: 1h

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario Outline: 📸 Créer une galerie photos avec Scenario Outline + helpers
    # 📝 MISSION: Créer différents albums photos avec des helpers
    # 🎯 NOUVEAUTÉ: Utiliser les endpoints /albums au lieu de /posts
    # 🟢 COMBINE: Scenario Outline + helpers + nouveaux endpoints
    
    # Étape 1: Créer un utilisateur (photographe) avec helper
    * def photographeData = { name: "<nom_photographe>", username: "<username>", email: "<email>" }
    * def photographe = call read('classpath:formation/jour3/helpers/helper-create-user.feature') photographeData
    * print "📷 Photographe créé:", photographe.user.name
    
    # Étape 2: Créer son album avec le helper
    * def albumData = { title: "<titre_album>", userId: photographe.user.id }
    * def album = call read('classpath:formation/jour3/helpers/helper-create-album.feature') albumData
    * print "📸 Album créé:", album.album.title
    
    # Étape 3: Validation que tout fonctionne
    * match photographe.success == true
    * match album.success == true
    * print "✅ Galerie <type> créée avec succès !"
    
    Examples:
      | type     | nom_photographe | username    | email                | titre_album           |
      | Vacances | Alice Voyage    | alice_photo | alice@vacances.com   | Photos de vacances    |
      | Famille  | Bob Parent      | bob_family  | bob@famille.com      | Album famille         |
      | Nature   | Carol Explorer  | carol_nature| carol@nature.com     | Paysages magnifiques  |
    # 💡 Résultat: 3 photographes avec leurs albums créés automatiquement !

  Scenario: 💬 Ajouter des commentaires avec read() + helper
    # 📝 MISSION: Ajouter des commentaires sur un post existant
    # 🎯 NOUVEAUTÉ: Endpoint /comments + données JSON externes
    # 🟡 COMBINE: read() + helper + nouveau endpoint
    
    * print "💬 CRÉATION DE COMMENTAIRES AVEC DONNÉES EXTERNES"
    
    # Étape 1: Charger les commentaires depuis un fichier JSON
    * def commentData = read('classpath:formation/jour3/data/collection-data.json')
    * def commentaires = commentData.commentaires
    * print "📄 Commentaires chargés:", commentaires.length, "commentaires prêts"
    
    # Étape 2: Prendre un post existant (on sait qu'il y en a)
    Given path '/posts/1'
    When method GET
    Then status 200
    * def postId = response.id
    * print "📝 Post trouvé:", response.title, "ID:", postId
    
    # Étape 3: Ajouter le premier commentaire avec helper
    * def premierComment = commentaires[0]
    * set premierComment.postId = postId
    * def commentCree = call read('classpath:formation/jour3/helpers/helper-create-comment.feature') premierComment
    * print "💬 Commentaire ajouté par:", commentCree.comment.name
    
    # Étape 4: Validation
    * match commentCree.success == true
    * match commentCree.comment.postId == postId
    * print "✅ Commentaire lié au bon post !"

  Scenario: 🔍 Explorer les nouveaux endpoints - Tests simples
    # 📝 MISSION: Découvrir /albums et /comments avec des tests basiques
    # 🎯 NOUVEAUTÉ: Endpoints différents de /posts et /users
    
    * print "🔍 EXPLORATION DES NOUVEAUX ENDPOINTS"
    
    # Test 1: Lister les albums existants
    Given path '/albums'
    When method GET
    Then status 200
    And match response == '#array'
    And match response[0].title == '#string'
    And match response[0].userId == '#number'
    * print "📸 Albums trouvés:", response.length
    
    # Test 2: Récupérer un album spécifique
    Given path '/albums/1'
    When method GET
    Then status 200
    And match response.id == 1
    And match response.title == '#string'
    * print "📖 Album 1:", response.title
    
    # Test 3: Lister les commentaires existants
    Given path '/comments'
    When method GET
    Then status 200
    And match response == '#array'
    And match response[0].name == '#string'
    And match response[0].email == '#string'
    * print "💬 Commentaires trouvés:", response.length
    
    # Test 4: Commentaires d'un post spécifique
    Given path '/comments'
    And param postId = 1
    When method GET
    Then status 200
    And match response == '#array'
    And match each response contains { postId: 1 }
    * print "💬 Commentaires du post 1:", response.length
    
    * print "✅ Exploration des nouveaux endpoints réussie !"

  Scenario: 🎯 DÉFI FINAL - Créer un système complet
    # 📝 MISSION: Utiliser TOUS les concepts avec les nouveaux endpoints
    # 🏆 DÉFI: Scenario Outline + helpers + read() + nouveaux endpoints
    
    * print "🏆 DÉFI FINAL - SYSTÈME GALERIE COMPLÈTE"
    
    # Étape 1: Charger les données albums
    * def data = read('classpath:formation/jour3/data/collection-data.json')
    * def albumsData = data.albums
    * print "📄 Données albums chargées:", albumsData.length, "albums"
    
    # Étape 2: Créer un utilisateur-artiste
    * def artisteData = { name: "Marie Créative", username: "marie_art", email: "marie@art.com" }
    * def artiste = call read('classpath:formation/jour3/helpers/helper-create-user.feature') artisteData
    * print "🎨 Artiste créé:", artiste.user.name
    
    # Étape 3: Créer son premier album depuis les données
    * def premierAlbum = albumsData[0]
    * set premierAlbum.userId = artiste.user.id
    * def album = call read('classpath:formation/jour3/helpers/helper-create-album.feature') premierAlbum
    * print "📸 Album créé:", album.album.title
    
    # Étape 4: Créer un post pour présenter l'album
    * def presentationData = { title: "Présentation: " + album.album.title, body: premierAlbum.description, userId: artiste.user.id }
    * def presentation = call read('classpath:formation/jour3/helpers/helper-create-post.feature') presentationData
    * print "📝 Présentation créée:", presentation.post.title
    
    # Étape 5: Ajouter un commentaire sur la présentation
    * def commentData = data.commentaires[0]
    * set commentData.postId = presentation.post.id
    * def commentaire = call read('classpath:formation/jour3/helpers/helper-create-comment.feature') commentData
    * print "💬 Commentaire ajouté par:", commentaire.comment.name
    
    # Validation finale
    * match artiste.success == true
    * match album.success == true
    * match presentation.success == true
    * match commentaire.success == true
    
    * print "🎉 SYSTÈME GALERIE COMPLÈTE CRÉÉ !"
    * print "   🎨 Artiste:", artiste.user.name
    * print "   📸 Album:", album.album.title  
    * print "   📝 Présentation:", presentation.post.title
    * print "   💬 Commentaire:", commentaire.comment.name
    * print "✅ TOUS LES CONCEPTS MAÎTRISÉS AVEC NOUVEAUX ENDPOINTS !"