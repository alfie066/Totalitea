package test;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Product;
import util.ProductHandler;

public class ProductHandlerTest {

    // Test 1: Check that searching "tea" actually returns items
    @Test
    public void testSearchProductsReturnsMatchesForTea() throws SQLException {
        String searchTerm = "tea";
        
        ArrayList<Product> results = ProductHandler.searchProducts(searchTerm);
        
        // Assertions to prove it worked
        assertNotNull(results); 
        assertTrue(results.size() > 0); // Should find at least 1 item
        
        // Verify the first item actually contains the word "tea"
        String name = results.get(0).getName().toLowerCase();
        String desc = results.get(0).getDescription().toLowerCase();
        assertTrue(name.contains("tea") || desc.contains("tea"));
    }

    // Test 2: Check that a fake search returns an empty list
    @Test
    public void testSearchProductsReturnsEmptyList() throws SQLException {
        String searchTerm = "XyzNonsenseDrink";
        
        ArrayList<Product> results = ProductHandler.searchProducts(searchTerm);
        
        // Assertions to prove it safely returns nothing
        assertNotNull(results);
        assertEquals(0, results.size()); // Should return exactly 0 items
    }
    
    // Test 3: Check that searching in uppercase still finds lowercase items
    @Test
    public void testSearchProductsIsCaseInsensitive() throws SQLException {
        String searchTerm = "TEA";
        
        ArrayList<Product> results = ProductHandler.searchProducts(searchTerm);
        
        // Should still find your tea products regardless of capital letters
        assertNotNull(results);
        assertTrue(results.size() > 0);
    }
}