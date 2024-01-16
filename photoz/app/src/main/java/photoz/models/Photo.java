package photoz.models;

import photoz.database.Query;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class Photo {
    public int id_photo;
    public String titre;
    public Date datepubliee;
    public String legende;
    public String chemin;
    public boolean visible; //true si la photo est visible par tous, false si elle est privée
    public String artistepseudo;

    public Photo(){};
    public Photo(int id_photo, String titre, Date datepubliee,String legende, String chemin, boolean visible, String artistePseudo) {
        this.id_photo = id_photo;
        this.titre = titre;
        this.datepubliee = datepubliee;
        this.legende = legende;
        this.chemin = chemin;
        this.visible = visible;
        this.artistepseudo = artistePseudo;
    }
    static ArrayList<Photo> all() throws SQLException {
        ResultSet set = Query.query("SELECT * FROM photo");
        return readPhotos(set);
    }

    static ArrayList<Photo> photoPublic() throws SQLException {
        ResultSet set = Query.query("SELECT * FROM photo WHERE visible = true AND photo.pseudo = ?", new Object[] {artistepseudo});
        return readPhotos(set);
    }

    public static ArrayList<Photo> photoUserCanSee() throws SQLException {
        ResultSet set = Query.query("SELECT * FROM view_photo_follow_subscription WHERE visible = true");
        return readPhotos(set);
    }

    public static Photo find(int id_photo) throws SQLException {
        ResultSet set = Query.query("SELECT * FROM photo WHERE id_photo = ?", new Object[] {id_photo});
        ArrayList<Photo> photos = readPhotos(set);
        if (!photos.isEmpty()){
            return photos.getFirst();
        }
        return null;
    }

    public boolean create() throws SQLException {
        return Query.update("INSERT INTO photo (titre, datepubliee, legende, chemin, pseudo) VALUES (?, ?, ?, ?, ?)", new Object[] {titre, datepubliee, legende,chemin, artistepseudo}) == 1;
    }

    public boolean delete() throws SQLException {
        return Query.update("DELETE FROM photo WHERE id_photo = ? AND pseudo = ? ", new Object[] {id_photo, artistepseudo}) == 1;
    }

    private static ArrayList<Photo> readPhotos(ResultSet set) throws SQLException {
        ArrayList<Photo> photos = null;
        while(set.next()) {
            photos.add(mapSetEntryToPhoto(set));
        }
        return photos;
    }

    private static Photo mapSetEntryToPhoto(ResultSet set) throws SQLException {
        Photo p = new Photo();

        p.id_photo = set.getInt("id_photo");
        p.titre = set.getString("titre");
        p.datepubliee = set.getDate("datepubliee");
        p.legende = set.getString("legende");
        p.chemin = set.getString("chemin");
        p.visible = set.getBoolean("visible");
        p.artistepseudo = set.getString("artistepseudo");

        return p;
    }
}
