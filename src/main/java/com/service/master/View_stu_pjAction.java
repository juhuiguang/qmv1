package com.service.master;

import java.io.IOException;

import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class View_stu_pjAction extends Action{
	public void gettableinformation(){
		String term_no=request.getParameter("term_no");
		String dep_no=request.getParameter("dep_no");
		String result="";
		JSONObject jo=new JSONObject();
		if(dep_no==null){
			ExecResult er=new ExecResult(false,"部门编号传入错误！");
			result=er.toString();
		}else{
			View_stu_pjService service=new View_stu_pjService();
			result=(service.gettableinformationService(dep_no,term_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void gettermnoinformation(){
		String result="";
		JSONObject jo=new JSONObject();{
			View_stu_pjService service=new View_stu_pjService();
		result=(service.gettermnoinformationService()).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

	
	public void getmodeltableinformation(){
		String term_no=request.getParameter("term_no");
		String class_no=request.getParameter("class_no");
		String result="";
		JSONObject jo=new JSONObject();
		if(class_no==null){
			ExecResult er=new ExecResult(false,"班级编号传入错误！");
			result=er.toString();
		}else{
			View_stu_pjService service=new View_stu_pjService();
			result=(service.getmodeltableinformationService(class_no,term_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void getsearchinformation(){
		String term_no=request.getParameter("term_no");
		String dep_no=request.getParameter("dep_no");
		String class_name=request.getParameter("class_name");
		String result="";
		JSONObject jo=new JSONObject();
		if(dep_no==null || class_name==null){
			ExecResult er=new ExecResult(false,"搜索信息传入错误传入错误！");
			result=er.toString();
		}else{
			View_stu_pjService service=new View_stu_pjService();
			result=(service.getsearchinformationService(dep_no,term_no,class_name)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public void getwpjstusinfo(){
		String class_no=request.getParameter("class_no");
	    String term_no=request.getParameter("term_no");
	    String task_no=request.getParameter("task_no");
		String result="";
		JSONObject js=new JSONObject();
		if(class_no==null){
			ExecResult er=new ExecResult(false,"班级编号传入错误！");
			result=er.toString();
		}else{
			View_stu_pjService service=new View_stu_pjService();
			result=(service.getwpjstusinfo(class_no,term_no,task_no)).toString();
		}
		try {
			System.out.println(result);
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
