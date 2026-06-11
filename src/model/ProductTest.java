package model;

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;

public class ProductTest {

    private Product product;

    @Before
    public void setUp() {
        product = new Product(1, "Tea", "Nice tea", 250);
    }


    @Test
    public void constructorTest() {
        Product p = new Product(5, "Coffee", "Strong coffee", 300);

        assertEquals(5, p.getId());
        assertEquals("Coffee", p.getName());
        assertEquals("Strong coffee", p.getDescription());
        assertEquals(300, p.getPrice());
    }


    @Test
    public void constructorNoIdTest() {
        Product p = new Product("Latte", "Milk coffee", 200);

        assertEquals(0, p.getId());
        assertEquals("Latte", p.getName());
        assertEquals("Milk coffee", p.getDescription());
        assertEquals(200, p.getPrice());
    }


    @Test
    public void getIdTest() {
        assertEquals(1, product.getId());
    }

    @Test
    public void getNameTest() {
        assertEquals("Tea", product.getName());
    }

    @Test
    public void getDescriptionTest() {
        assertEquals("Nice tea", product.getDescription());
    }

    @Test
    public void getPriceTest() {
        assertEquals(250, product.getPrice());
    }


    @Test
    public void setIdTest() {
        product.setId(10);
        assertEquals(10, product.getId());
    }

    @Test
    public void setNameTest() {
        product.setName("Green Tea");
        assertEquals("Green Tea", product.getName());
    }

    @Test
    public void setDescriptionTest() {
        product.setDescription("Better tea");
        assertEquals("Better tea", product.getDescription());
    }

    @Test
    public void setPriceTest() {
        product.setPrice(400);
        assertEquals(400, product.getPrice());
    }


    @Test
    public void formattedPriceTest() {
        String result = product.getFormattedPrice();


        assertEquals("£2.50", result);
    }


    @Test
    public void zeroPriceTest() {
        Product free = new Product(1, "Free Tea", "Promo", 0);

        assertEquals("£0.00", free.getFormattedPrice());
    }


    @Test
    public void largePriceTest() {
        Product expensive = new Product(1, "Luxury Coffee", "Rare beans", 12345);


        assertEquals("£123.45", expensive.getFormattedPrice());
    }


    @Test
    public void roundingTest() {
        Product small = new Product(1, "Cheap Tea", "Basic", 199);

        assertEquals("£1.99", small.getFormattedPrice());
    }


    @Test
    public void toStringTest() {
        String result = product.toString();

        assertTrue(result.contains("Tea"));
        assertTrue(result.contains("£2.50"));
        assertTrue(result.contains("Nice tea"));
    }
}