package com.service.base.bean;

/**
 * 
 * © 2015 niitSoft
 * 
 * @Title: BaseStudentObject.java
 * @Description: 学生实体类
 * @author LiKun
 * @date 2015年8月18日
 * @version V1.0
 *
 */
public class BaseStudentEntity {

	private String stu_no = "";
	private String stu_name = "";
	private String stu_birthday = "";
	private String stu_phone = "";
	private String stu_major_init = "";
	private String stu_year = "";
	private String stu_status = "";
	private String class_no ="";

	public String getClass_no() {
		return class_no;
	}

	public void setClass_no(String class_no) {
		this.class_no = class_no;
	}

	public String getStu_no() {
		return stu_no;
	}

	public void setStu_no(String stu_no) {
		this.stu_no = stu_no;
	}

	public String getStu_name() {
		return stu_name;
	}

	public void setStu_name(String stu_name) {
		this.stu_name = stu_name;
	}

	public String getStu_birthday() {
		return stu_birthday;
	}

	public void setStu_birthday(String stu_birthday) {
		this.stu_birthday = stu_birthday;
	}

	public String getStu_phone() {
		return stu_phone;
	}

	public void setStu_phone(String stu_phone) {
		this.stu_phone = stu_phone;
	}

	public String getStu_major_init() {
		return stu_major_init;
	}

	public void setStu_major_init(String stu_major_init) {
		this.stu_major_init = stu_major_init;
	}

	public String getStu_year() {
		return stu_year;
	}

	public void setStu_year(String stu_year) {
		this.stu_year = stu_year;
	}

	public String getStu_status() {
		return stu_status;
	}

	public void setStu_status(String stu_status) {
		this.stu_status = stu_status;
	}

	@Override
	public String toString() {
		return "BaseStudentEntity [stu_no=" + stu_no + ", stu_name=" + stu_name + ", stu_birthday=" + stu_birthday
				+ ",\n stu_phone=" + stu_phone + ", stu_major_init=" + stu_major_init + ",\n stu_year=" + stu_year
				+ ", stu_status=" + stu_status + "]";
	}

}
