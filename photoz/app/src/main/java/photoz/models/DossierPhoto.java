package photoz.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DossierPhoto {
    public int id_dossier;
    public int id_photo;

    public DossierPhoto() {
    }
    public DossierPhoto(int id_dossier, int id_photo) {
        this.id_dossier = id_dossier;
        this.id_photo = id_photo;
    }

    private static ArrayList<DossierPhoto> readDossierPhoto(ResultSet set) {
        ArrayList<DossierPhoto> dossierPhotos = new ArrayList<>();
        try {
            while (set.next()) {
                dossierPhotos.add(mapSetEntryToTag(set));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return dossierPhotos;
    }

    private static DossierPhoto mapSetEntryToTag(ResultSet set)  {
        DossierPhoto d = new DossierPhoto();

        try {
            d.id_dossier = set.getInt("id_dossier");
            d.id_photo = set.getInt("id_photo");

            return d;
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        }
    }
}
