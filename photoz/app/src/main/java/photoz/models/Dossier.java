package photoz.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Dossier {
    public int id_dossier;
    public String pseudo;
    public String nom;

    public Dossier() {
    }
    public Dossier(String nom, String pseudo, int id_dossier) {
        this.id_dossier = id_dossier;
        this.pseudo = pseudo;
        this.nom = nom;
    }

    private static ArrayList<Dossier> readDossier(ResultSet set) {
        ArrayList<Dossier> dossiers = new ArrayList<>();
        try {
            while (set.next()) {
                dossiers.add(mapSetEntryToTag(set));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return dossiers;
    }

    private static Dossier mapSetEntryToTag(ResultSet set)  {
        Dossier d = new Dossier();

        try {
            d.id_dossier = set.getInt("id_dossier");
            d.pseudo = set.getString("pseudo");
            d.nom = set.getString("nom");

            return d;
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        }
    }
}
