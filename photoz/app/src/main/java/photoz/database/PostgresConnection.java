package photoz.database;

import java.sql.*;

public class PostgresConnection {

    private static final Connection connection;
    private static final String url = "jdbc:postgresql://localhost:5432/?options=-c%20search_path=project_schema%20";
    private static final String username = "bdr";
    private static final String password = "bdr";
    private static PostgresConnection instance;

    static {
        try {
            connection = DriverManager.getConnection(url, username, password);
            connection.setSchema("project_schema");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private PostgresConnection() {
    }


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

    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }
}
