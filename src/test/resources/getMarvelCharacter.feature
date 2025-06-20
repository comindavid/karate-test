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
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character.json')
    And request jsonData
    When method POST
    * def createdId = karate.get('createdId')
    * karate.set('createdId', response.id)

  @id:5 @obtenerPersonaje @respuestaExitosa200
  Scenario: T-API-HU-0001-CA05-Obtener personaje por ID exitosamente 200 - karate
    * path createdId
    When method GET
    Then status 200
    * karate.set('createdId', createdId)

  @id:6 @obtenerPersonaje @errorNoEncontrado404
  Scenario: T-API-HU-0001-CA06-Obtener personaje por ID no existente 404 - karate
    * path '999'
    When method GET
    Then status 404
    And match response.error contains 'not found'
    * path createdId
    When method DELETE