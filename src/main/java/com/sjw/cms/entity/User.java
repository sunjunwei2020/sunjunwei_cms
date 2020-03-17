package com.sjw.cms.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 
 * @ClassName: User 
 * @Description: 用户信息
 * @author: 挪威的森林
 * @date: 2020年3月3日 下午2:39:07
 */
public class User implements Serializable{

	/**
	 * @fieldName: serialVersionUID
	 * @fieldType: long
	 * @Description: TODO
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String username;
	private String nickname;//昵称
	
	private String password;
	private String repassword;//确认密码
	public String getRepassword() {
		return repassword;
	}
	public void setRepassword(String repassword) {
		this.repassword = repassword;
	}
	private Date birthday;
	private String gender;
	private String locked;//用户账号信息 0：正常   1：禁用
	private Date created;//注册时间
	private Date updated;//修改时间
	private Integer role;//用户角色
	
	
	
	public Integer getRole() {
		return role;
	}
	public void setRole(Integer role) {
		this.role = role;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getLocked() {
		return locked;
	}
	public void setLocked(String locked) {
		this.locked = locked;
	}
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}
	public Date getUpdated() {
		return updated;
	}
	public void setUpdated(Date updated) {
		this.updated = updated;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", nickname=" + nickname + ", password=" + password
				+ ", birthday=" + birthday + ", gender=" + gender + ", locked=" + locked + ", created=" + created
				+ ", updated=" + updated + "]";
	}
	public User(Integer id, String username, String nickname, String password, Date birthday, String gender,
			String locked, Date created, Date updated) {
		super();
		this.id = id;
		this.username = username;
		this.nickname = nickname;
		this.password = password;
		this.birthday = birthday;
		this.gender = gender;
		this.locked = locked;
		this.created = created;
		this.updated = updated;
	}
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
