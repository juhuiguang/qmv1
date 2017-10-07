package com.service.student;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class Student_checking_Action extends Action {
//获取所带班级所有学生的考勤情况
	public void get_checking_stu() {
		String class_name_one = request.getParameter("class_name_one");
		String term_no_one= request.getParameter("term_no_one");
		String term_no_two= request.getParameter("term_no_two");
		String teacher_no= request.getParameter("teacher_no");
		String class_name_two=request.getParameter("class_name_two");
		String course_name= request.getParameter("course_name");
		String result = "";
		if(class_name_one == null) {
			ExecResult rs = new ExecResult(false,"学生考勤情况记录获取失败！");
			result = rs.toString();
		} else {
			Student_checking_Service service = new Student_checking_Service();
			result = (service.get_checking_stu(class_name_one,term_no_one ,term_no_two, teacher_no,class_name_two,course_name)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_qq_sl() {
		String term_no= request.getParameter("term_no");
		String teacher_no= request.getParameter("teacher_no");
		String class_name=request.getParameter("class_name");
		String course_name= request.getParameter("course_name");
		String result = "";

		Student_checking_Service service = new Student_checking_Service();
		result = (service.get_qq_sl(course_name,teacher_no,term_no,class_name,course_name,teacher_no,term_no,class_name,class_name,term_no,teacher_no,class_name,course_name)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getchange() {
		String stu_no= request.getParameter("stu_no");
		String check_time= request.getParameter("check_time");
		String check_status=request.getParameter("check_status");
		String result = "";

		Student_checking_Service service = new Student_checking_Service();
		result = (service.getchange(check_status,stu_no,check_time)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getdelete() {
		String stu_no= request.getParameter("stu_no");
		String check_time= request.getParameter("check_time");
		String result = "";
		Student_checking_Service service = new Student_checking_Service();
		result = (service.getdelete(stu_no,check_time)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public void loadstu_xq() {
		String stu_no= request.getParameter("stu_no");
		String term_no= request.getParameter("term_no");
		String teacher_no= request.getParameter("teacher_no");
		String result = "";

		Student_checking_Service service = new Student_checking_Service();
		result = (service.loadstu_xq(stu_no,term_no,teacher_no)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	public void get_checking_stu_college() {//根据学院标号和学期获取缺勤次数高的人
		String dep_no_one = request.getParameter("dep_no_one");
		String term_no_one= request.getParameter("term_no_one");
		String term_no_two= request.getParameter("term_no_two");
		String result = "";
		if(term_no_one == null) {
			ExecResult rs = new ExecResult(false,"学生考勤情况记录获取失败！");
			result = rs.toString();
		} else {
			Student_checking_Service service = new Student_checking_Service();
			result = (service.get_checking_stu_college(dep_no_one,term_no_one ,term_no_two)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadxqjl() {//根据学院标号和学期获取缺勤次数高的人
		String stu_no = request.getParameter("stu_no");
		String term_no= request.getParameter("term_no");

		String result = "";
		if(stu_no  == null) {
			ExecResult rs = new ExecResult(false,"数据错误！");
			result = rs.toString();
		} else {
			Student_checking_Service service = new Student_checking_Service();
			result = (service.loadxqjl(stu_no ,term_no)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_checking_stu_school() {//根据学院标号和学期获取缺勤次数高的人
		String term_no_one= request.getParameter("term_no_one");
		String term_no_two= request.getParameter("term_no_two");
		String result = "";
		if(term_no_one == null) {
			ExecResult rs = new ExecResult(false,"学生考勤情况记录获取失败！");
			result = rs.toString();
		} else {
			Student_checking_Service service = new Student_checking_Service();
			result = (service.get_checking_stu_school(term_no_one ,term_no_two)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_checking_stu_yes() {//有缺勤记录的人
		String class_name_one = request.getParameter("class_name_one");//获取到教师的教工号
		String term_no_one= request.getParameter("term_no_one");
		String term_no_two= request.getParameter("term_no_two");
		String teacher_no= request.getParameter("teacher_no");
		String class_name_two=request.getParameter("class_name_two");
		String course_name= request.getParameter("course_name");
		String result = "";
		if(class_name_one == null) {
			ExecResult rs = new ExecResult(false,"学生考勤情况记录获取失败！");
			result = rs.toString();
		} else {
			Student_checking_Service service = new Student_checking_Service();
			result = (service.get_checking_stu_yes(class_name_one,term_no_one ,term_no_two, teacher_no,class_name_two,course_name)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_checking_stu_yes_chart() {//有缺勤记录的人
		String class_name_one = request.getParameter("class_name_one");//获取到教师的教工号
		String term_no_one= request.getParameter("term_no_one");
		String term_no_two= request.getParameter("term_no_two");
		String teacher_no= request.getParameter("teacher_no");
		String class_name_two=request.getParameter("class_name_two");
		String course_name= request.getParameter("course_name");
		String result = "";
		if(class_name_one == null) {
			ExecResult rs = new ExecResult(false,"学生考勤情况记录获取失败！");
			result = rs.toString();
		} else {
			Student_checking_Service service = new Student_checking_Service();
			result = (service.get_checking_stu_yes_chart(class_name_one,term_no_one ,term_no_two, teacher_no,class_name_two,course_name)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_checking_stu_yes_chart_leave() {//有缺勤记录的人
		String class_name_one = request.getParameter("class_name_one");//获取到教师的教工号
		String term_no_one= request.getParameter("term_no_one");
		String term_no_two= request.getParameter("term_no_two");
		String teacher_no= request.getParameter("teacher_no");
		String class_name_two=request.getParameter("class_name_two");
		String course_name= request.getParameter("course_name");
		String result = "";
		if(class_name_one == null) {
			ExecResult rs = new ExecResult(false,"学生考勤情况记录获取失败！");
			result = rs.toString();
		} else {
			Student_checking_Service service = new Student_checking_Service();
			result = (service.get_checking_stu_yes_chart_leave(class_name_one,term_no_one ,term_no_two, teacher_no,class_name_two,course_name)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_checking_stu_no() {//无缺勤记录的人
		String class_name_one = request.getParameter("class_name_one");//获取到教师的教工号
		String term_no_one= request.getParameter("term_no_one");
		String term_no_two= request.getParameter("term_no_two");
		String teacher_no= request.getParameter("teacher_no");
		String class_name_two=request.getParameter("class_name_two");
		String course_name= request.getParameter("course_name");
		String result = "";
		if(class_name_one == null) {
			ExecResult rs = new ExecResult(false,"学生考勤情况记录获取失败！");
			result = rs.toString();
		} else {
			Student_checking_Service service = new Student_checking_Service();
			result = (service.get_checking_stu_no(class_name_one,term_no_one ,term_no_two, teacher_no,class_name_two,course_name)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	//获取老师的课程和所在的班级
	public void get_checking_class() {
		String teacher_no_flag = request.getParameter("teacher_no");//获取到教师的教工号
		String term_no= request.getParameter("term_no");
		String result = "";
		if(teacher_no_flag == null) {
			ExecResult rs = new ExecResult(false,"老师所有课表获取失败！");
			result = rs.toString();
		} else {
			Student_checking_Service service = new Student_checking_Service();
			result = (service.get_checking_class(teacher_no_flag,term_no)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_checking_classcenter() {
		String teacher_no = request.getParameter("teacher_no");//获取到教师的教工号
		String term_no= request.getParameter("term_no");
		String result = "";
		if(teacher_no == null) {
			ExecResult rs = new ExecResult(false,"老师所有课表获取失败！");
			result = rs.toString();
		} else {
			Student_checking_Service service = new Student_checking_Service();
			result = (service.get_checking_classcenter(teacher_no,term_no)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	public void get_checking_term() {
		String result = "";
			Student_checking_Service service = new Student_checking_Service();
			result = (service.get_checking_term()).toString();

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
		String result = "";
		if(stu_no == null) {
			ExecResult rs = new ExecResult(false,"请先登录！");
			result = rs.toString();
		} else {
			Student_checking_Service service = new Student_checking_Service();
			result = (service.get_checking_person(stu_no,term_no)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	public void get_classes_checking() {//根据班级学期课程找到班级所有缺课的学生   用来班主任班长查询
		String class_name_one = request.getParameter("class_name_one");//课程
		String class_name_two= request.getParameter("class_name_two");//学期
		String course_name= request.getParameter("course_name");//班级
		String term_no= request.getParameter("term_no");//学期
		String selected= request.getParameter("selected");//权限
		String result = "";
		if(course_name == null) {
			ExecResult rs = new ExecResult(false,"本班学生情况获取失败哦！");
			result = rs.toString();
		} else {
			Student_checking_Service service = new Student_checking_Service();
			result = (service.get_classes_checking(class_name_one,class_name_two,course_name,term_no,selected)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_classes_checking_yes() {//根据班级学期课程找到班级所有缺课的学生   用来班主任班长查询
		String class_name_one = request.getParameter("class_name_one");//课程
		String class_name_two= request.getParameter("class_name_two");//学期
		String course_name= request.getParameter("course_name");//班级
		String term_no= request.getParameter("term_no");//学期
		String result = "";
		if(course_name == null) {
			ExecResult rs = new ExecResult(false,"本班学生情况获取失败哦！");
			result = rs.toString();
		} else {
			Student_checking_Service service = new Student_checking_Service();
			result = (service.get_classes_checking_yes(class_name_one,class_name_two,course_name, term_no)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_checking_person_coursename() {
		String stu_no= request.getParameter("stu_no");
		String term_no= request.getParameter("term_no");
		String task_no= request.getParameter("task_no");
		String result = "";
		if(stu_no == null) {
			ExecResult rs = new ExecResult(false,"请先登录！");
			result = rs.toString();
		} else {
			Student_checking_Service service = new Student_checking_Service();
			result = (service.get_checking_person_coursename(stu_no,term_no,task_no)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadall_yeschecking() {
		String term_no= request.getParameter("term_no");
		String teacher_no= request.getParameter("teacher_no");
		String result = "";
		if(teacher_no == null) {
			ExecResult rs = new ExecResult(false,"请先登录！");
			result = rs.toString();
		} else {
			Student_checking_Service service = new Student_checking_Service();
			result = (service.loadall_yeschecking(term_no,teacher_no)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void changecheckrate() {
		String check_main_no= request.getParameter("check_main_no");
		String check_status= request.getParameter("check_status");
		String check_change_status= request.getParameter("check_change_status");
		String result = "";
		

		Student_checking_Service service = new Student_checking_Service();
		result = (service.changecheckrate(check_main_no,check_status,check_change_status)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getCheckInfo() {
		String student_name= request.getParameter("student_name");
		String term_no= request.getParameter("term_no");
		String dep_no= request.getParameter("dep_no");
		String time_star= request.getParameter("time_star");
		String time_end= request.getParameter("time_end");
		String pageIndex= request.getParameter("pageIndex");
		String pageLength= request.getParameter("pageLength");
		String flag= request.getParameter("flag");
		String result = "";
		

		Student_checking_Service service = new Student_checking_Service();
		result = (service.getCheckInfo(term_no,dep_no,time_star,time_end,student_name , pageIndex,pageLength,flag)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getCheckDetailInfo() {
		String term_no= request.getParameter("term_no");
		String dep_no= request.getParameter("dep_no");
		String time_star= request.getParameter("time_star");
		String time_end= request.getParameter("time_end");
		String stu_no= request.getParameter("stu_no");
		String result = "";
		

		Student_checking_Service service = new Student_checking_Service();
		result = (service.getCheckDetailInfo(term_no,dep_no,time_star,time_end,stu_no)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
