package util;

import java.sql.*;
import model.User;

public class UserHandler {

    public static User loginUser(String email, String password) throws SQLException {
        Connection conn = DbConnector.getConnection();
        String query = "SELECT * FROM user WHERE email=? AND password=?";
        PreparedStatement ps = conn.prepareStatement(query);

        ps.setString(1, email);
        ps.setString(2, password);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            User user = new User(
                rs.getString("name"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getString("dob"),
                rs.getString("address"),
                rs.getString("cardNumber"),
                rs.getString("expiryDate"),
                rs.getString("cvv")
            );
            user.setID(rs.getInt("id"));
            return user;
        }
        return null;
    }

    public static boolean registerUser(String name, String email, String password, String dob, String address, String cardNumber, String expiryDate, String cvv) throws SQLException {
        Connection conn = DbConnector.getConnection();
        String query = "INSERT INTO user (name, email, password, dob, address, cardNumber, expiryDate, cvv) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(query);

        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, password);
        ps.setString(4, dob);
        ps.setString(5, address);
        ps.setString(6, cardNumber);
        ps.setString(7, expiryDate);
        ps.setString(8, cvv);

        int result = ps.executeUpdate();
        return result > 0;
    }
    
    public static int getUserIdByEmail(String email) throws SQLException {
        Connection conn = DbConnector.getConnection();
        String query = "SELECT id FROM user WHERE email = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt("id");
        }
        return -1;
    }
}