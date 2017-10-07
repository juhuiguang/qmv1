package com.service.student;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class Student_survey_Action extends Action {

	public void getStuTable() {
		String termflag = request.getParameter("termno");
		String result = "";
		if(termflag == null) {
			ExecResult rs = new ExecResult(false,"学生学号学期号获取错误！");
			result = rs.toString();
		} else {
			Student_survey_Service service = new Student_survey_Service();
			result = (service.getStuTable(termflag)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public void postListen(){
		String stu_no=request.getParameter("stu_no");
		String term_no=request.getParameter("term_no");
		String survey_name_one=request.getParameter("survey_name_one");
		String survey_name_two=request.getParameter("survey_name_two");
		String result_one=request.getParameter("result_one");
		String result_two=request.getParameter("result_two");
		Map<String,String>param=new HashMap();		
		param.put("result_one", result_one);
		param.put("result_two", result_two);
		param.put("stu_no", stu_no);
		param.put("term_no", term_no);
		param.put("survey_name_one", survey_name_one);
		param.put("survey_name_two", survey_name_two);
		Student_survey_Service service=new Student_survey_Service();
		String result=(service.postListen(param)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void judgedata(){
		String stu_no=request.getParameter("stu_no");
		String term_no=request.getParameter("term_no");
		Student_survey_Service service=new Student_survey_Service();
		String result=(service.judgedata(stu_no,term_no)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
