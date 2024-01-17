package photoz.models;

import photoz.database.Query;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;

public class Photo {
    public int id_photo;
    public String titre;
    public Date datepubliee;
    public String legende;
    public String chemin;
    public Boolean visible; //true si la photo est visible par tous, false si elle est privée
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
    static ArrayList<Photo> all() {
        ResultSet set = Query.query("SELECT * FROM photo");
        return readPhotos(set);
    }

    public ArrayList<Photo> photoPublic() {
        ResultSet set = Query.query("SELECT * FROM photo WHERE visible = true AND photo.pseudo = ?", new Object[] {artistepseudo});
        return readPhotos(set);
    }

    public static ArrayList<Photo> photoUserCanSee(String pseudo)  {
        ResultSet set = Query.query("SELECT * FROM view_photo_follow_subscription WHERE utilisateurpseudo = ?", new Object[] {pseudo});
        return readPhotosView(set);
    }

    public static Photo find(int id_photo) {
        ResultSet set = Query.query("SELECT * FROM photo WHERE id_photo = ?", new Object[] {id_photo});
        ArrayList<Photo> photos = readPhotos(set);
        if (!photos.isEmpty()){
            return photos.getFirst();
        }
        return null;
    }

    public int create() {
        return Query.insert("INSERT INTO photo (titre, datepubliee, legende, chemin, visible, pseudo) VALUES (?, ?, ?, ?, ?, ?)", new Object[] {titre, datepubliee, legende,chemin, visible, artistepseudo}, "id_photo");
    }

    public boolean delete() {
        return Query.update("DELETE FROM photo WHERE id_photo = ? AND pseudo = ? ", new Object[] {id_photo, artistepseudo}) == 1;
    }

    private static ArrayList<Photo> readPhotos(ResultSet set) {
        ArrayList<Photo> photos = new ArrayList<>();
        try {
            while (set.next()) {
                photos.add(mapSetEntryToPhoto(set));
            }
        }
        catch (SQLException e){
            System.out.println(e);
        }
        return photos;
    }
    private static ArrayList<Photo> readPhotosView(ResultSet set)  {
        ArrayList<Photo> photos = new ArrayList<>();
        try {
            while (set.next()) {
                photos.add(mapSetEntryToPhotoView(set));
            }
        }
        catch (SQLException e){
            System.out.println(e);
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
        p.artistepseudo = set.getString("pseudo");

        return p;
    }
    private static Photo mapSetEntryToPhotoView(ResultSet set) throws SQLException {
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
