package com.service.teacher;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jhg.common.DateUtils;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
public class TeacherViewCheckAction extends Action{
	public void getTermInf(){
		String result=""; 
		TeacherViewCheckService service=new TeacherViewCheckService();
		result=(service.getTermInf()).toString();
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void getTableInf(){
		String term_no = request.getParameter("term_no");
		String teacher_no = request.getParameter("tea_no");
		String result=""; 
		if( term_no == null||teacher_no==null) {
			ExecResult rs = new ExecResult(false,"当前学期号传入错误！");
			result = rs.toString();
		} else {
			TeacherViewCheckService service=new TeacherViewCheckService();
			result=(service.getTableInf(term_no,teacher_no)).toString();
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void getTableDetail(){
	
		String task_no = request.getParameter("task_no");
		String result=""; 
		if( task_no==null) {
			ExecResult rs = new ExecResult(false,"教学任务编号传入错误！");
			result = rs.toString();
		} else {
			TeacherViewCheckService service=new TeacherViewCheckService();
			result=(service.getTableDetail(task_no)).toString();
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
