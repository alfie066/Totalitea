<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Totalitea - Register</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body style="background-color: #faf9f6; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;">

<jsp:include page="WEB-INF/jsp/navbar.jsp" />

    <div class="container" style="margin-top: 120px; margin-bottom: 50px;">
        <div class="row">
            <div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
                
                <div style="background: #ffffff; border: 1px solid #eae6df; padding: 40px 35px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.02);">
                    
                    <h2 style="color: #2c3e2b; font-family: Georgia, serif; font-weight: bold; text-align: center; margin-top: 0; margin-bottom: 8px;">Create an Account</h2>
                    <p style="color: #777; text-align: center; font-size: 14px; margin-bottom: 30px;">Join Totalitea to start managing your orders</p>

                    <form action="Register" method="POST">
                        
                        <h4 style="color: #2c3e2b; font-family: Georgia, serif; font-weight: bold; border-bottom: 1px solid #eae6df; padding-bottom: 8px; margin-bottom: 15px;">Personal Details</h4>

                        <div class="form-group">
                            <label style="color: #4a4a4a; font-weight: 500; font-size: 13px;">Full Name</label>
                            <input type="text" name="name" class="form-control" required placeholder="John Doe"
                                style="border-radius: 4px; border: 1px solid #ccc; height: 38px; box-shadow: none;">
                        </div>

                        <div class="form-group">
                            <label style="color: #4a4a4a; font-weight: 500; font-size: 13px;">Email Address</label>
                            <input type="email" name="email" class="form-control" required placeholder="john@example.com"
                                style="border-radius: 4px; border: 1px solid #ccc; height: 38px; box-shadow: none;">
                        </div>

                        <div class="form-group">
                            <label style="color: #4a4a4a; font-weight: 500; font-size: 13px;">Password</label>
                            <input type="password" name="password" class="form-control" required placeholder="••••••••"
                                style="border-radius: 4px; border: 1px solid #ccc; height: 38px; box-shadow: none;">
                        </div>

                        <div class="form-group">
                            <label style="color: #4a4a4a; font-weight: 500; font-size: 13px;">Date of Birth</label>
                            <input type="date" name="dob" class="form-control" required
                                style="border-radius: 4px; border: 1px solid #ccc; height: 38px; box-shadow: none;">
                        </div>

                        <div class="form-group">
                            <label style="color: #4a4a4a; font-weight: 500; font-size: 13px;">Shipping & Billing Address</label>
                            <input type="text" name="address" class="form-control" required placeholder="Aston Street, Birmingham"
                                style="border-radius: 4px; border: 1px solid #ccc; height: 38px; box-shadow: none;">
                        </div>

                    	

                        <button type="submit" class="btn btn-block" 
                            style="background-color: #2c3e2b; color: #ffffff; font-weight: 500; border-radius: 4px; padding: 12px; font-size: 15px; border: none; margin-top: 25px;">
                            Sign Up
                        </button>
                        
                    </form>

                    <hr style="border-top: 1px solid #eae6df; margin: 25px 0;">
                    
                    <p style="text-align: center; color: #666; margin-bottom: 0; font-size: 14px;">
                        Already have an account? <a href="login.jsp" style="color: #2c3e2b; font-weight: 600; text-decoration: none;">Login</a>
                    </p>
                    
                </div>
                
            </div>
        </div>
    </div>

</body>
</html>