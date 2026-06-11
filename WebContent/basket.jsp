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
ArrayList<BasketItem> basketItems = BasketHandler.getBasketItems(userId);

double subtotal = BasketHandler.calculateSubtotal(basketItems);

int totalWeight = BasketHandler.calculateTotalWeight(basketItems);
double weightKg = totalWeight / 1000.0;


double shipping = BasketHandler.calculateShipping(totalWeight, subtotal);


double total = subtotal + shipping;


for (BasketItem b : basketItems) {

	double pricePer100g = b.getPriceInPoundsPer100g();
	double itemPrice = pricePer100g * (b.getGrams() / 100.0);
	double itemTotal = itemPrice * b.getQuantity();

%>
<li>
    <%= b.getName() %>
    (<%= b.getGrams() %>g)
    x <%= b.getQuantity() %>
    - £<%= String.format("%.2f", itemTotal) %>
    ( £<%= String.format("%.2f", itemPrice) %> each )

    <form action="RemoveFromBasket" method="post" style="display:inline;">
        <input type="hidden" name="itemId" value="<%= b.getBasketItemId() %>">
        <button type="submit" class="btn btn-danger btn-sm">
            Remove
        </button>
    </form>
</li>
<%
}
%>
</ul>

<%
if (subtotal < 100 && subtotal > 0) {
    double remaining = 100 - subtotal;
%>
    <p style="color: #2c3e2b;">
        Spend £<%= String.format("%.2f", remaining) %> more for FREE delivery!
    </p>
<%
}
%>

<div style="margin-top: 20px; font-size: 18px;">

    <p>Subtotal: £<%= String.format("%.2f", subtotal) %></p>

    <p>
        Shipping:
        <% if (shipping == 0 && subtotal >= 100) { %>
            <span style="color: green;">FREE</span>
        <% } else { %>
            £<%= String.format("%.2f", shipping) %>
        <% } %>
    </p>

    <hr>

    <p><strong>Total: £<%= String.format("%.2f", total) %></strong></p>
    <p>Total weight: <%= String.format("%.2f", weightKg) %> kg</p>


</div>

		
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