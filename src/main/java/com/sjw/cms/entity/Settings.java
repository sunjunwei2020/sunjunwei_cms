package com.sjw.cms.entity;

/***
 * 
 * @ClassName: Settings 
 * @Description: 系统配置表
 * @author: 挪威的森林
 * @date: 2020年3月3日 下午2:35:09
 */
public class Settings {

	private Integer id;
	private String siteDomain;
	private String siteName;
	private Integer articleListSize;//文章每页显示的条目
	private Integer slideSize;//显示多少个广告
	private String adminUsername;
	private String adminPassword;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getSiteDomain() {
		return siteDomain;
	}
	public void setSiteDomain(String siteDomain) {
		this.siteDomain = siteDomain;
	}
	public String getSiteName() {
		return siteName;
	}
	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}
	public Integer getArticleListSize() {
		return articleListSize;
	}
	public void setArticleListSize(Integer articleListSize) {
		this.articleListSize = articleListSize;
	}
	public Integer getSlideSize() {
		return slideSize;
	}
	public void setSlideSize(Integer slideSize) {
		this.slideSize = slideSize;
	}
	public String getAdminUsername() {
		return adminUsername;
	}
	public void setAdminUsername(String adminUsername) {
		this.adminUsername = adminUsername;
	}
	public String getAdminPassword() {
		return adminPassword;
	}
	public void setAdminPassword(String adminPassword) {
		this.adminPassword = adminPassword;
	}
	@Override
	public String toString() {
		return "Settings [id=" + id + ", siteDomain=" + siteDomain + ", siteName=" + siteName + ", articleListSize="
				+ articleListSize + ", slideSize=" + slideSize + ", adminUsername=" + adminUsername + ", adminPassword="
				+ adminPassword + "]";
	}
	public Settings(Integer id, String siteDomain, String siteName, Integer articleListSize, Integer slideSize,
			String adminUsername, String adminPassword) {
		super();
		this.id = id;
		this.siteDomain = siteDomain;
		this.siteName = siteName;
		this.articleListSize = articleListSize;
		this.slideSize = slideSize;
		this.adminUsername = adminUsername;
		this.adminPassword = adminPassword;
	}
	public Settings() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
