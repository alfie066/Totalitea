package model;

import static org.junit.Assert.*;
import org.junit.Test;

public class UserTest {

    @Test
    public void testConstructor() {
        User user = new User("alfie cull", "test@test.com", "password123", "01/01/0001", "ef", null, null, null);

        assertEquals("test@test.com", user.getEmail());
        assertEquals("password123", user.getPassword());
        assertEquals("ef", user.getAddress());
        
    }

    @Test
    public void testSetAndGetID() {
        User user = new User("alfie cull", "test@test.com", "password123", "01/01/0001", "ef", null, null, null);

        user.setID(1);
        assertEquals(1, user.getID());
    }

    @Test
    public void testSetAndGetEmail() {
        User user = new User("alfie cull", "test@test.com", "password123", "01/01/0001", "ef", null, null, null);

        user.setEmail("new@test.com");
        assertEquals("new@test.com", user.getEmail());
    }

    @Test
    public void testSetAndGetPassword() {
        User user = new User("alfie cull", "test@test.com", "password123", "01/01/0001", "ef", null, null, null);

        user.setPassword("newpassword");
        assertEquals("newpassword", user.getPassword());
    }
    
}