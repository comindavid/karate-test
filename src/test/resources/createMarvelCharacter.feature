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

  @id:2 @crearPersonaje @respuestaExitosa201
  Scenario: T-API-HU-0001-CA02-Crear personaje exitosamente 201 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character.json')
    And request jsonData
    When method POST
    Then status 201
    And match response.name == 'Iron Man'
    And match response.id != null
    * karate.set('createdId', response.id)

  @id:3 @crearPersonaje @errorNombreDuplicado400
  Scenario: T-API-HU-0001-CA03-Crear personaje con nombre duplicado 400 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character_duplicate.json')
    And request jsonData
    When method POST
    Then status 400
    And match response.error contains 'already exists'
    * def createdId = karate.get('createdId')
    * path createdId
    When method DELETE


  @id:4 @crearPersonaje @errorCamposRequeridos400
  Scenario: T-API-HU-0001-CA04-Crear personaje con campos requeridos vacíos 400 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character_invalid.json')
    And request jsonData
    When method POST
    Then status 400
    And match response.name contains 'required'