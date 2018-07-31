package dao.impl;

import dao.ArticleDao;
import entity.Article;
import org.hibernate.Query;

import java.util.List;

public class ArticleDaoImpl extends BaseDaoImpl implements ArticleDao {

    @Override
    public int prev(int id, int u_id) {
        Object result;
        String sql;
        if (u_id > 0) {
            sql = "select article_id from ARTICLES where article_id < ? and user_id = ? order by article_id desc";
            result = getSession().createSQLQuery(sql).setParameter(0, id).setParameter(1, u_id).setMaxResults(1).uniqueResult();
        } else {
            sql = "select article_id from ARTICLES where article_id < ? order by article_id desc";
            result = getSession().createSQLQuery(sql).setParameter(0, id).setMaxResults(1).uniqueResult();
        }
        if (result != null) return (int) result;
        else return -1;
    }

    @Override
    public int next(int id, int u_id) {
        Object result;
        String sql;
        if (u_id > 0) {
            sql = "select article_id from ARTICLES where article_id > ? and user_id = ? order by article_id";
            result = getSession().createSQLQuery(sql).setParameter(0, id).setParameter(1, u_id).setMaxResults(1).uniqueResult();
        } else {
            sql = "select article_id from ARTICLES where article_id > ? order by article_id";
            result = getSession().createSQLQuery(sql).setParameter(0, id).setMaxResults(1).uniqueResult();
        }
        if (result != null) return (int) result;
        else return -1;
    }

    // 删除用户的文章
    @Override
    public void deleteByUser(int id) {
        String hql = "DELETE FROM Article WHERE user_id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    // 查询全部
    @Override
    public List<Article> getAll() {
        String hql = "From Article article LEFT OUTER JOIN FETCH article.article_author ORDER BY article.article_id DESC";
        return getSession().createQuery(hql).setMaxResults(100).list();
    }

    // 条件查询
    @Override
    public List<Article> getAll(String keywords, String type, int offset, int length) {
//        if (offset == -1 && length == -1) {
//            // 记录总数
//            String hql = "SELECT COUNT(*) From Article article WHERE article_title LIKE :title ORDER BY article.article_id DESC";
//            return getSession().createQuery(hql).setString("title", "%" + title + "%").list();
//        } else {

        // 分页查询 不需要总数
        if (type.equals("1")) {
            String hql = "From Article article WHERE article_title LIKE :title ORDER BY article.article_id DESC";
            return getSession().createQuery(hql).setString("title", "%" + keywords + "%").setFirstResult(offset).setMaxResults(length).list();
        } else if (type.equals("2")) {
            String hql = "From Article article WHERE article_content LIKE :content ORDER BY article.article_id DESC";
            return getSession().createQuery(hql).setString("content", "%" + keywords + "%").setFirstResult(offset).setMaxResults(length).list();
        } else {
            return null;
        }
    }


    // 查询一条
    @Override
    public Article getOneById(int id) {
        String hql = "From Article article LEFT OUTER JOIN FETCH article.article_author WHERE article.article_id = ?";
        return (Article) getSession().createQuery(hql).setParameter(0, id).uniqueResult();
    }

    // 查询总条数，为了分页
    @Override
    public int getCount() {
        String hql = "SELECT COUNT(*) From Article";
        int allRow = Integer.parseInt(getSession().createQuery(hql).uniqueResult().toString());
        return allRow;
    }

    // 分页查询
    @Override
    public List<Article> queryForPage(String hql, int offset, int length) {
        Query q = getSession().createQuery(hql);
        q.setFirstResult(offset);
        q.setMaxResults(length);
        return q.list();
    }

//    // 添加或更新
//    @Override
//    public void saveOrUpdate(Article article) {
//        getSession().saveOrUpdate(article);
//    }

    // 查询用户发表的文章
    @Override
    public List<Article> getAllById(int id) {
        String hql = "From Article article LEFT OUTER JOIN FETCH article.article_author WHERE article.article_author.user_id = ?";
        return getSession().createQuery(hql).setParameter(0, id).list();
    }

    // 查询用户发表博文总条数
    @Override
    public int getAllCountById(int id) {
        String hql = "SELECT COUNT(*) FROM Article article WHERE article.article_author.user_id = ?";
        int allRow = Integer.parseInt(getSession().createQuery(hql).setParameter(0, id).uniqueResult().toString());
        return allRow;
    }

    // 删除
    @Override
    public void delete(int id) {
        String hql = "DELETE FROM Article WHERE article_id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    @Override
    public List<Article> hotRankingList(java.sql.Date start, java.sql.Date end) {
        String hql = "FROM Article a WHERE a.article_time <= :endDate AND a.article_time >= :beginDate";
        Query query = getSession().createQuery(hql);
        query.setDate("beginDate", start);
        query.setDate("endDate", end);
        return query.list();
    }
}
