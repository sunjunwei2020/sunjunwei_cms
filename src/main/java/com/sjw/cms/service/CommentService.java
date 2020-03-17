package com.sjw.cms.service;

import com.github.pagehelper.PageInfo;
import com.sjw.cms.entity.Article;
import com.sjw.cms.entity.Comment;

public interface CommentService {

	/**
	 * 
	 * @Title: insert 
	 * @Description: 增加评论
	 * @param comment
	 * @return
	 * @return: int
	 */
	int insert(Comment comment);
	/**
	 * 
	 * @Title: selects 
	 * @Description: 根据文章查询文章评论
	 * @param article
	 * @return
	 * @return: List<Comment>
	 */
	PageInfo<Comment> selects(Article article,Integer page,Integer pageSize);
	PageInfo<Comment> selectsByCommentNum(int i, int j);
}
