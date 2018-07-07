package entity;

import java.util.Date;

/*
    激活码实体类
 */
public class Code {
    private Integer id;
    private String name;
    private String code;
    private Date create_time;
    private Date stop_time;
    private String effect;
    private User user;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Date create_time) {
        this.create_time = create_time;
    }

    public Date getStop_time() {
        return stop_time;
    }

    public void setStop_time(Date stop_time) {
        this.stop_time = stop_time;
    }

    public String getEffect() {
        return effect;
    }

    public void setEffect(String effect) {
        this.effect = effect;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Code() {
        super();
    }

    public Code(String name, String code, Date create_time, Date stop_time, String effect, User user) {
        this.name = name;
        this.code = code;
        this.create_time = create_time;
        this.stop_time = stop_time;
        this.effect = effect;
        this.user = user;
    }

    @Override
    public String toString() {
        return "Code{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", code='" + code + '\'' +
                ", create_time=" + create_time +
                ", stop_time=" + stop_time +
                ", effect='" + effect + '\'' +
                ", user=" + user +
                '}';
    }
}
