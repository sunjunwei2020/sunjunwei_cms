package com.sjw.cms.service;

import com.github.pagehelper.PageInfo;
import com.sjw.cms.entity.User;

public interface UserService {

	PageInfo<User> selects(User user, Integer pageNum, Integer pageSize);

	boolean updateLocked(User user);

	Boolean insert(User user);

	User selectUsername(User user);

	User selectByUsername(String username);

	User login(User user);
}
