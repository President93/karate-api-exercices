Feature:
    Background:
        * url baseUrl


    Scenario:
        * def credentials = 'teamdlab:44mUTmCP8REI93QbpogYvVAu'
        * def encoded = java.util.Base64.getEncoder().encodeToString(credentials.getBytes())
        * header Authorization = 'Basic ' + encoded
        
        Given path 'api/Messages'
        When method GET
        Then status 200
        * def allMessages = response

        * def destinataire = 'joana.hiu@xtech.com'
        * def messagesToDelete = karate.filter(allMessages, function(m) { return m.to == destinataire })

        * print 'Messages à supprimer pour', destinataire, ':', messagesToDelete.length


        * karate.forEach(messagesToDelete, function(msg) {
            karate.log('Suppression du message ID:', msg.id)
            karate.call({
            url: 'https://smtp-xam.xelians-dev.fr/api/Messages/' + msg.id,
            method: 'delete',
            headers: { Authorization: 'Basic ' + encoded }
            })
        })


    # Scenario: Simuler CRUD sur l'utilisateur "Test User"

        # # CREATE (POST)
        # Given path '/users'
        # And request
        # """
        # {
        # "name": "Test User",
        # "username": "testuser",
        # "email": "test@example.com"
        # }
        # """
        # When method POST
        # Then status 201
        # * def userId = response.id
        # * print 'Utilisateur créé avec ID:', userId

        # # READ (GET)
        # Given path '/users', userId
        # When method GET
        # Then status 200
        # And match response.name == "Test User"
        # And match response.username == "testuser"
        # * print 'Utilisateur récupéré:', response.name

        # # UPDATE (PUT)
        # Given path '/users', userId
        # And request
        # """
        # {
        # "id": "#(userId)",
        # "name": "Test User Modifié",
        # "username": "updateduser",
        # "email": "updated@example.com"
        # }
        # """
        # When method PUT
        # Then status 200
        # And match response.name == "Test User Modifié"
        # And match response.username == "updateduser"
        # * print 'Utilisateur mis à jour:', response.name

        # # DELETE
        # Given path '/users', userId
        # When method DELETE
        # Then status 200
        # * print 'Utilisateur supprimé avec ID:', userId

        # # VERIFY DELETE (GET après suppression)
        # Given path '/users', userId
        # When method GET
        # Then status 404
        # * print 'Vérification : utilisateur supprimé'
