package photoz.controllers;

import photoz.models.Photo;
import photoz.models.User;

import java.util.ArrayList;
import java.util.Map;

import io.javalin.http.Context;

import photoz.database.PostgresConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import photoz.models.Photo;



public class PhotoController {


	public void home(Context ctx) {
		ArrayList<Photo> photos = new ArrayList<Photo>();

		/*photos.add(new Photo(1, "NewYork", "Jean", "new-york.jpg"));
		photos.add(new Photo(2, "TimeLapse", "Jean", "timelapse.jpg"));

		ctx.render("photos.jte", Map.of("loggedUser",  new User("Jeanno", "Jeanno@gmail.com", "1234"), "photos", photos));*/
	}

	public void homeUser(Context ctx) {
		String pseudo = ctx.sessionAttribute("pseudo"); // Récupère le pseudo de l'utilisateur connecté
		List<Photo> photos = new ArrayList<>();
		String sql = "SELECT * FROM view_photo_follow_subscription WHERE utilisateur_pseudo = ?";

		try (Connection conn = PostgresConnection.getInstance().getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, pseudo);

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					Photo photo = new Photo(rs.getInt("id_photo"), rs.getString("titre"), rs.getString("legende"), rs.getString("chemin"), rs.getBoolean("visible"), rs.getString("artiste_pseudo"));
					photos.add(photo);
				}
			}
		} catch (SQLException e) {
			System.out.println("Erreur de base de données: " + e.getMessage());
			e.printStackTrace();
		}

		// Ici, vous devez récupérer la liste des utilisateurs de votre base de données
		// Pour l'exemple, je vais utiliser une liste vide
		List<Object> userList = new ArrayList<>(); // Remplacez ceci par la récupération réelle des utilisateurs

		ctx.render("photos.jte", Map.of("loggedUser", userList, "photos", photos));
	}
}