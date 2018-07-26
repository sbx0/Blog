package dao.impl;

import dao.MessageDao;
import entity.Message;

import java.util.List;

public class MessageDaoImpl extends BaseDaoImpl implements MessageDao {

    @Override
    public void read(int id) {
        String hql = "update Message m set m.isRead = 1 where m.id = ? ";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    @Override
    public List<Message> chat(int id, int user_id) {
        String hql = "from Message m where (m.receiveUser.user_id = ? and m.sendUser.user_id = ?) or (m.receiveUser.user_id = ? and m.sendUser.user_id = ?) order by m.id";
        return getSession().createQuery(hql).setParameter(0, user_id).setParameter(1, id).setParameter(2, id).setParameter(3, user_id).setMaxResults(1000).list();
    }

    // 删除关于用户的消息
    @Override
    public void deleteByUser(int id) {
        String hql = "DELETE FROM Message WHERE send_user_id = ? or receive_user_id = ?";
        getSession().createQuery(hql).setParameter(0, id).setParameter(1, id).executeUpdate();
    }

    @Override
    public void send(Message message) {
        getSession().saveOrUpdate(message);
    }

    @Override
    public List<Message> receive(int receive_user_id) {
        String hql = "from Message m where (m.receiveUser.user_id = ? and m.isRead = 0) order by m.id desc";
        return getSession().createQuery(hql).setParameter(0, receive_user_id).list();
    }

    @Override
    public void delete(int id) {
        String hql = "DELETE FROM Message WHERE id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    @Override
    public int count(int receive_user_id) {
        String hql = "select count(*) from Message m where (m.receiveUser.user_id = ? and m.isRead = 0)";
        int count = Integer.parseInt(getSession().createQuery(hql).setParameter(0, receive_user_id).uniqueResult().toString());
        return count;
    }
}
