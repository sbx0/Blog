package dao;

import entity.Code;
import entity.User;

import java.util.List;

public interface CodeDao {
    // 添加/修改激活码
    public void update(Code code);
    // 删除激活码
    public void delete(int id);
    // 删除用户的激活码
    public void deleteByUser(int id);
    // 查询激活码
    public Code query(int id);
    public Code query(String code);
    public List<Code> query(User user);
    // 总数
    public int getCount(int id);
    // 分页查询
    public List<Code> queryForPage(String hql, int offset, int length);
}
