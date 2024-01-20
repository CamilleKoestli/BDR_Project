@import photoz.models.Photo
@import photoz.models.Utilisateur

@param Utilisateur loggedUtilisateur = null
@param Photo photo
<%--@param String titre = null--%>
<%--@param String legende = null--%>
<%--@param Boolean visible = null--%>
@param String error = null

@template.layout(
content = @`
    <h1>Modifier photo</h1>
    <form action="/photo/${photo.id_photo}/edit" method="post">
        <input type="hidden" name="_method" value="PUT">
        <label>Titre</label>
        <input class="block mb-5" name="titre" value="${photo.titre}"/>
        <label>Légende</label>
        <textarea class="block mb-5" name="legende" placeholder="optionnel">${photo.legende}</textarea>
        <label for="visible">Visible publiquement</label>
        <input class="mx-4" type="checkbox" name="visible" id="visible" ${photo.visible != null && photo.visible ? 'checked' : ''}/>
        <button class="block my-5" type="submit">Modifier</button>
        @if (error != null)
            <p class="text-red-500">${error}</p>
        @endif
    </form>
`,
loggedUtilisateur