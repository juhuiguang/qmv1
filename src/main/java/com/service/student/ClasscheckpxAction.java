package com.service.student;

import java.io.IOException;

import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.master.Checkteacherpxservice;

public class ClasscheckpxAction extends Action{
	public void gettermnoinformation(){
		String result="";
		JSONObject jo=new JSONObject();{
			ClasscheckpxService service=new ClasscheckpxService();
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
		String class_no=request.getParameter("class_no");
		String result="";
		JSONObject jo=new JSONObject();
		if(class_no==null){
			ExecResult er=new ExecResult(false,"班级编号传入错误！");
			result=er.toString();
		}else{
			ClasscheckpxService service=new ClasscheckpxService();
			result=(service.gettableinformationService(class_no,term_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void getteaclass(){
		String teacher_no=request.getParameter("teacher_no");
		String result="";
		JSONObject jo=new JSONObject();
		if(teacher_no==null){
			ExecResult er=new ExecResult(false,"教师工号传入错误！");
			result=er.toString();
		}else{
			ClasscheckpxService service=new ClasscheckpxService();
			result=(service.getteaclassService(teacher_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public void getstuclass(){
		String stu_no=request.getParameter("stu_no");
		String result="";
		JSONObject jo=new JSONObject();
		if(stu_no==null){
			ExecResult er=new ExecResult(false,"信息员编号传入错误！");
			result=er.toString();
		}else{
			ClasscheckpxService service=new ClasscheckpxService();
			result=(service.getstuclassService(stu_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
