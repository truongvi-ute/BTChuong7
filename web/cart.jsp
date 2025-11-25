<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart</title>
    <link rel="stylesheet" href="styles/main.css" type="text/css"/>
    <style>
        .qty-input { width: 40px; padding: 3px; margin-right: 5px; text-align: center; }
        .cart-desc-col { text-align: left; }
        .cart-actions { margin-top: 20px; }
        .cart-actions button { margin-right: 10px; }
        td form { display: inline-block; margin: 0; }
    </style>
</head>
<body>

    <main class="container">
        <h2 class="page-title">Your cart</h2>

        <table class="cd-table">
            <thead>
                <tr>
                    <th>Quantity</th>
                    <th class="cart-desc-col">Description</th>
                    <th>Price</th>
                    <th>Amount</th>
                    <th></th> 
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty cart || empty cart.items}">
                        <tr>
                            <td colspan="5" style="text-align:center; padding: 20px;">
                                Your cart is empty.
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${cart.items}">
                            <tr>
                                <td>
                                    <form action="addToCart" method="post">
                                        <input type="hidden" name="productCode" value="${item.product.code}">
                                        <input type="text" class="qty-input" name="quantity" value="${item.quantity}">
                                        <button type="submit">Update</button>
                                    </form>
                                </td>
                                
                                <td class="cart-desc-col">${item.product.description}</td>
                                
                                <td class="price">${item.product.priceCurrencyFormat}</td>
                                
                                <td class="price">${item.totalCurrencyFormat}</td>
                                
                                <td>
                                    <form action="addToCart" method="post">
                                        <input type="hidden" name="productCode" value="${item.product.code}">
                                        <input type="hidden" name="quantity" value="0">
                                        <button type="submit">Remove Item</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <div class="cart-instructions">
            <p>To change the quantity, enter the new quantity and click on the Update button.</p>
        </div>

        <div class="cart-actions">
            <form action="index.html" method="get" style="display: inline;">
                <button type="submit">Continue Shopping</button>
            </form>

            <form action="checkout" method="post" style="display: inline;">
                <button type="submit">Checkout</button>
            </form>
        </div>
    </main>

</body>
</html>