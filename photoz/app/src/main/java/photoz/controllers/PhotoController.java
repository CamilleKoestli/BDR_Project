package photoz.controllers;

import photoz.models.Photo;
import photoz.models.User;

import java.util.ArrayList;
import java.util.Map;

import io.javalin.http.Context;

public class PhotoController {
	public void home(Context ctx) {
		ArrayList<Photo> photos = new ArrayList<Photo>();

		photos.add(new Photo(1, "NewYork", "Jean", "new-york.jpg"));
		photos.add(new Photo(2, "TimeLapse", "Jean", "timelapse.jpg"));

		ctx.render("photos.jte", Map.of("loggedUser",  new User("Jean", "Koestli"), "photos", photos));
	}


}
