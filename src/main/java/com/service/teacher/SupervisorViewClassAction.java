package com.service.teacher;

import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class SupervisorViewClassAction extends Action {
	
	public void getViewTerm() {
		String result ="";
		SupervisorViewClassService service = new SupervisorViewClassService();
		result = (service.getViewTerm()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	public void getSupViewClass() {
		String supnoflag = request.getParameter("supno");
		String depnameflag = request.getParameter("depname");
		String termnoflag = request.getParameter("termno");
		String result ="";
		if(supnoflag == null || depnameflag == null || termnoflag == null) {
			ExecResult er = new ExecResult(false,"登录用户工号或院系号或学期号获取错误！");
			result = er.toString();
		} else {
			SupervisorViewClassService service = new SupervisorViewClassService();
			result = (service.getSupViewClass(supnoflag,depnameflag,termnoflag)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getSupViewClassXQ() {
		String teanoflag = request.getParameter("teano");
		String termnoflag = request.getParameter("termno");
		String result2 = "";
		if(teanoflag == null || termnoflag == null) {
			ExecResult er = new ExecResult(false,"教师工号或学期号获取错误");
			result2 = er.toString();
		} else {
			SupervisorViewClassService service = new SupervisorViewClassService();
			result2 = (service.getSupViewClassXQ(teanoflag,termnoflag)).toString();
		}
		try {
			response.getWriter().write(result2);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getDetails() {
		String teano = request.getParameter("teano");
		String taskno = request.getParameter("taskno");
		String termno = request.getParameter("termno");
		String result = "";
		if(teano == null || taskno == null || termno == null) {
			ExecResult er = new ExecResult(false,"教师工号或教学号或学期号获取错误");
			result = er.toString();
		} else {
			SupervisorViewClassService service = new SupervisorViewClassService();
			result = (service.getDetails(teano,taskno,termno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getAllTerm() {
		String result="";
		SupervisorViewClassService service = new SupervisorViewClassService();
		result=(service.getAllTerm()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
