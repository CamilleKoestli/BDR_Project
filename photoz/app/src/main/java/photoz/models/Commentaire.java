package photoz.models;

import photoz.database.Query;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Commentaire {
    public int id_comm;
    public int id_photo;
    public String pseudo;
    public String texte;

    public Commentaire() {
    }

    public Commentaire(int id_comm, String texte, String pseudo, int id_photo) {
        this.id_comm = id_comm;
        this.id_photo = id_photo;
        this.pseudo = pseudo;
        this.texte = texte;
    }

    public static ArrayList<Commentaire> getCommentPhoto(int id_photo) {
        ResultSet set = Query.query("SELECT * FROM commentaire WHERE id_photo = ?", new Object[]{id_photo});
        return readCommentaire(set);
    }

    private static ArrayList<Commentaire> readCommentaire(ResultSet set) {
        ArrayList<Commentaire> commentaires = new ArrayList<>();
        try {
            while (set.next()) {
                commentaires.add(mapSetEntryToComment(set));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return commentaires;
    }

    private static Commentaire mapSetEntryToComment(ResultSet set) {
        Commentaire c = new Commentaire();
        try {
            c.id_comm = set.getInt("id_comm");
            c.id_photo = set.getInt("id_photo");
            c.pseudo = set.getString("pseudo");
            c.texte = set.getString("texte");
            return c;
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        }
    }
}
