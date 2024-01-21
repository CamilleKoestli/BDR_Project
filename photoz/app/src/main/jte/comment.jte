@import photoz.models.Commentaire

@param Commentaire commentaire

<div class="comment mx-2 my-1 p-1 hover:bg-blue-100">
    <p class="comment-author font-bold">${commentaire.pseudo}</p>
    <p class="comment-content">${commentaire.texte}</p>
</div>