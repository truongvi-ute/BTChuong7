package model;

import java.io.Serializable;
import java.text.NumberFormat;
import java.util.Locale;

public class LineItem implements Serializable {
    
    private Product product;
    private int quantity;

    public LineItem() {
        this.product = new Product();
        this.quantity = 0;
    }

    public LineItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    // Getters and Setters
    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    // Tính tổng tiền của dòng này (Giá * Số lượng)
    public double getTotal() {
        return product.getPrice() * quantity;
    }

    // Helper: Định dạng tổng tiền thành chuỗi (VD: $29.90)
    public String getTotalCurrencyFormat() {
        NumberFormat currency = NumberFormat.getCurrencyInstance(Locale.US);
        return currency.format(this.getTotal());
    }
}