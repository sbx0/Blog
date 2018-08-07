package entity;

import java.util.Date;

// 发票
public class Invoice {
    private int id; // 编号
    private Product product; // 产品
    private int number; // 数量
    private User buyer; // 买家
    private Date begin; // 购买时间
    private Date end; // 成交时间
    private int state; // 状态 0 用户存根 1 购物车 2 待付款 3 未使用 -1 失败

    // 成交时商品信息备份
    private String name; // 名称
    private String description; // 简介
    private double price; // 价格
    private double discount; // 折扣
    private String function; // 功能

    public int getId() {
        return id;
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

    public int getNumber() {
        if (number < 0) return 1;
        if (number > 100) return 100;
        return number;
    }

    public void setNumber(int number) {
        if (number < 0) number = 1;
        if (number > 100) number = 100;
        this.number = number;
    }

    public User getBuyer() {
        return buyer;
    }

    public void setBuyer(User buyer) {
        this.buyer = buyer;
    }

    public Date getBegin() {
        return begin;
    }

    public void setBegin(Date begin) {
        this.begin = begin;
    }

    public Date getEnd() {
        return end;
    }

    public void setEnd(Date end) {
        this.end = end;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public String getFunction() {
        return function;
    }

    public void setFunction(String function) {
        this.function = function;
    }
}
