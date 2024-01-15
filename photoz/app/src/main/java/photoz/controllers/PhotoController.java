package photoz.controllers;

import photoz.models.Photo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Map;

import io.javalin.http.Context;

import photoz.database.PostgresConnection;
import photoz.models.Utilisateur;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import java.util.Date;


public class PhotoController {


	public void home(Context ctx) throws ParseException {
		ArrayList<Photo> photos = new ArrayList<Photo>();

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date date = formatter.parse("2024-01-10");

		photos.add(new Photo(1, "Chien", date,"Couché de soleil", "DSC_0001.jpg", true, "Jeanno"));
		photos.add(new Photo(2, "Chat", date, "Timelapse sur ville", "DSC_0002.jpg", true, "Jeanno"));

		ctx.render("photos.jte", Map.of("loggedUser",  new Utilisateur("john_doe", "motdepasse1", "john.doe@example.com"), "photos", photos));
	}

	//Page accueil
	public void homeUser(Context ctx) {
		String pseudo = ctx.sessionAttribute("pseudo"); // Récupère le pseudo de l'utilisateur connecté
		List<Photo> photos = new ArrayList<>();
		String sql = "SELECT * FROM view_photo_follow_subscription WHERE utilisateur_pseudo = ?";

		try (Connection conn = PostgresConnection.getInstance().getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, pseudo);

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					Photo photo = new Photo(rs.getInt("id_photo"), rs.getString("titre"), rs.getDate("datepubliee"),rs.getString("legende"), rs.getString("chemin"), rs.getBoolean("visible"), rs.getString("artiste_pseudo"));
					photos.add(photo);
				}
			}
		} catch (SQLException e) {
			System.out.println("Erreur de base de données: " + e.getMessage());
			e.printStackTrace();
		}

		// Ici, vous devez récupérer la liste des utilisateurs de votre base de données
		// Pour l'exemple, je vais utiliser une liste vide
		List<Object> utilisateurList = new ArrayList<>(); // Remplacez ceci par la récupération réelle des utilisateurs

		ctx.render("photos.jte", Map.of("loggedUser", utilisateurList, "photos", photos));
	}

	public void getPhotoDetails(Context ctx) {
		int photoId = Integer.parseInt(ctx.pathParam("id")); // Récupère l'ID de la photo depuis l'URL
		String sql = "SELECT * FROM Photo WHERE id_photo = ?"; // Assurez-vous que cette requête est correcte

		try (Connection conn = PostgresConnection.getInstance().getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, photoId);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					Photo photo = new Photo(rs.getInt("id_photo"), rs.getString("titre"), rs.getDate("datepubliee"), rs.getString("legende"), rs.getString("chemin"), rs.getBoolean("visible"), rs.getString("artiste_pseudo"));
					ctx.render("photo-details.jte", Map.of("photo", photo));
				} else {
					ctx.status(404).result("Photo non trouvée");
				}
			}
		} catch (SQLException e) {
			System.out.println("Erreur de base de données: " + e.getMessage());
			e.printStackTrace();
			ctx.status(500).result("Erreur interne du serveur");
		}
	}
}