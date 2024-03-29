package photoz.controllers;

import io.javalin.http.Context;
import photoz.App;
import photoz.models.Badge;
import photoz.models.Photo;
import photoz.models.Utilisateur;

import java.util.ArrayList;
import java.util.Map;

public class ArtistesController {

    public void displayProfil(Context ctx) {
        Utilisateur artiste = Utilisateur.find(ctx.pathParam("pseudo"));

        ArrayList<Photo> photos = Photo.photoUserSeeArtiste(((Utilisateur) App.loggedUser(ctx)).pseudo, artiste.pseudo);

        ArrayList<Badge> badges = Badge.findBadgesForUser(artiste.pseudo);

        ctx.render("profile.jte", Map.of("loggedUtilisateur", App.loggedUser(ctx), "artiste", artiste, "photos", photos, "badges", badges));
    }

    public void displayMyProfil(Context ctx) {
        Utilisateur utilisateur = Utilisateur.find(ctx.pathParam("pseudo"));

        ArrayList<Photo> photos = Photo.myPhotos(((Utilisateur) App.loggedUser(ctx)).pseudo);

        ArrayList<Badge> badges = Badge.findBadgesForUser(((Utilisateur) App.loggedUser(ctx)).pseudo);

        ctx.render("myprofile.jte", Map.of("loggedUtilisateur", App.loggedUser(ctx), "photos", photos, "badges", badges));
    }
}
