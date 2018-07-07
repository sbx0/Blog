package dao;

import entity.Comment;

import java.util.List;

public interface CommentDao {
    // 修改评论
    public int update(Comment comment);

    // 获取一个评论
    public Comment getOneComment(int id);

    // 查询评论
    public List<Comment> getComments(int article_id);

    // 添加评论
    public void postComment(Comment comment);

    // 评论条数
    public int getCount(int article_id);

    // 总条数
    public int getCount();

    // 删除评论
    public void delete(int id);

    // 删除文章评论
    public void deleteArticleComment(int article_id);

    // 删除用户评论
    public void deleteByUser(int id);

    // 分页查询
    public List<Comment> queryForPage(String hql, int offset, int length);
}
