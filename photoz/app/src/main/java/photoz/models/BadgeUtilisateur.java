package photoz.models;

import photoz.database.Query;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BadgeUtilisateur {

    public int id_badge;
    public String pseudo;

    public BadgeUtilisateur() {
    }
    public BadgeUtilisateur(int id_badge, String pseudo){
        this.id_badge = id_badge;
        this.pseudo = pseudo;
    }

    public static ArrayList<BadgeUtilisateur> listBadgesUtilisateur(String pseudo){
        ResultSet set = Query.query("SELECT * FROM badgeutilisateur WHERE pseudo = ?", new Object[]{pseudo});
        return readBadgesUtilisateur(set);
    }


    private static ArrayList<BadgeUtilisateur> readBadgesUtilisateur(ResultSet set) {
        ArrayList<BadgeUtilisateur> badgesUtilisateur = new ArrayList<>();
        try {
            while (set.next()) {
                badgesUtilisateur.add(mapSetEntryToTag(set));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return badgesUtilisateur;
    }

    private static BadgeUtilisateur mapSetEntryToTag(ResultSet set)  {
        BadgeUtilisateur b = new BadgeUtilisateur();

        try {
            b.id_badge = set.getInt("id_badge");
            b.pseudo = set.getString("pseudo");

            return b;
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        }
    }
}
