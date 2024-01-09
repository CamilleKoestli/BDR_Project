@import photoz.models.User

@param User user

<div>
	@if(user != null)
	<div class="text-xl">${user.pseudo}</div>
	@else
	<button>Login</button>
	@endif
</div>