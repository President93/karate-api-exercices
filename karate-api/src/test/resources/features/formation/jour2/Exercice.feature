# Feature: bla bla
#     Background:
#         * url jsonUrl
#     Scenario: Créer plusieurs posts en une fois
#     Given path '/posts'
#     When method GET
#     Then status 200
#     * def all = response
#     * print 'Nombre total déléments à supprimer:', all.length

#     * karate.forEach(all, function(item){
#         karate.log('Suppression de lelement ID:', item.id)
#         var res = karate.call({
#             url: jsonUrl + '/posts/' + item.id,
#             method: 'delete'
#         });
#         karate.log('Supprime ID:', item.id, '| Status:', res.responseStatus);
#     })


Feature: Purge de tous les posts sans call()

Background:
    * def jsonUrl = 'http://localhost:3001'  
    * url jsonUrl

Scenario: Supprimer tous les posts existants
    # 1) Récupérer la liste
    Given path 'posts'
    When method GET
    Then status 200
    * def all = response
    * print 'Nombre total d\'éléments à supprimer :', all.length

    # 2) Supprimer chaque post via l'API JS karate.http()
    * eval
    """
    var http = karate.http(jsonUrl);     // client HTTP réutilisable
    for (var i = 0; i < all.length; i++) {
      var id = all[i].id;
      http.reset();                      // (bon réflexe) remet le path/params à zéro
      http.path('posts', id).delete();   // DELETE /posts/{id}
      karate.log('🗑️ Supprimé ID:', id, '| Status:', http.responseStatus);
    }
    """
