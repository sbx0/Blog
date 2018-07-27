package dao.impl;

import dao.TagDao;
import entity.Tag;

import java.util.List;

public class TagDaoImpl extends BaseDaoImpl<Tag> implements TagDao {

    @Override
    public void delete(int id) {
        String hql = "DELETE FROM Tag t WHERE t.id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    @Override
    public Tag query(Tag tag) {
        String hql;
        if (tag.getId() != null) {
            hql = "FROM Tag t WHERE t.id = ?";
            return (Tag) getSession().createQuery(hql).setParameter(0, tag.getId()).uniqueResult();
        } else if (tag.getName() != null) {
            hql = "FROM Tag t WHERE t.name = ?";
            return (Tag) getSession().createQuery(hql).setParameter(0, tag.getName().trim()).uniqueResult();
        }
        return null;
    }

    @Override
    public List<Tag> query() {
        String sql = "SELECT * FROM Tag AS t ORDER BY t.id DESC";
        return getSession().createSQLQuery(sql).list();
    }
}
