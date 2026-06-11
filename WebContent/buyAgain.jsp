<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.DbConnector" %>
<%@ page import="java.text.DecimalFormat" %>

<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Totalitea - Buy Again</title>
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

    <%@include file="WEB-INF/jsp/navbar.jsp" %>

<%
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = currentUser.getID();
    Connection conn = DbConnector.getConnection();

    String sql =
            "SELECT " +
            "p.Id AS productId, " +
            "p.Name, " +
            "p.Description, " +
            "oi.PriceInPencePer100g, " +
            "oi.Grams, " +
            "SUM(oi.Quantity) AS Quantity, " +
            "MAX(o.PlacedAt) AS LastPlacedAt " +
            "FROM OrderItem oi " +
            "JOIN Orders o ON oi.OrderId = o.Id " +
            "JOIN Product p ON oi.ProductId = p.Id " +
            "WHERE o.UserId = ? " +
            "AND o.Status = 'PAID' " +
            "GROUP BY p.Id, oi.Grams, p.Name, p.Description, oi.PriceInPencePer100g " +
            "ORDER BY LastPlacedAt DESC";

    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setInt(1, userId);
    ResultSet rs = ps.executeQuery();
    DecimalFormat df = new DecimalFormat("0.00");
%>

<div class="container">
    <main class="col-md-12">

        <div class="products-banner">
            <h1>Buy Again</h1>
            <p>Reorder your favourite drinks quickly and easily.</p>
        </div>

        <h2 class="section-title">Previous Orders</h2>

        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th style="width: 15%;">Name</th>
                        <th style="width: 45%;">Description</th>
                        <th style="width: 15%;">Price (100g)</th>
                        <th colspan="3" style="width: 25%; text-align: center;">Purchase Options</th>
                    </tr>
                </thead>
                <tbody>
<%
    while (rs.next()) {
%>
                <tr class="prod p<%= rs.getInt("productId") %>">
                    <td style="font-weight: 600; color: #2c3e2b;"><%= rs.getString("Name") %></td>
                    <td class="product-desc"><%= rs.getString("Description") %></td>
                    <td class="product-price">£<%= df.format(rs.getInt("PriceInPencePer100g") / 100.0) %></td>

                    <td colspan="3">
                        <form action="<%= request.getContextPath() %>/AddToBasket" method="post" style="display:flex; gap:8px; align-items:center; justify-content: center;">

                            <input type="hidden" name="pid" value="<%= rs.getInt("productId") %>">

                            <select name="grams" class="form-control" style="width:130px; display: inline-block;">
                                <option value="<%= rs.getInt("Grams") %>">
                                    <%= rs.getInt("Grams") %>g (previous)
                                </option>
                                <option value="100">100g</option>
                                <option value="200">200g</option>
                                <option value="300">300g</option>
                                <option value="400">400g</option>
                                <option value="500">500g</option>
                                <option value="1000">1000g</option>
                            </select>

                            <input type="number" name="qty" value="1" min="1" class="form-control" style="width:65px; display: inline-block;">

                            <button type="submit" class="btn-add-basket">
                                Buy again
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
    </main>
</div>

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</body>
</html>