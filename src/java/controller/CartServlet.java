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
//        System.out.println("ProductCode: "+ productCode);
//        System.out.println("Quantity: "+quantityString);

        HttpSession session = request.getSession();
        synchronized(session) {
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
            }

            // Tìm sản phẩm (Giữ nguyên switch-case)
            Product product = null;

            if (productCode != null) {
                product = switch (productCode) {
                    case "8601" -> new Product("8601", "86 (the band) - True Life Songs and Pictures", 14.95);
                    case "pf01" -> new Product("pf01", "Paddlefoot - The first CD", 12.95);
                    case "pf02" -> new Product("pf02", "Paddlefoot - The second CD", 14.95);
                    case "jr01" -> new Product("jr01", "Joe Rut - Genuine Wood Grained Finish", 14.95);
                    default -> null;
                };
            }

            if (product != null) {
                url = "/cart.jsp"; 
                LineItem curLineItem = null;
                for (LineItem i : cart.getItems())
                {
                    if(product.getCode().equals(i.getProduct().getCode()))
                    {
                        curLineItem = i;
                        break;
                    }
                }
                // Xử lí khi thêm sản phẩm từ trang html
                if (quantityString == null){
                    // nếu đã có trong cart
                    if(curLineItem != null)
                    {
                        curLineItem.setQuantity(curLineItem.getQuantity()+1);                
                    }
                    // nếu chưa có trong cart
                    else
                    {
                        curLineItem = new LineItem (product, 1);
                        cart.addItem(curLineItem);
                    }
                }
                else    // Xử lí khi update số lượng hoặc xóa sản phẩm
                {
                    int intQuantity;
                    try {
                        intQuantity = Integer.parseInt(quantityString);
                    } catch (NumberFormatException e) {
                        intQuantity = 1; // Mặc định là 1 nếu lỗi
                    }

                    if (intQuantity <= 0)   //thực hiện xóa
                    {
                        cart.removeItem(curLineItem);
                    }
                    else    //thực hiện update
                    {
                        if (curLineItem != null) {
                            curLineItem.setQuantity(intQuantity);
                        }
                    }
                }
            }
            session.setAttribute("cart", cart);
        }
        getServletContext().getRequestDispatcher(url).forward(request, response);
    }
}