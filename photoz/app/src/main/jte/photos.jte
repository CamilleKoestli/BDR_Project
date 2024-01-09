@import photoz.models.Photo
@import photoz.models.Utilisateur
@import java.util.ArrayList

@param Utilisateur loggedUtilisateur = null
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
	loggedUtilisateur
	)