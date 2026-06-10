<%@ page language="java" contentType="text/html; charset=UTF8"
	pageEncoding="UTF8"%>
<%@ page import="model.Product"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="util.BasketHandler"%>
<%@ page import="model.BasketItem"%>
<%@ page import="util.UserHandler"%>



<%
if (session.getAttribute("user") == null) {
	session.setAttribute("loginMessage", "You must be logged in to view your basket.");
	response.sendRedirect("login.jsp");
	return;
}
%>


<%
model.User basketUser = (model.User) session.getAttribute("user");
String userEmail = (basketUser != null) ? basketUser.getEmail() : null;
int userId = UserHandler.getUserIdByEmail(userEmail);
int basketId = BasketHandler.getOrCreateBasket(userId);
%>


<!doctype html>
<html>
<head>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<title>Project example - basket</title>
</head>
<body>


	<%@include file="WEB-INF/jsp/navbar.jsp"%>
	
	<%
		String msg = (String) session.getAttribute("message");
		if (msg != null) {
		%>
		    <div class="alert alert-success">
		        <%= msg %>
		    </div>
		<%
		    session.removeAttribute("message");
		}
		%>


	<main class="col-sm-9 offset-sm-3 col-md-10 offset-md-2 pt-3">
		<h1>Basket</h1>


		In your basket is:
<ul>
<%
ArrayList<BasketItem> basketItems = BasketHandler.getItemsFromBasket(basketId);
double totalCost = 0.0;

for (BasketItem b : basketItems) {

    double itemPrice = b.getPriceInPoundsPer100g();
    double itemTotal = itemPrice * b.getQuantity();
    totalCost += itemTotal;
%>
    <li>
        <%= b.getName() %>
        (<%= b.getGrams() %>g)
        x <%= b.getQuantity() %>
        - £<%= String.format("%.2f", itemTotal) %>
        ( £<%= String.format("%.2f", itemPrice) %> each )
    </li>
<%
}
%>
</ul>

<h3>Total: £<%= String.format("%.2f", totalCost) %></h3>

		
			<%
			if (basketItems != null && !basketItems.isEmpty()) {
			%>
			    <form action="checkout.jsp" method="get">
			        <button type="submit" class="btn btn-success">
			            Proceed to Checkout
			        </button>
			    </form>
			<%
			}
			%>

	</main>

</body>
</html>