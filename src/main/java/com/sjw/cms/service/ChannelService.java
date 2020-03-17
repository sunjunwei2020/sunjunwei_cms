package com.sjw.cms.service;

import java.util.List;

import com.sjw.cms.entity.Category;
import com.sjw.cms.entity.Channel;

public interface ChannelService {

	List<Channel> channel();

	List<Category> category(Integer cid);


}
