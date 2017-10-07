package com.service.master;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action; 
public class MasterViewJudgeAction extends Action{
	public void getTermInf(){
		String result=""; 
		MasterViewJudgeService service=new MasterViewJudgeService();
		result=(service.getTermInf()).toString();
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getjudgerule(){
		String term_no = request.getParameter("term_no");
		String tea_no = request.getParameter("tea_no");
		String result=""; 
		if( term_no == null) {
			ExecResult rs = new ExecResult(false,"当前学期号传入错误！");
			result = rs.toString();
		} else {
			MasterViewJudgeService service=new MasterViewJudgeService();
			result=(service.getjudgerule(term_no , tea_no)).toString();
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
			MasterViewJudgeService service=new MasterViewJudgeService();
			result=(service.getteacher(dep_no,term_no)).toString();
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void savescore(){
		String term_no = request.getParameter("term_no");
		String teacher_no = request.getParameter("teacher_no");
		String score = request.getParameter("score");
		String field = request.getParameter("field");
		String newsum = request.getParameter("newsum");
		String result=""; 
		if( teacher_no==null) {
			ExecResult rs = new ExecResult(false,"当前教工号传入错误！");
			result = rs.toString();
		} else {
			MasterViewJudgeService service=new MasterViewJudgeService();
			result=(service.savescore(term_no,teacher_no,score,field,newsum)).toString();
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
			MasterViewJudgeService service=new MasterViewJudgeService();
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
			MasterViewJudgeService service=new MasterViewJudgeService();
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
