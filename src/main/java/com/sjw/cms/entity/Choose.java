package com.sjw.cms.entity;

import java.util.Date;

public class Choose {

	private Integer id;
	private Date chooseDate;
	private Integer articleId;
	private String option;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Date getChooseDate() {
		return chooseDate;
	}
	public void setChooseDate(Date chooseDate) {
		this.chooseDate = chooseDate;
	}
	public Integer getArticleId() {
		return articleId;
	}
	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}
	public String getOption() {
		return option;
	}
	public void setOption(String option) {
		this.option = option;
	}
	@Override
	public String toString() {
		return "Choose [id=" + id + ", chooseDate=" + chooseDate + ", articleId=" + articleId + ", option=" + option
				+ "]";
	}
	public Choose(Integer id, Date chooseDate, Integer articleId, String option) {
		super();
		this.id = id;
		this.chooseDate = chooseDate;
		this.articleId = articleId;
		this.option = option;
	}
	public Choose() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
