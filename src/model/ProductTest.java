package model;

import static org.junit.Assert.*;
import org.junit.Test;

public class ProductTest {

    @Test
    public void testConstructorWithoutId() {
        Product p = new Product("Tea", "Nice tea", 250);

        assertEquals(0, p.getId());
        assertEquals("Tea", p.getName());
        assertEquals("Nice tea", p.getDescription());
        assertEquals(250, p.getPrice());
    }

    @Test
    public void testConstructorWithId() {
        Product p = new Product(1, "Coffee", "Strong coffee", 300);

        assertEquals(1, p.getId());
        assertEquals("Coffee", p.getName());
        assertEquals("Strong coffee", p.getDescription());
        assertEquals(300, p.getPrice());
    }

    @Test
    public void testSettersAndGetters() {
        Product p = new Product("Tea", "Nice tea", 250);

        p.setId(5);
        p.setName("Green Tea");
        p.setDescription("Healthy tea");
        p.setPrice(200);

        assertEquals(5, p.getId());
        assertEquals("Green Tea", p.getName());
        assertEquals("Healthy tea", p.getDescription());
        assertEquals(200, p.getPrice());
    }

    @Test
    public void testFormattedPrice() {
        Product p = new Product("Tea", "Nice tea", 250);

        assertEquals("£2.50", p.getFormattedPrice());
    }

    @Test
    public void testFormattedPriceRounding() {
        Product p = new Product("Tea", "Nice tea", 255);

        assertEquals("£2.55", p.getFormattedPrice());
    }
    

    @Test
    public void testToString() {
        Product p = new Product("Tea", "Nice tea", 250);

        String result = p.toString();

        assertTrue(result.contains("Tea"));
        assertTrue(result.contains("2.5"));
        assertTrue(result.contains("Nice tea"));
    }
    
}
