# 📁 JOUR 3 - Structure organisée

## 📊 Architecture professionnelle du projet

```
jour3/
├── data/                    # 📄 Fichiers de données externes
│   ├── test-data.json      # Données principales (users, articles, config)
│   ├── collection-data.json # Données albums et commentaires
│   ├── config-dev.json     # Configuration développement
│   └── users-exemple.csv   # Exemple de données CSV
├── helpers/                 # 🔧 Features réutilisables
│   ├── helper-create-user.feature     # Créer un utilisateur
│   ├── helper-create-post.feature     # Créer un post
│   ├── helper-create-album.feature    # Créer un album
│   ├── helper-create-comment.feature  # Créer un commentaire
│   └── helper-validate-simple.feature # Validation basique
└── tests/                   # 🧪 Tests principaux (3 modules = 3h)
    ├── 01-tests-parametres.feature       # Module 1: Scenario Outline (1h)
    ├── 02-features-reutilisables.feature # Module 2: Helpers + read() (1h)
    └── 03-exercice-pratique.feature      # Module 3: Exercice complet (1h)
```

## 🎯 Avantages de cette organisation

### **📄 Dossier `data/`**
- **Centralisation** des données de test
- **Maintenance** facilitée (1 seul endroit à modifier)
- **Environnements** multiples (dev, test, prod)
- **Formats** variés (JSON, CSV, XML)

### **🔧 Dossier `helpers/`**
- **Réutilisabilité** maximale
- **Maintenance** centralisée des helpers
- **Évolutivité** (facile d'ajouter de nouveaux helpers)
- **Convention** claire de nommage

### **🧪 Dossier `tests/`**
- **Séparation** tests vs utilitaires
- **Navigation** facilitée
- **Tests** focalisés sur la logique métier
- **Clarté** de l'organisation

## 📝 Utilisation

### **Charger des données :**
```gherkin
* def testData = read('classpath:formation/jour3/data/test-data.json')
* def collectionData = read('classpath:formation/jour3/data/collection-data.json')
* def config = read('classpath:formation/jour3/data/config-dev.json')
* def users = read('classpath:formation/jour3/data/users-exemple.csv')
```

### **Utiliser des helpers :**
```gherkin
* def user = call read('classpath:formation/jour3/helpers/helper-create-user.feature') userData
* def post = call read('classpath:formation/jour3/helpers/helper-create-post.feature') postData
* def album = call read('classpath:formation/jour3/helpers/helper-create-album.feature') albumData
* def comment = call read('classpath:formation/jour3/helpers/helper-create-comment.feature') commentData
* def validation = call read('classpath:formation/jour3/helpers/helper-validate-simple.feature') { postId: 1 }
```

## ✅ Bonnes pratiques respectées

- ✅ **Séparation des responsabilités** (data/helpers/tests)
- ✅ **Réutilisabilité** maximale
- ✅ **Maintenance** simplifiée
- ✅ **Lisibilité** améliorée
- ✅ **Évolutivité** assurée
- ✅ **Standards** professionnels