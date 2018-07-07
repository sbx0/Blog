package entity;

import java.util.Date;

/*
 * 文章实体类
 */
public class Article {
	private Integer article_id; // ID
	private User article_author; // 作者
	private String article_title; // 标题
	private Date article_time; // 发表时间
	private String article_content; // 内容
	private long article_views; // 浏览量
	private long article_comment; // 评论
	public Integer getArticle_id() {
		return article_id;
	}
	public void setArticle_id(Integer article_id) {
		this.article_id = article_id;
	}
	public User getArticle_author() {
		return article_author;
	}
	public void setArticle_author(User article_author) {
		this.article_author = article_author;
	}
	public String getArticle_title() {
		return article_title;
	}
	public void setArticle_title(String article_title) {
		this.article_title = article_title;
	}
	public Date getArticle_time() {
		return article_time;
	}
	public void setArticle_time(Date article_time) {
		this.article_time = article_time;
	}
	public String getArticle_content() {
		return article_content;
	}
	public void setArticle_content(String article_content) {
		this.article_content = article_content;
	}
	public long getArticle_views() {
		return article_views;
	}
	public void setArticle_views(long article_views) {
		this.article_views = article_views;
	}

	public long getArticle_comment() {
		return article_comment;
	}

	public void setArticle_comment(long article_comment) {
		this.article_comment = article_comment;
	}

	public Article() {
		super();
	}

	public Article(User article_author, String article_title, Date article_time, String article_content, long article_views, long article_comment) {
		this.article_author = article_author;
		this.article_title = article_title;
		this.article_time = article_time;
		this.article_content = article_content;
		this.article_views = article_views;
		this.article_comment = article_comment;
	}

	@Override
	public String toString() {
		return "Article{" +
				"article_id=" + article_id +
				", article_author=" + article_author +
				", article_title='" + article_title + '\'' +
				", article_time=" + article_time +
				", article_content='" + article_content + '\'' +
				", article_views=" + article_views +
				", article_comment=" + article_comment +
				'}';
	}
}
