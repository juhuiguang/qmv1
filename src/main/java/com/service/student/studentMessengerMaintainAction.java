package com.service.student;

import java.io.IOException;

import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.master.Master_view_stu_pjService;
import com.sys.RoleUserConfigService;

public class studentMessengerMaintainAction extends Action {

	public void getClassInfor() {
		String stuno = request.getParameter("stuno");
		String termno = request.getParameter("termno");
		String classid = request.getParameter("classid");
		String flag = request.getParameter("flag");
		String result = "";
		if(stuno == null || termno == null || classid == null || flag == null) {
			ExecResult rs = new ExecResult(false,"学生学号或学期号或班级号或标记号获取失败！");
			result = rs.toString();
		} else {
			studentMessengerMaintainService service = new studentMessengerMaintainService();
			if(flag.equals("0")) {
				result = (service.getClassInfor(stuno,termno)).toString();	
			} else {
				result = (service.TeaClassInfor(classid,termno)).toString();	
			}
					
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
		studentMessengerMaintainService service = new studentMessengerMaintainService();
		result=(service.getAllTerm()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void DeleteStu() {
		String termno = request.getParameter("termno");
		String stuno = request.getParameter("stuno");
		String result = "";
		if(termno == null || stuno == null) {
			ExecResult rs = new ExecResult(false,"学生学号或学期号获取失败！");
			result = rs.toString();
		} else {
			studentMessengerMaintainService service = new studentMessengerMaintainService();
			result = (service.DeleteStu(stuno,termno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getMajorClass(){
		String termno = request.getParameter("termno");
		String result=""; 
		if(termno == null) {
			ExecResult rs = new ExecResult(false,"学期号获取失败！");
			result = rs.toString();
		} else {
			studentMessengerMaintainService service = new studentMessengerMaintainService();
			result=(service.getMajorClass(termno)).toString(); 		
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block   
			e.printStackTrace();
		}
	}
	
	public void StuUpdata() {
		String termno = request.getParameter("termno");
		String stuno = request.getParameter("stuno");
		String majorno = request.getParameter("majorno");
		String classno = request.getParameter("classno");
		String result=""; 
		if(termno == null || stuno == null || majorno == null || classno == null) {
			ExecResult rs = new ExecResult(false,"学期号或学号或专业名称号或班级号获取失败！");
			result = rs.toString();
		} else {
			studentMessengerMaintainService service = new studentMessengerMaintainService();
			result=(service.StuUpdata(termno,stuno,majorno,classno)).toString(); 		
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block   
			e.printStackTrace();
		}
	}
	
	public void getStudent() {
		String termno = request.getParameter("termno");
		String result=""; 
		if(termno == null) {
			ExecResult rs = new ExecResult(false,"学期号获取失败！");
			result = rs.toString();
		} else {
			studentMessengerMaintainService service = new studentMessengerMaintainService();
			result=(service.getStudent(termno)).toString(); 		
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block   
			e.printStackTrace();
		}
	}
	
	public void StuAdd() {
		String termno = request.getParameter("termno");
		String stuno = request.getParameter("stuno");
		String majorno = request.getParameter("majorno");
		String classno = request.getParameter("classno");
		String result=""; 
		if(termno == null || stuno == null || majorno == null || classno == null) {
			ExecResult rs = new ExecResult(false,"学期号或学号或专业名称号或班级号获取失败！");
			result = rs.toString();
		} else {
			studentMessengerMaintainService service = new studentMessengerMaintainService();
			result=(service.StuAdd(termno,stuno,majorno,classno)).toString(); 		
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block   
			e.printStackTrace();
		}
	}
	
	public void getClasses() {
		String teano = request.getParameter("teano");
		String result = "";
		if(teano == null) {
			ExecResult rs = new ExecResult(false,"班主任号获取失败！");
			result = rs.toString();
		} else {
			studentMessengerMaintainService service = new studentMessengerMaintainService();
			result=(service.getClasses(teano)).toString(); 		
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block   
			e.printStackTrace();
		}
	}

}
