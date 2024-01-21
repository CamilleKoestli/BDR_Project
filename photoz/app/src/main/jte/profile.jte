@import photoz.models.Utilisateur
@import photoz.models.Badge
@import photoz.models.Photo
@import java.util.ArrayList


@param Utilisateur loggedUtilisateur = null
@param Utilisateur artiste = null
@param ArrayList<Photo> photos
@param ArrayList<Badge> badges

@template.layout(
content = @`
    <h1>Profil de ${artiste.pseudo}</h1>
        <div class="flex">
            <div class="w-1/4">
                <h2>Badges</h2>
                <ul>
                    @for (Badge badge : badges)
                    <li>
                        @if(badge.nom.equals("1photo"))
                            <img src="/firstpost.png"  width="75" height="auto" alt="${badge.nom}" title="${badge.nom}" class="badge-image">
                        @endif

                        @if(badge.nom.equals("100photos"))
                            <img src="/100photos.png"  width="75" height="auto" alt="${badge.nom}" title="${badge.nom}" class="badge-image">
                        @endif

                        @if(badge.nom.equals("100reactions"))
                            <img src="/100reactions.png"  width="75" height="auto" alt="${badge.nom}" title="${badge.nom}" class="badge-image">
                        @endif
                    </li>
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