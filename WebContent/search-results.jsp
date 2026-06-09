<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Search Results</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>

    <jsp:include page="WEB-INF/jsp/navbar.jsp" />

    <div class="container" style="margin-top: 70px;">
        <h2>Search Results</h2>
        <p>Showing matching items for: <strong><%= request.getAttribute("query") %></strong></p>
        <hr>

        <% 
            ArrayList<Product> products = (ArrayList<Product>) request.getAttribute("searchResults");
            if (products == null || products.isEmpty()) {
        %>
            <div class="alert alert-warning">
                No products found matching your search term. Try checking your spelling or searching for something else.
            </div>
            <a href="index.jsp" class="btn btn-default">Back to Home</a>
        <% 
            } else { 
        %>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Product Id</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Quantity</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        for (Product p : products) {
                    %>
                        <tr>
                            <td><%= p.getId() %></td>
                            <td><%= p.getName() %></td>
                            <td><%= p.getDescription() %></td>
                            <td><%= String.format("%.1f", p.getPrice() / 100.0) %></td>
                            <td>
                                <form action="AddToBasket" method="POST" style="margin: 0;">
                                    <input type="hidden" name="productId" value="<%= p.getId() %>">
                                    <input type="text" name="quantity" style="width: 40px; margin-right: 5px;">
                                    <button type="submit" class="btn btn-xs btn-default">Purchase</button>
                                </form>
                            </td>
                        </tr>
                    <% 
                        } 
                    %>
                </tbody>
            </table>
        <% 
            } 
        %>
    </div>

</body>
</html>