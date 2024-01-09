package photoz.models;

public class Reaction {
    private int id_photo;
    private String pseudo;
    private boolean plus_moins; //plus true     moins false

    public Reaction(boolean plus_moins, int id_photo, String pseudo) {
        this.id_photo = id_photo;
        this.pseudo = pseudo;
        this.plus_moins = plus_moins;
    }
}
