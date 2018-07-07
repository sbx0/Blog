package dao;

import entity.Data;

public interface DataDao {
    public Data query(int id);
    public void saveOrUpdate(Data data);
    public Data queryMax(int type);
    public void delete(int id);
}
