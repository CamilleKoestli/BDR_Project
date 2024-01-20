package photoz.controllers;

import io.javalin.util.FileUtil;
import photoz.App;
import photoz.models.Photo;
import photoz.models.Utilisateur;

import java.util.ArrayList;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import io.javalin.http.Context;

import java.sql.SQLException;

public class PhotoController {

    //Page accueil
    public void homeUser(Context ctx) {
        ArrayList<Photo> photos = Photo.photoUserCanSee(((Utilisateur) App.loggedUser(ctx)).pseudo );

        ctx.render("photos.jte", Map.of("loggedUtilisateur", App.loggedUser(ctx), "photos", photos));
    }

    public void getPhotoDetails(Context ctx) {
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
        if (photo.id_photo == -1) {
            ctx.render("publish.jte", Map.of("loggedUtilisateur", App.loggedUser(ctx), "error", "Erreur lors de la création de la photo"));
            return;
        }
        var file = ctx.uploadedFile("file");
        photo.chemin = file.filename();
        FileUtil.streamToFile(file.content(), "src/main/static/images/" + photo.chemin);
        photo.id_photo = photo.create();
        ctx.redirect("/photos/" + photo.id_photo);
    }

    public void updatePhoto(Context ctx) {
        int photoId = Integer.parseInt(ctx.pathParam("id"));
        Photo trouve = Photo.find(photoId);

        System.out.println("id : " + photoId);
        if (trouve != null && trouve.artistepseudo.equals(((Utilisateur) App.loggedUser(ctx)).pseudo)) {
            // Remplir le modèle avec les valeurs actuelles de la photo existante
            Map<String, Object> model = new HashMap<>();
            model.put("loggedUtilisateur", App.loggedUser(ctx));
            /*model.put("titre", trouve.titre);
            model.put("legende", trouve.legende);
            model.put("visible", trouve.visible);*/
            model.put("photo", trouve);
            model.put("error", "Une erreur s'est produite lors de la modification de la photo.");

            ctx.render("edit.jte", model);

            /*// Maintenant, vous pouvez mettre à jour la photo si le formulaire est soumis
            if (ctx.formParam("submit") != null) {
                trouve.titre = ctx.formParam("titre");
                trouve.legende = ctx.formParam("legende");
                trouve.datepubliee = new Date(System.currentTimeMillis());
                trouve.visible = ctx.formParam("visible").equals("on");
                trouve.artistepseudo = ((Utilisateur) App.loggedUser(ctx)).pseudo;

                if (trouve.update()) {
                    ctx.redirect("/photos/" + trouve.id_photo);
                } else {
                    ctx.status(403).result("Vous n'avez pas le droit de modifier cette photo");
                }
            } else {
                ctx.status(404).result("Photo non trouvée");
            }*/
        }

    }


    public void modifyPhoto(Context ctx) {

        int photoId = Integer.parseInt(ctx.pathParam("id"));
        Photo trouve = Photo.find(photoId);

        System.out.println("id : " + photoId);
        if (trouve != null && trouve.artistepseudo.equals(((Utilisateur) App.loggedUser(ctx)).pseudo)) {
            // Maintenant, vous pouvez mettre à jour la photo si le formulaire est soumis
            if (ctx.formParam("submit") != null) {
                trouve.titre = ctx.formParam("titre");
                trouve.legende = ctx.formParam("legende");
                trouve.datepubliee = new Date(System.currentTimeMillis());
                trouve.visible = ctx.formParam("visible").equals("on");
                trouve.artistepseudo = ((Utilisateur) App.loggedUser(ctx)).pseudo;

                if (trouve.update()) {
                    ctx.redirect("/photos/" + trouve.id_photo);
                } else {
                    ctx.status(403).result("Vous n'avez pas le droit de modifier cette photo");
                }
            } else {
                ctx.status(404).result("Photo non trouvée");
            }
        }
    }



    public void deletePhoto(Context ctx) {
        int photoId = Integer.parseInt(ctx.pathParam("id_photo"));
        Photo trouve = Photo.find(photoId);
        if (trouve != null && trouve.artistepseudo.equals(((Utilisateur) App.loggedUser(ctx)).pseudo)) {
            if (trouve.delete()) {
                ctx.redirect("/");
            } else {
                ctx.status(403).result("Vous n'avez pas le droit de supprimer cette photo");
            }
        } else {
            ctx.status(404).result("Photo non trouvée");
        }
    }



}