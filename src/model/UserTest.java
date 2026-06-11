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
            "123 Street"
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
            "456 Road"
        );

        assertEquals("Alice", testUser.getName());
        assertEquals("alice@test.com", testUser.getEmail());
        assertEquals("secure", testUser.getPassword());
        assertEquals("1999-05-10", testUser.getDob());
        assertEquals("456 Road", testUser.getAddress());
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


}