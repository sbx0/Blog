package dao.impl;

import dao.UserDao;
import entity.User;
import org.hibernate.Query;

import java.util.List;

public class UserDaoImpl extends BaseDao implements UserDao {
    // 登陆 / 查询邮箱是否重复
    @Override
    public User login(User user) {
        String hql = "FROM User u WHERE u.user_email = ?";
        user = (User) getSession().createQuery(hql).setParameter(0,user.getUser_email()).uniqueResult();
        return user;
    }

    // 查询用户名是否重复
    @Override
    public User check(User user) {
        String hql = "FROM User u WHERE u.user_name = ?";
        user = (User) getSession().createQuery(hql).setParameter(0,user.getUser_name()).uniqueResult();
        return user;
    }

    // 注册 / 修改用户
    @Override
    public void register(User user) {
        getSession().saveOrUpdate(user);
    }

    // 根据id查询单独一个用户
    @Override
    public User userById(int id) {
        String hql = "FROM User u WHERE u.user_id = ?";
        User u = (User) getSession().createQuery(hql).setParameter(0,id).uniqueResult();
        return u;
    }

    @Override
    public void delete(int id) {
        String hql = "DELETE FROM User WHERE user_id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    @Override
    public int getCount() {
        String hql = "SELECT COUNT(*) From User";
        int allRow = Integer.parseInt(getSession().createQuery(hql).uniqueResult().toString());
        return allRow;
    }

    // 分页查询
    @Override
    public List<User> queryForPage(String hql, int offset, int length) {
        Query q = getSession().createQuery(hql);
        q.setFirstResult(offset);
        q.setMaxResults(length);
        return q.list();
    }
}