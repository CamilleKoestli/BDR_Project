package photoz.controllers;

import io.javalin.util.FileUtil;
import photoz.App;
import photoz.models.Photo;

import java.util.ArrayList;
import java.util.Date;
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
            ctx.render("photo-details.jte", Map.of("photo", trouve, "loggedUtilisateur", App.loggedUser(ctx)));
        } else {
            ctx.status(404).result("Photo non trouvée");
        }
    }

    public void publishPhoto(Context ctx) {
        ctx.render("publish.jte", Map.of("loggedUtilisateur", App.loggedUser(ctx)));
    }

    public void storePhoto(Context ctx) {
        if (ctx.uploadedFile("file") == null) {
            ctx.render("publish.jte", Map.of("loggedUtilisateur", App.loggedUser(ctx), "error", "Vous devez choisir un fichier"));
            return;
        }
        Photo photo = new Photo();
        photo.titre = ctx.formParam("titre");
        photo.legende = ctx.formParam("legende");
        photo.datepubliee = new Date(System.currentTimeMillis());
        photo.visible = ctx.formParam("visible").equals("on");
        photo.artistepseudo = ((Utilisateur) App.loggedUser(ctx)).pseudo;
        photo.id_photo = photo.create();
        if (photo.id_photo == -1) {
            ctx.render("publish.jte", Map.of("loggedUtilisateur", App.loggedUser(ctx), "error", "Erreur lors de la création de la photo"));
            return;
        }
        var file = ctx.uploadedFile("file");
        photo.chemin = file.filename();
        FileUtil.streamToFile(file.content(), "src/main/static/images/" + photo.chemin);
        ctx.redirect("/photos/" + photo.id_photo);
    }

}