package com.sjw.cms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sjw.cms.dao.ChannelDao;
import com.sjw.cms.entity.Category;
import com.sjw.cms.entity.Channel;
import com.sjw.cms.service.ChannelService;

@Service
public class ChannelServiceImpl implements ChannelService {

	@Autowired
	private ChannelDao dao;

	@Override
	public List<Channel> channel() {
		
		return dao.channel();
	}

	@Override
	public List<Category> category(Integer cid) {
		
		return dao.category(cid);
	}
	
	
}
