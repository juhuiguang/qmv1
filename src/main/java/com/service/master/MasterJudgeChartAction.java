package com.service.master;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import com.jhg.mvc.Action;
import com.service.teacher.TeacherViewJudgeService;

public class MasterJudgeChartAction extends Action{
	public void getyearInf(){
		String result=""; 
		MasterJudgeChartService service=new MasterJudgeChartService();
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
		String dep_no= request.getParameter("dep_no");
		String year_no = request.getParameter("year_no"); 
		MasterJudgeChartService service=new MasterJudgeChartService(); 
		result=(service.getgrand(dep_no,year_no)).toString(); 
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void getTeacherInf(){
		String result=""; 
		String teacher_no = request.getParameter("teacher_no");
		String year_no = request.getParameter("year_no");
		MasterJudgeChartService service=new MasterJudgeChartService();
		result=(service.getTeacherInf(teacher_no , year_no)).toString(); 
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void changegrade(){
		String result=""; 
		String teacher_no= request.getParameter("teacher_no");
		String year_no = request.getParameter("year_no"); 
		String grade = request.getParameter("grade"); 
		MasterJudgeChartService service=new MasterJudgeChartService(); 
		result=(service.changegrade(teacher_no,year_no,grade)).toString(); 
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
