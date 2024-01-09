package photoz.models;

public class Utilisateur {
    public String pseudo;
    public String email;
    public String motdepasse;


    public Utilisateur(){}
    public Utilisateur(String pseudo, String motdepasse, String email) {
        this.pseudo = pseudo;
        this.email = email;
        this.motdepasse = motdepasse;
    }

    public void setPseudo(String pseudo) {
        this.pseudo = pseudo;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setMotdepasse(String motdepasse) {
        this.motdepasse = motdepasse;
    }
}
