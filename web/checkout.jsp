<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thank You</title>
    <link rel="stylesheet" href="styles/main.css" type="text/css"/>
    <style>
        .checkout-container {
            max-width: 800px;
            margin: 0 auto;
            text-align: center;
        }
        .thank-you-message {
            margin: 30px 0;
            padding: 20px;
            background: #f0f8f0;
            border-radius: 5px;
        }
        .thank-you-message h3 {
            color: #2c5f2d;
            font-size: 1.5em;
            margin-bottom: 10px;
        }
        .order-summary {
            margin: 30px 0;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 5px;
        }
        .order-summary h3 {
            color: #333;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
        }
        .order-total {
            font-size: 1.3em;
            font-weight: bold;
            color: #2c5f2d;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 2px solid #ddd;
        }
        .action-button {
            margin-top: 30px;
        }
    </style>
</head>
<body>

    <main class="container checkout-container">
        <h2 class="page-title">Order Complete</h2>

        <div class="thank-you-message">
            <h3>Thank you for your purchase!</h3>
            <p>Your order has been received and will be processed shortly.</p>
        </div>

        <div class="order-summary">
            <h3>Your Order</h3>
            <table class="cd-table">
                <thead>
                    <tr>
                        <th style="text-align: left;">Product</th>
                        <th style="text-align: center;">Quantity</th>
                        <th style="text-align: right;">Price</th>
                        <th style="text-align: right;">Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${cart.items}">
                        <tr>
                            <td style="text-align: left;">${item.product.description}</td>
                            <td style="text-align: center;">${item.quantity}</td>
                            <td style="text-align: right;" class="price">${item.product.priceCurrencyFormat}</td>
                            <td style="text-align: right;" class="price">${item.totalCurrencyFormat}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="order-total">
                Total: <span class="price">${cart.totalCurrencyFormat}</span>
            </div>
        </div>

        <div class="action-button">
            <form action="index.html" method="get">
                <button type="submit">Continue Shopping</button>
            </form>
        </div>

        <%
            // Xóa giỏ hàng sau khi hoàn tất đơn hàng
            session.removeAttribute("cart");
        %>
    </main>

</body>
</html>
