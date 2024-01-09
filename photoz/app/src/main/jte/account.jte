@import photoz.models.Utilisateur

@param Utilisateur utilisateur

<div>
	@if(utilisateur != null)
	<div class="text-xl">${utilisateur.pseudo}</div>
	@else
	<button>Connexion/Inscription</button>
	@endif
</div>