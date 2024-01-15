/*
 * This Java source file was generated by the Gradle 'init' task.
 */
package photoz;

import java.nio.file.Path;
import java.sql.Connection;

import gg.jte.ContentType;
import gg.jte.TemplateEngine;
import gg.jte.resolve.DirectoryCodeResolver;
import io.javalin.Javalin;
import io.javalin.http.staticfiles.Location;
import io.javalin.rendering.template.JavalinJte;
import photoz.database.PostgresConnection;
import photoz.controllers.*;
import photoz.models.Utilisateur;

public class App {
    static final int PORT = 7000;
    static Javalin app;

    public static void main(String[] args) {
        System.out.println("photoz server has started...");
        initializeDatabase();
        app = setupApp().start(PORT);
    }

    private static void initializeDatabase() {
        try {
            Connection connection = PostgresConnection.getInstance().getConnection();
            if (connection != null) {
                System.out.println("Connexion à la base de données réussie.");
            }
        } catch (Exception e) {
            System.out.println("Erreur lors de la connexion à la base de données: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Separated method to easily test the server
    public static Javalin setupApp() {
        JavalinJte.init(createTemplateEngine());

        Javalin app = Javalin.create(config -> {
            config.staticFiles.add("src/main/static", Location.EXTERNAL);
        });

        // TODO: Defines routes

        //Connexion
        ConnexionController connexionController = new ConnexionController();
        // Afficher la page de connexion/inscription
        app.get("/login_signin", ctx -> ctx.render("connexion.jte"));

        // Gérer la soumission du formulaire de connexion
        app.post("/utilisateur/${loggedUtilisateur.pseudo}", connexionController::loginUser);

        app.post("/utilisateur", connexionController::createUser);
        app.get("/utilisateur/{pseudo}", connexionController::loginUser);


        //Affichage photo
        PhotoController photoController = new PhotoController();
        app.get("/", photoController::home);
        //app.get("/", photoController::homeUser);
        app.get("/photos/{id}", photoController::getPhotoDetails);

        return app;
    }

    // Configuration of JTE templates
    // Taken from the Javalin tutorials:
    // https://javalin.io/tutorials/jte#precompiling-templates
    private static TemplateEngine createTemplateEngine() {
        if (System.getenv("PHOTOZ_PRODUCTION") != null) {
            // Production mode, use precompiled classes loaded in the JAR
            return TemplateEngine.createPrecompiled(Path.of("jte-classes"), ContentType.Html);
        } else {
            // Dev mode, compile on the fly templates in the default folder src/main/jte
            DirectoryCodeResolver codeResolver = new DirectoryCodeResolver(Path.of("src", "main", "jte"));
            return TemplateEngine.create(codeResolver, ContentType.Html);
        }
    }
}
