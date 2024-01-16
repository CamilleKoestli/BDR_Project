package photoz.controllers;


import io.javalin.http.Context;
import photoz.models.Utilisateur;
import java.sql.SQLException;
import java.util.Map;

public class ConnexionController {
    // Création d'un nouvel utilisateur
    public void createUser(Context ctx) throws SQLException {
        Utilisateur utilisateur = new Utilisateur();
        utilisateur.pseudo = ctx.formParam("pseudo");
        utilisateur.motdepasse = ctx.formParam("motdepasse");
        utilisateur.email = ctx.formParam("email");

        utilisateur.create();
        ctx.status(201).result("Utilisateur créé");

    }

    // Lecture des informations d'un utilisateur
    public void loginUser(Context ctx) throws SQLException {
        String pseudo = ctx.formParam("pseudo");
        String password = ctx.formParam("password");

        if (pseudo == null || password == null) {
            Utilisateur trouve = Utilisateur.find(pseudo);
            if (trouve != null && trouve.motdepasse.equals(password)) {
                ctx.sessionAttribute("utilisateur", trouve);
                ctx.redirect("/user" );
                return;
            }
            ctx.render("Connexion échouée");
        }
        ctx.render("connexion.jte", Map.of("error", "Pseudo ou mot de passe incorrect"));
    }
}


