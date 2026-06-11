<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="util.BasketHandler"%>
<%@ page import="model.BasketItem"%>
<%@ page import="util.UserHandler"%>
<%@ page import="model.User"%>

<%
if (session.getAttribute("user") == null) {
    session.setAttribute("loginMessage", "You must be logged in to view your basket.");
    response.sendRedirect("login.jsp");
    return;
}

model.User basketUser = (model.User) session.getAttribute("user");
String userEmail = (basketUser != null) ? basketUser.getEmail() : null;
User user = (User) request.getSession().getAttribute("user");
int userId = user.getID();
%>

<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Totalitea - Basket</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #fcfbfa;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            color: #333333;
            padding-top: 90px;
        }
        .basket-banner {
            max-width: 800px;
            margin: 0 auto 40px auto;
            text-align: center;
        }
        .basket-banner h1 {
            font-family: Georgia, serif;
            color: #2c3e2b;
            font-weight: bold;
            font-size: 36px;
            margin-bottom: 15px;
        }
        h2.section-title {
            font-family: Georgia, serif;
            color: #2c3e2b;
            font-weight: bold;
            margin-bottom: 25px;
            border-bottom: 1px solid #eae6df;
            padding-bottom: 10px;
        }
        .table-responsive {
            background: #ffffff;
            border: 1px solid #eae6df;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.02);
            padding: 15px;
            margin-bottom: 40px;
        }
        .table {
            margin-bottom: 0;
        }
        .table > thead > tr > th {
            border-bottom: 2px solid #eae6df !important;
            color: #2c3e2b;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 0.05em;
            font-weight: 600;
            padding: 14px 10px !important;
        }
        .table > tbody > tr > td {
            border-top: 1px solid #f2eee9;
            padding: 16px 10px !important;
            vertical-align: middle !important;
            font-size: 14px;
        }
        .summary-card {
            background: #ffffff;
            border: 1px solid #eae6df;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.02);
            padding: 25px;
            margin-bottom: 40px;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            font-size: 15px;
        }
        .summary-total {
            display: flex;
            justify-content: space-between;
            font-size: 18px;
            font-weight: bold;
            color: #2c3e2b;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eae6df;
        }
        .btn-checkout {
            background-color: #2c3e2b;
            color: #ffffff;
            border: none;
            font-weight: 500;
            border-radius: 4px;
            height: 44px;
            font-size: 16px;
            width: 100%;
            margin-top: 15px;
            transition: background-color 0.15s ease;
        }
        .btn-checkout:hover {
            background-color: #1e2b1e;
            color: #ffffff;
        }
        .btn-remove {
            background: none;
            border: none;
            color: #a94442;
            font-weight: 500;
            padding: 0;
            font-size: 13px;
            text-decoration: underline;
        }
        .btn-remove:hover {
            color: #721c24;
            text-decoration: none;
        }
    </style>
</head>
<body>

    <jsp:include page="WEB-INF/jsp/navbar.jsp" />

