package com.service.teacher.bean;

import java.util.ArrayList;
import java.util.List;

public class TaskObject {
	private String teacher_name;
	private String teacher_no;
	private String dep_no;
	private String dep_name;
	private String course_no;
	private String course_name;
	private String course_type;
	private List<TaskClassObject> classes=new ArrayList<TaskClassObject>();
	
	public List<TaskClassObject> getClasses() {
		return classes;
	}
	public void setClasses(List<TaskClassObject> classes) {
		this.classes = classes;
	}
	public String getTeacher_name() {
		return teacher_name;
	}
	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}
	public String getTeacher_no() {
		return teacher_no;
	}
	public void setTeacher_no(String teacher_no) {
		this.teacher_no = teacher_no;
	}
	public String getDep_no() {
		return dep_no;
	}
	public void setDep_no(String dep_no) {
		this.dep_no = dep_no;
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
	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}
	public String getCourse_type() {
		return course_type;
	}
	public void setCourse_type(String course_type) {
		this.course_type = course_type;
	}
}
