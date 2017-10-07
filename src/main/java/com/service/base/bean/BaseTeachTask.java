package com.service.base.bean;

/**
 * 
 * © 2015 niitSoft
 * 
 * @Title: BaseTeachTask.java
 * @Description: base_teach_task
 * @author LiKun
 * @date 2015年8月5日
 * @version V1.0
 *
 */
public class BaseTeachTask {

	/** 教学任务编号 */
	private String task_no = "";
	/** 学年学期编号 */
	private String term_no = "";
	/** 课程代码 */
	private String course_no = "";
	/** 课程名称 */
	private String course_name = "";
	/** 教工表_教工号 */
	private String teacher_no = "";
	/** 课程类型（公选课、讲授课、实训课） */
	private String course_type = "";
	/** 课程性质 */
	private String course_attr = "";
	/** 课程周描述 */
	private String course_week = "";
	/** 总学时 */
	private String course_ccount = "";
	/** 学生数限制 */
	private String course_scount = "";
	/** 上课班级 */
	private String class_no = "";
	/** 承担部门 */
	private String dep_no = "";

	public String getTask_no() {
		return task_no;
	}

	public void setTask_no(String task_no) {
		this.task_no = task_no;
	}

	public String getTerm_no() {
		return term_no;
	}

	public void setTerm_no(String term_no) {
		this.term_no = term_no;
	}

	public String getCourse_no() {
		return course_no;
	}

	public void setCourse_no(String course_no) {
		this.course_no = course_no;
	}

	public String getCourse_name() {
		return course_name;
	}

	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}

	public String getTeacher_no() {
		return teacher_no;
	}

	public void setTeacher_no(String teacher_no) {
		this.teacher_no = teacher_no;
	}

	public String getCourse_type() {
		return course_type;
	}

	public void setCourse_type(String course_type) {
		this.course_type = course_type;
	}

	public String getCourse_attr() {
		return course_attr;
	}

	public void setCourse_attr(String course_attr) {
		this.course_attr = course_attr;
	}

	public String getCourse_week() {
		return course_week;
	}

	public void setCourse_week(String course_week) {
		this.course_week = course_week;
	}

	public String getCourse_ccount() {
		return course_ccount;
	}

	public void setCourse_ccount(String course_ccount) {
		this.course_ccount = course_ccount;
	}

	public String getCourse_scount() {
		return course_scount;
	}

	public void setCourse_scount(String course_scount) {
		this.course_scount = course_scount;
	}

	public String getClass_no() {
		return class_no;
	}

	public void setClass_no(String class_no) {
		this.class_no = class_no;
	}

	public String getDep_no() {
		return dep_no;
	}

	public void setDep_no(String dep_no) {
		this.dep_no = dep_no;
	}

}
