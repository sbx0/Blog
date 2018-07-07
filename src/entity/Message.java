package entity;

import java.util.Date;

public class Message {
    private Integer id; // 消息ID
    private String content; // 消息内容
    private User sendUser; // 发送者
    private User receiveUser; // 接受者
    private Date sendTime; // 发送时间
    private Integer isRead; // 是否已读
    private Integer type; // 种类 私聊 群聊 群发 系统通知

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public User getSendUser() {
        return sendUser;
    }

    public void setSendUser(User sendUser) {
        this.sendUser = sendUser;
    }

    public User getReceiveUser() {
        return receiveUser;
    }

    public void setReceiveUser(User receiveUser) {
        this.receiveUser = receiveUser;
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

    public Integer getIsRead() {
        return isRead;
    }

    public void setIsRead(Integer isRead) {
        this.isRead = isRead;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Message() {
        super();
    }

    public Message(Integer id, String content, User sendUser, User receiveUser, Date sendTime, Integer isRead, Integer type) {
        this.id = id;
        this.content = content;
        this.sendUser = sendUser;
        this.receiveUser = receiveUser;
        this.sendTime = sendTime;
        this.isRead = isRead;
        this.type = type;
    }

    @Override
    public String toString() {
        return "Message{" +
                "id=" + id +
                ", content='" + content + '\'' +
                ", sendUser=" + sendUser +
                ", receiveUser=" + receiveUser +
                ", sendTime=" + sendTime +
                ", isRead=" + isRead +
                ", type=" + type +
                '}';
    }
}
