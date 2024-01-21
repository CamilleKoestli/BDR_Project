@import photoz.models.Photo
@import photoz.models.Utilisateur


@param Photo photo
@param Utilisateur loggedUtilisateur = null

@template.layout(
content = @`
    <h1>${photo.titre}</h1>
    <div class="mr-6 my-1 w-200 ">
        <form action="/photo/${photo.id_photo}/edit">
            <!-- Condition pour afficher le bouton "Modifier" -->
            @if(loggedUtilisateur != null && photo.artistepseudo.equals(loggedUtilisateur.pseudo))
                <button type="submit" href="/photo/${photo.id_photo}/edit">Modifier</button>
            @endif
        </form>

        <!-- Condition pour afficher le bouton "Supprimer" -->
        <form action="/photo/${photo.id_photo}/delete" method="post">
            @if(loggedUtilisateur != null && photo.artistepseudo.equals(loggedUtilisateur.pseudo))
                <button type="submit" href="/photo/${photo.id_photo}/delete"> Supprimer</button>
            @endif
        </form>

        <img src="/images/${photo.chemin}" alt="" class="mx-2 my-1 w-full">
        <p class="font-bold line-clamp-1 mt-1 mb-2">${photo.titre}</p>
        <div class="flex text-gray-600">
            <a href="${photo.artistepseudo.equals(loggedUtilisateur.pseudo) ? "/myprofile/"+ loggedUtilisateur.pseudo: "/profile/" + photo.artistepseudo}"
               style="margin-right: 20px; flex-shrink: 0">
                <p class="font-bold">${photo.artistepseudo}</p>
            </a>
            <p class="mx-3">${photo.legende}</p>
        </div>
    </div>
`,
loggedUtilisateur
)