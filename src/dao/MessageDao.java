package dao;

import entity.Message;

import java.util.List;

public interface MessageDao {
    // 已读
    public void read (int id);

    // 发送消息 / 修改消息
    public void send(Message message);

    // 接收消息
    public List<Message> receive(int receive_user_id);

    // 删除消息
    public void delete(int id);

    // 删除用户消息 发出的，接受的都会被删除
    public void deleteByUser(int id);

    // 未读消息数提醒
    public int count(int receive_user_id);

    // 查询与某一用户的消息
    public List<Message> chat(int id, int user_id);
}
