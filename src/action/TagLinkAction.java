package action;

import entity.Article;
import entity.Tag;
import entity.TagLink;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import service.ArticleService;
import service.TagLinkService;
import service.TagService;
import service.ToolService;

import java.util.List;

public class TagLinkAction extends BaseAction {
    private TagLinkService tagLinkService;
    private ArticleService articleService;
    private TagService tagService;
    private TagLink tagLink;
    private String tagsText;
    private int id;

    // 标签详情页 加载与标签相关的一切
    public String info() {
        List<TagLink> tagLinks = tagLinkService.queryByTag(id, tagLink.getId(), 10);
        if (tagLinks.size() > 0) {
            JSONArray aArray = new JSONArray();
            for (int i = 0; i < tagLinks.size(); i++) {
                Article article = tagLinks.get(i).getArticle();
                JSONObject aJson = new JSONObject();
                aJson.put("id", article.getArticle_id());
                aJson.put("title", article.getArticle_title());
                aJson.put("u_id", article.getArticle_author().getUser_id());
                aJson.put("u_name", article.getArticle_author().getUser_name());
                aJson.put("views", article.getArticle_views());
                aJson.put("time", article.getArticle_time());
                aArray.add(i, aJson);
            }
            // 如果加载数等于十，可能可以继续加载，返回查询结果的最后一个TagLink的ID
            if (tagLinks.size() == 10) getJson().put("tl_id", tagLinks.get(9).getId());
            getJson().put("articles", aArray);
            getJson().put("state", 0);
        } else {
            getJson().put("state", 1);
        }
        return "json";
    }

    // 查询标签
    public String one() {
        Tag tag = new Tag();
        tag.setId(id);
        tag = tagService.query(tag);
        getRequest().put("tag", tag);
        return "one";
    }

    // 删除标签
    public String remove() {
        try {
            tagLinkService.delete(id);
            getJson().put("state", 0);
        } catch (Exception e) {
            getJson().put("state", 1);
        }
        return "json";
    }

    // 添加标签
    public String add() {
        tagsText = ToolService.killHTML(tagsText);
        String[] tags = tagsText.split(" ");
        for (int i = 0; i < tags.length; i++) {
            if (tags[i].trim() == "" || tags[i].trim().length() == 0) continue;
            Article article = new Article();
            TagLink link = new TagLink();
            int tagId = tagService.exist(tags[i]);
            if (tagId != -1) {
                Tag tag = new Tag();
                tag.setId(tagId);
                link.setTag(tag);
            } else {
                Tag tag = new Tag();
                tag.setName(tags[i]);
                tagService.saveOrUpdate(tag);
                tagId = tagService.exist(tags[i]);
                tag.setId(tagId);
                link.setTag(tag);
            }
            if (id > 0) {
                if (!tagLinkService.exist(tagId, id)) {
                    article.setArticle_id(id);
                    link.setArticle(article);
                    tagLinkService.saveOrUpdate(link);
                }
                getJson().put("state", 0);
            } else getJson().put("state", 1);
        }
        return "json";
    }

    // 查询文章标签
    public String article() {
        List<TagLink> tagLinkList = tagLinkService.queryByArticle(id);
        if (tagLinkList.size() > 0) {
            JSONArray jsonTags = new JSONArray();
            for (int i = 0; i < tagLinkList.size(); i++) {
                JSONObject jsonTag = new JSONObject();
                jsonTag.put("id", tagLinkList.get(i).getId());
                jsonTag.put("t_id", tagLinkList.get(i).getTag().getId());
                jsonTag.put("name", tagLinkList.get(i).getTag().getName());
                jsonTag.put("a_id", tagLinkList.get(i).getArticle().getArticle_id());
                jsonTags.element(jsonTag);
            }
            getJson().put("tags", jsonTags);
            getJson().put("state", 0);
        } else {
            getJson().put("state", 1);
        }
        return "json";
    }

    // 查询标签与文章
    public String query() {
        TagLink tagLink = new TagLink();
        tagLink.setId(id);
        tagLink = tagLinkService.query(tagLink);
        if (tagLink != null) {
            getJson().put("state", 0);
            getJson().put("id", tagLink.getId());
            getJson().put("name", tagLink.getTag().getName());
            getJson().put("article", tagLink.getArticle().getArticle_title());
        } else {
            getJson().put("state", 1);
        }
        return "json";
    }

    public void setTagLinkService(TagLinkService tagLinkService) {
        this.tagLinkService = tagLinkService;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setTagLink(TagLink tagLink) {
        this.tagLink = tagLink;
    }

    public void setTagsText(String tagsText) {
        this.tagsText = tagsText;
    }

    public void setTagService(TagService tagService) {
        this.tagService = tagService;
    }

    public void setArticleService(ArticleService articleService) {
        this.articleService = articleService;
    }
}
