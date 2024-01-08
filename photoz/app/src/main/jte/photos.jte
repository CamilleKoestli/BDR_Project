@import photoz.models.Photo
@import photoz.models.User
@import java.util.ArrayList

@param User loggedUser = null
@param ArrayList<Photo> photos

	@template.layout(
	content = @`
	<h1>Fil d'actualité</h1>
	<div class="flex flex-wrap">
		@for(Photo photo : photos)
		@template.photo(photo)
		@endfor
	</div>
	`,
	loggedUser
	)