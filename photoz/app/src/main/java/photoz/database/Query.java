package photoz.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Query {

    public static ResultSet query(String sql) throws SQLException {
        Connection conn = PostgresConnection.getInstance().getConnection();
        PreparedStatement preparedStatement = conn.prepareStatement(sql);
        ResultSet resultSet = preparedStatement.executeQuery();

        return resultSet;
    }

    public static ResultSet query(String sql, Object[] params) throws SQLException {
        Connection conn = PostgresConnection.getInstance().getConnection();
        PreparedStatement preparedStatement = conn.prepareStatement(sql);

        for (Object param : params) {
            int cnt = 1;
            if (param instanceof String p) {
                preparedStatement.setString(cnt++, p);
            }
            if (param instanceof Integer p) {
                preparedStatement.setInt(cnt++, p);
            }
            if (param instanceof Double p) {
                preparedStatement.setDouble(cnt++, p);
            }
        }

        ResultSet resultSet = preparedStatement.executeQuery();

        return resultSet;
    }
}
