package photoz.models;

import photoz.database.Query;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Tag {
    public String mot;

    public Tag() {
    }

    public Tag(String mot) {
        this.mot = mot;
    }

    public int create() {
        return Query.insert("INSERT INTO tag (mot) VALUES (mot)", new Object[]{mot}, "mot");
    }


    public static Tag find(int mot) {
        ResultSet set = Query.query("SELECT * FROM tag", new Object[]{mot});
        ArrayList<Tag> Tags = readTags(set);
        if (!Tags.isEmpty()) {
            return Tags.getFirst();
        }
        return null;
    }

    private static ArrayList<Tag> readTags(ResultSet set) {
        ArrayList<Tag> Tags = new ArrayList<>();
        try {
            while (set.next()) {
                Tags.add(mapSetEntryToTag(set));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return Tags;
    }

    private static Tag mapSetEntryToTag(ResultSet set) throws SQLException {
        Tag p = new Tag();

        p.mot = set.getString("mot");

        return p;
    }
}
