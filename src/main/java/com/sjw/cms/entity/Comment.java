package com.sjw.cms.entity;

import java.io.Serializable;
import java.util.Date;

public class Comment implements Serializable{

	/**
	 * @fieldName: serialVersionUID
	 * @fieldType: long
	 * @Description: TODO
	 */
	private static final long serialVersionUID = 1L;
	
	
	private Integer id;
	private Integer userId;
	private Integer articleId;
	private String content;
	private Date created;
	
	private User user;
	private Article article;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getArticleId() {
		return articleId;
	}
	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Article getArticle() {
		return article;
	}
	public void setArticle(Article article) {
		this.article = article;
	}
	@Override
	public String toString() {
		return "Comment [id=" + id + ", userId=" + userId + ", articleId=" + articleId + ", content=" + content
				+ ", created=" + created + ", user=" + user + ", article=" + article + "]";
	}
	public Comment(Integer id, Integer userId, Integer articleId, String content, Date created, User user,
			Article article) {
		super();
		this.id = id;
		this.userId = userId;
		this.articleId = articleId;
		this.content = content;
		this.created = created;
		this.user = user;
		this.article = article;
	}
	public Comment() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
}
