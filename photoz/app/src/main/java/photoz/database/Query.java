package photoz.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Date;

public class Query {

    public static ResultSet query(String sql) {
        try {
            Connection conn = PostgresConnection.getInstance().getConnection();
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            return preparedStatement.executeQuery();
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        }

    }

    public static ResultSet query(String sql, Object[] params) {
        try {
            Connection conn = PostgresConnection.getInstance().getConnection();
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            assignParams(preparedStatement, params);
            return preparedStatement.executeQuery();
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        }

    }


    public static int update(String sql, Object[] params) {
        try {
            return runUpdate(sql, params).executeUpdate();
        } catch (SQLException e) {
            return -1;
        }
    }

    public static int insert(String sql, Object[] params, String primaryKey) {
        try {
            var statement = runUpdate(sql, params);
            int nb = statement.executeUpdate();
            if (nb == 0)
                return -1;

            ResultSet set = statement.getGeneratedKeys();
            set.next();
            return set.getInt(primaryKey);
        } catch (SQLException e) {
            System.out.println(e);
            return -1;
        }
    }

    private static PreparedStatement runUpdate(String sql, Object[] params) throws SQLException {
        Connection conn = PostgresConnection.getInstance().getConnection();
        PreparedStatement preparedStatement = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        assignParams(preparedStatement, params);

        return preparedStatement;
    }
    private static void assignParams(PreparedStatement preparedStatement, Object[] params) throws SQLException {
        int cnt = 1;
        for (Object param : params) {
            if (param instanceof String p) {
                preparedStatement.setString(cnt++, p);
            }
            if (param instanceof Integer p) {
                preparedStatement.setInt(cnt++, p);
            }
            if (param instanceof Double p) {
                preparedStatement.setDouble(cnt++, p);
            }
            if (param instanceof Date p) {
                preparedStatement.setDate(cnt++, p);
            }
            if (param instanceof Boolean p) {
                preparedStatement.setBoolean(cnt++, p);
            }
        }
    }
}
