package dao.impl;

import dao.CommentDao;
import entity.Comment;
import org.hibernate.Query;

import java.util.List;

public class CommentDaoImpl extends BaseDaoImpl implements CommentDao {

    @Override
    public int update(Comment comment) {
        try {
            getSession().update(comment);
            return 0;
        } catch (Exception e) {
            return 1;
        }
    }

    // 获取一个评论
    @Override
    public Comment getOneComment(int id) {
        String hql = "From Comment comment WHERE comment.comment_id = ?";
        Comment c = (Comment) getSession().createQuery(hql).setParameter(0, id).uniqueResult();
        return c;
    }

    // 删除用户评论
    @Override
    public void deleteByUser(int id) {
        String hql = "DELETE FROM Comment WHERE user_id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    // 查询评论
    @Override
    public List<Comment> getComments(int article_id) {
        String hql = "From Comment c LEFT OUTER JOIN FETCH c.comment_user WHERE c.comment_article.article_id = ? ORDER BY c.comment_id DESC";
        return getSession().createQuery(hql).setParameter(0, article_id).list();
    }

    // 添加评论
    @Override
    public void postComment(Comment comment) {
        getSession().save(comment);
    }

    // 评论条数
    @Override
    public int getCount(int article_id) {
        String hql = "SELECT COUNT(*) From Comment comment WHERE comment.comment_article.article_id = ?";
        int count = Integer.parseInt(getSession().createQuery(hql).setParameter(0, article_id).uniqueResult().toString());
        return count;
    }

    // 总条数
    @Override
    public int getCount() {
        String hql = "SELECT COUNT(*) From Comment comment";
        int count = Integer.parseInt(getSession().createQuery(hql).uniqueResult().toString());
        return count;
    }

    // 删除
    @Override
    public void delete(int id) {
        String hql = "DELETE FROM Comment WHERE comment_id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    // 删除文章的所有评论
    @Override
    public void deleteArticleComment(int article_id) {
        String hql = "Delete FROM Comment c WHERE c.comment_article.article_id = ?";
        getSession().createQuery(hql).setInteger(0, article_id).executeUpdate();
    }


    // 分页查询评论
    @Override
    public List<Comment> queryForPage(String hql, int offset, int length) {
        Query q = getSession().createQuery(hql);
        q.setFirstResult(offset);
        q.setMaxResults(length);
        return q.list();
    }
}
