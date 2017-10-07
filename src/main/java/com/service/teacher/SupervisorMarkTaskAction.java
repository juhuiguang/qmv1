package com.service.teacher;

import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.sun.org.apache.regexp.internal.REUtil;

public class SupervisorMarkTaskAction extends Action {
	
	public void getSupSearchTea() {
		String teaname = request.getParameter("teaname");
		String termno = request.getParameter("termno");
		String result = "";
		if(teaname == null || termno == null) {
			ExecResult er = new ExecResult(false,"教师姓名或学期号获取失败！");
			result = er.toString();
		} else {
			SupervisorMarkTaskService service = new SupervisorMarkTaskService();
			result = (service.getSupSearchTea(teaname,termno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getSupSearchCourse() {
		String coursename = request.getParameter("coursename");
		String termno = request.getParameter("termno");
		String result = "";
		if(coursename == null || termno == null) {
			ExecResult er = new ExecResult(false,"课程名或学期号获取失败！");
			result = er.toString();
		} else {
			SupervisorMarkTaskService service = new SupervisorMarkTaskService();
			result = (service.getSupSearchCourse(coursename,termno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getSupMarkTask() {
		String supno = request.getParameter("supno");
		String depno = request.getParameter("depno");
		String termno = request.getParameter("termno");
		String result = "";
		if(supno == null || depno == null || termno == null) {
			ExecResult er = new ExecResult(false,"登录用户工号或院系编号或学期号获取失败！");
			result = er.toString();
		} else {	
			    SupervisorMarkTaskService service = new SupervisorMarkTaskService();
				result = (service.getSupMarkTask(supno,depno,termno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getSupMarkTaskXQ() {
		String depno = request.getParameter("depno");
		String termno = request.getParameter("termno");
		String coursename = request.getParameter("coursename");
		String result = "";
		if( depno == null || termno == null || coursename == null) {
			ExecResult er = new ExecResult(false,"部门编号或学期号或课程名称获取失败！");
			result = er.toString();
		} else {
			SupervisorMarkTaskService service = new SupervisorMarkTaskService();
			result = (service.getSupMarkTaskXQ(depno,termno,coursename)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getSupMarkTaskADD(){
		String supno = request.getParameter("supno");
		String taskno = request.getParameter("taskno");
		String termno = request.getParameter("termno");
		String result = "";
		if( supno == null || taskno == null || termno == null) {
			ExecResult er = new ExecResult(false,"教工号或教学任务号或学期号获取失败！");
			result = er.toString();
		} else {
			SupervisorMarkTaskService service = new SupervisorMarkTaskService();
			result = (service.getSupMarkTaskADD(supno,taskno,termno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
}
