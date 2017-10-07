package com.service.base.bean;

/**
 * 
 * © 2015 niitSoft
 * 
 * @Title: BaseStudentObject.java
 * @Description:对应表base_student
 * @author LiKun
 * @date 2015年8月5日
 * @version V1.0
 *
 */
public class BaseClasses {

	/** 班级代码 */
	private String class_no = "";
	/** 班级名称 */
	private String class_name = "";
	/** 专业编码 */
	private String major_no = "";
	/** 班主任教工号 */
	private String teacher_no = "";
	/** 班长学号 */
	private String stu_no = "";
	/** 部门表_部门编码 */
	private String dep_no = "";
	/** 人数 */
	private String class_stu_amount = "";
	/** 是否毕业班 */
	private String class_isover = "";

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

	public String getMajor_no() {
		return major_no;
	}

	public void setMajor_no(String major_no) {
		this.major_no = major_no;
	}

	public String getTeacher_no() {
		return teacher_no;
	}

	public void setTeacher_no(String teacher_no) {
		this.teacher_no = teacher_no;
	}

	public String getStu_no() {
		return stu_no;
	}

	public void setStu_no(String stu_no) {
		this.stu_no = stu_no;
	}

	public String getDep_no() {
		return dep_no;
	}

	public void setDep_no(String dep_no) {
		this.dep_no = dep_no;
	}

	public String getClass_stu_amount() {
		return class_stu_amount;
	}

	public void setClass_stu_amount(String class_stu_amount) {
		this.class_stu_amount = class_stu_amount;
	}

	public String getClass_isover() {
		return class_isover;
	}

	public void setClass_isover(String class_isover) {
		this.class_isover = class_isover;
	}

	@Override
	public String toString() {
		return "BaseClasses [class_no=" + class_no + ", class_name=" + class_name + ", major_no=" + major_no
				+ ", teacher_no=" + teacher_no + ", stu_no=" + stu_no + ", dep_no=" + dep_no + ", class_stu_amount="
				+ class_stu_amount + ", class_isover=" + class_isover + "]";
	}
	
	

}
