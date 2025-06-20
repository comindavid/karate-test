@REQ_HU-0001 @HU0001 @crud_personajes_marvel @marvel_characters_api @Agente2 @E2 @iniciativa_marvel_api
Feature: HU-0001 CRUD de personajes Marvel (microservicio para gestión de personajes)

  Background:
    * configure ssl = true
    * url "http://bp-se-test-cabcd9b246a5.herokuapp.com/comindavid/api/characters"
    * def generarHeaders =
      """
      function() {
        return {
          "Content-Type": "application/json"
        };
      }
      """
    * def headers = generarHeaders()
    * headers headers

  @id:7 @actualizarPersonaje @respuestaExitosa200
  Scenario: T-API-HU-0001-CA07-Actualizar personaje exitosamente 200 - karate
    * def jsonDataCreate = read('classpath:data/marvel_characters_api/request_create_character_two.json')
    And request jsonDataCreate
    When method POST
    * def createdId = karate.get('createdId')
    * karate.set('createdId', response.id)
    * def jsonData = read('classpath:data/marvel_characters_api/request_update_character.json')
    * def createdId = response.id
    * path createdId
    And request jsonData
    When method PUT
    Then status 200
    # And match response.description == 'Updated description'
    # And match response.id == createdId
    * karate.set('createdId', createdId)
    * path createdId
    When method DELETE

  @id:8 @actualizarPersonaje @errorNoEncontrado404
  Scenario: T-API-HU-0001-CA08-Actualizar personaje no existente 404 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character.json')
    * path '999'
    And request jsonData
    When method PUT
    Then status 404
    # And match response.error contains 'not found'
    # And match response.status == 404