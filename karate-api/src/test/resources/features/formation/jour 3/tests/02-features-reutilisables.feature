Feature: JOUR 3 - Features réutilisables simplifiées (1h)
  # 🎯 Objectif principal: Réutiliser le code avec call read  
  # ⏱️ Durée: 1h (seulement l'essentiel)

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: ❌ PROBLÈME - Code dupliqué partout
    # 📝 DÉMONSTRATION: Répétition = maintenance difficile
    
    # Créer un post (code long...)
    Given path '/posts'
    And request { "title": "Post test 1", "body": "Contenu", "userId": 1 }
    When method POST
    Then status 201
    And match response.title == '#string'
    And match response.body == '#string'
    And match response.userId == 1
    * def postId1 = response.id
    
    # Créer un autre post (même code répété...)
    Given path '/posts'
    And request { "title": "Post test 2", "body": "Contenu", "userId": 1 }
    When method POST
    Then status 201
    And match response.title == '#string'
    And match response.body == '#string'
    And match response.userId == 1
    * def postId2 = response.id
    
    * print "❌ Code répété = problème de maintenance !"

  Scenario: ✅ SOLUTION - call read pour réutiliser
    # 📝 OBJECTIF: Un helper = beaucoup de réutilisations
    
    # Créer des posts avec un helper (code réutilisable !)
    * def post1 = call read('classpath:formation/jour3/helpers/helper-create-post.feature') { title: "Post via helper 1", body: "Contenu", userId: 1 }
    * def post2 = call read('classpath:formation/jour3/helpers/helper-create-post.feature') { title: "Post via helper 2", body: "Contenu", userId: 1 }
    
    # Vérifier que les deux ont fonctionné
    * match post1.success == true
    * match post2.success == true
    * print "✅ Deux posts créés avec 2 lignes au lieu de 20+ !"

  Scenario: Helper avec paramètres
    # 📝 OBJECTIF: Passer des données variables aux helpers
    
    # Différentes données à tester
    * def articleData = { title: "Mon article", body: "Contenu détaillé", userId: 1 }
    * def rapportData = { title: "Rapport mensuel", body: "Données du mois", userId: 2 }
    
    # Même helper, données différentes
    * def article = call read('classpath:formation/jour3/helpers/helper-create-post.feature') articleData
    * def rapport = call read('classpath:formation/jour3/helpers/helper-create-post.feature') rapportData
    
    # Validation
    * match article.post.title == "Mon article"
    * match rapport.post.title == "Rapport mensuel"
    * print "✅ Helper adaptatif avec paramètres !"

  Scenario: Chaîner plusieurs helpers - Workflow
    # 📝 OBJECTIF: Orchestrer plusieurs helpers ensemble
    
    # Étape 1: Créer un utilisateur  
    * def author = call read('classpath:formation/jour3/helpers/helper-create-user.feature') { name: "Alice Blog", username: "alice_b", email: "alice@blog.com" }
    * print "👤 Auteur créé:", author.user.name
    
    # Étape 2: Créer un post pour cet auteur
    * def article = call read('classpath:formation/jour3/helpers/helper-create-post.feature') { title: "Premier article", body: "Mon premier blog post", userId: author.user.id }
    * print "📄 Article créé:", article.post.title
    
    # Étape 3: Valider l'article
    * def validation = call read('classpath:formation/jour3/helpers/helper-validate-simple.feature') { postId: article.post.id }
    * print "✅ Validation:", validation.message
    
    # Tout a fonctionné ensemble !
    * match author.success == true
    * match article.success == true
    * match validation.isValid == true
    * print "🎉 Workflow complet avec 3 helpers !"

  Scenario: Comparaison directe - Avant/Après helpers
    # 📝 DÉMONSTRATION: Gain évident des helpers
    
    * print "=== AVANT (sans helpers) ==="
    * print "   📄 Créer 1 post = 8 lignes de code"
    * print "   🔄 Pour 10 posts = 80 lignes répétitives"
    * print "   🛠️ Modifier la logique = 80 endroits à changer"
    
    * print "=== APRÈS (avec helpers) ==="
    * print "   📄 Créer 1 post = 1 ligne de code"  
    * print "   🔄 Pour 10 posts = 10 lignes"
    * print "   🛠️ Modifier la logique = 1 seul helper à changer"
    
    # Démonstration concrète
    * def quickPost = call read('classpath:formation/jour3/helpers/helper-create-post.feature') { title: "Demo rapide", body: "Une seule ligne !", userId: 1 }
    * match quickPost.success == true
    * print "✅ Preuve : post créé en 1 ligne avec helper !"

  Scenario: ✅ TECHNIQUE ESSENTIELLE - read() pour fichiers JSON
    # 📝 OBJECTIF: Charger des données depuis un fichier externe
    # 🎯 TRÈS IMPORTANT: Séparer les données des tests pour faciliter la maintenance
    
    # Charger des données depuis un fichier JSON externe
    * def testData = read('classpath:formation/jour3/data/test-data.json')
    * print "📄 Données chargées depuis test-data.json"
    
    # Accéder aux différentes sections
    * def users = testData.users
    * def articles = testData.articles
    * def config = testData.config
    
    * print "👥 Utilisateurs disponibles:", users.length
    * print "📰 Articles disponibles:", articles.length
    * print "⚙️ Configuration:", config.baseUrl
    
    # Utiliser les données pour créer un utilisateur
    * def userData = users[0]
    * def user = call read('classpath:formation/jour3/helpers/helper-create-user.feature') userData
    * print "✅ Utilisateur créé depuis fichier JSON:", user.user.name
    
    # Utiliser les données pour créer un article
    * def articleData = articles[0]
    * set articleData.userId = user.user.id
    * def article = call read('classpath:formation/jour3/helpers/helper-create-post.feature') articleData
    * print "✅ Article créé depuis fichier JSON:", article.post.title
    
    * match user.success == true
    * match article.success == true
    * print "🎉 read() + helpers = Combinaison parfaite !"
