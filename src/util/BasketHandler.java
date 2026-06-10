package util;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.BasketItem;

public class BasketHandler {

    public static void addToBasket(int userId, int productId, int grams, int quantity) throws SQLException {

        OrderHandler.addItemToOrder(userId, productId, grams, quantity);
    }


    public static ArrayList<BasketItem> getBasketItems(int userId) throws SQLException {

        int orderId = OrderHandler.getOpenOrderId(userId);

        ArrayList<BasketItem> items = new ArrayList<>();

        if (orderId == -1) {
            return items; // empty basket
        }

        String query =
            "SELECT oi.Id, p.Id AS productId, p.Name, " +
            "oi.PriceInPencePer100g, oi.Grams, oi.Quantity " +
            "FROM OrderItem oi " +
            "JOIN Product p ON oi.ProductId = p.Id " +
            "WHERE oi.OrderId = ?";

        PreparedStatement ps = DbConnector.getConnection().prepareStatement(query);
        ps.setInt(1, orderId);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            items.add(new BasketItem(
                rs.getInt("Id"),
                rs.getInt("productId"),
                rs.getString("Name"),
                rs.getInt("PriceInPencePer100g"),
                rs.getInt("Grams"),
                rs.getInt("Quantity")
            ));
        }

        return items;
    }


    public static void removeFromBasket(int userId, int productId, int grams) throws SQLException {

        int orderId = OrderHandler.getOpenOrderId(userId);

        if (orderId != -1) {
            OrderHandler.removeItem(orderId, productId, grams);
        }
    }


    public static void clearBasket(int userId) throws SQLException {

        int orderId = OrderHandler.getOpenOrderId(userId);

        if (orderId == -1) return;

        String sql = "DELETE FROM OrderItem WHERE OrderId = ?";
        PreparedStatement ps = DbConnector.getConnection().prepareStatement(sql);
        ps.setInt(1, orderId);
        ps.executeUpdate();
    }
}
