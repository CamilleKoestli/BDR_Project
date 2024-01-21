package photoz.models;

import photoz.database.Query;

import java.sql.ResultSet;

import java.sql.SQLException;
import java.util.ArrayList;

public class Statut {
    public String pseudo;
    public String pseudoart;
    public boolean typedemande;
    public boolean accepte_refus;

    public Statut() {
    }
    public Statut(boolean typedemande, boolean accepte_refus, String pseudoart, String pseudo) {
        this.pseudo = pseudo;
        this.pseudoart = pseudoart;
        this.typedemande = accepte_refus;
        this.accepte_refus = accepte_refus;
    }

    private static ArrayList<Statut> readStatut(ResultSet set) {
        ArrayList<Statut> statuts = new ArrayList<>();
        try {
            while (set.next()) {
                statuts.add(mapResultSetToStatut(set));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return statuts;
    }

    public static Statut mapResultSetToStatut(ResultSet set) {
        Statut s = new Statut();
        try {
            s.pseudo = set.getString("pseudo");
            s.pseudoart = set.getString("pseudoart");
            s.typedemande = set.getBoolean("typedemande");
            s.accepte_refus = set.getBoolean("accepte_refus");

            return s;
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        }
    }
}
