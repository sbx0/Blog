package entity;

import java.util.Date;

public class Status {
    private Integer id;
    private String name;
    private User user;
    private Date start_time;
    private Date stop_time;

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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getStart_time() {
        return start_time;
    }

    public void setStart_time(Date start_time) {
        this.start_time = start_time;
    }

    public Date getStop_time() {
        return stop_time;
    }

    public void setStop_time(Date stop_time) {
        this.stop_time = stop_time;
    }

    public Status() {
        super();
    }

    public Status(String name, User user, Date start_time, Date stop_time) {
        this.name = name;
        this.user = user;
        this.start_time = start_time;
        this.stop_time = stop_time;
    }

    @Override
    public String toString() {
        return "Status{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", user=" + user +
                ", start_time=" + start_time +
                ", stop_time=" + stop_time +
                '}';
    }
}
