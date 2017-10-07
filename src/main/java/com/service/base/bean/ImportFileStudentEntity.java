package com.service.base.bean;

import org.jeecgframework.poi.excel.annotation.Excel;

/**
 * 
 * © 2015 niitSoft
 * 
 * @Title: ImportFileStudentEntity.java
 * @Description: 导入新学生实体注解类
 * @author LiKun
 * @date 2015年8月2日
 * @version V1.0
 *
 */
public class ImportFileStudentEntity implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	/** 姓名 */
	@Excel(name = "学号")
	private java.lang.String stu_no;
	/** 性别 */
	@Excel(name = "姓名")
	private java.lang.String stu_name;
	/** 所属院系 */
	@Excel(name = "所属院系")
	private java.lang.String stu_deartment;
	/** 专业 */
	@Excel(name = "专业")
	private java.lang.String stu_major;
	/** 专业代码 */
	@Excel(name = "专业代码")
	private java.lang.String stu_majorNo;
	/** 班级 */
	@Excel(name = "班级")
	private java.lang.String stu_class;
	/** 班级代码 */
	@Excel(name = "班级代码")
	private java.lang.String stu_classNo;

	/** 入学年份 */
	@Excel(name = "入学年份")
	private java.lang.String stu_year;

	public java.lang.String getStu_no() {
		return stu_no;
	}

	public void setStu_no(java.lang.String stu_no) {
		this.stu_no = stu_no;
	}

	public java.lang.String getStu_name() {
		return stu_name;
	}

	public void setStu_name(java.lang.String stu_name) {
		this.stu_name = stu_name;
	}

	public java.lang.String getStu_deartment() {
		return stu_deartment;
	}

	public void setStu_deartment(java.lang.String stu_deartment) {
		this.stu_deartment = stu_deartment;
	}

	public java.lang.String getStu_major() {
		return stu_major;
	}

	public void setStu_major(java.lang.String stu_major) {
		this.stu_major = stu_major;
	}

	public java.lang.String getStu_class() {
		return stu_class;
	}

	public void setStu_class(java.lang.String stu_class) {
		this.stu_class = stu_class;
	}

	public java.lang.String getStu_majorNo() {
		return stu_majorNo;
	}

	public void setStu_majorNo(java.lang.String stu_majorNo) {
		this.stu_majorNo = stu_majorNo;
	}

	public java.lang.String getStu_classNo() {
		return stu_classNo;
	}

	public void setStu_classNo(java.lang.String stu_classNo) {
		this.stu_classNo = stu_classNo;
	}

	public java.lang.String getStu_year() {
		return stu_year;
	}

	public void setStu_year(java.lang.String stu_year) {
		this.stu_year = stu_year;
	}

	@Override
	public String toString() {
		return "ImportFileStudentEntity [stu_no=" + stu_no + ", stu_name=" + stu_name + ", stu_deartment="
				+ stu_deartment + ",\n stu_major=" + stu_major + ", stu_majorNo=" + stu_majorNo + ", stu_class="
				+ stu_class + ",\n stu_classNo=" + stu_classNo + ", stu_year=" + stu_year + "]";
	}

	

}
