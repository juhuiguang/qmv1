package com.service.student;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.sun.java_cup.internal.runtime.virtual_parse_stack;

public class TeacherCenterAction extends Action {

	public void get_table_listen() {
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no");
		String result = "";
		if(teacher_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service.get_table_listen(teacher_no,term_no)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void load_time_attendance() {
		String term_no = request.getParameter("term_no");
		String time_one=request.getParameter("time_one");
		String time_two=request.getParameter("time_two");
		String result = "";
		if(term_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service.load_time_attendance(term_no,time_one,time_two)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadallclass() {
		String class_year = request.getParameter("class_year");
		String result = "";
		if(class_year == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service.loadallclass(class_year)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void load_time_college() {
		String term_no = request.getParameter("term_no");
		String dep_no = request.getParameter("dep_no");
		String time_one=request.getParameter("time_one");
		String time_two=request.getParameter("time_two");
		String result = "";
		if(term_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service.load_time_college(term_no,dep_no,time_one,time_two)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadtermyear() {
		TeacherCenterService service = new TeacherCenterService();
		try {
			response.getWriter()
					.write(JSONObject.toJSONString(service.loadtermyear()));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void get_grade_xq() {
		String term_no = request.getParameter("term_no");
		String class_no_two= request.getParameter("class_no_two");
		String class_no_one= request.getParameter("class_no_one");
		String starttime= request.getParameter("starttime");
		String endtime= request.getParameter("endtime");
		String result = "";
		if(class_no_one == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service.get_grade_xq(class_no_one,term_no,class_no_two,term_no,starttime,endtime)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_table_evaluate_numble() {
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no");
		String result = "";
		if(teacher_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service.get_table_evaluate_numble(teacher_no,term_no)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_table_evaluate() {
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no");
		String result = "";
		if(teacher_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service.get_table_evaluate(teacher_no,term_no)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_table_px() {
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no");
		String result = "";
		if(teacher_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service.get_table_px(teacher_no,term_no)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_stu_checking_no() {
		String teacher_no_one = request.getParameter("teacher_no_one");
		String term_no_one = request.getParameter("term_no_one");
		String term_no_two = request.getParameter("term_no_two");
		String teacher_no_two = request.getParameter("teacher_no_two");
		String result = "";
		if(teacher_no_one == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service.get_stu_checking_no(teacher_no_one,term_no_one,term_no_two,teacher_no_two)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_grade_attendace() {
		String term_no = request.getParameter("term_no");
		String dep_no = request.getParameter("dep_no");
		String grade_no = request.getParameter("grade_no");
		String starttime= request.getParameter("starttime");
		String endtime= request.getParameter("endtime");
		String result = "";
		if(term_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service.get_grade_attendace(term_no,dep_no,grade_no,starttime,endtime)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_stu_checking_yes() {
		String teacher_no_one = request.getParameter("teacher_no_one");
		String term_no_one = request.getParameter("term_no_one");
		String term_no_two = request.getParameter("term_no_two");
		String teacher_no_two = request.getParameter("teacher_no_two");
		String result = "";
		if(teacher_no_one == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service.get_stu_checking_yes(teacher_no_one,term_no_one,term_no_two,teacher_no_two)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_stu_checking_leave() {
		String teacher_no_one = request.getParameter("teacher_no_one");
		String term_no_one = request.getParameter("term_no_one");
		String term_no_two = request.getParameter("term_no_two");
		String teacher_no_two = request.getParameter("teacher_no_two");
		String result = "";
		if(teacher_no_one == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service.get_stu_checking_leave(teacher_no_one,term_no_one,term_no_two,teacher_no_two)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	public void get_school_attendancerate() {
		String term_no = request.getParameter("term_no");
		String result = "";
		if(term_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service.get_school_attendancerate(term_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_college_attendancerate() {
		String term_no = request.getParameter("term_no");
		String dep_name = request.getParameter("dep_name");
		String starttime= request.getParameter("starttime");
		String endtime= request.getParameter("endtime");
		String result = "";
		if(term_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service.get_college_attendancerate(term_no,dep_name,starttime,endtime)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_supervisor_tkjl() {
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no");
		String result = "";
		if(teacher_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service. get_supervisor_tkjl(teacher_no,term_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_supervisor_jxrw() {
		String master_teacher_no = request.getParameter("master_teacher_no");
		String term_no = request.getParameter("term_no");
		String result = "";
		if(master_teacher_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service. get_supervisor_jxrw(master_teacher_no,term_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	public void get_supervisor_tkjh() {
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no");
		String result = "";
		if(teacher_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service. get_supervisor_tkjh(teacher_no,term_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_supervisor_bmsk() {
		String term_no = request.getParameter("term_no");
		String college_no = request.getParameter("college_no");
		String result = "";
		if(college_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service. get_supervisor_bmsk(term_no,college_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_supervisor_jxzl() {
		String term_no = request.getParameter("term_no");
		String college_no = request.getParameter("college_no");
		String result = "";
		if(college_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service. get_supervisor_jxzl(term_no,college_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_supervisor_jspx() {
		String term_no = request.getParameter("term_no");
		String college_no = request.getParameter("college_no");
		String result = "";
		if(college_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service. get_supervisor_jspx(term_no,college_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_supervisor_xnkh() {
		String term_no = request.getParameter("term_no");
		String college_no = request.getParameter("college_no");
		String result = "";
		if(college_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service. get_supervisor_xnkh(college_no,term_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_college_pj() {
		String term_no = request.getParameter("term_no");
		String college_no = request.getParameter("college_no");
		String result = "";
		if(college_no == null && term_no==null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service. get_college_pj(term_no,college_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_school_pj() {
		String term_no = request.getParameter("term_no");
		String result = "";
		if(term_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service. get_school_pj(term_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_class_attendancerate() {
		String term_no = request.getParameter("term_no");
		String dep_no = request.getParameter("dep_no");
		String result = "";
		if(term_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service. get_class_attendancerate(term_no,dep_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public void get_checking_person() {
		String stu_no= request.getParameter("stu_no");
		String term_no= request.getParameter("term_no");
		String starttime= request.getParameter("starttime");
		String endtime= request.getParameter("endtime");
		String result = "";
		if(stu_no == null) {
			ExecResult rs = new ExecResult(false,"请先登录！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service.get_checking_person(stu_no,term_no,starttime,endtime)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadCheckByClassNo() {
		String term_no = request.getParameter("term_no");
		String class_no = request.getParameter("class_no");
		String result = "";
		if(term_no == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			TeacherCenterService service = new TeacherCenterService();
			result = (service. loadCheckByClassNo(term_no,class_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
