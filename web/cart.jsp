<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Cart" %>
<%@ page import="model.LineItem" %>
<%@ page import="java.util.List" %>

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
                <% 
                    // 1. Lấy giỏ hàng từ Session bằng Java thuần
                    Cart cart = (Cart) session.getAttribute("cart");
                    
                    // 2. Kiểm tra giỏ hàng trống
                    if (cart == null || cart.getItems().isEmpty()) {
                %>
                    <tr>
                        <td colspan="5" style="text-align:center; padding: 20px;">
                            Your cart is empty.
                        </td>
                    </tr>
                <% 
                    } else {
                        // 3. Vòng lặp Java thuần (Thay thế cho c:forEach)
                        List<LineItem> items = cart.getItems();
                        for (LineItem item : items) {
                %>
                    <tr>
                        <td>
                            <form action="addToCart" method="post">
                                <input type="hidden" name="productCode" value="<%= item.getProduct().getCode() %>">
                                <input type="text" class="qty-input" name="quantity" value="<%= item.getQuantity() %>">
                                <button type="submit">Update</button>
                            </form>
                        </td>
                        
                        <td class="cart-desc-col"><%= item.getProduct().getDescription() %></td>
                        
                        <td class="price"><%= item.getProduct().getPriceCurrencyFormat() %></td>
                        
                        <td class="price"><%= item.getTotalCurrencyFormat() %></td>
                        
                        <td>
                            <form action="addToCart" method="post">
                                <input type="hidden" name="productCode" value="<%= item.getProduct().getCode() %>">
                                <input type="hidden" name="quantity" value="0">
                                <button type="submit">Remove Item</button>
                            </form>
                        </td>
                    </tr>
                <% 
                        } // Kết thúc vòng for
                    } // Kết thúc else
                %>
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