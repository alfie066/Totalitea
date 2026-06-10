<%@ page language="java" %>

<html>
<head>
    <title>Checkout</title>
</head>
<body>

<h1>Enter Payment Details</h1>

<form action="<%= request.getContextPath() %>/ProcessOrder" method="post">


    <label>Name on Card:</label>
    <input type="text" name="cardName" required><br><br>

    <label>Card Number:</label>
    <input type="text" name="cardNumber" required><br><br>

    <label>Expiry Date:</label>
    <input type="text" name="expiry" placeholder="MM/YY" required><br><br>

    <label>CVV:</label>
    <input type="password" name="cvv" required><br><br>

    <button type="submit">Pay Now</button>

</form>

</body>
</html>