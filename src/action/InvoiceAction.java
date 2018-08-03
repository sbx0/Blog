package action;

import entity.Invoice;
import entity.Product;
import entity.User;
import service.InvoiceService;
import service.ProductService;
import service.UserService;

import java.util.Date;

public class InvoiceAction extends BaseAction {
    private InvoiceService invoiceService;
    private ProductService productService;
    private UserService userService;
    private int id;
    private Product product;
    private Invoice invoice;

    public String buy() {
        User user = (User) getSession().get("user");
        if (user != null) {
            // 获取用户信息
            user = userService.getUser(user.getUser_id());
            // 获取商品信息
            Product p = productService.query(product);
            if ((p.getPrice() * 1) < user.getUser_integral()) {
                Invoice invoice = new Invoice();
                invoice.setNumber(1);
                invoice.setBegin(new Date());
                // 扣除积分
                double integral = user.getUser_integral() - (p.getPrice() * invoice.getNumber());
                user.setUser_integral(integral);
                userService.register(user);
                // 获取购买信息
                invoice.setProduct(p);
                invoice.setBuyer(user);
                invoice.setState(0);
                invoice.setEnd(new Date());
                // 记录商品信息
                invoice.setName(p.getName());
                invoice.setDescription(p.getDescription());
                invoice.setPrice(p.getPrice());
                invoice.setDiscount(p.getDiscount());
                invoice.setFunction(p.getFunction());
                // 保存存根
                invoiceService.saveOrUpdate(invoice);
                // 货物减少
                p.setNumber(p.getNumber() - invoice.getNumber());
                productService.saveOrUpdate(p);
                getJson().put("state", 0);
            } else {
                getJson().put("state", -1);
            }
        } else {
            getJson().put("state", 1);
        }
        return "json";
    }

    public String want() {
        return "json";
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setProductService(ProductService productService) {
        this.productService = productService;
    }

    public void setInvoiceService(InvoiceService invoiceService) {
        this.invoiceService = invoiceService;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }
}
