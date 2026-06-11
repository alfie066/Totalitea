<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="util.ProductHandler" %>

<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Totalitea - Products</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #fcfbfa;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            color: #333333;
            padding-top: 90px;
        }
        .products-banner {
            max-width: 800px;
            margin: 0 auto 40px auto;
            text-align: center;
        }
        .products-banner h1 {
            font-family: Georgia, serif;
            color: #2c3e2b;
            font-weight: bold;
            font-size: 36px;
            margin-bottom: 15px;
        }
        .products-banner p {
            color: #666666;
            font-size: 15px;
            line-height: 1.6;
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
            margin-bottom: 60px;
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
        .table > tbody > tr {
            transition: background-color 0.2s ease;
        }
        .table > tbody > tr:hover {
            background-color: #f7f5f2;
        }
        .table > tbody > tr > td {
            border-top: 1px solid #f2eee9;
            padding: 16px 10px !important;
            vertical-align: middle !important;
            font-size: 14px;
        }
        .product-desc {
            color: #555555;
            max-width: 450px;
            line-height: 1.5;
        }
        .product-price {
            font-weight: 600;
            color: #2c3e2b;
        }
        .form-control {
            border: 1px solid #dcd8d0;
            border-radius: 4px;
            box-shadow: none;
            height: 34px;
            transition: border-color 0.2s;
        }
        .form-control:focus {
            border-color: #2c3e2b;
            box-shadow: none;
        }
        .btn-add-basket {
            background-color: #2c3e2b;
            color: #ffffff;
            border: none;
            font-weight: 500;
            border-radius: 4px;
            padding: 6px 14px;
            height: 34px;
            transition: background-color 0.15s ease;
            white-space: nowrap;
        }
        .btn-add-basket:hover {
            background-color: #1e2b1e;
            color: #ffffff;
        }
    </style>
</head>
<body>

    <jsp:include page="WEB-INF/jsp/navbar.jsp" />

<div class="container">
    <main class="col-md-12">

        <div class="products-banner">
            <h1>Products</h1>
            <p>Welcome to Totalitea – explore our premium selection of teas and coffees from around the world. Each product is carefully sourced to bring you the best flavour and quality.</p>
            <p>Select your preferred quantity and weight before adding items to your basket. Whether you're after a smooth morning coffee or a calming evening tea, we've got you covered.</p>
        </div>

<%
    ArrayList<Product> products = (ArrayList<Product>) request.getAttribute("products");
    String query = (String) request.getAttribute("query");

    if (products == null) {
        if (query == null || query.isEmpty()) {
            products = ProductHandler.getProducts();
        } else {
            products = new ArrayList<Product>();
        }
    }
%>

<%
    if (query != null && !query.isEmpty()) {
%>
        <div class="alert alert-info" style="background-color: #f4f1ec; border-color: #eae6df; color: #2c3e2b; font-size: 16px;">
            Showing results for: <strong><%= query %></strong>
        </div>
<%
    }
%>

<%
    if (products.isEmpty() && query != null && !query.isEmpty()) {
%>
        <div class="alert alert-danger" style="background-color: #f8d7da; border-color: #f5c6cb; color: #721c24; font-size: 16px; margin-top: 20px;">
            No results found for "<strong><%= query %></strong>"
        </div>
<%
    }
%>

<%
    if (!products.isEmpty()) {
%>

        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th style="width: 15%;">Name</th>
                        <th style="width: 45%;">Description</th>
                        <th style="width: 15%;">Price (for 100g)</th>
                        <th colspan="3" style="width: 25%; text-align: center;">Purchase Options</th>
                    </tr>
                </thead>
                <tbody>

<%
    for (Product p : products) {
%>
                    <tr class="prod p<%= p.getId() %>">
                        <td style="font-weight: 600; color: #2c3e2b;"><%= p.getName() %></td>
                        <td class="product-desc"><%= p.getDescription() %></td>
                        <td class="product-price"><%= p.getFormattedPrice() %></td>

                        <td colspan="3">
                            <form action="<%= request.getContextPath() %>/AddToBasket" method="post" style="display:flex; gap:8px; align-items:center; justify-content: center;">

                                <input type="hidden" name="pid" value="<%= p.getId() %>">

                                <select name="grams" class="form-control" style="width:90px; display: inline-block;">
                                    <option value="100">100g</option>
                                    <option value="200">200g</option>
                                    <option value="300">300g</option>
                                    <option value="400">400g</option>
                                    <option value="500">500g</option>
                                    <option value="1000">1000g</option>
                                </select>

                                <input type="number" name="qty" value="1" min="1" class="form-control" style="width:65px; display: inline-block;">

                                <button type="submit" class="btn-add-basket">
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