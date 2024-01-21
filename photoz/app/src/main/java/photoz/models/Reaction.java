package photoz.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Reaction {
    private int id_photo;
    private String pseudo;
    private boolean plus_moins; //plus true     moins false

    public Reaction(){}

    public Reaction(boolean plus_moins, int id_photo, String pseudo) {
        this.id_photo = id_photo;
        this.pseudo = pseudo;
        this.plus_moins = plus_moins;
    }

    private static ArrayList<Reaction> readReaction(ResultSet set) {
        ArrayList<Reaction> reactions = new ArrayList<>();
        try {
            while (set.next()) {
                reactions.add(mapSetEntryToReaction(set));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return reactions;
    }

    private static Reaction mapSetEntryToReaction(ResultSet set) {
        Reaction r = new Reaction();

        try {
            r.id_photo = set.getInt("id_photo");
            r.pseudo = set.getString("pseudo");
            r.plus_moins = set.getBoolean("plus_moins");

            return r;
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        }
    }
}
