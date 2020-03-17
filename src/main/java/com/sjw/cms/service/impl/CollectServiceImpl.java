package com.sjw.cms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sjw.cms.dao.CollectDao;
import com.sjw.cms.entity.Collect;
import com.sjw.cms.service.CollectService;
import com.sjw.cms.util.CMSException;
import com.sjw.common.utils.StringUtil;

@Service
public class CollectServiceImpl implements CollectService {

	
	@Autowired
	private CollectDao dao;
	
	
	//收藏文章
	@Override
	public boolean insert(Collect collect) {
		//调用工具类 判断是否是正确的链接
		if(!StringUtil.isHttpUrl(collect.getUrl())){
			throw new CMSException("不是合法的链接");
		}
		
		return dao.insert(collect)>0;
	}
	
	//取消收藏文章
	@Override
	public boolean delete(Integer id) {
		
		return dao.delete(id)>0;
	}
	
	//查询收藏文章
	@Override
	public List<Collect> selects(Integer userId) {
		
		return dao.selects(userId);
	}
	
	//查询文章是否被收藏
	@Override
	public Collect selectByTitleAndUserId(String title, Integer userId) {
		
		return dao.selectByTitleAndUserId(title, userId);
	}
	
}
