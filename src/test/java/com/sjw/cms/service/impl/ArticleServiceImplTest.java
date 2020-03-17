package com.sjw.cms.service.impl;

import static org.junit.Assert.*;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.pagehelper.PageInfo;
import com.sjw.cms.entity.Article;
import com.sjw.cms.service.ArticleService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-beans.xml")
public class ArticleServiceImplTest {

	@Autowired
	private ArticleService service;
	//插入
	@Test
	public void testInsert() {
		Article ac = new Article();
		ac.setTitle("test");
		ac.setUserId(1);
		ac.setChannelId(1);
		ac.setCategoryId(1);
		ac.setContent("蛇哥啊啊啊啊");
		ac.setCreated(new Date());
		
		service.insert(ac);
	}
	//查询
	@Test
	public void testSelects() {
		Article article = new Article(); 
		PageInfo<Article> pageInfo = service.selects(article,1,5);
		System.out.println(pageInfo);
	}
	
	@Test
	public void testSelectsa() {
		Integer aa = -1;
		System.out.println(aa);
	}

}
