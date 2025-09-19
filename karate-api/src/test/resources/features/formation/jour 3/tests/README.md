# 🧪 Tests Jour 3 - Techniques Essentielles

## 🎯 Objectif du jour

Maîtriser les techniques essentielles de Karate :
- **Scenario Outline** pour tests paramétrés
- **call read()** pour réutiliser des helpers
- **read()** pour charger des fichiers externes

## ⏱️ Planning (3h total)

| Module | Durée | Fichier | Contenu |
|--------|-------|---------|---------|
| **1. Tests paramétrés** | 1h | `01-tests-parametres.feature` | Scenario Outline + Examples |
| **2. Features réutilisables** | 1h | `02-features-reutilisables.feature` | Helpers + read() JSON |
| **3. Exercice pratique** | 1h | `03-exercice-pratique.feature` | Combinaison complète |

## 📚 Modules détaillés

### **Module 1 : Tests paramétrés (1h)**
- **Concept** : Scenario Outline avec table Examples
- **Objectif** : Éviter la duplication dans les tests
- **API** : JSONPlaceholder `/users`
- **Technique** : Paramétrage avec `<variable>`

```gherkin
Scenario Outline: Tests paramétrés
  Given path '/users/<userId>'
  When method GET
  Then status 200
  And match response.name == '<expectedName>'
  
Examples:
  | userId | expectedName |
  | 1      | Leanne Graham |
  | 2      | Ervin Howell |
```

### **Module 2 : Features réutilisables (1h)**
- **Concept** : call read() pour helpers + read() pour JSON
- **Objectif** : Centraliser et réutiliser le code
- **Technique** : Helpers + données externes

```gherkin
# Utilisation helper
* def userData = { name: "Alice", username: "alice", email: "alice@test.com" }
* def user = call read('classpath:formation/jour3/helpers/helper-create-user.feature') userData

# Lecture JSON externe
* def testData = read('classpath:formation/jour3/data/test-data.json')
* def users = testData.users
```

### **Module 3 : Exercice pratique (1h)**
- **Concept** : Combiner toutes les techniques
- **Objectif** : Système galerie photo complet
- **API** : Albums + Comments (nouveaux endpoints)
- **Technique** : Scenario Outline + helpers + read() JSON

## 🌐 APIs utilisées

### **JSONPlaceholder endpoints**
- **Users** : `/users` (création photographes)
- **Albums** : `/albums` (galeries photos) ⭐ *Nouveau*
- **Comments** : `/comments` (commentaires) ⭐ *Nouveau*
- **Posts** : `/posts` (présentations)

### **Données externes**
- `test-data.json` : Utilisateurs et articles
- `collection-data.json` : Albums et commentaires ⭐ *Nouveau*

## 💡 Concepts clés

### **Scenario Outline vs Scenario**
```gherkin
# AVANT (duplication)
Scenario: Test utilisateur 1
  Given path '/users/1'
  When method GET
  Then match response.name == 'Leanne Graham'

Scenario: Test utilisateur 2  
  Given path '/users/2'
  When method GET
  Then match response.name == 'Ervin Howell'

# APRÈS (paramétré)
Scenario Outline: Test utilisateurs
  Given path '/users/<userId>'
  When method GET
  Then match response.name == '<name>'
  
Examples:
  | userId | name          |
  | 1      | Leanne Graham |
  | 2      | Ervin Howell  |
```

### **call read() vs read()**
```gherkin
# call read() = Exécuter une feature (helper)
* def user = call read('classpath:path/helper.feature') params

# read() = Charger des données (JSON/CSV)
* def data = read('classpath:path/data.json')
```

## 🚀 Comment tester

### **Tests complets**
```bash
# Tout le jour 3
mvn test -Dtest=TestRunner#testJour3

# Module par module
mvn test -Dkarate.options="classpath:formation/jour3/tests/01-tests-parametres.feature"
mvn test -Dkarate.options="classpath:formation/jour3/tests/02-features-reutilisables.feature"
mvn test -Dkarate.options="classpath:formation/jour3/tests/03-exercice-pratique.feature"
```

## ✅ Compétences acquises

À la fin du jour 3, les participants maîtrisent :
- ✅ **Scenario Outline** pour éviter la duplication
- ✅ **call read()** pour réutiliser des helpers
- ✅ **read()** pour charger des fichiers JSON/CSV
- ✅ **Nouveaux endpoints** albums et comments
- ✅ **Architecture modulaire** avec data/helpers/tests
- ✅ **Workflows complets** multi-étapes

## 📖 Ressources

### **Helpers disponibles**
- [helper-create-user](../helpers/helper-create-user.feature)
- [helper-create-album](../helpers/helper-create-album.feature)
- [helper-create-comment](../helpers/helper-create-comment.feature)

### **Données disponibles**
- [test-data.json](../data/test-data.json)
- [collection-data.json](../data/collection-data.json)

### **Documentation**
- [Helpers](../helpers/README.md)
- [Données](../data/README.md)

## 🔗 Navigation

- **Formation générale** : [Formation](../../README.md)
- **Jour précédent** : [Jour 2](../../jour2/README.md)
- **Modules bonus** : [Authentification](../../../modules-bonus/)

---

**Durée totale** : 3h | **Niveau** : Intermédiaire | **Prérequis** : Jours 1-2