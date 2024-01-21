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

    public static ArrayList<Badge> findBadgesForUser(String pseudo){
        String sql = "SELECT b.id_badge, b.nom " +
                "FROM badge b " +
                "INNER JOIN badgeutilisateur bu ON b.id_badge = bu.id_badge " +
                "WHERE bu.pseudo = ?";

        ArrayList<Badge> badges = new ArrayList<>();

        try (ResultSet resultSet = Query.query(sql, new Object[]{pseudo})) {
            while (resultSet.next()) {
                Badge badge = new Badge();
                badge.nom = resultSet.getString("nom");
                badges.add(badge);
            }
        }
        catch (SQLException e){
            System.out.println(e);
        }

        return badges;
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
