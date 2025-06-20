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

  @id:1 @listarPersonajes @respuestaExitosa200
  Scenario: T-API-HU-0001-CA01-Obtener todos los personajes 200 - karate
    When method GET
    Then status 200
    # And match response == []