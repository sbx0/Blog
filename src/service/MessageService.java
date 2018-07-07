package service;

import dao.impl.MessageDaoImpl;
import entity.Message;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;

import java.util.List;

public class MessageService {
    private MessageDaoImpl messageDao;

    public List<Message> chat(int id, int user_id) {
        return messageDao.chat(id, user_id);
    }

    // 已读
    public int read(int id) {
        try {
            messageDao.read(id);
            return 0;
        } catch (Exception e) {
            return 1;
        }
    }

    // 删除用户消息
    public int deleteByUser(int id) {
        try {
            messageDao.deleteByUser(id);
            return 0;
        } catch (Exception e) {
            return 1;
        }
    }

    // 发送消息 / 修改消息
    public void send(Message message) {
        messageDao.send(message);
    }

    // 接收消息
    public List<Message> receive(int receive_user_id) {
        return messageDao.receive(receive_user_id);
    }

    // 删除消息
    public void delete(int id) {
        messageDao.delete(id);
    }

    // 未读消息数提醒
    public int count(int receive_user_id) {
        return messageDao.count(receive_user_id);
    }

    // 将List<Code>中有用的东西转换成json串
    public JSONArray messagesJson(List<Message> messages) {
        JSONArray jsonArray = new JSONArray();
        int i = 0;
        for (Message message : messages) {
            jsonArray.add(i, messageJson(message));
            i++;
        }
        return jsonArray;
    }

    // 将code变成jsonObject
    public JSONObject messageJson(Message message) {
        // json config 配置 去除无效数据
        JsonConfig config = new JsonConfig();
        config.setJsonPropertyFilter(new PropertyFilter() {
            public boolean apply(Object arg0, String arg1, Object arg2) {
                if (arg1.equals("id") || arg1.equals("content") || arg1.equals("sendUser") || arg1.equals("sendUser")
                        || arg1.equals("user_id") || arg1.equals("user_name") || arg1.equals("receiveUser")
                        || arg1.equals("sendTime") || arg1.equals("time") || arg1.equals("isRead") || arg1.equals("type")) {
                    return false;
                } else {
                    return true;
                }
            }
        });
        JSONObject jsonObject = JSONObject.fromObject(message, config);
        return jsonObject;
    }

    public void setMessageDao(MessageDaoImpl messageDao) {
        this.messageDao = messageDao;
    }

    public MessageDaoImpl getMessageDao() {
        return messageDao;
    }
}
