package com.service.student;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class PostSettingAction extends Action {

	public void loadposttype() {
		String result ="";
		PostSettingService service=new PostSettingService();
		result=(service.loadposttype()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadpost() {
		String job_type=request.getParameter("job_type");
		String result ="";
		if(job_type == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			PostSettingService service=new PostSettingService();
			result=(service.loadpost(job_type)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadchange() {
		String job_type=request.getParameter("job_type");
		String job_name=request.getParameter("job_name");
		String job_kh=request.getParameter("job_kh");
		String result ="";
		if(job_type == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			PostSettingService service=new PostSettingService();
			result=(service.loadchange(job_type,job_name,job_kh)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public void loaddelete() {
		String job_type=request.getParameter("job_type");
		String job_name=request.getParameter("job_name");
		String result ="";
		if(job_type == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			PostSettingService service=new PostSettingService();
			result=(service.loaddelete(job_type,job_name)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadadd() {
		String job_type=request.getParameter("job_type");
		String job_name=request.getParameter("job_name");
        String result="";
		Map<String,String>param=new HashMap();
		param.put("job_type", job_type);
		param.put("job_name", job_name);
			PostSettingService service=new PostSettingService();
			result=(service.loadadd(param)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	
	
	
}
