package action;

import entity.Invoice;
import entity.Product;
import entity.User;

import java.text.SimpleDateFormat;
import java.util.Date;

public class InvoiceAction extends BaseAction {
    private int id;
    private Product product;
    private Invoice invoice;

    public String one() {
        Invoice tempInvoice = new Invoice();
        tempInvoice.setId(id);
        Invoice i = invoiceService.query(tempInvoice);
        if (i != null) {
            getJson().put("id", i.getId());
            getJson().put("name", i.getName());
            getJson().put("number", i.getNumber());
            getJson().put("price", i.getPrice());
            getJson().put("discount", i.getDiscount());
            getJson().put("buyer_id", i.getBuyer().getUser_id());
            getJson().put("buyer_name", i.getBuyer().getUser_name());
            getJson().put("begin", i.getBegin());
            getJson().put("end", i.getEnd());
            getJson().put("state", 0);
        } else {
            getJson().put("state", 1);
        }
        return "json";
    }

    /**
     * 用户购买某商品
     *
     * @return json串
     */
    public String buy() {
        User user = loginUser();
        if (user != null) {
            // 获取用户信息
            user = userService.getUser(user.getUser_id());
            // 获取商品信息
            Product p = productService.query(product);
            // 判断是否限购
            if (p.haveDefine()) {
                int count = invoiceService.countHaveProduct(p.getId(), user.getUser_id());
                if (!p.checkDefine(count)) {
                    getJson().put("state", -4);
                    return "json";
                }
            }
            // 判断时间是否正确
            if (!p.sellTime()) {
                getJson().put("state", -3);
                return "json";
            }
            // 判断折扣信息
            double price = p.getPrice();
            if (p.haveDiscount()) price = p.calculateDiscount();
            if (p.getNumber() < invoice.getNumber()) {
                getJson().put("state", -2);
                return "json";
            } else if (price < user.getUser_integral()) {
                Invoice i = new Invoice();
                i.setBegin(new Date());
                i.setNumber(invoice.getNumber());
                // 扣除积分
                double integral = user.getUser_integral() - price;
                user.setUser_integral(integral);
                userService.register(user);
                // 获取购买信息
                i.setProduct(p);
                i.setBuyer(user);
                i.setState(0);
                i.setEnd(new Date());
                // 记录商品信息
                i.setName(p.getName());
                i.setDescription(p.getDescription());
                i.setPrice(price);
                i.setDiscount(p.getDiscount());
                i.setFunction(p.getFunction());
                // 创建唯一ID
                String date;
                int tempId;
                Invoice tempInvoice = new Invoice();
                do {
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyymmss");
                    date = simpleDateFormat.format(new Date());
                    int randomNum = (int) (Math.random() * 89 + 10);
                    date += randomNum;
                    tempId = Integer.parseInt(date);
                    tempInvoice.setId(tempId);
                } while (invoiceService.query(tempInvoice) != null);
                i.setId(tempId);
                // 保存存根
                invoiceService.saveOrUpdate(i);
                // 货物减少
                p.setNumber(p.getNumber() - i.getNumber());
                productService.saveOrUpdate(p);
                getJson().put("i_id", tempId);
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

    public void setId(int id) {
        this.id = id;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public int getId() {
        return id;
    }

    public Product getProduct() {
        return product;
    }

    public Invoice getInvoice() {
        return invoice;
    }
}
