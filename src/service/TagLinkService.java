package service;

import dao.impl.TagLinkDaoImpl;
import entity.Article;
import entity.Tag;
import entity.TagLink;

import java.util.List;

public class TagLinkService {
    private TagLinkDaoImpl tagLinkDao;

    public void deleteByArticle(int id) {
        tagLinkDao.deleteByArticle(id);
    }

    public boolean exist(int t_id, int a_id) {
        TagLink tagLink = new TagLink();
        Tag tag = new Tag();
        tag.setId(t_id);
        Article article = new Article();
        article.setArticle_id(a_id);
        tagLink.setTag(tag);
        tagLink.setArticle(article);
        tagLink = query(tagLink);
        if (tagLink != null) {
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
