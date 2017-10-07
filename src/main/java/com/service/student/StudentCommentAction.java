package com.service.student;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.teacher.TeacherListenService;

public class StudentCommentAction extends Action{
	public void getStuCommentResult(){
		String Class_No=request.getParameter("Class_no");
		String student_no=request.getParameter("student_no");
		String result="";
		if(Class_No==null||student_no==null){
			ExecResult error=new ExecResult(false,"学生或老师信息传入错误！");
			result=error.toString();
		}else{
			StudentCommentService service=new StudentCommentService();
			result=(service.getStuCommentResult(Class_No,student_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void getStuCommentTable(){
		String tableflag=request.getParameter("flag");
		String result="";
		if(tableflag==null){
			ExecResult er=new ExecResult(false,"评教课程标记传入错误！");
			result=er.toString();
		}else{
			StudentCommentService service=new StudentCommentService();
			result=(service.getStuCommentTable(tableflag)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void getStuCommentInf(){
		String Class_no=request.getParameter("class_no");
		String term_no=request.getParameter("term_no");
		String result="";
		if(Class_no==null){
			ExecResult err=new ExecResult(false,"课程编码传入错误！");
			result=err.toString();
		}else{
			StudentCommentService service=new StudentCommentService();
			result=(service.getStuCommentInf(Class_no,term_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void postComment(){
		String stu_no=request.getParameter("stu_no");
		String task_no=request.getParameter("task_no");
		String status=request.getParameter("status");
		String jxjy=request.getParameter("jxjy");
		String jxpj=request.getParameter("jxpj");
		String total=request.getParameter("total");
		String fields=request.getParameter("fields");

		Map<String,String>param=new HashMap();
		if(fields!=null){
			String [] fieldsarr=fields.split(",");
			for(int i=0;i<fieldsarr.length;i++){
				param.put(fieldsarr[i], request.getParameter(fieldsarr[i]));
			}
		}
		param.put("fields", fields);
		param.put("jxjy", jxjy);
		param.put("jxpj", jxpj);
		param.put("total", total);
		param.put("stu_no", stu_no);
		param.put("task_no", task_no);
		param.put("status", status);
		
		
		StudentCommentService service=new StudentCommentService();
		String result=(service.postComment(param)).toString();
		
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void getTableMobile(){
		String flag=request.getParameter("flag");
		String student_no=request.getParameter("student_no");
		String task_no=request.getParameter("task_no");
		String result=""; 
		StudentCommentService service=new StudentCommentService();
		result=(service.getTableMobile(flag , student_no , task_no)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void postCommentMobile(){
		String stu_no=request.getParameter("student_no");
		String task_no=request.getParameter("task_no");
		String flag=request.getParameter("flag");
		String jxjy=request.getParameter("jxjy");
		String jxpj=request.getParameter("jxpj");
		String per=request.getParameter("perAll");
		String perAll [] = null;
		if(!per.equals("") && !(per == null)){
			perAll = per.split("-");
		}
	
		
		StudentCommentService service=new StudentCommentService();
		String result=(service.postCommentMobile(stu_no , task_no ,flag ,jxjy ,jxpj ,perAll)).toString();
		
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
