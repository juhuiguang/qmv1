package com.service.student;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.teacher.TeacherListenService;

public class Student_kcb_Action extends Action {

	public void getStuClassno(){
		String class_no=request.getParameter("class_no");
		String term_no=request.getParameter("term_no");
		String stu_no=request.getParameter("stu_no");

		String result="";
		if(class_no==null){
			ExecResult er=new ExecResult(false,"编号传入错误！");
			result=er.toString();
		}else{
			Student_kcb_Service service=new Student_kcb_Service();
			result=(service.getStuClassnoService(class_no,term_no,stu_no)).toString();
		}
		System.out.println(result);
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public void getclassinformation(){
		String class_no=request.getParameter("class_no");
		String result="";
		if(class_no==null){
			ExecResult er=new ExecResult(false,"班级编号传入错误！");
			result=er.toString();
		}else{
			Student_kcb_Service service=new Student_kcb_Service();
			result=(service.getclassinformationService(class_no)).toString();
		}
		System.out.println(result);
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public void getMoblieInfo(){
		String class_no=request.getParameter("class_no");
		String term_no=request.getParameter("term_no");
		String stu_no=request.getParameter("stu_no");
		String result="";
		if(class_no==null||term_no==null||stu_no==null){
			ExecResult er=new ExecResult(false,"数据传入错误！");
			result=er.toString();
		}else{
			Student_kcb_Service service=new Student_kcb_Service();
			result=(service.getMoblieInfo(class_no,term_no,stu_no)).toString();
		}
		System.out.println(result);
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

}
