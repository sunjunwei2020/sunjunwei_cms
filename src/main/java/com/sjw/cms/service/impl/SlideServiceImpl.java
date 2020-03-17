package com.sjw.cms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sjw.cms.dao.SlideDao;
import com.sjw.cms.entity.Slide;
import com.sjw.cms.service.SlideService;

@Service
public class SlideServiceImpl implements SlideService {

	@Autowired
	private SlideDao dao;

	@Override
	public List<Slide> list() {
		
		return dao.list();
	}
	
	
}
