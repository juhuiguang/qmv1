package com.service.base;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.master.MasterJudgeChartService;
import com.service.master.MasterViewJudgeService; 
public class BaseJudgeChartAction extends Action{
	public void getdepInf(){
		String result="";  
		BaseJudgeChartService service=new BaseJudgeChartService();
		result=(service.getdepInf()).toString(); 
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block 
			e.printStackTrace(); 
		}
	}
	public void getyearInf(){
		String result=""; 
		BaseJudgeChartService service=new BaseJudgeChartService();
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
		BaseJudgeChartService service=new BaseJudgeChartService(); 
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
		BaseJudgeChartService service=new BaseJudgeChartService();
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
		BaseJudgeChartService service=new BaseJudgeChartService(); 
		result=(service.changegrade(teacher_no,year_no,grade)).toString(); 
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
