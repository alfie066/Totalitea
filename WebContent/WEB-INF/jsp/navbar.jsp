<%@ page import="model.User" %>

<%
    User currentUser = (User) session.getAttribute("user");
%>

<nav class="navbar navbar-default navbar-fixed-top"
...
	style="background-color: #ffffff; border-bottom: 1px solid #eae6df; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.02); padding: 5px 0;">
	<div class="container-fluid" style="display: flex; align-items: center; justify-content: space-between; flex-wrap: nowrap;">
		
		<div class="navbar-header" style="display: flex; align-items: center;">
			<a class="navbar-brand" href="index.jsp"
				style="color: #2c3e2b; font-weight: bold; font-family: Georgia, serif; font-size: 22px; height: auto; padding: 10px 15px;">Totalitea</a>
		</div>

		<div id="navbar" style="display: flex; align-items: center; justify-content: space-between; width: 100%; margin-left: 10px;">
			
			<ul class="nav navbar-nav" style="display: flex; flex-direction: row; margin: 0; padding-left: 0; list-style: none;">
				<li><a href="index.jsp" style="color: #4a4a4a; font-weight: 500; padding: 10px 15px;">Home</a></li>
				<li><a href="products.jsp" style="color: #4a4a4a; font-weight: 500; padding: 10px 15px;">Products</a></li>
				<li><a href="products.jsp" style="color: #4a4a4a; font-weight: 500; padding: 10px 15px;">Buy again</a></li>
				<li><a href="basket.jsp" style="color: #4a4a4a; font-weight: 500; padding: 10px 15px;">Basket</a></li>
			</ul>

			<ul class="nav navbar-nav" style="display: flex; flex-direction: row; align-items: center; margin: 0; list-style: none;">
				
				<li style="margin-right: 20px;">
					<form action="SearchServlet" method="GET" style="margin: 0; display: flex; gap: 8px;">
						<div class="form-group" style="margin: 0; width: 220px;">
							<input type="text" name="query" class="form-control"
								placeholder="Search products..."
								style="border-radius: 4px; border: 1px solid #ccc; padding: 6px 12px; width: 100%; height: 36px; box-shadow: none;">
						</div>
						<button type="submit" class="btn btn-default"
							style="border-radius: 4px; height: 36px; padding: 6px 16px;">Search</button>
					</form>
				</li>

				<% if (currentUser == null) { %> 
					<li>
						<a href="login.jsp" style="padding: 0;">
							<button class="btn" type="button"
								style="background-color: #2c3e2b; color: #ffffff; border: none; font-weight: 500; border-radius: 4px; padding: 6px 22px; height: 36px;">
								Login
							</button>
						</a> 
					</li>
				<% } else { %> 
					<li style="display: flex; align-items: center;">
						<span style="color: #2c3e2b; font-weight: 600; margin-right: 15px; font-size: 14px; white-space: nowrap;">
							Hello, <%= currentUser.getName() %>!
						</span>
					</li>
					<li>
						<a href="Logout" style="padding: 0;">
							<button class="btn" type="button"
								style="background-color: #a94442; color: #ffffff; border: none; font-weight: 500; border-radius: 4px; padding: 6px 20px; height: 36px;">
								Logout
							</button>
						</a> 
					</li>
				<% } %>
			</ul>

		</div>
	</div>
</nav>