package com.sjw.cms.dao;

import java.util.List;

import com.sjw.cms.entity.Article;
import com.sjw.cms.entity.Choose;
import com.sjw.cms.entity.ChooseResult;
import com.sjw.cms.entity.Collect;
import com.sjw.cms.entity.User;

public interface ArticleDao {
	//插入
	int insert(Article article);
	//列表查询
	List<Article> select(Article article);
	
	Article sele(Integer id);
	
	int updatehot(Article article);
	int updatestatus(Article article);
	//查询我的收藏
	List<Collect> selectCollect(Integer id);
	List<Article> choose();
	Article articleId(Integer id);
	Integer selectA();
	Integer selectB();
	Integer selectC();
	Integer selectD();
	Integer selectSum();
}
