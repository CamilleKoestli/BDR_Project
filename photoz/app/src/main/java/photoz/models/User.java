package photoz.models;

import java.sql.Date;

public class User {
    public String firstname;
    public String lastname;
    public String email;
    public String password;
    public Date registration_date;

    public User(String firstname, String lastname) {
        this.firstname = firstname;
        this.lastname = lastname;
    }

}
