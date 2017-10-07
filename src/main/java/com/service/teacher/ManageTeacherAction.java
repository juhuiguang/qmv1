package com.service.teacher;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.master.Checkteacherpxservice;

public class ManageTeacherAction extends Action {
	
	public void gettermnoinformation(){
		String result="";
		JSONObject jo=new JSONObject();{
			ManageTeacherService service=new ManageTeacherService();
		result=(service.gettermnoinformationService()).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	public void getjobinformation(){
		String result="";
		JSONObject jo=new JSONObject();{
			ManageTeacherService service=new ManageTeacherService();
		result=(service.getjobinformationService()).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void getDepartmentTeacher(){
		String pageindex=request.getParameter("pageindex");
		String pagelength=request.getParameter("pagelength");
		String dep_no=request.getParameter("dep_no");
		String temppage=request.getParameter("temppage");
		String term_no=request.getParameter("term_no");
		String result="";
		JSONObject jo=new JSONObject();
		if(dep_no==null){
			ExecResult er=new ExecResult(false,"部门标号传入错误！");
			result=er.toString();
		}else{
			ManageTeacherService service=new ManageTeacherService();
			ExecResult r1=(service.getTeacherInfTable(dep_no,/*Integer.parseInt(pageindex),Integer.parseInt(pagelength),*/term_no));
/*			if(Integer.parseInt(temppage)==1){
				ExecResult r2=(service.getTeacherCount(dep_no,term_no));
			    jo.put("total",r2.getData().getJSONObject(0).getString("totalrows"));
			    System.out.println(r2);
			}
*/			jo.put("rows",r1.getData());
			result=jo.toJSONString();	
		};
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getvoidTeacher(){
		String term_no=request.getParameter("term_no");
		String dep_no=request.getParameter("dep_no");
		String result="";
		    ManageTeacherService service=new ManageTeacherService();
		    ExecResult r1=(service.getVoidteacherservice(term_no,dep_no));
			result=r1.toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void changeteacherjob(){
		String term_no=request.getParameter("term_no");
		String teacher_no=request.getParameter("teacher_no");
		String job_no=request.getParameter("job_no");
		String result="";
		if(teacher_no==null || job_no==null ||term_no==null){
			ExecResult er=new ExecResult(false,"数据传入错误！");
			result=er.toString();
		}else{
		    ManageTeacherService service=new ManageTeacherService();
		    ExecResult r1=(service.changeteacherjobservice(term_no,teacher_no,job_no));
			result=r1.toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public void searchTeacher(){
		String dep_no=request.getParameter("dep_no");
		String teacher_name=request.getParameter("teacher_name");
		String term_no=request.getParameter("term_no");
		String result="";
		    ManageTeacherService service=new ManageTeacherService();
		    ExecResult r1=(service.searchteacherservice(teacher_name,term_no,dep_no));
			result=r1.toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void searchlocalTeacher(){
		String teacher_name=request.getParameter("teacher_name");
		String dep_no=request.getParameter("dep_no");
		String term_no=request.getParameter("term_no");
		String result="";
		if(dep_no==null){
			ExecResult er=new ExecResult(false,"部门标号传入错误！");
			result=er.toString();
		}else{
		    ManageTeacherService service=new ManageTeacherService();
		    ExecResult r1=(service.searchlocalteacherservice(teacher_name,dep_no,term_no));
			result=r1.toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void addteacher(){
		String dep_no=request.getParameter("dep_no");
		String teacher_no=request.getParameter("teacher_no");
		String term_no=request.getParameter("term_no");
		String job_no=request.getParameter("job_no");
		String result="";
		if(dep_no==null){
			ExecResult er=new ExecResult(false,"部门标号传入错误！");
			result=er.toString();
		}
		ManageTeacherService service=new ManageTeacherService();
		result=(service.addTeacher(dep_no,teacher_no,term_no,job_no)).toString();
		
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	

	public void removeteacher(){
		String teacher_no=request.getParameter("teacher_no");
		String term_no=request.getParameter("term_no");
		String result="";
		if(teacher_no==null){
			ExecResult er=new ExecResult(false,"教师工号传入错误！");
			result=er.toString();
			return ;
		}
		ManageTeacherService service=new ManageTeacherService();
		result=(service.removeTeacher(teacher_no,term_no)).toString();
		
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
