package util;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



public class OrderHandler {

    public static int addItemToOrder(int userId, int productId, int grams, int quantity) throws SQLException {

        CallableStatement stmt = DbConnector.getCallableStatement(
            "{CALL insertItemIntoOrder(?, ?, ?, ?, ?)}"
        );

        stmt.setInt(1, userId);
        stmt.setInt(2, productId);
        stmt.setInt(3, grams);
        stmt.setInt(4, quantity);
        stmt.registerOutParameter(5, java.sql.Types.INTEGER);

        stmt.execute();

        return stmt.getInt(5);
    }


    /**
     * Get current OPEN order ID for a user
     */
    public static int getOpenOrderId(int userId) throws SQLException {

        String sql = "SELECT Id FROM Orders WHERE UserId = ? AND Status = 'OPEN' LIMIT 1";

        java.sql.Connection conn = DbConnector.getConnection();
        java.sql.PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return rs.getInt("Id");
        }

        return -1; // no open order
    }


    /**
     * Get all items in an order (basket)
     */
    public static ResultSet getOrderItems(int orderId) throws SQLException {

        String sql = "SELECT * FROM OrderItem WHERE OrderId = ?";

        java.sql.Connection conn = DbConnector.getConnection();
        java.sql.PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, orderId);

        return ps.executeQuery();
    }


    /**
     * Remove item from order
     */
    public static void removeItem(int orderId, int productId, int grams) throws SQLException {

        CallableStatement stmt = DbConnector.getCallableStatement(
            "{CALL removeOrderItem(?, ?, ?)}"
        );

        stmt.setInt(1, orderId);
        stmt.setInt(2, productId);
        stmt.setInt(3, grams);

        stmt.execute();
    }
    
    public static void completeOrder(int orderId) throws SQLException {

        String sql = "UPDATE Orders SET Status = 'PAID', PlacedAt = CURRENT_TIMESTAMP WHERE Id = ?";

        java.sql.Connection conn = DbConnector.getConnection();
        java.sql.PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, orderId);
        ps.executeUpdate();
    }
}