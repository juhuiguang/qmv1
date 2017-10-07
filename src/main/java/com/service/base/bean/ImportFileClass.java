package com.service.base.bean;

import java.io.Serializable;

import org.jeecgframework.poi.excel.annotation.Excel;

public class ImportFileClass implements Serializable{
	private static final long serialVersionUID = 1L;
	@Excel(name="班级代码")
	private String class_no;
	@Excel(name="班级名称")
	private String class_name;
	@Excel(name="专业代码")
	private String major_no;
	@Excel(name="班主任工号")
	private String teacher_no;
	@Excel(name="信息员学号")
	private String stu_no;
	@Excel(name="班级人数")
	private String class_stu_amount;
	@Excel(name="承担部门")
	private String dep_no;
	@Excel(name="班级状态")
	private String class_isover;
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
	public String getClass_stu_amount() {
		return class_stu_amount;
	}
	public void setClass_stu_amount(String class_stu_amount) {
		this.class_stu_amount = class_stu_amount;
	}
	public String getDep_no() {
		return dep_no;
	}
	public void setDep_no(String dep_no) {
		this.dep_no = dep_no;
	}
	public String getClass_isover() {
		return class_isover;
	}
	public void setClass_isover(String class_isover) {
		this.class_isover = class_isover;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "ImportFileClass [class_no=" + class_no + ", class_name=" + class_name + ", major_no=" + major_no
				+ ", teacher_no=" + teacher_no + ", stu_no=" + stu_no + ", class_stu_amount=" + class_stu_amount
				+ ", dep_no=" + dep_no + ", class_isover=" + class_isover + "]";
	}
	

}
