package com.sjw.cms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.sjw.cms.entity.Article;
import com.sjw.cms.entity.User;
import com.sjw.cms.service.ArticleService;
import com.sjw.cms.service.UserService;

@RequestMapping("admin")
@Controller
public class AdminController {
	
	@Autowired
	private ArticleService service;

	@Autowired
	private UserService userService;
	
	@RequestMapping(value={"","/","index"})
	public String index(){
		
		return "admin/index";
	}
	
	@RequestMapping("articles")
	public String articles(Model m,Article article, @RequestParam(defaultValue="1")Integer pageNum,@RequestParam(defaultValue="3")Integer pageSize){
		
		PageInfo<Article> info = service.selects(article, pageNum, pageSize);
		
		m.addAttribute("info",info);
		m.addAttribute("ar", article);
		
		return "admin/articles";
	}
	
	@ResponseBody
	@RequestMapping("uphot")
	public Object uphot(Article article){
		System.out.println(article.getId()+"aaaaaaaaaaaaaaaaaaa"+article.getHot());
		boolean  boo = service.updatehot(article);
		
		return boo;
	}
	
	@ResponseBody
	@RequestMapping("xiangqing")
	public Object xiangqing(Integer id){
		
		Article article = service.select(id);
		
		return article;
	}
	
	/**
	 * 
	 * @Title: updateStatus 
	 * @Description: 修改状态  是否审核通过
	 * @param article
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("updateStatus")
	public Object updateStatus(Article article){
		
		boolean boo = service.updateStatus(article);
	
		return boo;
	}
	
	/***
	 * 
	 * @Title: user 
	 * @Description: 用户管理
	 * @return
	 * @return: String
	 */
	@RequestMapping("users")
	public String user(User user,Model m, @RequestParam(defaultValue="1")Integer pageNum,@RequestParam(defaultValue="3")Integer pageSize){
		
		PageInfo<User> page = userService.selects(user,pageNum,pageSize);
		
		m.addAttribute("info",page);
		m.addAttribute("user",user);
		
		return "admin/user";
	}
	
	/**
	 * 
	 * @Title: updateLocked 
	 * @Description: 修改用户状态  正常 禁用
	 * @param user
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("updateLocked")
	public Object updateLocked(User user){
		boolean boo = userService.updateLocked(user);
		
		return boo;
	}
}
