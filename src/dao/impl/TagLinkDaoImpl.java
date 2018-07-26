package dao.impl;

import dao.TagLinkDao;
import entity.TagLink;

import java.util.List;

public class TagLinkDaoImpl extends BaseDaoImpl<TagLink> implements TagLinkDao {

    @Override
    public List<TagLink> queryByArticle(int id) {
        String hql = "FROM TagLink tl WHERE tl.article.article_id = ? ORDER BY tl.id DESC";
        return getSession().createQuery(hql).setParameter(0, id).list();
    }

    @Override
    public void delete(int id) {
        String hql = "DELETE FROM TagLink tl WHERE tl.id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    @Override
    public TagLink query(TagLink tagLink) {
        String hql;
        if (tagLink.getId() != null) {
            hql = "FROM TagLink tl WHERE tl.id = ?";
            return (TagLink) getSession().createQuery(hql).setParameter(0, tagLink.getId()).uniqueResult();
        } else if (tagLink.getTag().getId() != null) {
            hql = "FROM TagLink tl WHERE tl.tag.id = ?";
            return (TagLink) getSession().createQuery(hql).setParameter(0, tagLink.getTag().getId()).uniqueResult();
        } else if (tagLink.getArticle().getArticle_id() != null) {
            hql = "FROM TagLink tl WHERE tl.article.article_id = ?";
            return (TagLink) getSession().createQuery(hql).setParameter(0, tagLink.getArticle().getArticle_id()).uniqueResult();
        }
        return null;
    }

    @Override
    public List<TagLink> query() {
        String sql = "SELECT * FROM TagLink tl ORDER BY tl.id DESC";
        return getSession().createSQLQuery(sql).list();
    }
}
