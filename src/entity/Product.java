package entity;

import java.util.Date;

// 商品
public class Product {
    private int id; // 编号
    private String name; // 名称
    private String description; // 简介
    private User seller; // 卖家

    private int number; // 存货
    private int define; // 限制购买数
    private int authority; // 购买权限

    private double price; // 价格
    private Date begin; // 开始贩卖时间
    private Date end; // 结束贩卖时间

    private double discount; // 折扣
    private Date d_begin; // 折扣开始时间
    private Date d_end; // 折扣结束时间

    private String function; // 功能

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public User getSeller() {
        return seller;
    }

    public void setSeller(User seller) {
        this.seller = seller;
    }

    public int getDefine() {
        return define;
    }

    public void setDefine(int limit) {
        this.define = limit;
    }

    public int getAuthority() {
        return authority;
    }

    public void setAuthority(int authority) {
        this.authority = authority;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
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

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public Date getD_begin() {
        return d_begin;
    }

    public void setD_begin(Date d_begin) {
        this.d_begin = d_begin;
    }

    public Date getD_end() {
        return d_end;
    }

    public void setD_end(Date d_end) {
        this.d_end = d_end;
    }

    public String getFunction() {
        return function;
    }

    public void setFunction(String function) {
        this.function = function;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }
}