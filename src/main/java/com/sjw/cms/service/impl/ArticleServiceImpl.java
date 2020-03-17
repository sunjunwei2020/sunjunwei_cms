package com.sjw.cms.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sjw.cms.dao.ArticleDao;
import com.sjw.cms.entity.Article;
import com.sjw.cms.entity.Choose;
import com.sjw.cms.entity.ChooseResult;
import com.sjw.cms.entity.Collect;
import com.sjw.cms.entity.User;
import com.sjw.cms.service.ArticleService;
import com.sjw.common.utils.NumberUtil;

@Service
public class ArticleServiceImpl implements ArticleService {

	@Autowired
	private ArticleDao dao;

	@Override
	public int insert(Article article) {
		
		return dao.insert(article);
		
	}

	@Override
	public PageInfo<Article> selects(Article article,Integer pageNum,Integer pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		
		List<Article> list = dao.select(article);
		
		return new PageInfo<Article>(list);
	}

	@Override
	public Article select(Integer id) {
		Article article = dao.sele(id);
		return article;
	}

	@Override
	public boolean updatehot(Article article) {
		int i = dao.updatehot(article);
		return i>0;
	}

	@Override
	public boolean updateStatus(Article article) {
		int i = dao.updatestatus(article);
		return i>0;
	}

	@Override
	public PageInfo<Collect> selectCollect(User user,Integer pageNum, Integer pageSize) {
		
		PageHelper.startPage(pageNum, pageSize);
		
		List<Collect> list = dao.selectCollect(user.getId());
		
		return new PageInfo<Collect>(list);
	}

	@Override
	public List<Article> choose() {
		
		return dao.choose();
	}

	@Override
	public Article articleId(Integer id) {
		
		return dao.articleId(id);
	}

	@Override
	public List<ChooseResult> selectPx() {
		List<ChooseResult> list = new ArrayList<ChooseResult>();
		Integer A = dao.selectA();
		Integer B = dao.selectB();
		Integer C = dao.selectC();
		Integer D = dao.selectD();
		
		Integer sum = dao.selectSum();
		
		int bfbA = NumberUtil.getPercent(A, sum);
		int bfbB = NumberUtil.getPercent(B, sum);
		int bfbC = NumberUtil.getPercent(C, sum);
		int bfbD = NumberUtil.getPercent(D, sum);
		
		ChooseResult result = new ChooseResult();
		result.setA(A);
		result.setB(B);
		result.setC(C);
		result.setD(D);
		result.setBfbA(bfbA);
		result.setBfbB(bfbB);
		result.setBfbC(bfbC);
		result.setBfbD(bfbD);
		result.setSum(sum);
		
		list.add(result);
		return list;
	}
	
	
}
