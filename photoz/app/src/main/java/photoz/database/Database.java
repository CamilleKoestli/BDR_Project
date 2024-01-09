package photoz;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    private static Connection connection = null;

    public static Connection getConnection() {
        if (connection == null) {
            try {
                String url = System.getenv("DB_URL");
                String user = System.getenv("bdr");
                String password = System.getenv("bdr");

                connection = DriverManager.getConnection(url, user, password);
            } catch (SQLException e) {
                throw new RuntimeException("Erreur de connexion à la base de données", e);
            }
        }
        return connection;
    }
}