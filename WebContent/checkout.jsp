<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout - Totalitea</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <style>
        body {
            background-color: #fcfbfa;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            padding-top: 90px; /* Prevents fixed navbar from overlapping content */
        }
        .checkout-card {
            background: #ffffff;
            border: 1px solid #eae6df;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
            padding: 30px;
            margin-top: 30px;
            margin-bottom: 50px;
        }
        .checkout-title {
            font-family: Georgia, serif;
            color: #2c3e2b;
            font-weight: bold;
            margin-bottom: 25px;
            text-align: center;
        }
        .form-control:focus {
            border-color: #2c3e2b;
            box-shadow: none;
        }
        .btn-pay {
            background-color: #2c3e2b;
            color: #ffffff;
            border: none;
            font-weight: 500;
            border-radius: 4px;
            height: 44px;
            font-size: 16px;
            width: 100%;
            margin-top: 15px;
            transition: background-color 0.2s ease;
        }
        .btn-pay:hover {
            background-color: #1e2b1e;
            color: #ffffff;
        }
    </style>
</head>
<body>

<jsp:include page="WEB-INF/jsp/navbar.jsp" />

<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            
            <div class="checkout-card">
                <h2 class="checkout-title">Secure Checkout</h2>
                
                <form action="<%= request.getContextPath() %>/ProcessOrder" method="post">
                    
                    <div class="form-group">
                        <label style="color: #4a4a4a; font-weight: 500;">Name on Card</label>
                        <input type="text" name="nameOnCard" class="form-control" 
                               placeholder="e.g. Bob Smith" required style="height: 40px;">
                    </div>

                    <div class="form-group">
                        <label style="color: #4a4a4a; font-weight: 500;">Card Number</label>
                        <input type="text" name="cardNumber" class="form-control" 
                               placeholder="•••• •••• •••• ••••" required style="height: 40px;">
                    </div>

                    <div class="row">
                        <div class="col-xs-6">
                            <div class="form-group">
                                <label style="color: #4a4a4a; font-weight: 500;">Expiry Date</label>
                                <input type="month" name="expiry" class="form-control"
       							required style="height: 40px;">
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <div class="form-group">
                                <label style="color: #4a4a4a; font-weight: 500;">CVV</label>
                                <input type="password" name="cvv" class="form-control"
							       maxlength="4"
							       pattern="[0-9]{3,4}"
							       inputmode="numeric"
							       required
							       style="height: 40px;">
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-pay">
                        Pay Securely Now
                    </button>
                    
                </form>
            </div>

        </div>
    </div>
</div>

</body>
</html>