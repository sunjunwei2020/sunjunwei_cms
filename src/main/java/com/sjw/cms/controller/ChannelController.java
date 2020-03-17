package com.sjw.cms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sjw.cms.entity.Category;
import com.sjw.cms.service.ChannelService;

@RequestMapping("channels")
@Controller
public class ChannelController {

	@Autowired
	private ChannelService service;
	
	/**
	 * 
	 * @Title: channel 
	 * @Description: 查询栏目
	 * @return
	 * @return: Object
	 */
	@ResponseBody
	@RequestMapping("channel")
	public Object channel(){
		return service.channel();
	}
	
	
	@ResponseBody
	@RequestMapping("categoryId")
	public List<Category> categoryId(Integer cid){
		List<Category> list = service.category(cid);
		
		return list;
	}
}
