package photoz.models;

import java.sql.Date;

public class User {
    public String pseudo;
    public String email;
    public String password;


    public User(String pseudo, String email, String password) {
        this.pseudo = pseudo;
        this.email = email;
        this.password = password;
    }

}
