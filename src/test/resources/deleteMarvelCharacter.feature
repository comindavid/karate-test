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
    

  @id:9 @eliminarPersonaje @respuestaExitosa204
  Scenario: T-API-HU-0001-CA09-Eliminar personaje exitosamente 204 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character_three.json')
    And request jsonData
    When method POST
    * def createdId = karate.get('createdId')
    * karate.set('createdId', response.id)

    * def createdId = response.id
    * path createdId
    When method DELETE
    Then status 204
    * karate.set('createdId', createdId)

  @id:10 @eliminarPersonaje @errorNoEncontrado404
  Scenario: T-API-HU-0001-CA10-Eliminar personaje no existente 404 - karate
    * path '999'
    When method DELETE
    Then status 404
    # And match response.error contains 'not found'
    # And match response.status == 404