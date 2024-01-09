package photoz.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


*
 * Singleton class that provides a connection to the Postgres SQL database.
 *
 * @author Aubry Mangold <aubry.mangold@heig-vd.ch>
 * @author Eva Ray <eva.ray@heig-vd.ch>
 * @author Vitòria Cosmo De Oliviera <maria.cosmodeoliveira@heig-vd.ch>


public class PostgresConnection {
*
     * The connection to the database.


    private static final Connection connection;

*
     * The url to connect to the database.


    private static final String url = "jdbc:postgresql://postgresql:5432/bdr";

*
     * The username to connect to the database.


    private static final String username = "bdr";

*
     * The password to connect to the database.


    private static final String password = "bdr";

*
     * The instance of the PostgresConnection.


    private static PostgresConnection instance;

     * Static block to initialize the connection to the database.


    static {
        try {
            connection = DriverManager.getConnection(url, username, password);
            connection.setSchema("projet");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

*
     * Constructor.


    private PostgresConnection() {
    }

*
     * Get the instance of the PostgresConnection.
     *
     * @return The instance of the PostgresConnection.


    public static PostgresConnection getInstance() {
        if (instance == null) {
            instance = new PostgresConnection();
        } else {
            try {
                if (instance.getConnection().isClosed()) {
                    instance = new PostgresConnection();
                }
            } catch (SQLException e) {
                System.out.println("Database connection check failed : " + e.getMessage());
            }
        }
        return instance;
    }

*
     * Get the connection to the database.
     *
     * @return The connection to the database.


    public Connection getConnection() {
        return connection;
    }
}
