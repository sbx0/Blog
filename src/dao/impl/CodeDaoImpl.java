package dao.impl;

import dao.CodeDao;
import entity.Code;
import entity.User;
import org.hibernate.Query;

import java.util.List;

public class CodeDaoImpl extends BaseDao implements CodeDao {

    // 删除用户的激活码
    @Override
    public void deleteByUser(int id) {
        String hql = "DELETE FROM Code WHERE user_id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    // 添加/修改激活码
    @Override
    public void update(Code code) {
        getSession().saveOrUpdate(code);
    }

    // 删除激活码
    @Override
    public void delete(int id) {
        String hql = "DELETE FROM Code WHERE id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    // 查询激活码
    @Override
    public Code query(int id) {
        String hql = "FROM Code c WHERE c.id = ?";
        return (Code) getSession().createQuery(hql).setParameter(0,id).uniqueResult();
    }

    @Override
    public Code query(String code) {
        String hql = "FROM Code c WHERE c.code = ?";
        return (Code) getSession().createQuery(hql).setParameter(0,code).uniqueResult();
    }

    @Override
    public List<Code> query(User user) {
        String hql = "FROM Code c WHERE c.user.user_id = ?";
        return getSession().createQuery(hql).setParameter(0,user.getUser_id()).list();
    }

    @Override
    public List<Code> queryForPage(String hql, int offset, int length) {
        Query q = getSession().createQuery(hql);
        q.setFirstResult(offset);
        q.setMaxResults(length);
        return q.list();
    }

    @Override
    public int getCount(int id) {
        String hql = "SELECT COUNT(*) From Code ";
        return Integer.parseInt(getSession().createQuery(hql).uniqueResult().toString());
    }
}
