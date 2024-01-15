package photoz.controllers;


import io.javalin.http.Context;

import photoz.database.PostgresConnection;
import photoz.models.Utilisateur;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.concurrent.ConcurrentHashMap;

public class ConnexionController {
    private ConcurrentHashMap<Integer, Utilisateur> utilisateurs = new ConcurrentHashMap<>();

    // Création d'un nouvel utilisateur
    public void createUser(Context ctx) {
        Utilisateur utilisateur = new Utilisateur();
        utilisateur.pseudo= ctx.formParam("pseudo");
        utilisateur.motdepasse = ctx.formParam("motdepasse");
        utilisateur.email = ctx.formParam( "email");

        String sql = "INSERT INTO Utilisateur (pseudo, motdepasse, email) VALUES (?, ?, ?)";

        try (Connection conn = PostgresConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, utilisateur.pseudo);
            pstmt.setString(2, utilisateur.motdepasse);
            pstmt.setString(3, utilisateur.email);
            pstmt.executeUpdate();
            ctx.status(201).result("Utilisateur créé");
        } catch (SQLException e) {
            ctx.status(500).result("Erreur serveur: " + e.getMessage());
        }
    }

    // Lecture des informations d'un utilisateur
    public void loginUser(Context ctx) {
        String pseudo = ctx.formParam("pseudo");
        String password = ctx.formParam("password");
        String sql = "SELECT * FROM Utilisateur WHERE pseudo = ?";

        try (Connection connection = PostgresConnection.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, pseudo);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String hashedPasswordFromDatabase = resultSet.getString("motdepasse");

                if (verifierMotDePasse(password, hashedPasswordFromDatabase)) {
                    Utilisateur utilisateur = new Utilisateur(
                            resultSet.getString("pseudo"),
                            resultSet.getString("email"),
                            resultSet.getString("motdepasse")
                    );
                    ctx.redirect("/utilisateur/" + utilisateur.pseudo);
                } else {
                    ctx.status(401).result("Mot de passe incorrect");
                }
            } else {
                ctx.status(404).result("Utilisateur non trouvé");
            }
        } catch (SQLException e) {
            ctx.status(500).result("Erreur serveur: " + e.getMessage());
        }
    }

    private boolean verifierMotDePasse(String motDePasseSoumis, String motDePasseBaseDeDonnées) {
        return motDePasseSoumis.equals(motDePasseBaseDeDonnées);
    }

}


