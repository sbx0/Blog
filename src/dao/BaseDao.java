package dao;

import java.util.List;

public interface BaseDao<T> {

    // 增 / 改
    public void saveOrUpdate(T t);

    // 删
    public void delete(int id);

    // 查
    public T query(T t);

    // 查全部
    public List<T> query();

}
