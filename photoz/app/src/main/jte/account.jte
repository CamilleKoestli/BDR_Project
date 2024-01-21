@import photoz.models.Utilisateur

@param Utilisateur utilisateur

<div>
	@if(utilisateur != null)
		<a href="/publish"><button>Poster photo</button></a>
		<a href="/logout"><button>Déconnexion</button></a>
	<a href="/myprofile/${utilisateur.pseudo}"><div class="text-xl">${utilisateur.pseudo}</div></a>
	@else
		<a href="/login_signin"><button>Connexion/Inscription</button></a>
	@endif
</div>