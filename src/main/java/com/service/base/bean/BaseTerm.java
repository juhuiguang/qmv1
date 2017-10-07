package com.service.base.bean;

/**
 * 
 * © 2015 niitSoft
 * 
 * @Title: BaseTerm.java
 * @Description: base_term
 * @author LiKun
 * @date 2015年8月5日
 * @version V1.0
 *
 */
public class BaseTerm {

	/** 学年学期编号（20140，20141） */
	private String term_no;
	/** 学年学期名称 */
	private String term_name;
	/** 学年学期打印名称 */
	private String term_print_name;
	/** 学期开始日期 */
	private String term_startdate;
	/** 学期结束日期 */
	private String term_enddate;
	/** 学期状态（0结束、1开始） */
	private String term_status;
	/** 学期新生数据状态（0未初始化、1已初始化） */
	private String term_student;
	/** 学期新班级数据状态（0未初始化、1已初始化）） */
	private String term_class;
	/** 学期新课程数据状态（0未初始化、1已初始化） */
	private String term_course;
	/** 学期学生评教开关（0结束、1开始） */
	private String term_pj;
	/** 学期教学质量考核开关（0结束、1开始） */
	private String term_kh;

	public String getTerm_no() {
		return term_no;
	}

	public void setTerm_no(String term_no) {
		this.term_no = term_no;
	}

	public String getTerm_name() {
		return term_name;
	}

	public void setTerm_name(String term_name) {
		this.term_name = term_name;
	}

	public String getTerm_print_name() {
		return term_print_name;
	}

	public void setTerm_print_name(String term_print_name) {
		this.term_print_name = term_print_name;
	}

	public String getTerm_startdate() {
		return term_startdate;
	}

	public void setTerm_startdate(String term_startdate) {
		this.term_startdate = term_startdate;
	}

	public String getTerm_enddate() {
		return term_enddate;
	}

	public void setTerm_enddate(String term_enddate) {
		this.term_enddate = term_enddate;
	}

	public String getTerm_status() {
		return term_status;
	}

	public void setTerm_status(String term_status) {
		this.term_status = term_status;
	}

	public String getTerm_student() {
		return term_student;
	}

	public void setTerm_student(String term_student) {
		this.term_student = term_student;
	}

	public String getTerm_class() {
		return term_class;
	}

	public void setTerm_class(String term_class) {
		this.term_class = term_class;
	}

	public String getTerm_course() {
		return term_course;
	}

	public void setTerm_course(String term_course) {
		this.term_course = term_course;
	}

	public String getTerm_pj() {
		return term_pj;
	}

	public void setTerm_pj(String term_pj) {
		this.term_pj = term_pj;
	}

	public String getTerm_kh() {
		return term_kh;
	}

	public void setTerm_kh(String term_kh) {
		this.term_kh = term_kh;
	}

	@Override
	public String toString() {
		return "BaseTermObject [term_no=" + term_no + ", term_name=" + term_name + ", term_print_name="
				+ term_print_name + ", term_startdate=" + term_startdate + ", term_enddate=" + term_enddate
				+ ", term_status=" + term_status + ", term_student=" + term_student + ", term_class=" + term_class
				+ ", term_course=" + term_course + ", term_pj=" + term_pj + ", term_kh=" + term_kh + "]";
	}

}
