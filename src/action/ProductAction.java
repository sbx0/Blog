package action;

import entity.Product;
import entity.User;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import service.ProductService;

import java.util.List;

public class ProductAction extends BaseAction {
    private int id;
    private ProductService productService;
    private Product product;

    public String add() {
        User user = (User) getSession().get("user");
        if (user != null && user.getUser_is_admin() == 1) {
            product.setSeller(user);
            product.setFunction("active");
            productService.saveOrUpdate(product);
            getJson().put("state", 0);
        } else {
            getJson().put("state", 1);
        }
        return "json";
    }

    public String get() {
        List<Product> products = productService.query();
        JSONArray jProducts = new JSONArray();
        for (int i = 0; i < products.size(); i++) {
            JSONObject jProduct = new JSONObject();
            jProduct.put("name", products.get(i).getName());
            jProduct.put("price", products.get(i).getPrice());
            jProduct.put("seller_id", products.get(i).getSeller().getUser_id());
            jProduct.put("seller_name", products.get(i).getSeller().getUser_name());
            jProducts.element(jProduct);
        }
        if (jProducts.size() > 0) {
            getJson().put("products", jProducts);
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
}
