package com.service.base.bean;


/**
 * 教师实体类
 * © 2015 niitSoft
 * 名称：BaseTeacherObject.java
 * 描述：添加教师使用
 *
 * @author LiKun
 * @version v1.0
 * @date：2015年7月30日
 */
public class BaseTeacherEntity {

	/**  教工号  */
	private String teacher_no = "";
	/** 教师姓名  */
	private String teacher_name = "";
	/** 所属部门  */
	private String dep_no = "";
	/** 教工状态  */
	private String teacher_status = "";
	private String teacher_title = "";
	public String getTeacher_no() {
		return teacher_no;
	}
	public void setTeacher_no(String teacher_no) {
		this.teacher_no = teacher_no;
	}
	public String getTeacher_name() {
		return teacher_name;
	}
	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}
	public String getDep_no() {
		return dep_no;
	}
	public void setDep_no(String dep_no) {
		this.dep_no = dep_no;
	}
	public String getTeacher_status() {
		return teacher_status;
	}
	public void setTeacher_status(String teacher_status) {
		this.teacher_status = teacher_status;
	}
	@Override
	public String toString() {
		return "BaseTeacherObject [teacher_no=" + teacher_no + ", teacher_name=" + teacher_name + ", dep_no=" + dep_no
				+ ", teacher_status=" + teacher_status + "]";
	}
	public void setTeacher_title(String parameter) {
		this.teacher_title  = parameter;
		
	}
	public String getTeacher_title() {
		
		return teacher_title;
	}
	
	

	
}
