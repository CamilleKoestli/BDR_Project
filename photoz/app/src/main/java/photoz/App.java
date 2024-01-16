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
import io.javalin.http.Context;
import io.javalin.http.staticfiles.Location;
import io.javalin.rendering.template.JavalinJte;
import photoz.database.PostgresConnection;
import photoz.controllers.*;
import photoz.models.*;

public class App {
    static final int PORT = 7000;
    static Javalin app;

    public static Object testLoggedUtilisateur = null;

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
        app.post("/login_signin", connexionController::loginUser);


        //app.post("/login_signin", connexionController::createUser);
        /*app.get("/utilisateur/{pseudo}", photoCOntroller::homeUser);*/


        //Affichage photo
        PhotoController photoController = new PhotoController();
        // Page d'accueil
        app.get("/", photoController::home);

        //quand tu clique sur le pseudo
        app.get("/{pseudo}", ctx -> { } );
        //app.get("/utilisateur/{pseudo}", photoController::home);
        app.get("/photos/{id}", photoController::getPhotoDetails);

        // Gestion de l'exception, fait par Samuel Roland
        app.exception(Exception.class, (e, ctx) -> {
            String msg = "<div style='font-family: monospace; font-size: 1.5em;'><h1>Java exception</h1>";
            msg += "\n<h2>" + e.toString() + "</h2>\n";
            for (var element : e.getStackTrace()) {
                boolean bold = element.getClassName().startsWith("photoz");
                msg += "<br>" + (bold ? ("<strong>" + element + "</strong>") : element);
            }
            msg += "</div>";
            ctx.html(msg);
            ctx.status(500);
        });

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

    //TODO A CHANGER
    public static Object loggedUser(Context ctx) {
        if (testLoggedUtilisateur != null) {
            return testLoggedUtilisateur;
        }

        Object possibleUtilisateur = ctx.req().getSession().getAttribute("utilisateur");
        if (possibleUtilisateur == null)
            return 1;
        return (Utilisateur) possibleUtilisateur;
    }
}
