package dao.impl;

import dao.DataDao;
import entity.Data;

public class DataDaoImpl extends BaseDaoImpl implements DataDao {

    @Override
    public void delete(int id) {
        String hql = "DELETE FROM Data WHERE id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    @Override
    public Data query(int id) {
        String hql = "From Data d Where d.id = ?";
        Data data = (Data) getSession().createQuery(hql).setParameter(0, id).uniqueResult();
        return data;
    }

    @Override
    public void saveOrUpdate(Data data) {
        getSession().saveOrUpdate(data);
    }

    @Override
    public Data queryMax(int type) {
        String hql = "From Data d Where d.type = ? Order by d.data DESC,d.update_time ASC";
        Data data = (Data) getSession().createQuery(hql).setParameter(0, type).setMaxResults(1).uniqueResult();
        return data;
    }
}
