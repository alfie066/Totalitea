package model;

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;

public class UserTest {

    private User user;

    @Before
    public void setUp() {
        user = new User(
            "John Doe",
            "john@test.com",
            "pass123",
            "2000-01-01",
            "123 Street",
            "1234567890123456",
            "2026-11-01",
            "123"
        );
        user.setID(1);
    }


    @Test
    public void constructorTest() {
        User testUser = new User(
            "Alice",
            "alice@test.com",
            "secure",
            "1999-05-10",
            "456 Road",
            "9999999999999999",
            "2027-01-01",
            "999"
        );

        assertEquals("Alice", testUser.getName());
        assertEquals("alice@test.com", testUser.getEmail());
        assertEquals("secure", testUser.getPassword());
        assertEquals("1999-05-10", testUser.getDob());
        assertEquals("456 Road", testUser.getAddress());
        assertEquals("9999999999999999", testUser.getCardNumber());
        assertEquals("2027-01-01", testUser.getExpiryDate());
        assertEquals("999", testUser.getCvv());
    }


    @Test
    public void idTest() {
        assertEquals(1, user.getID());

        user.setID(5);
        assertEquals(5, user.getID());
    }

 
    @Test
    public void nameTest() {
        assertEquals("John Doe", user.getName());

        user.setName("Jane");
        assertEquals("Jane", user.getName());
    }


    @Test
    public void emailTest() {
        assertEquals("john@test.com", user.getEmail());

        user.setEmail("new@test.com");
        assertEquals("new@test.com", user.getEmail());
    }


    @Test
    public void passwordTest() {
        assertEquals("pass123", user.getPassword());

        user.setPassword("newpass");
        assertEquals("newpass", user.getPassword());
    }


    @Test
    public void dobTest() {
        assertEquals("2000-01-01", user.getDob());

        user.setDob("1995-12-12");
        assertEquals("1995-12-12", user.getDob());
    }


    @Test
    public void addressTest() {
        assertEquals("123 Street", user.getAddress());

        user.setAddress("New Address");
        assertEquals("New Address", user.getAddress());
    }


    @Test
    public void cardNumberTest() {
        assertEquals("1234567890123456", user.getCardNumber());

        user.setCardNumber("1111222233334444");
        assertEquals("1111222233334444", user.getCardNumber());
    }


    @Test
    public void expiryDateTest() {
        assertEquals("2026-11-01", user.getExpiryDate());

        user.setExpiryDate("2028-05-01");
        assertEquals("2028-05-01", user.getExpiryDate());
    }


    @Test
    public void cvvTest() {
        assertEquals("123", user.getCvv());

        user.setCvv("999");
        assertEquals("999", user.getCvv());
    }


    @Test
    public void emptyValuesTest() {
        User emptyUser = new User("", "", "", "", "", "", "", "");

        assertEquals("", emptyUser.getName());
        assertEquals("", emptyUser.getEmail());
        assertEquals("", emptyUser.getPassword());
        assertEquals("", emptyUser.getAddress());
    }

}