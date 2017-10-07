package com.service.base.bean;

/**
 * 
 * © 2015 niitSoft
 * 
 * @Title: BaseClassLogic.java
 * @Description:逻辑班级表 base_class_logic
 * @author LiKun
 * @date 2015年8月5日
 * @version V1.0
 *
 */
public class BaseClassLogic {

	/** 学年学期号 */
	private String term_no = "";
	/** 学号 */
	private String student_no = "";
	/** 教学任务号 */
	private String task_no = "";
	/** 课程号 */
	private String course_no = "";
	/** 逻辑班级号 */
	private String logic_no = "";
	/** 逻辑班级名字 */
	private String logic_name = "";

	public String getTerm_no() {
		return term_no;
	}

	public void setTerm_no(String term_no) {
		this.term_no = term_no;
	}

	public String getStudent_no() {
		return student_no;
	}

	public void setStudent_no(String student_no) {
		this.student_no = student_no;
	}
	
	

	public String getTask_no() {
		return task_no;
	}

	public void setTask_no(String task_no) {
		this.task_no = task_no;
	}

	public String getCourse_no() {
		return course_no;
	}

	public void setCourse_no(String course_no) {
		this.course_no = course_no;
	}

	public String getLogic_no() {
		return logic_no;
	}

	public void setLogic_no(String logic_no) {
		this.logic_no = logic_no;
	}

	public String getLogic_name() {
		return logic_name;
	}

	public void setLogic_name(String logic_name) {
		this.logic_name = logic_name;
	}

	@Override
	public String toString() {
		return "BaseClassLogic [term_no=" + term_no + ", student_no=" + student_no + ", course_no=" + course_no
				+ ", logic_no=" + logic_no + ", logic_name=" + logic_name + "]";
	}

}
