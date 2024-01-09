package photoz.models;

public class Commentaire {
    private int id_comm;

    private int id_photo;
    private String pseudo;
    private String texte;

    public Commentaire(int id_comm, String texte, String pseudo, int id_photo) {
        this.id_comm = id_comm;
        this.id_photo = id_photo;
        this.pseudo = pseudo;
        this.texte = texte;
    }
}
