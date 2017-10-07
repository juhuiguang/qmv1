package com.service.student;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jhg.common.DateUtils;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.teacher.TeacherViewCommentService;
public class ClassViewCommentAction extends Action{
	public void getTermInf(){
		String result=""; 
		ClassViewCommentService service=new ClassViewCommentService();
		result=(service.getTermInf()).toString();
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}  
	public void getClassPJD(){
		String termno = request.getParameter("termno");
		String userno = request.getParameter("userno");
		String flag = request.getParameter("flag");
		String result = ""; 
		if( termno == null||userno == null) {
			ExecResult rs = new ExecResult(false,"学期号或用户号传入错误！");
			result = rs.toString();
		} else {
			ClassViewCommentService service=new ClassViewCommentService();
			result=(service.getClassPJD(termno,userno,flag)).toString();
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void getClassPJDetailD(){
		String taskno = request.getParameter("taskno");
		String classno = request.getParameter("classno"); 
		String termno = request.getParameter("termno"); 
		String result=""; 
		if( taskno == null || classno == null || termno == null) {
			ExecResult rs = new ExecResult(false,"教学任务编号或班级编号或学期号传入错误！");
			result = rs.toString();
		} else {
			ClassViewCommentService service=new ClassViewCommentService();
			result=(service.getClassPJDetailD(taskno,classno,termno)).toString();
		}
		try { 
			response.getWriter().write(result); 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getClasses() {
		String userno = request.getParameter("userno");            
		String result = "";
		if(userno == null) {
			ExecResult rs = new ExecResult(false,"用户登录号获取失败！");
			result = rs.toString();
		} else {
			ClassViewCommentService service=new ClassViewCommentService(); 
			result=(service.getClasses(userno)).toString(); 		
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block   
			e.printStackTrace();
		}
	}

}
