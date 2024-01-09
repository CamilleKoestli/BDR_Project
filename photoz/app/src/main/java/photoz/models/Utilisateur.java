package photoz.models;

public class Utilisateur {
    public String pseudo;
    public String email;
    public String motdepasse;


    public Utilisateur(String pseudo, String motdepasse, String email) {
        this.pseudo = pseudo;
        this.email = email;
        this.motdepasse = motdepasse;
    }

}
