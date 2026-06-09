<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<!DOCTYPE html>


<html>
<head>
    <title>Totalitea Login</title>
</head>
<body>

	<%
	    String msg = (String) session.getAttribute("loginMessage");
	
	    if (msg != null) {
	%>
	        <p style="color:red;"><%= msg %></p>
	<%
	        session.removeAttribute("loginMessage");
	    }
	%>

    <h2>Login to Totalitea</h2>

    <% if(request.getAttribute("errorMessage") != null) { %>
        <p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <form action="Login" method="POST">
        
        <label>Email:</label>
        <input type="email" name="email" required><br><br>
        
        <label>Password:</label>
        <input type="password" name="password" required><br><br>
        
        <button type="submit">Login</button>
        
    </form>

    <br>
    <p>Don't have an account? <a href="register.jsp">Register</a></p>
</body>