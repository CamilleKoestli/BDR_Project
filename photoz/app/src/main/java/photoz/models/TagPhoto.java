package photoz.models;

import photoz.database.Query;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TagPhoto {

    public String mot;

    public int id_photo;

    public TagPhoto() {
    }

    public TagPhoto(String mot, int id_photo) {
        this.mot = mot;
        this.id_photo = id_photo;

    }


    public static TagPhoto find(int id_photo) {
        ResultSet set = Query.query("SELECT * FROM tagphoto WHERE id_photo = ?", new Object[]{id_photo});
        ArrayList<TagPhoto> Tags = readTagsPhoto(set);
        if (!Tags.isEmpty()) {
            return Tags.getFirst();
        }
        return null;
    }

    public int create() {
        return Query.insert("INSERT INTO tagphoto (mot, id_photo) VALUES (?, ?);", new Object[]{mot, id_photo}, "id_photo");
    }

    public boolean update() {
        return Query.update("UPDATE tagphoto SET mot = ? WHERE id_photo = ? AND mot = ?", new Object[]{id_photo, mot}) == 1;
    }

    public boolean delete() {
        return Query.update("DELETE FROM tagphoto WHERE id_photo = ? AND mot = ?", new Object[]{id_photo, mot}) == 1;
    }

    private static ArrayList<TagPhoto> readTagsPhoto(ResultSet set) {
        ArrayList<TagPhoto> Tags = new ArrayList<>();
        try {
            while (set.next()) {
                Tags.add(mapSetEntryToTagPhoto(set));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return Tags;
    }

    private static TagPhoto mapSetEntryToTagPhoto(ResultSet set) {
        TagPhoto p = new TagPhoto();

        try {
            p.mot = set.getString("mot");
            p.id_photo = set.getInt("id_photo");

            return p;
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        }
    }
}
