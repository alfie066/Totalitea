<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Totalitea Register</title>
</head>
<body>

    <h2>Register for Totalitea</h2>

    <form action="Register" method="POST">
        <label>Email:</label>
        <input type="email" name="email" required><br><br>

        <label>Password:</label>
        <input type="password" name="password" required><br><br>
        
        <label>Address:</label>
        <input type="address" name="address" required><br><br>

        <button type="submit">Sign Up</button>
    </form>

    <br>
    <p>Already have an account? <a href="login.jsp">Login</a></p>

</body>
</html>