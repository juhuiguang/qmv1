package com.service.student;

import java.io.IOException;

import com.alibaba.fastjson.JSONObject;
import com.jhg.mvc.Action;
import com.service.app.AppService;

public class TeacherCheckAction extends Action {
	public void checkInfo() {
		String currentWeek = request.getParameter("currentWeek");
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no"); 
		String course_type = request.getParameter("course_type"); 
		TeacherCheckService service = new TeacherCheckService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.checkInfo(currentWeek, teacher_no, term_no ,course_type )));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getStudentCheckInfo() {
		String selectedWeek = request.getParameter("selectedWeek");
		String check_main_no = request.getParameter("check_main_no");
		String term_no = request.getParameter("term_no"); 
		String course_type = request.getParameter("course_type"); 
		String class_no = request.getParameter("class_no");
		String course_set = request.getParameter("course_set"); 
		String sche_no = request.getParameter("sche_no"); 
		TeacherCheckService service = new TeacherCheckService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.getStudentCheckInfo(selectedWeek, check_main_no, term_no ,course_type , class_no,course_set,sche_no)));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void postStuStatus() {
		String check_main_no = request.getParameter("check_main_no");
		String stu_no = request.getParameter("stu_no");
		String check_status = request.getParameter("check_status");
		TeacherCheckService service = new TeacherCheckService();
		try {
			response.getWriter()
					.write(JSONObject.toJSONString(service.postStuStatus(check_main_no, stu_no, check_status)));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void postMainCheckInfo() {
		String check_main_no = request.getParameter("check_main_no");
		String check_kk = request.getParameter("check_kk");
		String check_cd = request.getParameter("check_cd");
		String check_zt = request.getParameter("check_zt");
		String check_qj = request.getParameter("check_qj");
		String check_count = request.getParameter("check_count");
		String check_ratio = request.getParameter("check_ratio");
		String jsws = request.getParameter("jswsValue"); 
		String ktjl = request.getParameter("ktjlValue");
		TeacherCheckService service = new TeacherCheckService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.postMainCheckInfo(check_main_no, check_kk,
					check_cd, check_zt, check_qj, check_count, check_ratio ,jsws ,ktjl)));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void checkRecordInfo() {
		String currentWeek = request.getParameter("currentWeek");
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no");
		TeacherCheckService service = new TeacherCheckService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.checkRecordInfo(currentWeek, teacher_no, term_no)));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void checkRecordDetail() {
		String course_week = request.getParameter("course_week");
		String sche_no = request.getParameter("sche_no");
		String course_type = request.getParameter("course_type");
		TeacherCheckService service = new TeacherCheckService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.checkRecordDetail(course_week, sche_no, course_type)));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
