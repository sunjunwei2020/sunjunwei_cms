package com.sjw.cms.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.sjw.cms.entity.Article;
import com.sjw.cms.entity.Category;
import com.sjw.cms.entity.Channel;
import com.sjw.cms.entity.ChooseResult;
import com.sjw.cms.entity.Collect;
import com.sjw.cms.entity.Comment;
import com.sjw.cms.entity.Slide;
import com.sjw.cms.entity.User;
import com.sjw.cms.service.ArticleService;
import com.sjw.cms.service.ChannelService;
import com.sjw.cms.service.CollectService;
import com.sjw.cms.service.CommentService;
import com.sjw.cms.service.SlideService;

@Controller
public class IndexController {

	@Autowired
	private ChannelService service;
	
	@Autowired
	private ArticleService articleService;
	
	@Autowired
	private SlideService slideService;
	
	@Autowired
	private CommentService commentService;
	
	@Autowired
	private CollectService collectService;
	
	/**
	 * 
	 * @Title: index 
	 * @Description: 进入首页
	 * @param m
	 * @return
	 * @return: String
	 */
	@RequestMapping(value={"","/","index"})
	public String index(Model m,Article article,@RequestParam(defaultValue="1")Integer pageNum,@RequestParam(defaultValue="3")Integer pageSize){
		
		article.setStatus(1);//只显示审核过的文章
		article.setDeleted(0);//只显示未删除的文章
		
		//查询左侧栏目
		List<Channel> list = service.channel();
		
		
		
		//判断 如果栏目id不为空 查询其下所有分类
		if(article.getChannelId()!=null){
			List<Category> category = service.category(article.getChannelId());
		
			m.addAttribute("category",category);
		}
		
		//如果栏目为空  说明没有点击左侧栏目 则默认为热点状态
		if(article.getChannelId()==null){
			article.setHot(1);
			
			//查询轮播图
			List<Slide> slides = slideService.list();
			m.addAttribute("slides",slides);
		}
		
		//查询所有文章
		PageInfo<Article> info = articleService.selects(article, pageNum, pageSize);
				
		//查询10篇最新文章
		Article article2 = new Article();
		article2.setStatus(1);//最新文章只显示审核过的
		article2.setDeleted(0);//最新文章只显示未删除的
		PageInfo<Article> lastArticles = articleService.selects(article2, 1, 10);
		
		
		
		//本月评选
		List<ChooseResult> ch = articleService.selectPx();
		
		m.addAttribute("ch",ch);
		m.addAttribute("lastArticles",lastArticles);
		m.addAttribute("list", list);
		m.addAttribute("article",article);
		m.addAttribute("info",info);
		
		return "index/index";
	}
	
	
	/**
	 * 
	 * @Title: article 
	 * @Description: 文章详情
	 * @param m
	 * @param id
	 * @return
	 * @return: String
	 */
	@RequestMapping("article")
	public String article(Model m,Integer id,HttpSession session,@RequestParam(defaultValue = "1") Integer pageNum,@RequestParam(defaultValue = "5")Integer pageSize){
		//查询文章
		Article article = articleService.select(id);
		
		/*User user = (User) session.getAttribute("user");
		Integer userId = user.getId();
		article.setUserId(userId);*/
		//查询出文章当前的评论信息
		PageInfo<Comment> info = commentService.selects(article, pageNum, pageSize);
		
		//查询出所有文章的评论
		PageInfo<Comment> info2 = commentService.selectsByCommentNum(1,10);
		
		//查询该文章是否被收藏过
		User user = (User) session.getAttribute("user");
		Collect collect = null;
		//如果用户已经登录 则查询是否收藏过文章
		if(user!=null){
			collect = collectService.selectByTitleAndUserId(article.getTitle(), user.getId());
		}
		
		
		m.addAttribute("collect",collect);
		m.addAttribute("article",article);
		m.addAttribute("info",info);
		m.addAttribute("info2",info2);
		
		return "index/article";
	}
	
	/**
	 * 
	 * @Title: collect 
	 * @Description: 收藏文章
	 * @param collect
	 * @param session
	 * @return
	 * @return: boolean
	 */
	@ResponseBody
	@RequestMapping("collect")
	public boolean collect(Collect collect,HttpSession session){
		
		User user = (User) session.getAttribute("user");
		//没有登录 则不能收藏
		if(user == null){
			return false;
		}
		
		collect.setUser(user);
		collect.setCreated(new Date());
		
		return collectService.insert(collect);
	
	}
	
	/**
	 * 
	 * @Title: deletecollect 
	 * @Description: 取消收藏文章
	 * @param id
	 * @return
	 * @return: boolean
	 */
	@ResponseBody
	@RequestMapping("deleteCollect")
	public boolean deletecollect(Integer id){
		
		return collectService.delete(id);
	}
	
	
	/**
	 * 
	 * @Title: addComment 
	 * @Description: 增加评论
	 * @return
	 * @return: boolean
	 */
	@ResponseBody
	@RequestMapping("addComment")
	public boolean addComment(Comment comment,Integer articleId,HttpSession session){
		//获取session中的信息
		User user = (User) session.getAttribute("user");
		//判断 如果用户为空没有登录 则不能评论
		if(user == null){
			return false;
		}
		
		comment.setUserId(user.getId());
		comment.setArticleId(articleId);
		comment.setCreated(new Date());
		
		boolean boo = commentService.insert(comment)>0;
		
		return boo;
		
	}
	
}
