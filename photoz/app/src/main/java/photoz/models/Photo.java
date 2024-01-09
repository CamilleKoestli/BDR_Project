package photoz.models;

public class Photo {
    private int id;
    private String titre;
    private String legende;
    private String chemin;
    private boolean visible;
    private String artistePseudo;

    public Photo(int id, String titre, String legende, String chemin, boolean visible, String artistePseudo) {
        this.id = id;
        this.titre = titre;
        this.legende = legende;
        this.chemin = chemin;
        this.visible = visible;
        this.artistePseudo = artistePseudo;
    }
}
