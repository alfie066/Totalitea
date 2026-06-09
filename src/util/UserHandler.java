package util;

import java.sql.*;

public class UserHandler {

    public static boolean loginUser(String email, String password) throws SQLException {

        Connection conn = DbConnector.getConnection();

        String query = "SELECT * FROM user WHERE email=? AND password=?";
        PreparedStatement ps = conn.prepareStatement(query);

        ps.setString(1, email);
        ps.setString(2, password);

        ResultSet rs = ps.executeQuery();

        return rs.next();
    }


    public static boolean registerUser(String email, String password) throws SQLException {

        Connection conn = DbConnector.getConnection();

        String query = "INSERT INTO user (email, password) VALUES (?, ?)";
        PreparedStatement ps = conn.prepareStatement(query);

        ps.setString(1, email);
        ps.setString(2, password);

        int result = ps.executeUpdate();

        return result > 0;
    }
}
