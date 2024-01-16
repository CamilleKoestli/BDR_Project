package photoz.controllers;

import photoz.App;
import photoz.models.Photo;

import java.util.ArrayList;
import java.util.Map;

import io.javalin.http.Context;
import photoz.models.Utilisateur;

import java.sql.SQLException;

public class PhotoController {

    //Page accueil
    public void homeUser(Context ctx) throws SQLException {
        ArrayList<Photo> photos = Photo.photoUserCanSee(((Utilisateur) App.loggedUser(ctx)).pseudo);

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