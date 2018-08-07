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

    public boolean sellTime() {
        Date now = new Date();
        boolean isBegin = true, isEnd = true;
        if (getBegin() != null && now.getTime() < getBegin().getTime()) isBegin = false;
        if (getEnd() != null && now.getTime() > getEnd().getTime()) isEnd = false;
        if (isBegin && isEnd) return true;
        else return false;
    }

    public double calculateDiscount() {
        double discount = getDiscount() / 10;
        return (double) Math.round(getPrice() * discount * 100) / 100;
    }

    // 判断是否享受折扣
    public boolean haveDiscount() {
        boolean isBegin = true, isEnd = true, isDiscount = true;
        Date now = new Date();
        if (getD_begin() != null && now.getTime() < getD_begin().getTime()) isBegin = false;
        if (getD_end() != null && now.getTime() > getD_end().getTime()) isEnd = false;
        if (getDiscount() <= 0) isDiscount = false;
        if (isBegin && isEnd && isDiscount) return true;
        else return false;
    }

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
        return (double) Math.round(price * 100) / 100;
    }

    public void setPrice(double price) {
        this.price = (double) Math.round(price * 100) / 100;
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
        // 折扣必须大于0 小于10
        if (discount < 0) return 0.1;
        if (discount > 10) return 10;
        return discount;
    }

    public void setDiscount(double discount) {
        // 折扣必须大于0 小于10
        if (discount < 0) discount = 0.1;
        if (discount > 10) discount = 10;
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