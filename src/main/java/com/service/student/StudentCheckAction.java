package com.service.student;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
public class StudentCheckAction extends Action {
	public void getStuCheckInf() {
		String tea_no = request.getParameter("tea_no");
		String term_no = request.getParameter("term_no");
		String result = "";
		if(tea_no == null || term_no == null) {
			ExecResult rs = new ExecResult(false,"当前学期号或教工号传入错误！");
			result = rs.toString();
		} else {
			StudentCheckService service = new StudentCheckService();
			result = (service.getStuCheckInf(tea_no, term_no)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public void getStuCheckClassInf() {
		String sche_no = request.getParameter("sche_no"); 
		String term_no = request.getParameter("term_no");
		String course_type = request.getParameter("course_type");
		String result = "";
		if(sche_no == null||term_no == null ) {
			ExecResult rs = new ExecResult(false,"当前学期号或教工号传入错误！");
			result = rs.toString();
		} else {
			StudentCheckService service = new StudentCheckService();
			result = (service.getStuCheckClassInf(sche_no,term_no,course_type)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public void getStuStatus() {
		String sche_no = request.getParameter("sche_no");
		String currentweek = request.getParameter("currentweek");
		String term_no = request.getParameter("term_no");
		String result = "";
		System.out.println(term_no);
		if(sche_no == null||currentweek == null ||term_no == null) {
			ExecResult rs = new ExecResult(false,"当前学期号或教工号传入错误！");
			result = rs.toString();
		} else {
			StudentCheckService service = new StudentCheckService();
			result = (service.getStuStatus(sche_no,currentweek,term_no)).toString();	
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void changeStuStatus() {
		String mainid = request.getParameter("mainid");
		String stu_no = request.getParameter("stu_no");
		String check_status= request.getParameter("check_status");
		String old_check_status= request.getParameter("old_check_status");
		String result = "";
		Map<String,String>param=new HashMap();
		if(mainid == null||stu_no == null||check_status == null||old_check_status == null ) {
			ExecResult rs = new ExecResult(false,"主表ID或学号或缺勤状态传入错误！");
			result = rs.toString();
		}
		param.put("mainid", mainid);
		param.put("stu_no", stu_no);
		param.put("check_status", check_status);
		param.put("old_check_status", old_check_status);
		
		StudentCheckService service=new StudentCheckService();
		result=(service.changeStuStatus(param)).toString();
		
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public void saveStuStatus() {
		String mainid = request.getParameter("mainid");
		String stu_no = request.getParameter("stu_no");
		String check_status= request.getParameter("check_status");
		String result = "";
		Map<String,String>param=new HashMap();
		if(mainid == null||stu_no == null||check_status == null ) {
			ExecResult rs = new ExecResult(false,"主表ID或学号或缺勤状态传入错误！");
			result = rs.toString();
		}
		param.put("mainid", mainid);
		param.put("stu_no", stu_no);
		param.put("check_status", check_status);
		
		StudentCheckService service=new StudentCheckService();
		result=(service.saveStuStatus(param)).toString();
		
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public void removeStuStatus() {
		String mainid = request.getParameter("mainid");
		String stu_no = request.getParameter("stu_no");
		String check_status= request.getParameter("check_status");
		String result = "";
		Map<String,String>param=new HashMap();
		if(mainid == null||stu_no == null||check_status == null ) {
			ExecResult rs = new ExecResult(false,"主表ID或学号或缺勤状态传入错误！");
			result = rs.toString();
		}
		param.put("mainid", mainid);
		param.put("stu_no", stu_no);
		param.put("check_status", check_status);
		
		StudentCheckService service=new StudentCheckService();
		result=(service.removeStuStatus(param)).toString();
		
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getsxStuStatus() {
		String sche_no = request.getParameter("sche_no");
		String currentweek = request.getParameter("currentweek");
		String term_no = request.getParameter("term_no");
		String check_sx = request.getParameter("check_sx");
		String result = ""; 
		if(sche_no == null||currentweek == null ||term_no == null) {
			ExecResult rs = new ExecResult(false,"当前学期号或教工号传入错误！");
			result = rs.toString();
		} else {
			StudentCheckService service = new StudentCheckService();
			result = (service.getsxStuStatus(sche_no,currentweek,term_no,check_sx)).toString();	
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public void postsxStuStatus() {
		String sche_no = request.getParameter("sche_no");
		String currentweek = request.getParameter("currentweek");
		String term_no = request.getParameter("term_no");
		String check_sx = request.getParameter("check_sx");
		String check_kk=request.getParameter("check_kk");
		String check_cd=request.getParameter("check_cd");
		String check_zt=request.getParameter("check_zt");
		String check_qj=request.getParameter("check_qj");
		String check_count=request.getParameter("stu_count");
		String check_ratio=request.getParameter("check_ratio");
		String result = "";
		if(sche_no == null||currentweek == null ||term_no == null) {
			ExecResult rs = new ExecResult(false,"当前学期号或教工号传入错误！");
			result = rs.toString();
		} else {
			StudentCheckService service = new StudentCheckService();
			result = (service.postsxStuStatus(sche_no,currentweek,term_no,check_sx,check_kk,check_cd,check_zt,check_qj,check_count,check_ratio)).toString();	
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public void postStuStatus() {
		String sche_no = request.getParameter("sche_no");
		String currentweek = request.getParameter("currentweek");
		String term_no = request.getParameter("term_no");
		String check_kk=request.getParameter("check_kk");
		String check_cd=request.getParameter("check_cd");
		String check_zt=request.getParameter("check_zt");
		String check_qj=request.getParameter("check_qj");
		String check_count=request.getParameter("stu_count");
		String check_ratio=request.getParameter("check_ratio");
		String result = "";
		if(sche_no == null||currentweek == null ||term_no == null) {
			ExecResult rs = new ExecResult(false,"当前学期号或教工号传入错误！");
			result = rs.toString();
		} else {
			StudentCheckService service = new StudentCheckService();
			result = (service.postStuStatus(sche_no,currentweek,term_no,check_kk,check_cd,check_zt,check_qj,check_count,check_ratio)).toString();	
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public void getsxweeksSta() { 
		String sche_no = request.getParameter("sche_no");
		String term_no = request.getParameter("term_no");
		String check_sx = request.getParameter("check_sx");    
		
		System.out.println(sche_no);   
		System.out.println(term_no);   
		System.out.println(check_sx); 
		String result = "";
		if(sche_no==null||check_sx==null ||term_no==null) {
			ExecResult rs = new ExecResult(false,"当前学期号或sche_no或实训节次传入错误！");
			result = rs.toString();
		} else {
			StudentCheckService service = new StudentCheckService();
			result = (service.getsxweeksSta(sche_no,term_no,check_sx)).toString();	
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception    
			e.printStackTrace(); 
		}
	}
	public void getweeksSta() {
		String sche_no = request.getParameter("sche_no");
		String term_no = request.getParameter("term_no");

		String result = ""; 
		if(sche_no == null||term_no == null) {
			ExecResult rs = new ExecResult(false,"当前学期号或sche_no传入错误！");
			result = rs.toString();
		} else {
			StudentCheckService service = new StudentCheckService();
			result = (service.getweeksSta(sche_no,term_no)).toString();	
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getCheckRecord() {
		String check_sche_no = request.getParameter("check_sche_no");

		String result = ""; 
		if(check_sche_no == null) {
			ExecResult rs = new ExecResult(false,"当前sche_no传入错误！");
			result = rs.toString();
		} else {
			StudentCheckService service = new StudentCheckService();
			result = (service.getCheckRecord(check_sche_no)).toString();	
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadSwitch() {
		String term_no = request.getParameter("term_no");

		String result = "";
		StudentCheckService service = new StudentCheckService();
		result = (service.loadSwitch(term_no)).toString();	
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
