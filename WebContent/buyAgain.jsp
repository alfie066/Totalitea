<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.DbConnector" %>
<%@ page import="java.text.DecimalFormat" %>

<!doctype html>
<html>
<head>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<title>Buy Again</title>
</head>
<body>

<%@include file="WEB-INF/jsp/navbar.jsp" %>

<%
    // ✅ DO NOT redeclare currentUser (navbar already has it)

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
%>

<div class="container-fluid">
    <main class="col-md-12">
        <h1>Buy Again</h1>

        <section class="row text-center placeholders">
            <p>Reorder your favourite drinks quickly and easily.</p>
        </section>

        <h2>Previous Orders</h2>

        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price (100g)</th>
                        <th>Size</th>
                        <th>Quantity</th>
                        <th></th>
                    </tr>
                </thead>

                <tbody>
                
                <%
DecimalFormat df = new DecimalFormat("0.00");
%>

<%
    while (rs.next()) {
%>

<tr>
    <td><%= rs.getString("Name") %></td>
    <td><%= rs.getString("Description") %></td>
	<td>£<%= df.format(rs.getInt("PriceInPencePer100g") / 100.0) %></td>

    <td colspan="3">

        <form action="<%= request.getContextPath() %>/AddToBasket"
              method="post"
              style="display:flex; gap:8px; align-items:center;">

            <!-- ✅ correct product ID -->
            <input type="hidden" name="pid" value="<%= rs.getInt("productId") %>">

            <!-- grams (pre-selected from previous order) -->
            <select name="grams" class="form-control" style="width:auto;">
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

            <!-- quantity -->
            <input type="number" name="qty" value="1" min="1"
                   class="form-control" style="width:70px;">

            <button type="submit" class="btn btn-success btn-sm">
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