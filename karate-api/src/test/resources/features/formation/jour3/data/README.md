# 📄 Données Externes - Jour 3

## 🎯 Objectif

Centraliser toutes les données externes utilisées dans les tests du jour 3.

## 📁 Fichiers disponibles

| Fichier | Format | Contenu | Usage |
|---------|--------|---------|-------|
| **test-data.json** | JSON | Users, articles, config | Tests généraux |
| **collection-data.json** | JSON | Albums, commentaires | Exercices pratiques |
| **config-dev.json** | JSON | Configuration développement | Environnement |
| **users-exemple.csv** | CSV | Liste d'utilisateurs | Tests CSV |

## 💡 Avantages de cette approche

### **📄 Centralisation**
- Toutes les données au même endroit
- Maintenance facilitée
- Cohérence des tests

### **🔄 Réutilisabilité**
- Mêmes données pour plusieurs tests
- Évite la duplication
- Facilite les modifications

### **🌍 Environnements multiples**
- `config-dev.json` pour développement
- `config-test.json` pour tests
- `config-prod.json` pour production

## 📖 Comment utiliser

### **Charger un fichier JSON**
```gherkin
* def testData = read('classpath:formation/jour3/data/test-data.json')
* def users = testData.users
* def articles = testData.articles
```

### **Charger configuration**
```gherkin
* def config = read('classpath:formation/jour3/data/config-dev.json')
* def baseUrl = config.api.baseUrl
* def timeout = config.timeouts.default
```

### **Charger un CSV**
```gherkin
* def users = read('classpath:formation/jour3/data/users-exemple.csv')
* print 'Nombre d\'utilisateurs:', users.length
```

## 🗂️ Structure des fichiers JSON

### **test-data.json**
```json
{
  "users": [...],
  "articles": [...],
  "config": {...}
}
```

### **collection-data.json**
```json
{
  "albums": [...],
  "commentaires": [...]
}
```

## ✅ Bonnes pratiques

- ✅ **Nommage cohérent** des fichiers
- ✅ **Structure logique** des données
- ✅ **Validation** des formats JSON
- ✅ **Documentation** des contenus
- ✅ **Séparation** par environnement

## 🔧 Maintenance

Pour modifier les données :
1. Éditer le fichier JSON/CSV concerné
2. Valider la syntaxe JSON
3. Tester avec un scenario simple
4. Documenter les changements

---

**Note** : Ces fichiers sont chargés via `read()` dans les tests Karate