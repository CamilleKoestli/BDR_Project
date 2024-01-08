@import photoz.models.User

@param User user

<div>
	@if(user != null)
	<div class="text-xl">${user.firstname} ${user.lastname}</div>
	@else
	<button>Login</button>
	@endif
</div>