package photoz.controllers;

import photoz.models.Photo;
import photoz.models.User;

import java.util.ArrayList;
import java.util.Map;

import io.javalin.http.Context;

public class PhotoController {
	public void home(Context ctx) {
		ArrayList<Photo> photos = new ArrayList<Photo>();
		ctx.render("photos.jte", Map.of("loggedUser",  new User("Jean", "Koestli"), "photos", photos));
	}


}
