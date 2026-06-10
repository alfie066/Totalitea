package util;

import java.sql.*;

import model.BasketItem;

public class OrderHandler {

    public static int createOrder(int userId, double total) throws SQLException {
        Connection conn = DbConnector.getConnection();

        String sql = "INSERT INTO Orders (UserId, TotalPrice) VALUES (?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);

        ps.setInt(1, userId);
        ps.setDouble(2, total);

        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) {
            return rs.getInt(1);
        }

        throw new SQLException("Failed to create order");
    }

    public static void insertOrderItem(int orderId, BasketItem b) throws SQLException {
        Connection conn = DbConnector.getConnection();

        String sql = "INSERT INTO OrderItem (OrderId, ProductId, Quantity, UnitPrice) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, orderId);
        ps.setInt(2, b.getProductId());
        ps.setInt(3, b.getQuantity());
        ps.setDouble(4, b.getTotalPrice());

        ps.executeUpdate();
    }
}