package action;

import entity.Article;
import entity.Tag;
import entity.TagLink;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import service.TagLinkService;
import service.TagService;
import service.ToolService;

import java.util.List;

public class TagLinkAction extends BaseAction {
    private TagLinkService tagLinkService;
    private TagService tagService;
    private TagLink tagLink;
    private String tagsText;
    private int id;

    public String one() {
        Tag tag = new Tag();
        tag.setId(id);
        tag = tagService.query(tag);
        getRequest().put("tag", tag);
        return "one";
    }

    public String remove() {
        try {
            tagLinkService.delete(id);
            getJson().put("state", 0);
        } catch (Exception e) {
            getJson().put("state", 1);
        }
        return "json";
    }

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
}
