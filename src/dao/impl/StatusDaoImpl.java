package dao.impl;

import dao.StatusDao;
import entity.Status;

import java.util.List;

public class StatusDaoImpl extends BaseDaoImpl implements StatusDao {

    @Override
    public void saveOrUpdate(Status status) {
        getSession().saveOrUpdate(status);
    }

    @Override
    public void delete(int id) {
        String hql = "DELETE FROM Status WHERE id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    @Override
    public void deleteByUser(int id) {
        String hql = "DELETE FROM Status WHERE user_id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    @Override
    public Status query(int id) {
        String hql = "From Status s WHERE s.id = ?";
        return (Status) getSession().createQuery(hql).setParameter(0, id).uniqueResult();
    }

    @Override
    public List<Status> queryByUser(int id) {
        String hql = "From Status s WHERE s.user.user_id = ? ORDER BY s.id DESC";
        return getSession().createQuery(hql).setParameter(0, id).list();
    }

    @Override
    public Status queryByNameAndUser(String name, int id) {
        String hql = "FROM Status s WHERE s.name = ? AND s.user.user_id = ? ORDER BY s.id DESC";
        return (Status) getSession().createQuery(hql)
                .setParameter(0, name)
                .setParameter(1,id)
                .uniqueResult();
    }
}
