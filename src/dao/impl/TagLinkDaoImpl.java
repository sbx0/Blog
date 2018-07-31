package dao.impl;

import dao.TagLinkDao;
import entity.TagLink;

import java.util.List;

public class TagLinkDaoImpl extends BaseDaoImpl<TagLink> implements TagLinkDao {

    // 由标签查询文章
    @Override
    public List<TagLink> queryByTag(int id, int a_id, int pageSize) {
        // 从当前的TagLink往前取pageSize个
        String hql;
        if (a_id != 0) {
            hql = "From TagLink t Where t.tag.id = ? and t.article.article_id < ? ORDER BY t.article.article_id DESC";
            return (List<TagLink>) getSession().createQuery(hql)
                    .setParameter(0, id)
                    .setParameter(1, a_id)
                    .setMaxResults(pageSize)
                    .list();
        } else {
            hql = "From TagLink t Where t.tag.id = ? ORDER BY t.article.article_id DESC";
            return (List<TagLink>) getSession().createQuery(hql)
                    .setParameter(0, id)
                    .setMaxResults(pageSize)
                    .list();
        }
    }

    @Override
    public TagLink exist(int t_id, int a_id) {
        String hql = "FROM TagLink t WHERE t.tag.id = ? AND t.article.article_id = ?";
        return (TagLink) getSession().createQuery(hql)
                .setParameter(0, t_id)
                .setParameter(1, a_id)
                .uniqueResult();
    }

    @Override
    public void deleteByArticle(int id) {
        String hql = "DELETE FROM TagLink t WHERE t.article.article_id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    @Override
    public List<TagLink> queryByArticle(int id) {
        String hql = "FROM TagLink t WHERE t.article.article_id = ? ORDER BY t.article.article_id DESC";
        return getSession().createQuery(hql).setParameter(0, id).list();
    }

    @Override
    public void delete(int id) {
        String hql = "DELETE FROM TagLink t WHERE t.id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    @Override
    public TagLink query(TagLink tagLink) {
        String hql;
        if (tagLink.getId() != null) {
            hql = "FROM TagLink t WHERE t.id = ?";
            return (TagLink) getSession().createQuery(hql).setParameter(0, tagLink.getId()).uniqueResult();
        } else if (tagLink.getTag().getId() != null) {
            hql = "FROM TagLink t WHERE t.tag.id = ?";
            return (TagLink) getSession().createQuery(hql).setParameter(0, tagLink.getTag().getId()).uniqueResult();
        } else if (tagLink.getArticle().getArticle_id() != null) {
            hql = "FROM TagLink t WHERE t.article.article_id = ?";
            return (TagLink) getSession().createQuery(hql).setParameter(0, tagLink.getArticle().getArticle_id()).uniqueResult();
        }
        return null;
    }

    @Override
    public List<TagLink> query() {
        String sql = "SELECT * FROM TagLink t ORDER BY t.id DESC";
        return getSession().createSQLQuery(sql).list();
    }
}
