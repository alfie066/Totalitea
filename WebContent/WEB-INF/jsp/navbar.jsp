<nav class="navbar navbar-default navbar-fixed-top"
	style="background-color: #ffffff; border-bottom: 1px solid #eae6df; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.02);">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.jsp"
				style="color: #2c3e2b; font-weight: bold; font-family: Georgia, serif;">Totalitea</a>
		</div>

		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-left custom-spaced-links">
				<li><a href="index.jsp"
					style="color: #4a4a4a; font-weight: 500;">Home</a></li>
				<li><a href="products.jsp"
					style="color: #4a4a4a; font-weight: 500;">Products</a></li>
				<li><a href="ProductList"
					style="color: #4a4a4a; font-weight: 500;">Same products</a></li>
				<li><a href="basket.jsp"
					style="color: #4a4a4a; font-weight: 500;">Basket</a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right" style="margin-right: 0;">
				<li>
					<%-- Check if the session attribute "user" is null (User is NOT logged in) --%>
					<%
					if (session.getAttribute("user") == null) {
					%> <a href="login.jsp" style="padding: 0; background: transparent;">
						<button class="btn navbar-btn btn-md" type="button"
							style="margin-right: 15px; background-color: #2c3e2b; color: #ffffff; border: none; font-weight: 500; border-radius: 4px; padding: 6px 20px;">
							Login</button>
				</a> <%
 } else {
 %> <%-- If "user" exists in the session (User IS logged in) --%> <%-- FIXED: Changed 'LogoutServlet' to 'Logout' to match your servlet mapping --%>
					<a href="Logout" style="padding: 0; background: transparent;">
						<button class="btn navbar-btn btn-md" type="button"
							style="margin-right: 15px; background-color: #a94442; color: #ffffff; border: none; font-weight: 500; border-radius: 4px; padding: 6px 20px;">
							Logout</button>
				</a> <%
 }
 %>
				</li>
			</ul>

			<form action="SearchServlet" method="GET"
				class="navbar-form navbar-right">
				<div class="form-group">
					<input type="text" name="query" class="form-control"
						placeholder="Search products..."
						style="border-radius: 4px; border: 1px solid #ccc;">
				</div>
				<button type="submit" class="btn btn-default"
					style="border-radius: 4px;">Search</button>
			</form>

		</div>
	</div>
</nav>