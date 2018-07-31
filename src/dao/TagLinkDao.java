package dao;

import entity.TagLink;

import java.util.List;

public interface TagLinkDao extends BaseDao<TagLink> {

    // 由标签查询文章
    public List<TagLink> queryByTag(int id, int a_id, int pageSize);

    // 由文章查询标签
    public List<TagLink> queryByArticle(int id);

    // 由文章删除标签
    public void deleteByArticle(int id);

    // 判断文章是否有重复标签
    public TagLink exist(int t_id, int a_id);

}
