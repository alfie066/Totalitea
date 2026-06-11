<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ page import="model.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="util.ProductHandler" %>

<!doctype html>
<html>
<head>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF8">
    <title>Totalitea - Products</title>
</head>

<body>

<%@include file="WEB-INF/jsp/navbar.jsp" %>

<div class="container-fluid">
    <main class="col-md-12">

        <h1>Products</h1>

        <section class="row text-center placeholders">
            <p>
                Welcome to Totalitea – explore our premium selection of teas and coffees from around the world.
                Each product is carefully sourced to bring you the best flavour and quality.
            </p>
            <p>
                Select your preferred quantity and weight before adding items to your basket.
                Whether you're after a smooth morning coffee or a calming evening tea, we've got you covered.
            </p>
        </section>

<%
    // ✅ Get products first (important!)
    ArrayList<Product> products = (ArrayList<Product>) request.getAttribute("products");

    String query = (String) request.getAttribute("query");

    // ✅ Default behaviour: show all products only if no search
    if (products == null) {
        if (query == null || query.isEmpty()) {
            products = ProductHandler.getProducts();
        } else {
            products = new ArrayList<Product>();
        }
    }
%>

<%
    // ✅ Show search text
    if (query != null && !query.isEmpty()) {
%>
        <p style="font-size: 20px;">
            Showing results for: <strong><%= query %></strong>
        </p>
<%
    }
%>

<%
    // ✅ No results message
    if (products.isEmpty() && query != null && !query.isEmpty()) {
%>
        <p style="font-size: 18px; color: #a94442;">
            No results found for "<strong><%= query %></strong>"
        </p>
<%
    }
%>

<%
    // ✅ Only show table if there are products
    if (!products.isEmpty()) {
%>

        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price (for 100g)</th>
                        <th>Size</th>
                        <th>Quantity</th>
                        <th></th>
                    </tr>
                </thead>

                <tbody>

<%
    for (Product p : products) {
%>
                    <tr class="prod p<%= p.getId() %>">

                        <td><%= p.getName() %></td>
                        <td><%= p.getDescription() %></td>
                        <td><%= p.getFormattedPrice() %></td>

                        <td colspan="3">

                            <form action="<%= request.getContextPath() %>/AddToBasket"
                                  method="post"
                                  style="display:flex; gap:8px; align-items:center;">

                                <input type="hidden" name="pid" value="<%= p.getId() %>">

                                <select name="grams" class="form-control" style="width:auto;">
                                    <option value="100">100g</option>
                                    <option value="200">200g</option>
                                    <option value="300">300g</option>
                                    <option value="400">400g</option>
                                    <option value="500">500g</option>
                                    <option value="1000">1000g</option>
                                </select>

                                <input type="number" name="qty" value="1" min="1"
                                       class="form-control" style="width:70px;">

                                <button type="submit" class="btn btn-primary btn-sm">
                                    Add to basket
                                </button>

                            </form>

                        </td>

                    </tr>
<%
    }
%>

                </tbody>
            </table>
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