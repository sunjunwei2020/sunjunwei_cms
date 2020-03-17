package com.sjw.cms.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sjw.cms.entity.User;
import com.sjw.cms.service.UserService;
import com.sjw.cms.util.CMSException;
import com.sjw.cms.util.Result;

@RequestMapping("passport")
@Controller
public class PassportController {

	
	@Autowired
	private UserService service;
	
	/**
	 * 
	 * @Title: reg 
	 * @Description: 去註冊
	 * @return
	 * @return: String
	 */
	@RequestMapping("reg")
	public String reg(){
		
		return "passport/reg";
	}
	
	/**
	 * 
	 * @Title: toReg 
	 * @Description: 執行註冊
	 * @param user
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("toReg")
	public Result<User> toReg(User user,Model m){
		Result<User> result = new Result<>();
		
		try {
			if(service.insert(user)){
				result.setCode(200);//成功
				result.setMsg("注册成功");
			}
		} catch (CMSException e) {
			//如果是自定义异常
			e.printStackTrace();
			result.setCode(300);//失败
			result.setMsg("注册失败:"+e.getMessage());
		}catch (Exception e) {
			//不可预知的异常
			e.printStackTrace();
			result.setCode(500);
			result.setMsg("注册失败,系统出现不可预知的异常,请联系管理员");
		}
		
		return result;
	}
	
	/**
	 * 
	 * @Title: login 
	 * @Description: 去登录--普通用户
	 * @return
	 * @return: String
	 */
	@RequestMapping("login")
	public String login(){
		
		return "passport/login";
	}
	
	/**
	 * 
	 * @Title: login 
	 * @Description: 去登录--管理员
	 * @return
	 * @return: String
	 */
	@RequestMapping("admin/login")
	public String adminlogin(){
		
		return "passport/adminlogin";
	}
	
	/**
	 * 
	 * @Title: loginTo 
	 * @Description: 执行登录
	 * @param user
	 * @param m
	 * @param session
	 * @return
	 * @return: Result<User>
	 */
	@ResponseBody
	@RequestMapping("loginTo")
	public Result<User> loginTo(User user,Model m,HttpSession session){
		Result<User> result = new Result<>();
		
		try {
			//去登录，如果登录成功则 返回用户的基本信息
			User u = service.login(user);
			//判断是否有该用户
			if(u != null){
				result.setCode(200);//登录成功
				result.setMsg("登录成功");
				//判断是否是管理员
				if(u.getRole()==1){
					//等于1 为管理员
					session.setAttribute("admin",u);					
				}else{
					//普通用户
					session.setAttribute("user",u);
				}
			}
		} catch (CMSException e) {//自定义异常
			e.printStackTrace();
			result.setCode(300);//登录失败
			result.setMsg("登录失败:"+e.getMessage());
		}catch (Exception e) {//不可预知的异常
			e.printStackTrace();
			result.setCode(500);//登录失败 不可预知的异常
			result.setMsg("登录失败，系统出现不可预知异常，请联系管理员");
		}
	
		
		return result;
	}
	
	
	
	
	
	
	
	/**
	 * 
	 * @Title: logout 
	 * @Description: 用户注销
	 * @param session
	 * @return
	 * @return: String
	 */
	@RequestMapping("logout")
	public String logout(HttpSession session){
		
		//清除session
		session.invalidate();
		
		return "redirect:/";//重定向 回到系统首页
	}
	
	/**
	 * 
	 * @Title: checkName 
	 * @Description: 检查用户名是否存在
	 * @param username
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("checkName")
	public boolean checkName(String username){
			//如果返回结果等于null  说明没有该用户  返回true
		return service.selectByUsername(username)==null;
	}
	
}
