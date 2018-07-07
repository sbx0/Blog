package dao;

import entity.User;

import java.util.List;

public interface UserDao {
    // 登陆 / 查询 邮箱是否重复
    public User login(User user);
    // 查询用户名是否重复
    public User check(User user);
    // 注册
    public void register(User user);
    // 根据id查询用户详情
    public User userById(int id);
    // 删除
    public void delete(int id);
    // 计数
    public int getCount();
    // 分页查询
    public List<User> queryForPage(String hql, int offset, int length);
}
