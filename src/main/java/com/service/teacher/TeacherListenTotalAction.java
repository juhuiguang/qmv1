package com.service.teacher;

import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class TeacherListenTotalAction extends Action {
 
	public void getTeaLisInfor() {
		String term_no = request.getParameter("term_no");
		String dep_no = request.getParameter("dep_no");
		String result = "";
		if(term_no == null || dep_no == null) {
			ExecResult er = new ExecResult(false,"学期号或部门号获取失败！");
			result = er.toString();
		} else {
			TeacherListenTotalService service = new TeacherListenTotalService();
			result = (service.getTeaLisInfor(term_no,dep_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getSinglDepLisInfor() {
		String term_no = request.getParameter("term_no");
		String dep_no = request.getParameter("dep_no");
		String result = "";
		if(term_no == null || dep_no == null) {
			ExecResult er = new ExecResult(false,"学期号或部门号获取失败！");
			result = er.toString();
		} else {
			TeacherListenTotalService service = new TeacherListenTotalService();
			result = (service.getSinglDepLisInfor(term_no,dep_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
	}
	
	public void getSinglDepTeaInfor() {
		String term_no = request.getParameter("term_no");
		String tea_no = request.getParameter("tea_no");
		String result = "";
		if(term_no == null || tea_no == null) {
			ExecResult er = new ExecResult(false,"学期号或教工号获取失败！");
			result = er.toString();
		} else {
			TeacherListenTotalService service = new TeacherListenTotalService();
			result = (service.getSinglDepTeaInfor(term_no,tea_no)).toString();
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getJobTeaLisInfor() {
		String term_no = request.getParameter("term_no");
		String result = "";
		if(term_no == null) {
			ExecResult er = new ExecResult(false,"学期号获取失败！");
			result = er.toString();
		} else {
			TeacherListenTotalService service = new TeacherListenTotalService();
			result = (service.getJobTeaLisInfor(term_no)).toString();
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getSinglJobLisInfor() {
		String term_no = request.getParameter("term_no");
		String job_no = request.getParameter("job_no");
		String result = "";
		if(term_no == null || job_no == null) {
			ExecResult er = new ExecResult(false,"学期号或岗位号获取失败！");
			result = er.toString();
		} else {
			TeacherListenTotalService service = new TeacherListenTotalService();
			result = (service.getSinglJobLisInfor(term_no,job_no)).toString();
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
