package service;

import dao.impl.TagLinkDaoImpl;
import entity.TagLink;

import java.util.List;

public class TagLinkService {
    private TagLinkDaoImpl tagLinkDao;

    public List<TagLink> queryByTag(int id, int a_id, int pageSize) {
        return tagLinkDao.queryByTag(id, a_id, pageSize);
    }

    public void deleteByArticle(int id) {
        tagLinkDao.deleteByArticle(id);
    }

    public boolean exist(int t_id, int a_id) {
        if (tagLinkDao.exist(t_id, a_id) != null) {
            return true;
        } else {
            return false;
        }
    }

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
