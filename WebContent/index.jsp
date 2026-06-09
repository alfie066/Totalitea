<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
<head>
<%-- Page Configuration and Bootstrap Stylesheets --%>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" >
<link href="css/style.css" rel="stylesheet" >
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Totalitea | Premium Tea & Coffee</title>
</head>
<body>

	<%-- include navbar --%>
	<%@include file="WEB-INF/jsp/navbar.jsp" %>

    <%-- Main Welcome Banner (Jumbotron) --%>
    <div class="jumbotron" style="background-color: #f5f2eb; padding: 70px 0; margin-bottom: 40px; border-bottom: 1px solid #e1dbcf;">
      <div class="container text-center">
        <h1 style="color: #2c3e2b; font-family: Georgia, serif; font-weight: bold; margin-bottom: 15px; font-size: 52px;">Artisanal Tea & Fresh Beans</h1>
        <p style="color: #555; max-width: 700px; margin: 0 auto 25px auto; font-size: 18px; line-height: 1.6;">
          Welcome to Totalitea. Discover our hand-picked selection of organic loose-leaf teas, premium pyramid tea bags, and ethically sourced coffee beans.
        </p>
        <%-- Main Shop Blends Call to Action Button --%>
        <p><a class="btn btn-primary btn-lg" href="ProductList" role="button" style="background-color: #2c3e2b; border: none; padding: 12px 30px;">Explore Our Blends</a></p>
      </div>
    </div>

    <%-- Main Three Column Grid Layout Container --%>
    <div class="container">
      <div class="row">
        
        <%-- Premium Tea Bags Category Box --%>
        <div class="col-md-4">
          <div style="background: #ffffff; border: 1px solid #e6e6e6; padding: 30px; border-radius: 6px; text-align: center; margin-bottom: 20px;">
            <div style="font-size: 45px; margin-bottom: 10px;">🍃</div>
            <h2 style="color: #2c3e2b; font-size: 24px; font-weight: 600; margin-top: 10px; margin-bottom: 15px;">Premium Tea Bags</h2>
            <p style="color: #666; min-height: 60px; font-size: 14px; line-height: 1.5;">From vibrant organic green teas to comforting breakfast blends, browse our expertly crafted selections.</p>
            <%-- Shop Teas Action Button --%>
            <p><a class="btn btn-default" href="products.jsp" role="button" style="border-radius: 4px; width: 100%; font-weight: 500;">Shop Teas &raquo;</a></p>
          </div>
        </div>
        
        <%-- Whole Coffee Beans Category Box --%>
        <div class="col-md-4">
          <div style="background: #ffffff; border: 1px solid #e6e6e6; padding: 30px; border-radius: 6px; text-align: center; margin-bottom: 20px;">
            <div style="font-size: 45px; margin-bottom: 10px;">☕</div>
            <h2 style="color: #2c3e2b; font-size: 24px; font-weight: 600; margin-top: 10px; margin-bottom: 15px;">Whole Coffee Beans</h2>
            <p style="color: #666; min-height: 60px; font-size: 14px; line-height: 1.5;">Freshly roasted single-origin varieties and custom espresso blends. Available in whole bean or tailored grinds.</p>
            <%-- Shop Coffee Action Button --%>
            <p><a class="btn btn-default" href="ProductList" role="button" style="border-radius: 4px; width: 100%; font-weight: 500;">Shop Coffee &raquo;</a></p>
          </div>
        </div>
        
        <%-- Shopping Basket Quick View Box --%>
        <div class="col-md-4">
          <div style="background: #ffffff; border: 1px solid #e6e6e6; padding: 30px; border-radius: 6px; text-align: center; margin-bottom: 20px;">
            <div style="font-size: 45px; margin-bottom: 10px;">🛒</div>
            <h2 style="color: #2c3e2b; font-size: 24px; font-weight: 600; margin-top: 10px; margin-bottom: 15px;">Your Basket</h2>
            <p style="color: #666; min-height: 60px; font-size: 14px; line-height: 1.5;">Ready to brew? Head over to your shopping basket to review your selected items and check out securely.</p>
            <%-- View Basket Action Button --%>
            <p><a class="btn btn-default" href="basket.jsp" role="button" style="border-radius: 4px; width: 100%; font-weight: 500;">View Basket &raquo;</a></p>
          </div>
        </div>
        
      </div>

      <hr style="border-top: 1px solid #eee; margin: 40px 0;">

      <%-- Website Footer Section --%>
      <footer class="text-center" style="padding-bottom: 30px; color: #888;">
        <p>&copy; 2026 Totalitea Co. &bull; Sourced Ethically, Brewed Exceptionally.</p>
      </footer>
    </div> 
    
    <%-- External JavaScript Core Frameworks --%>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js" type ="text/javascript"> </script >
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" > </script >
</body>
</html>