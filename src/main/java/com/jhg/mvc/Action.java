package com.jhg.mvc;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.serializer.JSONSerializer;
import com.jhg.common.DataType;
import com.jhg.common.RequestUtils;
import com.jhg.common.TypeUtils;


/**
 * action 请求
 *
 */
public class Action{
	
	protected  HttpServletRequest  request;
	
	protected  HttpServletResponse response;
	
	/**
	 * Ajax 标志
	 */
	private    boolean isAjax =  false;
	
		
	public HttpServletRequest getRequest() {
		return request;
	}
	

	@SuppressWarnings("unused")
	private void setRequest(HttpServletRequest request) {		
	   this.request     =  request; 
	 //�?测请求是否是Ajax请求
	   boolean isAjax0  =  RequestUtils.Boolean(this.request, "ajax") || RequestUtils.Boolean(this.request, "AJAX");
	   if(!isAjax0)
	   {
		   isAjax0 =  request.getHeader("X_REQUESTED_WITH")!=null ? true : false;
	   }
	   isAjax=isAjax0;
	  
	}
	
	public HttpServletResponse getResponse() {
		return response;
	}
	
	@SuppressWarnings("unused")
	private void setResponse(HttpServletResponse response) {
		this.response = response;
	}
	

	public boolean  isAjax(){
		return this.isAjax;
	}
	
	/**
	 * 设置成Ajax请求,则用Ajax方式返回响应
	 */
	public  void setAjax(){
		 this.isAjax  =  true;
	}
	
	private void setAjax(final boolean isAjax){
		 this.isAjax  =  isAjax;
	}
	
	public  void assign(DataType dataType, String s, Object obj){
		if(DataType.DATA == dataType)
		{
		   request.setAttribute(s, obj);	 
		}
		else if(DataType.STATUS==dataType)
		{
		  request.setAttribute("__STATUS", obj);	
		}
		else if(DataType.MSG==dataType)
		{
		  request.setAttribute("__MSG",obj);	
		}
	}
		
	public  void assign(String s, Object obj){
		assign(DataType.DATA,s, obj);
	}
		
	protected PrintWriter getWriter()
	{
		 try {
			return response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null; 		
	}
	
	

	/**
	 * 如果参数为空 默认是调用Ajax方式返回
	 */
	 protected void display(){
		 display("");	
	 }
	 
     protected void display(String url){
    	if(url==null || url.equals(""))
    	{
    	   this.setAjax();
    	}    	
 		if(isAjax)
        {
           ajaxWrite();
        }
        else
        {
           nonAjaxWrite();
           forward(url);
        }
	 }
	     
     /**
      * 非Ajax方式返回  实现服务器内部跳�? 
      * @param url
      */
     public void forward(String url){
    	setAjax(false);
    	 try {
			request.getRequestDispatcher(url).forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
     }
     
     /**
      * 非Ajax方式返回 实现浏览器重定向跳转
      * @param url
      */
     public void redirect(String url)
     {  
    	setAjax(false);
        try {
			response.sendRedirect(url);
		} catch (IOException e) {
			e.printStackTrace();
		}
     }
     
     
 	/**
 	 * 返回非Ajax 数据
 	 */
 	 private void nonAjaxWrite(){ 	  
 		Object stauts_0=request.getAttribute("__STATUS");
 		if(stauts_0!=null)
 		{
 		   request.setAttribute("stauts", stauts_0);
 		}
 		request.removeAttribute("__STATUS");
 		Object msg_0=request.getAttribute("__MSG");
 		if(msg_0!=null)
 		{
 		   request.setAttribute("msg", msg_0);
 		}
 		request.removeAttribute("__MSG");		
 	 }
 	 
	 /**
	 * 序列化Ajax 数据
	 */
	 private void ajaxWrite(){
	     Hashtable<String, Object> ajaxReturn = new Hashtable<String, Object>();
		 ajaxReturn.put("stauts", 1);
		 ajaxReturn.put("msg", "");
		 ajaxReturn.put("data", new Object());
		 		
		 Hashtable<String, Object> data      = new Hashtable<String, Object>();
		  
		 Object stauts_0 = request.getAttribute("__STATUS");
		 if (stauts_0 != null) {
			try {
				data.put("stauts", Integer.parseInt(stauts_0.toString()));
			} catch (NumberFormatException e) {
			}
		 }
		 request.removeAttribute("__STATUS");
		 ajaxReturn.put("msg", TypeUtils.getString(request.getAttribute("__MSG")));
		 request.removeAttribute("__MSG");
		 for (Enumeration<?> e = request.getAttributeNames(); e.hasMoreElements();) {
			 String name = e.nextElement().toString();
			 data.put(name, request.getAttribute(name));
		 }
		 ajaxReturn.put("data", data);
		 PrintWriter wirter= this.getWriter();
		 if(wirter!=null)
		 {
			wirter.flush(); 
			JSONSerializer.write(wirter,ajaxReturn);
		 }
	}

}
