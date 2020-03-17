package com.sjw.cms.dao;

import java.util.List;

import com.sjw.cms.entity.Category;
import com.sjw.cms.entity.Channel;

public interface ChannelDao {

	List<Channel> channel();

	List<Category> category(Integer cid);

}
