package com.sjw.cms.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sjw.cms.dao.UserDao;
import com.sjw.cms.entity.User;
import com.sjw.cms.service.UserService;
import com.sjw.cms.util.CMSException;
import com.sjw.cms.util.Md5Util;
import com.sjw.common.utils.StringUtil;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao dao;

	@Override
	public PageInfo<User> selects(User user, Integer pageNum, Integer pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		
		List<User> list = dao.selects(user);
		
		return new PageInfo<>(list);
	}

	@Override
	public boolean updateLocked(User user) {
		int i = dao.updateLocked(user);
		return i>0;
	}
	
	/**
	 * 注册
	 */
	@Override
	public Boolean insert(User user) {
		
		//用户名不能为空
		if(StringUtil.hasText(user.getUsername())){
			throw new CMSException("用户名不能为空");
		}
		//用户名长度
		if(user.getUsername().length()<2 || user.getUsername().length()>10){
			throw new CMSException("用户名的长度在2-10之间");
		}
		//验证用户名
		User findUser = this.selectByUsername(user.getUsername());
		if(findUser!=null){
			throw new CMSException("用户名已经被注册");
		}
		//密码校验
		if(StringUtil.hasText(user.getPassword())){
			throw new CMSException("密码不能为空");
		}
		//密码长度
		if(user.getPassword().length()<6 || user.getPassword().length()>10){
			throw new CMSException("密码长度在6-10之间");
		}
		//确认密码
		if(StringUtil.hasText(user.getRepassword())){
			throw new CMSException("确认密码不能为空");
		}
		if(!user.getRepassword().equals(user.getPassword())){
			throw new CMSException("两次密码输入不一致");
		}
		
		//给密码赋值 并且对密码进行加密处理
		user.setPassword(Md5Util.encode(user.getPassword()));
		//初始用户的注册信息
		user.setCreated(new Date());//注册时间
		user.setNickname(user.getUsername());//默认用户昵称为用户名
		user.setLocked("0");//默认用户状态为0  正常的
		
		//执行注册
		int i = dao.insert(user);
		
		return i>0;
	}

	@Override
	public User selectUsername(User user) {
		
		return dao.selectUsername(user);
	}
	
	@Override
	public User selectByUsername(String username) {
		return dao.selectByUsername(username);
	}

	/**
	 * 登录
	 */
	@Override
	public User login(User user) {
		//验证 用户名不能为空
		if(StringUtil.hasText(user.getUsername())){
			throw new CMSException("用户名不能为空");
		}
		//验证用户名是否存在
		User u = this.selectByUsername(user.getUsername());
		if(u == null){
			throw new CMSException("该用户名不存在");
		}
		//判断密码是否一致,数据库密码是加密后存储的
		//先对登录密码进行加密  然后进行判断
		if(!Md5Util.encode(user.getPassword()).equals(u.getPassword())){
			throw new CMSException("密码不正确，请重新录入");
		}
		//判断账号是否被禁用
		if(u.getLocked().equals("1")){
			throw new CMSException("当前账号已被禁用");
		}
			
		return u;
	}
	
	
}
