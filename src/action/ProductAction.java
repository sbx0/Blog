package action;

import entity.Product;
import entity.User;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import service.ProductService;
import service.UserService;

import java.util.Date;
import java.util.List;

public class ProductAction extends BaseAction {
    private int id;
    private ProductService productService;
    private UserService userService;
    private Product product;

    // 获取一个商品
    public String one() {
        Product p = new Product();
        p.setId(id);
        p = productService.query(p);
        if (p.getName() != null) {
            JSONObject jProduct = new JSONObject();
            jProduct.put("id", p.getId());
            jProduct.put("name", p.getName());
            jProduct.put("price", p.getPrice());
            jProduct.put("number", p.getNumber());
            jProduct.put("desc", p.getDescription());
            jProduct.put("define", p.getDefine());
            jProduct.put("begin", p.getBegin());
            jProduct.put("end", p.getEnd());
            jProduct.put("discount", p.getDiscount());
            jProduct.put("d_begin", p.getD_begin());
            jProduct.put("d_end", p.getD_end());
            jProduct.put("function", p.getFunction());
            // 判断折扣信息
            double price = p.getPrice();
            Date now = new Date();
            boolean isBegin = true, isEnd = true;
            if (p.getD_begin() != null) {
                if (now.getTime() < p.getD_begin().getTime()) {
                    isBegin = false;
                }
            }
            if (p.getD_end() != null) {
                if (now.getTime() > p.getD_end().getTime()) {
                    isEnd = false;
                }
            }
            if (isBegin && isEnd && p.getDiscount() != 0.0) {
                if (p.getDiscount() < 1 || p.getDiscount() > 10) p.setDiscount(9);
                double discount = p.getDiscount() / 10;
                price = price * discount;
                price = (double) Math.round(price * 100) / 100;
                jProduct.put("d_price", price);
            }
            getJson().put("product", jProduct);
            getJson().put("state", 0);
        } else {
            getJson().put("state", 1);
        }
        return "json";
    }

    // 添加商品
    public String add() {
        User user = (User) getSession().get("user");
        if (user != null && user.getUser_is_admin() == 1) {
            product.setAuthority(0);
            product.setSeller(user);
            productService.saveOrUpdate(product);
            getJson().put("state", 0);
        } else {
            getJson().put("state", 1);
        }
        return "json";
    }

    // 获取全部商品
    public String get() {
        User user = (User) getSession().get("user");
        List<Product> products = productService.query();
        JSONArray jProducts = new JSONArray();
        for (int i = 0; i < products.size(); i++) {
            JSONObject jProduct = new JSONObject();
            jProduct.put("id", products.get(i).getId());
            jProduct.put("name", products.get(i).getName());
            jProduct.put("price", products.get(i).getPrice());
            jProduct.put("number", products.get(i).getNumber());
            jProduct.put("seller_id", products.get(i).getSeller().getUser_id());
            jProduct.put("seller_name", products.get(i).getSeller().getUser_name());
            jProducts.element(jProduct);
        }
        if (jProducts.size() > 0) {
            getJson().put("products", jProducts);
            if (user != null) {
                user = userService.getUser(user.getUser_id());
                getJson().put("integral", user.getUser_integral());
            } else {
                getJson().put("integral", "未登录");
            }
            getJson().put("state", 0);
        } else getJson().put("state", 1);
        return "json";
    }

    public void setProductService(ProductService productService) {
        this.productService = productService;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
}