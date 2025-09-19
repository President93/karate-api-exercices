import com.intuit.karate.junit5.Karate;

public class FormationJoursTest {
   @Karate.Test
          // ===== 🟢 JOUR 1 - FONDAMENTAUX (7 heures) =====

    Karate jour1_matin_premiersPas() {
        // - Découvrir Karate
        return Karate.run("classpath:features/formation/jour1/01-premiers-pas.feature");
    }
    
    
    @Karate.Test
    Karate jour1_matin_assertionsTypes() {
        //  Types et assertions
        return Karate.run("classpath:features/formation/jour1/02-assertions-types.feature");
    }
    
    @Karate.Test
    Karate jour1_apresMidi_listesArrays() {
        //  Arrays et listes
        return Karate.run("classpath:features/formation/jour1/03-listes-et-arrays.feature");
    }

    // ===== 🟡 JOUR 2 - CRUD ET VARIABLES (7 heures) =====
    
    @Karate.Test
    Karate jour2_matin_introPost() {
                // 🎯  Introduction POST

        return Karate.run("classpath:features/formation/jour2/01-introduction-post.feature");
    }
    
    @Karate.Test
    Karate jour2_matin_putPatchDelete() {
        // 🎯  PUT, PATCH, DELETE
        return Karate.run("classpath:features/formation/jour2/02-put-patch-delete.feature");
    }
    
    @Karate.Test
    Karate jour2_apresMidi_variablesAvancees() {
        //- Variables et JavaScript
        return Karate.run("classpath:features/formation/jour2/03-variables-avancees.feature");
    }

       @Karate.Test
    Karate test() {
        //- Variables et JavaScript
        return Karate.run("classpath:features/formation/jour2/projet3-statistiques-blog.feature");
    }


    @Karate.Test
        Karate testToutSeulKarate() {
            //  Arrays et listes
            return Karate.run("classpath:features/formation/jour2/Exercice.feature");
        }
}