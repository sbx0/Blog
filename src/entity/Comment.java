package entity;

import java.util.Date;

/*
 * 评论实体类
 */
public class Comment {
	private Integer comment_id; // ID
	private Integer comment_floor; // 楼层号
	private User comment_user; // 评论者
	private Article comment_article; // 评论的文章
	private String comment_content; // 评论
	private Date comment_time; // 时间
	public Integer getComment_id() {
		return comment_id;
	}
	public void setComment_id(Integer comment_id) {
		this.comment_id = comment_id;
	}
	public User getComment_user() {
		return comment_user;
	}
	public void setComment_user(User comment_user) {
		this.comment_user = comment_user;
	}
	public String getComment_content() {
		return comment_content;
	}
	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}
	public Date getComment_time() {
		return comment_time;
	}
	public void setComment_time(Date comment_time) {
		this.comment_time = comment_time;
	}
	public Article getComment_article() {
		return comment_article;
	}
	public void setComment_article(Article comment_article) {
		this.comment_article = comment_article;
	}
	public Integer getComment_floor() {
		return comment_floor;
	}
	public void setComment_floor(Integer comment_floor) {
		this.comment_floor = comment_floor;
	}
	public Comment() {
		super();
	}
	public Comment(Integer comment_floor, User comment_user, Article comment_article, String comment_content, Date comment_time) {
		this.comment_floor = comment_floor;
		this.comment_user = comment_user;
		this.comment_article = comment_article;
		this.comment_content = comment_content;
		this.comment_time = comment_time;
	}

	@Override
	public String toString() {
		return "Comment{" +
				"comment_id=" + comment_id +
				", comment_floor=" + comment_floor +
				", comment_user=" + comment_user +
				", comment_article=" + comment_article +
				", comment_content='" + comment_content + '\'' +
				", comment_time=" + comment_time +
				'}';
	}
}
