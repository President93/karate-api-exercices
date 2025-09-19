# 🔧 Helpers - Features Réutilisables

## 🎯 Objectif

Centraliser les fonctionnalités communes dans des features réutilisables pour éviter la duplication de code.

## 📁 Helpers disponibles

| Helper | Fonction | Paramètres | Retour |
|--------|----------|------------|--------|
| **helper-create-user** | Créer utilisateur | name, username, email | user, success |
| **helper-create-post** | Créer article | title, body, userId | post, success |
| **helper-create-album** | Créer album | title, userId | album, success |
| **helper-create-comment** | Créer commentaire | name, email, body, postId | comment, success |
| **helper-validate-simple** | Validation basique | postId | success |

## 💡 Avantages des helpers

### **🔄 Réutilisabilité**
- Une fois écrit, utilisable partout
- Évite la duplication de code
- Maintenance centralisée

### **🧪 Tests cohérents**
- Même logique de création
- Validation standardisée
- Résultats prévisibles

### **📖 Lisibilité**
- Tests plus courts
- Focus sur la logique métier
- Code auto-documenté

## 📖 Comment utiliser

### **Appeler un helper**
```gherkin
* def userData = { name: "Alice", username: "alice", email: "alice@test.com" }
* def user = call read('classpath:formation/jour3/helpers/helper-create-user.feature') userData
* print 'Utilisateur créé:', user.user.name
```

### **Chaîner des helpers**
```gherkin
# Créer un utilisateur
* def userData = { name: "Bob", username: "bob", email: "bob@test.com" }
* def user = call read('classpath:formation/jour3/helpers/helper-create-user.feature') userData

# Créer son album
* def albumData = { title: "Mes photos", userId: user.user.id }
* def album = call read('classpath:formation/jour3/helpers/helper-create-album.feature') albumData

# Validation
* match user.success == true
* match album.success == true
```

## 🏗️ Structure d'un helper

### **Pattern standard**
```gherkin
Feature: Helper - Description

Background:
  * url 'https://jsonplaceholder.typicode.com'

Scenario: Action avec validation
  # Requête avec paramètres
  Given path '/endpoint'
  And request
  """
  {
    "field1": "#(param1)",
    "field2": "#(param2)"
  }
  """
  When method POST
  Then status 201
  
  # Variables de retour
  * def resource = response
  * def success = true
  
  * print 'Helper: Resource créée ID:', resource.id
```

## ⚙️ Paramètres et retours

### **Passage de paramètres**
```gherkin
# Dans le test principal
* def userData = { name: "Alice", username: "alice", email: "alice@test.com" }
* def result = call read('classpath:formation/jour3/helpers/helper-create-user.feature') userData

# Dans le helper
And request
"""
{
  "name": "#(name)",
  "username": "#(username)", 
  "email": "#(email)"
}
"""
```

### **Variables de retour**
Chaque helper retourne toujours :
- **`success`** : boolean (true/false)
- **`resource`** : objet créé (user, post, album, etc.)

## 🧪 Tests des helpers

### **Test unitaire d'un helper**
```gherkin
* def testData = { name: "Test User", username: "testuser", email: "test@example.com" }
* def result = call read('classpath:formation/jour3/helpers/helper-create-user.feature') testData

# Validation
* match result.success == true
* match result.user.name == "Test User"
* match result.user.id == '#number'
```

## ✅ Bonnes pratiques

- ✅ **Un helper = une responsabilité**
- ✅ **Nommage cohérent** : `helper-action-resource`
- ✅ **Validation systématique** du retour
- ✅ **Documentation** des paramètres
- ✅ **Gestion d'erreurs** avec success boolean
- ✅ **Messages informatifs** avec print

## 🔧 Maintenance

Pour créer un nouveau helper :
1. Copier un helper existant
2. Adapter endpoint et paramètres
3. Tester unitairement
4. Documenter dans ce README

---

**Pattern Karate** : `call read('classpath:path/to/helper.feature') parameters`