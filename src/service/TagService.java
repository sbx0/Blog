package service;

import dao.impl.TagDaoImpl;
import entity.Tag;

import java.util.List;

public class TagService {
    private TagDaoImpl tagDao;

    public void setTagDao(TagDaoImpl tagDao) {
        this.tagDao = tagDao;
    }

    public void saveOrUpdate(Tag t) {
        tagDao.saveOrUpdate(t);
    }

    public void delete(int id) {
        tagDao.delete(id);
    }

    public Tag query(Tag t) {
        return tagDao.query(t);
    }

    public List<Tag> query() {
        return tagDao.query();
    }

}