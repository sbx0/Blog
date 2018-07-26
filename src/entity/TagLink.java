package entity;

public class TagLink {
    private Integer id;
    private Tag tag; // 关联标签
    private Article article; // 关联文章

    public TagLink() {
        super();
    }

    @Override
    public String toString() {
        return "TagLink{" +
                "id=" + id +
                ", tag=" + tag +
                ", article=" + article +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Tag getTag() {
        return tag;
    }

    public void setTag(Tag tag) {
        this.tag = tag;
    }

    public Article getArticle() {
        return article;
    }

    public void setArticle(Article article) {
        this.article = article;
    }
}
