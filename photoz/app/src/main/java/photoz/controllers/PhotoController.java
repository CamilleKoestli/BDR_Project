package photoz.controllers;

import photoz.App;
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

        photos.add(new Photo(1, "Chien", date, "Couché de soleil", "DSC_0001.jpg", true, "Jeanno"));
        photos.add(new Photo(2, "Chat", date, "Timelapse sur ville", "DSC_0002.jpg", true, "Jeanno"));

        ctx.render("photos.jte", Map.of("loggedUser", new Utilisateur("john_doe", "123", "john.doe@example.com"), "photos", photos));
    }

    //Page accueil
    public void homeUser(Context ctx) throws SQLException {
        Utilisateur utilisateur = ctx.sessionAttribute("utilisateur");
        if (utilisateur != null) {
            ArrayList<Photo> photos = Photo.photoUserCanSee();

            ctx.render("photos.jte", Map.of("loggedUtilisateur", App.loggedUser(ctx), "photos", photos));
        }
        else {
            ctx.redirect("/login_signin");
        }
    }

    public void getPhotoDetails(Context ctx) throws SQLException {
        int photoId = Integer.parseInt(ctx.pathParam("id"));

        Photo trouve = Photo.find(photoId);
        if (trouve != null) {
            ctx.render("photo-details.jte", Map.of("photo", trouve));
        } else {
            ctx.status(404).result("Photo non trouvée");
        }
    }
}