<div class="container">
    <main class="col-md-12">

        <div class="basket-banner">
            <h1>Your Basket</h1>
        </div>

        <%
        String msg = (String) session.getAttribute("message");
        if (msg != null) {
        %>
            <div class="alert alert-success" style="background-color: #d4edda; border-color: #c3e6cb; color: #155724;">
                <%= msg %>
            </div>
        <%
            session.removeAttribute("message");
        }
        %>

        <%
        ArrayList<BasketItem> basketItems = BasketHandler.getBasketItems(userId);
        double subtotal = BasketHandler.calculateSubtotal(basketItems);
        int totalWeight = BasketHandler.calculateTotalWeight(basketItems);
        double weightKg = totalWeight / 1000.0;
        double shipping = BasketHandler.calculateShipping(totalWeight, subtotal);
        double total = subtotal + shipping;

        if (basketItems == null || basketItems.isEmpty()) {
        %>
            <div class="alert alert-info" style="background-color: #f4f1ec; border-color: #eae6df; color: #2c3e2b; font-size: 16px; text-align: center; padding: 30px;">
                Your basket is empty. Go explore our <a href="products.jsp" style="color: #2c3e2b; font-weight: bold; text-decoration: underline;">products</a> page!
            </div>
        <%
        } else {
        %>

        <div class="row">
            <div class="col-md-8">
                <h2 class="section-title">Items</h2>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th style="width: 40%;">Product</th>
                                <th style="width: 15%; text-align: center;">Size</th>
                                <th style="width: 15%; text-align: center;">Qty</th>
                                <th style="width: 20%; text-align: right;">Total</th>
                                <th style="width: 10%;"></th>
                            </tr>
                        </thead>
                        <tbody>
<%
        for (BasketItem b : basketItems) {
            double pricePer100g = b.getPriceInPoundsPer100g();
            double itemPrice = pricePer100g * (b.getGrams() / 100.0);
            double itemTotal = itemPrice * b.getQuantity();
%>
                            <tr>
                                <td>
                                    <div style="font-weight: 600; color: #2c3e2b;"><%= b.getName() %></div>
                                    <div style="font-size: 12px; color: #777777;">£<%= String.format("%.2f", itemPrice) %> each</div>
                                </td>
                                <td style="text-align: center; color: #555555;"><%= b.getGrams() %>g</td>
                                <td style="text-align: center; color: #555555;"><%= b.getQuantity() %></td>
                                <td style="text-align: right; font-weight: 600; color: #2c3e2b;">£<%= String.format("%.2f", itemTotal) %></td>
                                <td style="text-align: center;">
                                    <form action="RemoveFromBasket" method="post" style="display:inline;">
                                        <input type="hidden" name="itemId" value="<%= b.getBasketItemId() %>">
                                        <button type="submit" class="btn-remove">Remove</button>
                                    </form>
                                </td>
                            </tr>
<%
        }
%>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="col-md-4">
                <h2 class="section-title">Summary</h2>
                <div class="summary-card">
                    
                    <%
                    if (subtotal < 100 && subtotal > 0) {
                        double remaining = 100 - subtotal;
                    %>
                        <div class="alert alert-warning" style="background-color: #fff3cd; border-color: #ffeeba; color: #856404; font-size: 13px; text-align: center; margin-bottom: 20px; border-radius: 4px;">
                            Spend <strong>£<%= String.format("%.2f", remaining) %></strong> more for <strong>FREE</strong> delivery!
                        </div>
                    <%
                    }
                    %>

                    <div class="summary-row">
                        <span>Subtotal</span>
                        <span>£<%= String.format("%.2f", subtotal) %></span>
                    </div>

                    <div class="summary-row">
                        <span>Shipping</span>
                        <span>
                            <% if (shipping == 0 && subtotal >= 100) { %>
                                <span style="color: #2c3e2b; font-weight: 600;">FREE</span>
                            <% } else { %>
                                £<%= String.format("%.2f", shipping) %>
                            <% } %>
                        <% if (shipping > 0) { %>
                            <div style="font-size: 11px; color: #777777; text-align: right;"><%= String.format("%.2f", weightKg) %> kg</div>
                        <% } %>
                        </span>
                    </div>

                    <% if (shipping == 0 && subtotal >= 100) { %>
                        <div class="summary-row" style="font-size: 12px; color: #777777;">
                            <span>Total Weight</span>
                            <span><%= String.format("%.2f", weightKg) %> kg</span>
                        </div>
                    <% } %>

                    <div class="summary-total">
                        <span>Estimated Total</span>
                        <span>£<%= String.format("%.2f", total) %></span>
                    </div>

                    <form action="checkout.jsp" method="get">
                        <button type="submit" class="btn-checkout">
                            Proceed to Checkout
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <%
        }
        %>

    </main>
</div>

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>