package com.sjw.cms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sjw.cms.dao.CommentDao;
import com.sjw.cms.entity.Article;
import com.sjw.cms.entity.Comment;
import com.sjw.cms.service.CommentService;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentDao dao;
	
	
	@Override
	public int insert(Comment comment) {
		try {
			//增加评论
			 dao.insert(comment);
			//每增加一条评论 让评论数量+1
			dao.updateArticle(comment.getArticleId());
			
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return 0;
	}

	@Override
	public PageInfo<Comment> selects(Article article, Integer page, Integer pageSize) {
		
		PageHelper.startPage(page, pageSize);
		List<Comment> list = dao.selects(article);
		
		return new PageInfo<Comment>(list);
	}

	@Override
	public PageInfo<Comment> selectsByCommentNum(int i, int j) {
		PageHelper.startPage(i, j);
		List<Comment> list = dao.selectsByCommentNum();
		
		return new PageInfo<Comment>(list);
	}

}
