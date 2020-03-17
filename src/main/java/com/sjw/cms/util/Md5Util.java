package com.sjw.cms.util;

import org.apache.commons.codec.digest.DigestUtils;

public class Md5Util {

	//使用加密
	private static String salt = "shege666";
	
	public static String encode(String password){
		
		return DigestUtils.md5Hex(password+salt);
	}
}
