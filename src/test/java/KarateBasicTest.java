import com.intuit.karate.junit5.Karate;

class KarateBasicTest {
    static {
        System.setProperty("karate.ssl", "true");
    }
    @Karate.Test
    Karate testBasic() {
        return Karate.run(
            "classpath:listMarvelCharacter.feature",
            "classpath:createMarvelCharacter.feature",
            "classpath:getMarvelCharacter.feature",
            "classpath:updateMarvelCharacter.feature",
            "classpath:deleteMarvelCharacter.feature"
            );
    }

}
