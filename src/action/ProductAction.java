package action;

import entity.Product;
import entity.User;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.util.List;

/**
 * 产品类Action
 *
 * @author 汪恒
 * @author blog.ducsr.cn
 */
public class ProductAction extends BaseAction {
    /**
     * 页面传递过来的id
     */
    private int id;
    /**
     * 页面传递过来的产品类
     */
    private Product product;

    /**
     * 获取某个产品信息
     *
     * @return json串
     */
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
            // 符合打折条件 计算打折价格
            if (p.haveDiscount()) jProduct.put("d_price", p.calculateDiscount());
            getJson().put("product", jProduct);
            getJson().put("state", 0);
        } else {
            // 商品不存在
            getJson().put("state", 1);
        }
        return "json";
    }

    /**
     * 添加新商品 或 修改旧商品
     *
     * @return json串
     */
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

    /**
     * 获取商品列表
     *
     * @return json串
     */
    public String get() {
        User user = (User) getSession().get("user");
        List<Product> products = productService.query();
        JSONArray jProducts = new JSONArray();
        for (int i = 0; i < products.size(); i++) {
            JSONObject jProduct = new JSONObject();
            jProduct.put("id", products.get(i).getId());
            jProduct.put("name", products.get(i).getName());
            jProduct.put("price", products.get(i).getPrice());
            // 判断是否符合打折条件
            if (products.get(i).haveDiscount()) {
                jProduct.put("discount", products.get(i).getDiscount());
                jProduct.put("price", products.get(i).calculateDiscount());
            } else jProduct.put("price", products.get(i).getPrice());
            jProduct.put("number", products.get(i).getNumber());
            jProduct.put("seller_id", products.get(i).getSeller().getUser_id());
            jProduct.put("seller_name", products.get(i).getSeller().getUser_name());
            jProducts.element(jProduct);
        }
        if (jProducts.size() > 0) {
            getJson().put("products", jProducts);
            // 获取用户积分存入json串中
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

    public void setId(int id) {
        this.id = id;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getId() {
        return id;
    }

    public Product getProduct() {
        return product;
    }

}
