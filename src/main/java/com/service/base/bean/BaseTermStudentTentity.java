package com.service.base.bean;

/**
 * 
 * © 2015 niitSoft
 * 
 * @Title: BaseTermStudent.java
 * @Description:对应base_term_student
 * @author LiKun
 * @date 2015年8月5日
 * @version V1.0
 *
 */
public class BaseTermStudentTentity {

	/** 学年学期编码 */
	private String term_no = "";
	/** 学号 */
	private String stu_no = "";
	/** 专业代码 */
	private String major_no = "";
	/** 班级代码 */
	private String class_no = "";

	public String getTerm_no() {
		return term_no;
	}

	public void setTerm_no(String term_no) {
		this.term_no = term_no;
	}

	public String getStu_no() {
		return stu_no;
	}

	public void setStu_no(String stu_no) {
		this.stu_no = stu_no;
	}

	public String getMajor_no() {
		return major_no;
	}

	public void setMajor_no(String major_no) {
		this.major_no = major_no;
	}

	public String getClass_no() {
		return class_no;
	}

	public void setClass_no(String class_no) {
		this.class_no = class_no;
	}

	@Override
	public String toString() {
		return "BaseTermStudent [term_no=" + term_no + ", stu_no=" + stu_no + ", major_no=" + major_no + ", class_no="
				+ class_no + "]";
	}

}
