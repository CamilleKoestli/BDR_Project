@import photoz.models.Photo
@import photoz.models.Utilisateur


@param Photo photo
@param Utilisateur loggedUtilisateur = null

@template.layout(
content = @`
    <h1>${photo.titre}</h1>
    <a href="/photos/${photo.id_photo}">
        <div class="mx-2 my-1 w-200 ">
            <img src="/images/${photo.chemin}" alt="" class="w-full">
            <p class="font-bold line-clamp-1 mt-1 mb-2">${photo.titre}</p>
            <div class="flex text-gray-600">
                <p class="font-bold flex-1">${photo.artistepseudo}</p>
                <p class="flex-1">${photo.legende}</p>
            </div>
        </div>
    </a>
`,
loggedUtilisateur
)