package photoz.models;

import java.util.Date;

public class Photo {
    public int id_photo;
    public String titre;
    public Date datepubliee;
    public String legende;
    public String chemin;
    public boolean visible;
    public String artistePseudo;

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

    public void setDatePubliee(Date datepubliee) {
        this.datepubliee = datepubliee;
    }
}
