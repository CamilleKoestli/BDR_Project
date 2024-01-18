package photoz.models;

import photoz.database.Query;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Badge {
    private int id_badge;
    private String nom;
    private String description;

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
                badge.id_badge = resultSet.getInt("id_badge");
                badge.nom = resultSet.getString("nom");
                badges.add(badge);
            }
        }
        catch (SQLException e){
            System.out.println(e);
        }

        return badges;
    }
}
