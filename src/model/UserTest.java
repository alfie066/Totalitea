package model;

import static org.junit.Assert.*;
import org.junit.Test;

public class UserTest {

    @Test
    public void testConstructor() {
        User user = new User("test@test.com", "password123");

        assertEquals("test@test.com", user.getEmail());
        assertEquals("password123", user.getPassword());
    }

    @Test
    public void testSetAndGetID() {
        User user = new User("test@test.com", "password123");

        user.setID(1);
        assertEquals(1, user.getID());
    }

    @Test
    public void testSetAndGetEmail() {
        User user = new User("test@test.com", "password123");

        user.setEmail("new@test.com");
        assertEquals("new@test.com", user.getEmail());
    }

    @Test
    public void testSetAndGetPassword() {
        User user = new User("test@test.com", "password123");

        user.setPassword("newpassword");
        assertEquals("newpassword", user.getPassword());
    }
}