@import photoz.models.Utilisateur
@param Utilisateur loggedUtilisateur = null


@template.layout(
content = @`
<!-- Section Connexion -->
<div class="login-section">
    <h1>Connexion</h1>
    <form action="/utilisateur/${loggedUtilisateur.pseudo}" method="post">
        <div class="form-group">
            <label for="login-pseudo">Pseudo</label>
            <input type="text" id="login-pseudo" name="pseudo" required>
        </div>
        <div class="form-group">
            <label for="login-password">Mot de passe</label>
            <input type="password" id="login-password" name="password" required>
        </div>
        <button type="submit">Se connecter</button>
    </form>
</div>

    <div class="signup-section">
        <h2>Inscription</h2>
        <form action="/login_signin" method="post">
            <div class="form-group">
                <label for="signup-pseudo">Pseudo</label>
                <input type="text" id="signup-pseudo" name="pseudo" required>
            </div>
            <div class="form-group">
                <label for="signup-email">Email</label>
                <input type="email" id="signup-email" name="email" required>
            </div>
            <div class="form-group">
                <label for="signup-password">Mot de passe</label>
                <input type="password" id="signup-password" name="password" required>
            </div>
            <button type="submit">S'inscrire</button>
        </form>
    </div>
`,
loggedUtilisateur
)