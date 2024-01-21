package photoz.models;

import photoz.database.Query;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Badge {
    public int id_badge;
    public String nom;
    public String description;

    public Badge(String nom, String description, int id) {
        this.id_badge = id;
        this.nom = nom;
        this.description = description;
    }

    public Badge() {}

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

    private static ArrayList<Badge> readBadges(ResultSet set) {
        ArrayList<Badge> badges = new ArrayList<>();
        try {
            while (set.next()) {
                badges.add(mapSetEntryToTag(set));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return badges;
    }

    private static Badge mapSetEntryToTag(ResultSet set)  {
        Badge b = new Badge();

       try {
           b.id_badge = set.getInt("id_badge");
           b.nom = set.getString("nom");
           b.description = set.getString("description");

           return b;
       } catch (SQLException e) {
           System.out.println(e);
           return null;
       }
    }
}
