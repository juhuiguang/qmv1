package com.service.base;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.master.MasterViewJudgeService; 
public class BaseJudgeAction extends Action {
	public void getTermInf(){
		String result=""; 
		BaseJudgeService service=new BaseJudgeService();
		result=(service.getTermInf()).toString();
		try { 
			response.getWriter().write(result); 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void getDepInf(){
		String result=""; 
		BaseJudgeService service=new BaseJudgeService();
		result=(service.getDepInf()).toString();
		try { 
			response.getWriter().write(result); 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void getjudgerule(){
		String term_no = request.getParameter("term_no");
		String result=""; 
		if( term_no == null) {
			ExecResult rs = new ExecResult(false,"当前学期号传入错误！");
			result = rs.toString();
		} else {
			BaseJudgeService service=new BaseJudgeService();
			result=(service.getjudgerule(term_no )).toString();
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void getteacher(){
		String dep_no = request.getParameter("dep_no");
		String term_no = request.getParameter("term_no");
		String result=""; 
		if( dep_no==null) {
			ExecResult rs = new ExecResult(false,"当前部门编号传入错误！");
			result = rs.toString();
		} else {
			BaseJudgeService service=new BaseJudgeService();
			result=(service.getteacher(dep_no,term_no)).toString(); 
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public void getddtk(){
		String term_no = request.getParameter("term_no");
		String teacher_no = request.getParameter("teacher_no");
		String result=""; 
		if( teacher_no==null) {
			ExecResult rs = new ExecResult(false,"当前教工号传入错误！");
			result = rs.toString();
		} else {
			BaseJudgeService service=new BaseJudgeService();
			result=(service.getddtk(term_no,teacher_no)).toString();
		}
		try {  
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void getxspj(){
		String term_no = request.getParameter("term_no");
		String teacher_no = request.getParameter("teacher_no");
		String result=""; 
		if( teacher_no==null) {
			ExecResult rs = new ExecResult(false,"当前教工号传入错误！");
			result = rs.toString();
		} else {
			BaseJudgeService service=new BaseJudgeService();
			result=(service.getxspj(term_no,teacher_no)).toString();
		}
		try {  
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
