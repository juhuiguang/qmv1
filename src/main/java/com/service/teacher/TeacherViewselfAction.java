package com.service.teacher;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.student.StudentCheckService;

public class TeacherViewselfAction extends Action{
	public void getTermInf(){
		String result=""; 
		TeacherViewselfService service=new TeacherViewselfService();
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
			TeacherViewselfService service=new TeacherViewselfService();
			result=(service.getTableInf(term_no,teacher_no)).toString();
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
