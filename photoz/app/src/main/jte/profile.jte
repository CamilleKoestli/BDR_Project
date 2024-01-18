@import photoz.models.Utilisateur
@import photoz.models.Badge
@import photoz.models.Photo
@import java.util.ArrayList


@param Photo photo
@param Utilisateur loggedUtilisateur = null
@param Badge badge
@param ArrayList<Photo> photos
@param ArrayList<Badge> badges

@template.layout(
content = @`
    <h1>${loggedUtilisateur.pseudo}</h1> <%--MAUVAIS PSEUDO photo.artistepseudo mais ne marche pas--%>
    <div class="flex">
        <div class="w-1/4">
            <h2>Badges</h2>
            <ul>
                @for (Badge badge : badges)
                    <li>${badge.nom}</li>
                @endfor
            </ul>
        </div>
        <div class="w-3/4">
            <h2>Photos</h2>
            <div class="flex flex-wrap">
                @for (Photo photo : photos)
                    @template.photo(photo)
                @endfor
            </div>
        </div>
    </div>
`,
    loggedUtilisateur
)