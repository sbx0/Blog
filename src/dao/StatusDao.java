package dao;

import entity.Status;

import java.util.List;

public interface StatusDao {
    // 增加/修改
    public void saveOrUpdate(Status status);
    // 删除
    public void delete(int id);
    public void deleteByUser(int id);
    // 查询
    public Status query(int id);
    public List<Status> queryByUser(int id);
    public Status queryByNameAndUser(String name,int id);
}
