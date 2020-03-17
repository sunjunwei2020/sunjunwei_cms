package com.sjw.cms.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageInfo;
import com.sjw.cms.entity.Article;
import com.sjw.cms.entity.Choose;
import com.sjw.cms.entity.Collect;
import com.sjw.cms.entity.User;
import com.sjw.cms.service.ArticleService;

@RequestMapping("my")
@Controller
public class ArticleController {

	@Autowired
	private ArticleService service;
	
	@RequestMapping(value={"","/","index"})
	public String article(){
		
		return "my/article";
	}
	
	//本月评选
	@RequestMapping("choose")
	public String choose(Model m){
		List<Article> list = service.choose();
		
		m.addAttribute("list",list);
		return "my/choose";
	}
	
	//查询我的文章
	@ResponseBody
	@RequestMapping("articleId")
	public Object articleId(Integer id){
		
		Article article = service.articleId(id);
		
		return article;
	}
	
	
	
	//我的收藏
	@RequestMapping("collect")
	public String collect(Model m,HttpSession session,@RequestParam(defaultValue="1")Integer pageNum,@RequestParam(defaultValue="5")Integer pageSize){
		
		//获取session中用户的数据
		User user = (User) session.getAttribute("user");
		
		PageInfo<Collect> info = service.selectCollect(user,pageNum,pageSize);
		
		m.addAttribute("info", info);
		
		return "my/collect";
	}
	
	
	@ResponseBody
	@RequestMapping("article")
	public Object article(Integer id){
		
		Article article = service.select(id);
		
		return article;
	}
	
	//我的文章
	@RequestMapping("articles")
	public String articles(Model m,HttpSession session,@RequestParam(defaultValue="1")Integer pageNum,@RequestParam(defaultValue="3")Integer pageSize ){
		
		Article article = new Article();
		
		//从session中获取用户信息
		User user = (User) session.getAttribute("user");
		
		article.setUserId(user.getId());
		
		PageInfo<Article> page = service.selects(article,pageNum,pageSize);
		
		m.addAttribute("info", page);
		
		return "my/articles";
	}
	
	@RequestMapping("publish")
	public String publish(){
		
		return "my/publish";
	}
	
	/**
	 * 
	 * @Title: publishb 
	 * @Description: 发布文章
	 * @param file
	 * @param article
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("publishb")
	public Object publishb(HttpSession session,MultipartFile file,Article article){
		//文件上传
		if(!file.isEmpty()){
			String path="d:/pic/";
			//文件的原始名称 .png
			String filename = file.getOriginalFilename();
			//重新起名
			String newFileName = UUID.randomUUID().toString()+filename.substring(filename.lastIndexOf("."));
			//创建文件
			File f = new File(path,newFileName);
			//把文件写入硬盘
			try {
				file.transferTo(f);
				article.setPicture(newFileName);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		//文章初始化数据
		//从session中获取用户信息
		User user = (User) session.getAttribute("user");
				
		article.setUserId(user.getId());//发布人
		article.setCreated(new Date());
		article.setHits(0);//点击量默认0
		article.setDeleted(0);//默认未删除
		article.setHot(0);//默认非热门
		article.setStatus(0);//默认待审核
		
		return service.insert(article)>0;
		
	}
}
