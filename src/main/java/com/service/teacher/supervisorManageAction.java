package com.service.teacher;

import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.student.MassService;
import com.service.student.TeacherCenterService;

public class supervisorManageAction extends Action {
	public void loadall(){
		String result = "";
		supervisorService service = new supervisorService();
		result = (service.loadall()).toString();
	try {
		response.getWriter().write(result);
	} catch (IOException e) {
		// TODO: handle exception
		e.printStackTrace();
	}
		
	}
	public void loadallcollege() {
		String dep_no = request.getParameter("dep_no");
		String result = "";
		if(dep_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			supervisorService service = new supervisorService();
			result = (service.loadallcollege(dep_no)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadchange() {
		String teacher_no = request.getParameter("teacher_no");
		String master_status = request.getParameter("master_status");
		String result = "";
		if(teacher_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			supervisorService service = new supervisorService();
			result = (service.loadchange(teacher_no,master_status)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loaddelete() {
		String teacher_no = request.getParameter("teacher_no");
		String master_type = request.getParameter("master_type");
		String result = "";
		if(teacher_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			supervisorService service = new supervisorService();
			result = (service.loaddelete(teacher_no,master_type)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
