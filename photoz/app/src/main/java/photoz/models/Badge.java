package photoz.models;

public class Badge {
    private int id_badge;
    private String nom;
    private String description;

    public Badge(String nom, String description, int id) {
        this.id_badge = id;
        this.nom = nom;
        this.description = description;
    }
}
