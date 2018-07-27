package dao;

import entity.TagLink;

import java.util.List;

public interface TagLinkDao extends BaseDao<TagLink> {
    // 由文章查询标签
    public List<TagLink> queryByArticle(int id);
    // 由文章删除标签
    public void deleteByArticle(int id);

}
