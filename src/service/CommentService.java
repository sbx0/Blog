package service;

import dao.impl.CommentDaoImpl;
import dao.impl.UserDaoImpl;
import entity.Comment;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.util.List;

public class CommentService {

    private CommentDaoImpl commentDao;
    private UserDaoImpl userDao;

    // 获取用户评论总数
    public int countByUser(int id) {
        return commentDao.countByUser(id);
    }


    // 修改评论
    public int updateComment(Comment comment) {
        try {
            commentDao.update(comment);
            return 0;
        } catch (Exception e) {
            return 1;
        }
    }

    // 获取一个评论
    public Comment getOneComment(int id) {
        return commentDao.getOneComment(id);
    }

    // 删除用户评论
    public int deleteByUser(int id) {
        try {
            commentDao.deleteByUser(id);
            return 0;
        } catch (Exception e) {
            return 1;
        }
    }

    // 获取评论
    public List<Comment> getComments(int article_id) {
        return commentDao.getComments(article_id);
    }

    // 添加评论
    public void postComment(Comment comment) {
        commentDao.postComment(comment);
    }

    // 评论条数
    public int getCount(int article_id) {
        return commentDao.getCount(article_id);
    }

    // 删除评论
    public void delete(int id) {
        commentDao.delete(id);
    }

    // 删除文章评论
    public void deleteArticleComment(int article_id) {
        commentDao.deleteArticleComment(article_id);
    }

    // 分页查询
    public PageBean queryForPage(int pageSize, int page, int id) {
        int count = commentDao.getCount(id); // 总记录数
        int totalPage = PageBean.countTotalPage(pageSize, count); // 总页数
        int offset = PageBean.countOffset(pageSize, page); // 当前页开始记录
        int length = pageSize; // 每页记录数
        int currentPage = PageBean.countCurrentPage(page);
        List<Comment> list = commentDao.queryForPage("From Comment c LEFT OUTER JOIN FETCH c.comment_article Where c.comment_article.article_id = " + id + " ORDER BY c.comment_id DESC", offset, length); // 该分页的记录
        // 把分页信息保存到Bean中
        PageBean pageBean = new PageBean();
        pageBean.setPageSize(pageSize);
        pageBean.setCurrentPage(currentPage);
        pageBean.setAllRow(count);
        pageBean.setTotalPage(totalPage);
        pageBean.setList(list);
        pageBean.init();
        return pageBean;
    }

    // 分页查询
    public PageBean queryForPage(int pageSize, int page) {
        int count = commentDao.getCount(); // 总记录数
        int totalPage = PageBean.countTotalPage(pageSize, count); // 总页数
        int offset = PageBean.countOffset(pageSize, page); // 当前页开始记录
        int length = pageSize; // 每页记录数
        int currentPage = PageBean.countCurrentPage(page);
        List<Comment> list = commentDao.queryForPage("From Comment c ORDER BY c.comment_id DESC", offset, length); // 该分页的记录
        // 把分页信息保存到Bean中
        PageBean pageBean = new PageBean();
        pageBean.setPageSize(pageSize);
        pageBean.setCurrentPage(currentPage);
        pageBean.setAllRow(count);
        pageBean.setTotalPage(totalPage);
        pageBean.setList(list);
        pageBean.init();
        return pageBean;
    }

    // 将List<Code>中有用的东西转换成json串
    public JSONArray toJsonArray(List<Comment> comments) {
        JSONArray jsonArray = new JSONArray();
        int i = 0;
        for (Comment c : comments) {
            jsonArray.add(i, toJson(c));
            i++;
        }
        return jsonArray;
    }

    // 将List<Commnet>中有用的东西转换成json串
    public JSONObject toJson(Comment c) {
        JSONObject jc = new JSONObject();
        jc.put("comment_id", c.getComment_id());
        jc.put("comment_floor", c.getComment_floor());
        jc.put("user_id", c.getComment_user().getUser_id());
        jc.put("article_id", c.getComment_article().getArticle_id());
        jc.put("comment_content", "*");
        jc.put("comment_time", c.getComment_time());
        return jc;
    }

    // 将List<Commnet>中有用的东西转换成json串
    public JSONArray commentJson(List<Comment> comments) {
        JSONArray jsonArray = new JSONArray();
        for (int i = 0; i < comments.size(); i++) {
            JSONObject cJson = new JSONObject();
            cJson.put("id", comments.get(i).getComment_id());
            cJson.put("content", comments.get(i).getComment_content());
            cJson.put("floor", comments.get(i).getComment_floor());
            cJson.put("time", comments.get(i).getComment_time());
            cJson.put("com_user_id", comments.get(i).getComment_user().getUser_id());
            cJson.put("com_user_name", comments.get(i).getComment_user().getUser_name());
            cJson.put("article_id", comments.get(i).getComment_article().getArticle_id());
            cJson.put("author_id", comments.get(i).getComment_article().getArticle_author().getUser_id());
            jsonArray.add(cJson);
        }
        return jsonArray;
    }

    public void setUserDao(UserDaoImpl userDao) {
        this.userDao = userDao;
    }

    public UserDaoImpl getUserDao() {
        return userDao;
    }

    public void setCommentDao(CommentDaoImpl commentDao) {
        this.commentDao = commentDao;
    }

    public CommentDaoImpl getCommentDao() {
        return commentDao;
    }

}
