<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ page import ="model.Product" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="util.ProductHandler" %> 
   
<!doctype html>
<html>
<head>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" >
<link href="css/style.css" rel="stylesheet" >
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<title>Project example - products</title>
</head>
<body>

    <%@include file="WEB-INF/jsp/navbar.jsp" %>
    
<div class="container-fluid">
        <main class="col-sm-9 offset-sm-3 col-md-10 offset-md-2 pt-3">
          <h1>Products</h1>
          <section class="row text-center placeholders">
            <p>Welcome to Totalitea – explore our premium selection of teas and coffees from around the world. Each product is carefully sourced to bring you the best flavour and quality.</p>
			<p>Select your preferred quantity and weight before adding items to your basket. Whether you're after a smooth morning coffee or a calming evening tea, we’ve got you covered.</p>
          </section>

          
			<%
			String query = (String) request.getAttribute("query");
			if (query != null && !query.isEmpty()) {
			%>
			    <p>Showing results for: <strong><%= query %></strong></p>
			<%
			}
			%>
			
			<h2>All products</h2>
			<div class="table-responsive">

            <table class="table table-striped">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Description</th>
                  <th>Price</th>
                  <th>Size (grams)</th>
                  <th>Quantity</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
<%
ArrayList<Product> products = (ArrayList<Product>) request.getAttribute("products");

if (products == null) {
    products = ProductHandler.getProducts();
}

for(Product p : products) {
%>
<tr class="prod p<%= p.getId() %>">

    <td><%= p.getName() %></td>
    <td><%= p.getDescription() %></td>
    <td><%= p.getFormattedPrice() %></td>

    <!-- Put EVERYTHING form-related inside ONE cell -->
    <td colspan="3">

        <form action="/Totalitea/AddToBasket" method="post" style="margin:0;">

            <select name="grams" class="form-control"
                    style="display:inline-block; width:auto;">
                <option value="100">100g</option>
                <option value="200">200g</option>
                <option value="300">300g</option>
                <option value="500">500g</option>
                <option value="1000">1000g</option>
            </select>

            <input type="number" name="qty" value="1" min="1"
                   class="form-control"
                   style="display:inline-block; width:70px; margin-left:5px;">

            <input type="hidden" name="pid" value="<%= p.getId() %>">

            <button type="submit" class="btn btn-primary btn-sm"
                    style="display:inline-block; margin-left:5px;">
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
        </main>
      </div>

<script src="https://code.jquery.com/jquery-1.12.4.min.js" type ="text/javascript"> </script >
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" > </script >
</body>
</html>