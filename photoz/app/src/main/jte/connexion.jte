@import photoz.models.Utilisateur
@param Utilisateur loggedUtilisateur = null
@param String error = null


@template.layout(
content = @`
<!-- Section Connexion -->
<div class="login-section">
    <h1>Connexion</h1>
    <form action="/login_signin" method="post">
        <div class="form-group">
            <label for="login-pseudo">Pseudo</label>
            <input class="block mb-2" type="text" id="login-pseudo" name="pseudo" required>
        </div>
        <div class="form-group">
            <label for="login-password">Mot de passe</label>
            <input class="block mb-2" type="password" id="login-password" name="password" required>
        </div>
        <button class="block mb-10 " type="submit">Se connecter</button>
        @if(error != null)
            <p class="error">${error}</p>
        @endif
    </form>
</div>

    <div class="signup-section">
        <h2>Inscription</h2>
        <form action="/login_signin" method="post">
            <div class="form-group">
                <label for="signup-pseudo">Pseudo</label>
                <input class="block mb-2" type="text" id="signup-pseudo" name="pseudo" required>
            </div>
            <div class="form-group">
                <label for="signup-email">Email</label>
                <input class="block mb-2" type="email" id="signup-email" name="email" required>
            </div>
            <div class="form-group">
                <label for="signup-password">Mot de passe</label>
                <input class="block mb-2" type="password" id="signup-password" name="password" required>
            </div>
            <button class="block mb-2" type="submit">S'inscrire</button>
        </form>

        <img src="/logo_photoz.png" width="200" height="auto">
    </div>
`,
loggedUtilisateur
)