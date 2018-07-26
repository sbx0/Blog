package service;

import dao.impl.TagLinkDaoImpl;
import entity.TagLink;

import java.util.List;

public class TagLinkService {
    private TagLinkDaoImpl tagLinkDao;

    public void setTagLinkDao(TagLinkDaoImpl tagLinkDao) {
        this.tagLinkDao = tagLinkDao;
    }

    public List<TagLink> queryByArticle(int id) {
        return tagLinkDao.queryByArticle(id);
    }

    public void saveOrUpdate(TagLink t) {
        tagLinkDao.saveOrUpdate(t);
    }

    public void delete(int id) {
        tagLinkDao.delete(id);
    }

    public TagLink query(TagLink t) {
        return tagLinkDao.query(t);
    }

    public List<TagLink> query() {
        return tagLinkDao.query();
    }
}
