package photoz.models;

public class Utilisateur {
    private String pseudo;
    private String email;
    private String motdepasse;

    public Utilisateur(){};

    public Utilisateur(String pseudo, String motdepasse, String email) {
        this.pseudo = pseudo;
        this.email = email;
        this.motdepasse = motdepasse;
    }

    public String getEmail() {
        return email;
    }

    public String getMotdepasse() {
        return motdepasse;
    }

    public String getPseudo() {
        return pseudo;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setMotdepasse(String motdepasse) {
        this.motdepasse = motdepasse;
    }

    public void setPseudo(String pseudo) {
        this.pseudo = pseudo;
    }
}
