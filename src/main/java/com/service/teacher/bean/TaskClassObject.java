package com.service.teacher.bean;

import java.util.ArrayList;
import java.util.List;

public class TaskClassObject {
	private String task_no;
	private String class_no;
	private String class_name;
	private List<ScheObject> sches=new ArrayList<ScheObject>();
	public String getTask_no() {
		return task_no;
	}
	public void setTask_no(String task_no) {
		this.task_no = task_no;
	}
	public String getClass_no() {
		return class_no;
	}
	public void setClass_no(String class_no) {
		this.class_no = class_no;
	}
	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	public List<ScheObject> getSches() {
		return sches;
	}
	public void setSches(List<ScheObject> sches) {
		this.sches = sches;
	}
}
