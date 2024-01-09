package photoz.models;

public class Dossier {
    private int id_dossier;
    private String pseudo;
    private String nom;

    public Dossier(String nom, String pseudo, int id_dossier) {
        this.id_dossier = id_dossier;
        this.pseudo = pseudo;
        this.nom = nom;
    }
}
