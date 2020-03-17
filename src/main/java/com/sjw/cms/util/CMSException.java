package com.sjw.cms.util;

public class CMSException extends RuntimeException{

	/**
	 * @fieldName: serialVersionUID
	 * @fieldType: long
	 * @Description: TODO
	 */
	private static final long serialVersionUID = 1L;
	
	
	private String message;//异常消息


	public String getMessage() {
		return message;
	}


	public void setMessage(String message) {
		this.message = message;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	@Override
	public String toString() {
		return "CMSException [message=" + message + "]";
	}


	public CMSException(String message) {
		super();
		this.message = message;
	}


	public CMSException() {
		super();
		// TODO Auto-generated constructor stub
	}


	public CMSException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
		// TODO Auto-generated constructor stub
	}


	public CMSException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}


	public CMSException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}
	
	
	
	
}
