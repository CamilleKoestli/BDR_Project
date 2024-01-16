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

    //Page accueil
    public void homeUser(Context ctx) throws SQLException {
        ArrayList<Photo> photos = Photo.photoUserCanSee();
        ctx.render("photos.jte", Map.of("loggedUtilisateur", App.loggedUser(ctx), "photos", photos));
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