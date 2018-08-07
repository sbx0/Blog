package action;

import entity.Tag;

public class TagAction extends BaseAction {
    private Tag tag;
    private int id;

    public String query() {
        Tag t = new Tag();
        t.setId(id);
        t = tagService.query(t);
        if (t != null) {
            getJson().put("id", t.getId());
            getJson().put("name", t.getName());
            getJson().put("state", 0);
        } else {
            getJson().put("state", 1);
        }
        return "json";
    }

    public void setTag(Tag tag) {
        this.tag = tag;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Tag getTag() {
        return tag;
    }

    public int getId() {
        return id;
    }

}
