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
public class BaseStudent {

	/** 学号 */
	private String stu_no = "";
	/** 姓名 */
	private String stu_name = "";
	/** 生日(20150717) */
	private String stu_birthday = "";
	/** 手机号码 */
	private String stu_phone = "";
	/** 初始专业代码 */
	private String stu_major_code = "";

	/** 入学年份 */
	private String stu_year = "";
	/** 学生状态 */
	private String stu_status = "1";

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

	public String getStu_major_code() {
		return stu_major_code;
	}

	public void setStu_major_code(String stu_major_code) {
		this.stu_major_code = stu_major_code;
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
		return "BaseStudentObject [stu_no=" + stu_no + ", stu_name=" + stu_name + ", stu_birthday=" + stu_birthday
				+ ",\n stu_phone=" + stu_phone + ", stu_major_code=" + stu_major_code + ", stu_year=" + stu_year
				+ ",\n stu_status=" + stu_status + "]";
	}

}
