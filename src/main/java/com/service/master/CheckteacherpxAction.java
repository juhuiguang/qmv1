package com.service.master;

import java.io.IOException;

import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class CheckteacherpxAction extends Action {
	public void gettermnoinformation(){
		String result="";
		JSONObject jo=new JSONObject();{
		Checkteacherpxservice service=new Checkteacherpxservice();
		result=(service.gettermnoinformationService()).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void gettableinformation(){
		String term_no=request.getParameter("term_no");
		String dep_no=request.getParameter("dep_no");
		String result="";
		JSONObject jo=new JSONObject();
		if(dep_no==null){
			ExecResult er=new ExecResult(false,"部门编号传入错误！");
			result=er.toString();
		}else{
			Checkteacherpxservice service=new Checkteacherpxservice();
			result=(service.gettableinformationService(dep_no,term_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	
	public void getclassdetailinformation(){
		String term_no=request.getParameter("term_no");
		String class_no=request.getParameter("class_no");
		String result="";
		JSONObject jo=new JSONObject();
		if(class_no==null){
			ExecResult er=new ExecResult(false,"班级编号传入错误！");
			result=er.toString();
		}else{
			Checkteacherpxservice service=new Checkteacherpxservice();
			result=(service.getclassdetailinformation(class_no,term_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	public void getdetailclassinformation(){
		String term_no=request.getParameter("term_no");
		String class_name=request.getParameter("class_name");
		String dep_no=request.getParameter("dep_no");
		String result="";
		JSONObject jo=new JSONObject();
		if(class_name==null||dep_no==null){
			ExecResult er=new ExecResult(false,"班级名称传入传入错误！");
			result=er.toString();
		}else{
			Checkteacherpxservice service=new Checkteacherpxservice();
			result=(service.getdetailclassinformationService(class_name,term_no,dep_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
