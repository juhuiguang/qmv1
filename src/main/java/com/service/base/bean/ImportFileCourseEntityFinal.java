package com.service.base.bean;

import java.io.Serializable;

import org.jeecgframework.poi.excel.annotation.Excel;

public class ImportFileCourseEntityFinal implements Serializable{
	private static final long serialVersionUID = 1L;
	@Excel(name = "承担单位")
	private String dep_name; 

	@Excel(name = "课程")
	private String course_no; 
	
	@Excel(name = "总学时")
	private String class_hour; 
	
	@Excel(name = "教师")
	private String teacher; 
	
	@Excel(name = "上课人数")
	private String course_account; 
	
	@Excel(name = "上课班级构成")
	private String course_class; 
	
	@Excel(name = "周次")
	private String week; 
	
	@Excel(name = "节次")
	private String section; 
	
	@Excel(name = "地点")
	private String course_place;
	
	@Excel(name = "班数")
	private String classes_number;
	
	@Excel(name = "课程类别一")
	private String course_type1; 
	
	@Excel(name = "课程类别二")
	private String course_type2; 
	
	public ImportFileCourseEntityFinal() {
		super();
	}

	public String getDep_name() {
		return dep_name;
	}

	public void setDep_name(String dep_name) {
		this.dep_name = dep_name;
	}

	public String getCourse_no() {
		return course_no;
	}

	public void setCourse_no(String course_no) {
		this.course_no = course_no;
	}

	public String getClass_hour() {
		return class_hour;
	}

	public void setClass_hour(String class_hour) {
		this.class_hour = class_hour;
	}

	public String getTeacher() {
		return teacher;
	}

	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}

	public String getCourse_account() {
		return course_account;
	}

	public void setCourse_account(String course_account) {
		this.course_account = course_account;
	}

	public String getCourse_class() {
		return course_class;
	}

	public void setCourse_class(String course_class) {
		this.course_class = course_class;
	}

	public String getWeek() {
		return week;
	}

	public void setWeek(String week) {
		this.week = week;
	}

	public String getSection() {
		return section;
	}

	public void setSection(String section) {
		this.section = section;
	}

	public String getCourse_place() {
		return course_place;
	}

	public void setCourse_place(String course_place) {
		this.course_place = course_place;
	}

	public String getClasses_number() {
		return classes_number;
	}

	public void setClasses_number(String classes_number) {
		this.classes_number = classes_number;
	}

	public String getCourse_type1() {
		return course_type1;
	}

	public void setCourse_type1(String course_type1) {
		this.course_type1 = course_type1;
	}

	public ImportFileCourseEntityFinal(String dep_name, String course_no, String class_hour, String teacher,
			String course_account, String course_class, String week, String section, String course_place,
			String classes_number, String course_type1, String course_type2) {
		super();
		this.dep_name = dep_name;
		this.course_no = course_no;
		this.class_hour = class_hour;
		this.teacher = teacher;
		this.course_account = course_account;
		this.course_class = course_class;
		this.week = week;
		this.section = section;
		this.course_place = course_place;
		this.classes_number = classes_number;
		this.course_type1 = course_type1;
		this.course_type2 = course_type2;
	}

	public String getCourse_type2() {
		return course_type2;
	}

	public void setCourse_type2(String course_type2) {
		this.course_type2 = course_type2;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
}
