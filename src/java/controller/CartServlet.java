package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Cart;
import model.LineItem;
import model.Product;

@WebServlet("/addToCart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String url = "/index.html";
        
        String productCode = request.getParameter("productCode");
        String quantityString = request.getParameter("quantity");

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
        }

        // Tìm sản phẩm (Giữ nguyên switch-case)
        Product product = null;
        if (productCode != null) {
            switch (productCode) {
                case "8601": product = new Product("8601", "86 (the band) - True Life Songs and Pictures", 14.95); break;
                case "pf01": product = new Product("pf01", "Paddlefoot - The first CD", 12.95); break;
                case "pf02": product = new Product("pf02", "Paddlefoot - The second CD", 14.95); break;
                case "jr01": product = new Product("jr01", "Joe Rut - Genuine Wood Grained Finish", 14.95); break;
                default: product = null; break;
            }
        }

        if (product != null) {
            url = "/cart.jsp"; 

            // LOGIC XỬ LÝ SỐ LƯỢNG
            if (quantityString != null) {
                int quantityInput;
                try {
                    quantityInput = Integer.parseInt(quantityString);
                } catch (NumberFormatException e) {
                    quantityInput = 1;
                }

                if (quantityInput > 0) {
                    // 1. TRƯỜNG HỢP UPDATE (Người dùng nhập số cụ thể: 2, 5, 10...)
                    // Cập nhật đúng số lượng đó
                    LineItem item = new LineItem(product, quantityInput);
                    cart.addItem(item); 
                } else {
                    // 2. TRƯỜNG HỢP REMOVE/GIẢM (Nút Remove gửi số 0)
                    // Yêu cầu: Giảm 1 đơn vị. Nếu về 0 thì xóa.
                    
                    // Bước A: Phải tìm xem sản phẩm này đang có bao nhiêu cái trong giỏ?
                    LineItem existingItem = null;
                    for (LineItem item : cart.getItems()) {
                        if (item.getProduct().getCode().equals(productCode)) {
                            existingItem = item;
                            break;
                        }
                    }

                    // Bước B: Tính toán trừ đi 1
                    if (existingItem != null) {
                        int currentQty = existingItem.getQuantity();
                        int newQty = currentQty - 1;

                        if (newQty > 0) {
                            // Nếu vẫn còn > 0 thì cập nhật số lượng mới
                            existingItem.setQuantity(newQty);
                        } else {
                            // Nếu = 0 thì xóa hẳn khỏi giỏ
                            cart.removeItem(existingItem);
                        }
                    }
                }
            } else {
                // 3. TRƯỜNG HỢP ADD NEW (Từ trang chủ)
                // Logic cũ: setQuantity(1). 
                // Nếu muốn thông minh hơn (cộng dồn khi bấm Add nhiều lần):
                LineItem existingItem = null;
                for (LineItem item : cart.getItems()) {
                    if (item.getProduct().getCode().equals(productCode)) {
                        existingItem = item;
                        break;
                    }
                }
                
                if (existingItem != null) {
                    // Nếu đã có -> Tăng thêm 1
                    existingItem.setQuantity(existingItem.getQuantity() + 1);
                } else {
                    // Nếu chưa có -> Thêm mới số lượng 1
                    LineItem item = new LineItem(product, 1);
                    cart.addItem(item);
                }
            }
        }

        session.setAttribute("cart", cart);
        getServletContext().getRequestDispatcher(url).forward(request, response);
    }
}