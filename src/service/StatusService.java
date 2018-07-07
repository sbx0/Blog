package service;

import dao.impl.StatusDaoImpl;
import entity.Status;

import java.util.List;

public class StatusService {
    private StatusDaoImpl statusDao;

    public void setStatusDao(StatusDaoImpl statusDao) {
        this.statusDao = statusDao;
    }

    public StatusDaoImpl getStatusDao() {
        return statusDao;
    }

    public void saveOrUpdate(Status status) {
        statusDao.saveOrUpdate(status);
    }

    public void delete(int id) {
        statusDao.delete(id);
    }

    public int deleteByUser(int id) {
        try {
            statusDao.deleteByUser(id);
            return 0;
        } catch (Exception e) {
            return 1;
        }
    }

    public Status query(int id) {
        return statusDao.query(id);
    }

    public List<Status> queryByUser(int id) {
        return statusDao.queryByUser(id);
    }

    public Status queryByNameAndUser(String name, int id) {
        return statusDao.queryByNameAndUser(name, id);
    }

}
