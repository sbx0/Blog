package service;

import dao.impl.DataDaoImpl;
import entity.Data;

public class DataService {
    private DataDaoImpl dataDao;

    public Data query(int id) {
        return dataDao.query(id);
    }

    public void saveOrUpdate(Data data) {
        dataDao.saveOrUpdate(data);
    }

    public Data queryMax(int type) {
        return dataDao.queryMax(type);
    }

    public void setDataDao(DataDaoImpl dataDao) {
        this.dataDao = dataDao;
    }

}
