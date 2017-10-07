package com.service.student;

import java.io.IOException;

import com.jhg.mvc.Action;

public class PostSetManageAction extends Action {

	public void getPostInfor() {
		String result = "";
		PostSetManageService service = new PostSetManageService();
		result = (service.getPostInfor()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void savePostData() {
		String post_name = request.getParameter("post_name");
		String post_times = request.getParameter("post_times");
		String status = request.getParameter("status"); 
		String result = ""; 
		PostSetManageService service = new PostSetManageService();
		result = (service.savePostData(post_name,post_times,status)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void UpdPostSinglData() {
		String post_no = request.getParameter("post_no");
		String post_name = request.getParameter("post_name");
		String post_times = request.getParameter("post_times"); 
		String status = request.getParameter("status");  
		String result = ""; 
		PostSetManageService service = new PostSetManageService();
		result = (service.UpdPostSinglData(post_no,post_name,post_times,status)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void DelPostSinglData() {
		String post_no = request.getParameter("post_no");
		String result = ""; 
		PostSetManageService service = new PostSetManageService();
		result = (service.DelPostSinglData(post_no)).toString(); 
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
