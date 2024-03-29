package photoz.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import photoz.database.Query;

public class Utilisateur {
    public String pseudo;
    public String email;
    public String motdepasse;


    public Utilisateur() {
    }

    public Utilisateur(String pseudo, String motdepasse, String email) {
        this.pseudo = pseudo;
        this.email = email;
        this.motdepasse = motdepasse;
    }

    public void setPseudo(String pseudo) {
        this.pseudo = pseudo;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setMotdepasse(String motdepasse) {
        this.motdepasse = motdepasse;
    }

    static ArrayList<Utilisateur> all() {
        ResultSet set = Query.query("SELECT * FROM utilisateur");
        return readUtilisateurs(set);
    }

    public static Utilisateur find(String pseudo) {
        ResultSet set = Query.query("SELECT * FROM utilisateur WHERE pseudo = ?", new Object[]{pseudo});
        ArrayList<Utilisateur> utilisateurs = readUtilisateurs(set);
        if (!utilisateurs.isEmpty()) {
            return utilisateurs.getFirst();
        }
        return null;
    }

    public boolean create() {
        return Query.update("INSERT INTO utilisateur (pseudo, motdepasse, email) VALUES (?, ?, ?)", new Object[]{pseudo, motdepasse, email}) == 1;
    }

    private static ArrayList<Utilisateur> readUtilisateurs(ResultSet set) {
        ArrayList<Utilisateur> utilisateurs = new ArrayList<>();
        try {
            while (set.next()) {
                utilisateurs.add(mapSetEntryToUser(set));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return utilisateurs;
    }

    private static Utilisateur mapSetEntryToUser(ResultSet set) {
        Utilisateur u = new Utilisateur();
        try {
            u.pseudo = set.getString("pseudo");
            u.email = set.getString("email");
            u.motdepasse = set.getString("motdepasse");
            return u;
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        }
    }
}