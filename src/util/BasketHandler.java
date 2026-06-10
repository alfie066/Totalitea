package util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import model.BasketItem;

public class BasketHandler {


    public static int getOrCreateBasket(int userId) throws SQLException {
        Connection conn = DbConnector.getConnection();


        String selectSql = "SELECT Id FROM Basket WHERE UserId = ?";
        PreparedStatement ps = conn.prepareStatement(selectSql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return rs.getInt("Id");
        }

        String insertSql = "INSERT INTO Basket (UserId) VALUES (?)";
        PreparedStatement insert = conn.prepareStatement(insertSql, PreparedStatement.RETURN_GENERATED_KEYS);
        insert.setInt(1, userId);
        insert.executeUpdate();

        ResultSet keys = insert.getGeneratedKeys();
        if (keys.next()) {
            return keys.getInt(1);
        }

        throw new SQLException("Failed to create basket for userId: " + userId);
    }


    public static boolean addToBasket(int basketId, int pid, int grams, int qty) {
        try {
            CallableStatement cs = DbConnector.getConnection()
                .prepareCall("{call insertItemIntoBasket(?,?,?,?,?)}");

            cs.setInt(1, basketId);
            cs.setInt(2, pid);
            cs.setInt(3, grams);
            cs.setInt(4, qty);

            cs.registerOutParameter(5, Types.INTEGER);

            cs.execute();

            return true;

        } catch (SQLException sqle) {
            System.out.println(sqle);
        }
        return false;
    }

    public static ArrayList<BasketItem> getItemsFromBasket(int basketId) throws SQLException {

        String query =
            "SELECT b.Id AS basketItemId, " +
            "p.Id AS productId, " +
            "p.Name, " +
            "b.priceInPencePer100g, " +
            "b.Grams, " +
            "b.Quantity " +
            "FROM BasketItem b " +
            "JOIN Product p ON b.ProductId = p.Id " +
            "WHERE b.BasketId = ?";

        PreparedStatement ps = DbConnector.getConnection().prepareStatement(query);
        ps.setInt(1, basketId);
        ResultSet rs = ps.executeQuery();

        ArrayList<BasketItem> items = new ArrayList<>();

        while (rs.next()) {
            items.add(new BasketItem(
                rs.getInt("basketItemId"),
                rs.getInt("productId"),
                rs.getString("Name"),
                rs.getInt("priceInPencePer100g"),
                rs.getInt("Grams"),
                rs.getInt("Quantity")
            ));
        }

        return items;
    }
    
    public static void clearBasket(int basketId) throws SQLException {
        String sql = "DELETE FROM BasketItem WHERE BasketId = ?";
        java.sql.PreparedStatement ps = DbConnector.getConnection().prepareStatement(sql);
        ps.setInt(1, basketId);
        ps.executeUpdate();
    }
}