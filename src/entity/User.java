package entity;

import java.util.Date;

/*
 * 用户实体类
 */
public class User {
    private Integer user_id; // ID
    private String user_name; // 用户名
    private String user_email; // 邮箱
    private String user_password; // 密码
    private Integer user_is_admin; // 0 为用户 1为管理员
    private Date user_register_time; // 注册时间
    private Date user_birthday; // 生日
    private String user_signature; // 签名
    private Double user_integral; // 积分

    // 判断用户权限
    public boolean authority() {
        if (user_is_admin < 0) return true;
        else return false;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getUser_email() {
        return user_email;
    }

    public void setUser_email(String user_email) {
        this.user_email = user_email;
    }

    public String getUser_password() {
        return user_password;
    }

    public void setUser_password(String user_password) {
        this.user_password = user_password;
    }

    public Integer getUser_is_admin() {
        return user_is_admin;
    }

    public void setUser_is_admin(Integer user_is_admin) {
        this.user_is_admin = user_is_admin;
    }

    public Date getUser_register_time() {
        return user_register_time;
    }

    public void setUser_register_time(Date user_register_time) {
        this.user_register_time = user_register_time;
    }

    public Date getUser_birthday() {
        return user_birthday;
    }

    public void setUser_birthday(Date user_birthday) {
        this.user_birthday = user_birthday;
    }

    public String getUser_signature() {
        return user_signature;
    }

    public void setUser_signature(String user_signature) {
        this.user_signature = user_signature;
    }

    public Double getUser_integral() {
        return (double) Math.round(user_integral * 100) / 100;
    }

    public void setUser_integral(Double user_integral) {
        this.user_integral = (double) Math.round(user_integral * 100) / 100;
    }
}
