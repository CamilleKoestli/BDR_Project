package photoz.models;

import java.util.Date;

public class Photo {
    private int id_photo;
    private String titre;
    private Date datepubliee;
    private String legende;
    private String chemin;
    private boolean visible;
    private String artistePseudo;

    public Photo(int id_photo, String titre, Date datepubliee,String legende, String chemin, boolean visible, String artistePseudo) {
        this.id_photo = id_photo;
        this.titre = titre;
        this.datepubliee = datepubliee;
        this.legende = legende;
        this.chemin = chemin;
        this.visible = visible;
        this.artistePseudo = artistePseudo;
    }

    public Date getDatePubliee() {
        return datepubliee;
    }

    public int getId_photo() {
        return id_photo;
    }

    public String getTitre() {
        return titre;
    }

    public String getArtistePseudo() {
        return artistePseudo;
    }

    public String getChemin() {
        return chemin;
    }

    public String getLegende() {
        return legende;
    }

    public boolean getVisible(){
        return visible;
    }
    public void setDatePubliee(Date datepubliee) {
        this.datepubliee = datepubliee;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public void setDatepubliee(Date datepubliee) {
        this.datepubliee = datepubliee;
    }

    public void setLegende(String legende) {
        this.legende = legende;
    }

    public void setChemin(String chemin) {
        this.chemin = chemin;
    }

    public void setVisible(boolean visible) {
        this.visible = visible;
    }
}
