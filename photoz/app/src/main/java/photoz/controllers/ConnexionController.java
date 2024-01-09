package photoz.controllers;



import io.javalin.http.Context;

import photoz.database.PostgresConnection;
import photoz.models.Utilisateur;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import java.util.Date;

public class ConnexionController {

    // Création d'un nouvel utilisateur
    public void createUser(Context ctx) {
        Utilisateur user = ctx.bodyAsClass(Utilisateur.class);
        // Hasher le mot de passe ici avant de l'insérer
        String sql = "INSERT INTO Utilisateur (pseudo, motdepasse, email) VALUES (?, ?, ?)";

        try (Connection conn = PostgresConnection.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getPseudo());
            pstmt.setString(2, user.getMotdepasse());
            pstmt.setString(3, user.getEmail());
            pstmt.executeUpdate();
            ctx.status(201).result("Utilisateur créé");
        } catch (SQLException e) {
            ctx.status(500).result("Erreur serveur: " + e.getMessage());
        }
    }

    // Lecture des informations d'un utilisateur
    public void getUser(Context ctx) {
        String pseudo = ctx.pathParam("pseudo");
        String sql = "SELECT * FROM Utilisateur WHERE pseudo = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, pseudo);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Utilisateur user = new Utilisateur();
                user.setPseudo(rs.getString("pseudo"));
                user.setEmail(rs.getString("email"));
                // Ne pas renvoyer le mot de passe
                ctx.json(user);
            } else {
                ctx.status(404).result("Utilisateur non trouvé");
            }
        } catch (SQLException e) {
            ctx.status(500).result("Erreur serveur: " + e.getMessage());
        }
    }
}
