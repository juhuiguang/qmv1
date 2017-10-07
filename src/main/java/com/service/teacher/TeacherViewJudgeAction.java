package com.service.teacher;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
public class TeacherViewJudgeAction extends Action{
	public void getTermInf(){
		String result=""; 
		String teacher_no = request.getParameter("tea_no");
		TeacherViewJudgeService service=new TeacherViewJudgeService();
		result=(service.getTermInf(teacher_no)).toString(); 
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void getyearInf(){
		String result=""; 
		TeacherViewJudgeService service=new TeacherViewJudgeService();
		result=(service.getyearInf()).toString(); 
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void getgrand(){
		String result=""; 
		String teacher_no = request.getParameter("tea_no");
		String dep_no= request.getParameter("dep_no");
		String year_no = request.getParameter("year_no");
		TeacherViewJudgeService service=new TeacherViewJudgeService();
		result=(service.getgrand(teacher_no,dep_no,year_no)).toString(); 
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
