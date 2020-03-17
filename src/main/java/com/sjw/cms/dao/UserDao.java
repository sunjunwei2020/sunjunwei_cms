package com.sjw.cms.dao;

import java.util.List;

import com.sjw.cms.entity.User;

public interface UserDao {

	List<User> selects(User user);

	int updateLocked(User user);

	int insert(User user);

	User selectUsername(User user);

	User selectByUsername(String username);

	
}
