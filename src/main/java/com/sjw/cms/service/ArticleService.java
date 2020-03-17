package com.sjw.cms.service;

import java.util.List;

import com.github.pagehelper.PageInfo;
import com.sjw.cms.entity.Article;
import com.sjw.cms.entity.Choose;
import com.sjw.cms.entity.ChooseResult;
import com.sjw.cms.entity.Collect;
import com.sjw.cms.entity.User;

public interface ArticleService {

	//插入方法
	int insert(Article article );
	//列表查询方法
	PageInfo<Article> selects(Article article,Integer pageNum,Integer pageSize);
	Article select(Integer id);
	boolean updatehot(Article article);
	boolean updateStatus(Article article);
	//我的收藏
	PageInfo<Collect> selectCollect(User user,Integer pageNum, Integer pageSize);
	List<Article> choose();
	Article articleId(Integer id);
	List<ChooseResult> selectPx();
}
