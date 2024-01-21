@import photoz.models.Commentaire
@import photoz.models.Utilisateur
@import photoz.models.Photo
@import java.util.ArrayList

@param Utilisateur loggedUtilisateur = null
@param ArrayList<Commentaire> commentaires
@param Photo photo

@template.layout(
content = @`
    <h1>Commentaires sur "${photo.titre}"</h1>
    <div class="comments-container">
        @for(Commentaire commentaire : commentaires)
            @template.comment(commentaire)
        @endfor
    </div>
    <!-- Zone pour ajouter un nouveau commentaire -->
    @if(loggedUtilisateur != null)
        <form action="/photo/${photo.id_photo}/comments" method="post">
            <textarea name="contenu" placeholder="Ajoutez un commentaire..." required></textarea>
            <button type="submit">Envoyer</button>
        </form>
    @endif
`,
loggedUtilisateur
)