package dao;

import entity.Article;

import java.util.List;

public interface ArticleDao {
    // 查询全部
    public List<Article> getAll();

    // 条件查询
    public List<Article> getAll(String title, String content, int offset, int length);

    // 查询一条
    public Article getOneById(int id);

    // 查询总条数，为了分页
    public int getCount();

    // 分页查询
    public List<Article> queryForPage(String hql, int offset, int length);

    // saveOrUpdate
    public void saveOrUpdate(Article article);

    // 单用户文章列表
    public List<Article> getAllById(int id);

    // 单用户文章总条数
    public int getAllCountById(int id);

    // 删除
    public void delete(int id);

    // 删除用户的发布的文章
    public void deleteByUser(int id);

    // 30天内的热度排行榜
    public List<Article> hotRankingList(java.sql.Date start, java.sql.Date end);
}
