<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Totalitea - Login</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body style="background-color: #faf9f6; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;">

<jsp:include page="WEB-INF/jsp/navbar.jsp" />

    <div class="container" style="margin-top: 120px; margin-bottom: 50px;">
        <div class="row">
            <div class="col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3">
                
                <div style="background: #ffffff; border: 1px solid #eae6df; padding: 40px 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.02);">
                    
                    <h2 style="color: #2c3e2b; font-family: Georgia, serif; font-weight: bold; text-align: center; margin-top: 0; margin-bottom: 8px;">Welcome Back</h2>
                    <p style="color: #777; text-align: center; font-size: 14px; margin-bottom: 30px;">Login to manage your Totalitea account</p>

                    <%-- Flash/Session Error Messages --%>
                    <%
                        String msg = (String) session.getAttribute("loginMessage");
                        if (msg != null) {
                    %>
                        <div class="alert alert-danger" style="border-radius: 4px; padding: 10px 15px; font-size: 14px; border: 1px solid #ebccd1; background-color: #f2dede; color: #a94442; margin-bottom: 20px;">
                            <%= msg %>
                        </div>
                    <%
                            session.removeAttribute("loginMessage");
                        }
                    %>

                    <%-- Request Error Messages --%>
                    <% if(request.getAttribute("errorMessage") != null) { %>
                        <div class="alert alert-danger" style="border-radius: 4px; padding: 10px 15px; font-size: 14px; border: 1px solid #ebccd1; background-color: #f2dede; color: #a94442; margin-bottom: 20px;">
                            <%= request.getAttribute("errorMessage") %>
                        </div>
                    <% } %>

                    <form action="Login" method="POST">
                        
                        <div class="form-group" style="margin-bottom: 20px;">
                            <label style="color: #4a4a4a; font-weight: 500; margin-bottom: 6px; font-size: 14px;">Email Address</label>
                            <input type="email" name="email" class="form-control" required placeholder="name@example.com"
                                style="border-radius: 4px; border: 1px solid #ccc; height: 42px; box-shadow: none;">
                        </div>
                        
                        <div class="form-group" style="margin-bottom: 25px;">
                            <label style="color: #4a4a4a; font-weight: 500; margin-bottom: 6px; font-size: 14px;">Password</label>
                            <input type="password" name="password" class="form-control" required placeholder="••••••••"
                                style="border-radius: 4px; border: 1px solid #ccc; height: 42px; box-shadow: none;">
                        </div>
                        
                        <button type="submit" class="btn btn-block" 
                            style="background-color: #2c3e2b; color: #ffffff; font-weight: 500; border-radius: 4px; padding: 12px; font-size: 15px; border: none; transition: background 0.2s;">
                            Login
                        </button>
                        
                    </form>

                    <hr style="border-top: 1px solid #eae6df; margin: 25px 0;">
                    
                    <p style="text-align: center; color: #666; margin-bottom: 0; font-size: 14px;">
                        Don't have an account? <a href="register.jsp" style="color: #2c3e2b; font-weight: 600; text-decoration: none;">Register</a>
                    </p>
                    
                </div>
                
            </div>
        </div>
    </div>

</body>
</html>