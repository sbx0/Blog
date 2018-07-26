package action;

import entity.TagLink;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import service.TagLinkService;

import java.util.List;

public class TagLinkAction extends BaseAction {
    private TagLinkService tagLinkService;
    private TagLink tagLink;
    private int id;

    public String article() {
        List<TagLink> tagLinkList = tagLinkService.queryByArticle(id);
        if (tagLinkList.size() > 0) {
            JSONArray jsonTags = new JSONArray();
            for (int i = 0; i < tagLinkList.size(); i++) {
                JSONObject jsonTag = new JSONObject();
                jsonTag.put("id", tagLinkList.get(i).getTag().getId());
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
}
