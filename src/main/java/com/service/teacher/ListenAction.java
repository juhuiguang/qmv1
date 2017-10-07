package com.service.teacher;

import java.io.IOException;
import java.util.List;

import com.alibaba.fastjson.JSONArray;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.teacher.bean.TaskObject;

public class ListenAction extends Action{
	public void getTasks(){
		String type=request.getParameter("type");
		String keywords=request.getParameter("keywords");
		String dep_no=request.getParameter("dep_no");
		
		ListenService service=new ListenService();
		JSONArray tasks=service.getTasks(type, keywords, dep_no);
		List<TaskObject> tos=service.genTaskObject(tasks);
		
		ExecResult er=new ExecResult();
		er.setResult(true);
		er.setData(JSONArray.parseArray(JSONArray.toJSONString(tos)));
		try {
			response.getWriter().write(er.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getTeachers(){
		ListenService service=new ListenService();
		String teacher=request.getParameter("teacher");    
		ExecResult er=service.getTeachers(teacher);
		if(er.getResult()>0){
			JSONArray ja=er.getData();
			try {
				response.getWriter().write(ja.toJSONString());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public void getMarkedTeacher(){
		ListenService service=new ListenService();
		String teacher=request.getParameter("teacher");
		ExecResult er=service.getMarkTeacher(teacher);
		try {
			response.getWriter().write(er.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getMasterPlan(){
		String master_no=request.getParameter("master_no");
		String week=request.getParameter("week");
		ListenService service=new ListenService();
		ExecResult er=service.getMasterPlan(week, master_no);
		try {
			response.getWriter().write(er.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void judgeSupLisBut() {
		ListenService service=new ListenService();
		ExecResult er=service.judgeSupLisBut();
		try {
			response.getWriter().write(er.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getSinglCourseFileData() {
		String termno = request.getParameter("termno");
		String courseno = request.getParameter("courseno");
		String teano = request.getParameter("teano");
		String result = "";
		if(termno == null || courseno == null ||  teano == null) {
			ExecResult er = new ExecResult(false,"学期号或课程编码或教工号获取失败！");
			result = er.toString();
		} else {
			ListenService service=new ListenService();
			result = (service.getSinglCourseFileData(termno,courseno,teano)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
