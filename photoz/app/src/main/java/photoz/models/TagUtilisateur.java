package photoz.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TagUtilisateur {

    String pseudo;
    String mot;
    public TagUtilisateur(){}
    public TagUtilisateur(String pseudo, String mot){
        this.mot = mot;
        this.pseudo = pseudo;
    }

    private static ArrayList<TagUtilisateur> readTagUtilisateur(ResultSet set) {
        ArrayList<TagUtilisateur> tagUtilisateurs = new ArrayList<>();
        try {
            while (set.next()) {
                tagUtilisateurs.add(mapSetEntryToTagUtilisateur(set));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return tagUtilisateurs;
    }

    private static TagUtilisateur mapSetEntryToTagUtilisateur(ResultSet set) {
        TagUtilisateur t = new TagUtilisateur();

        try {
            t.mot = set.getString("mot");
            t.pseudo = set.getString("pseudo");

            return t;
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        }
    }
}
