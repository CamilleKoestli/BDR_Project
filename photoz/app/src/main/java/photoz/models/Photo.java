package photoz.models;

public class Photo {
    private int id_photo;
    private String titre;
    private String datepubliee;
    private String legende;
    private String chemin;
    private boolean visible;
    private String artistePseudo;

    public Photo(int id_photo, String titre, String datepubliee,String legende, String chemin, boolean visible, String artistePseudo) {
        this.id_photo = id_photo;
        this.titre = titre;
        this.datepubliee = datepubliee;
        this.legende = legende;
        this.chemin = chemin;
        this.visible = visible;
        this.artistePseudo = artistePseudo;
    }
}
