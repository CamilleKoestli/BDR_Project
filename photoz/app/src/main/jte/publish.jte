@import photoz.models.Photo
@import photoz.models.Utilisateur


@param Photo photo
@param Utilisateur loggedUtilisateur = null
@param String error = null


@template.layout(
content = @`
    <h1>Poster photo</h1>
    <form action="/publish" method="post" enctype="multipart/form-data">
        <label>Titre</label>
        <input class="block mb-5" name="titre"/>
        <label>Legende</label>
        <textarea class="block mb-5" name="legende" placeholder="optionnel"></textarea>
        <label for="visible">Visible publiquement</label>
        <input class="mx-4" type="checkbox" name="visible" id="visible" checked/>
        <input class="block my-5" type="file" name="file" />
        <button class="block my-5" type="submit">Poster</button>
        @if (error != null)
            <p class="text-red-500">{{ error }}</p>

        @endif
    </form>
`,
loggedUtilisateur
)