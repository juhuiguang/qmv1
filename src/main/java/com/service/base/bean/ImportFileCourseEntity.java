package com.service.base.bean;

import org.jeecgframework.poi.excel.annotation.Excel;

/**
 * 
 * © 2015 niitSoft
 * 
 * @Title: ImportFileCourseEntity.java
 * @Description: 导入文件课程实体注解类 实体类string字段的在set方法加上trim方法，去除导入的excel的数据内容包含空格
 * @author LiKun
 * @date 2015年8月2日
 * @version V1.0
 *
 */
public class ImportFileCourseEntity implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	/** 序号 */
	@Excel(name = "序号")
	// @ExcelVerify(notNull = true)
	// @ExcelVerify(notNull = true, regex = "^[0-9]*$", regexTip = "不是数字")
	private String courseId;

	/** 课程 */
	@Excel(name = "课程")
	// @ExcelVerify(notNull = true)
	// @ExcelVerify(notNull = true)
	private java.lang.String courseName;
	
	/** 课程类型 */
	@Excel(name = "课程类型")
	// @ExcelVerify(notNull = true)
	// @ExcelVerify(notNull = true)
	private java.lang.String courseType;

	/** 总学时 */
	@Excel(name = "总学时")
	// @ExcelVerify(notNull = true)
	// @ExcelVerify(notNull = true, regex = "^[0-9]*$", regexTip = "不是数字")
	private java.lang.String courseTotalTime;

	/** 任课教师 */
	@Excel(name = "任课教师")
	// @ExcelVerify(notNull = true)
	private java.lang.String courseTeacher;

	/** 教工号 */
	@Excel(name = "教工号")
	// @ExcelVerify(notNull = true)
	private java.lang.String courseTeacherNo;

	/** 人数/班数 */
	@Excel(name = "人数/班数")
	// @ExcelVerify(notNull = true)
	private java.lang.String courseStuOrClass;
	
	/** 班级代码 */
	@Excel(name = "班级代码")
	// @ExcelVerify(notNull = true)
	private java.lang.String classNo;

	/** 行政班级 */
	@Excel(name = "行政班级")
	// @ExcelVerify(notNull = true)
	private java.lang.String courseClass;

	/** 周次 */
	@Excel(name = "周次")
	// @ExcelVerify(notNull = true)
	private java.lang.String courseWeek;

	/** 节次 */
	@Excel(name = "节次")
	// @ExcelVerify(notNull = true)
	private java.lang.String courseSection;

	/** 承担部门编码 */
	@Excel(name = "承担部门编码")
	// @ExcelVerify(notNull = true, regex = "^[0-9]*$", regexTip = "不是数字")
	private java.lang.String courseDepNo;

	/** 上课地点 */
	@Excel(name = "上课地点")
	// @ExcelVerify(notNull = true)
	private java.lang.String courseAddr;

	

	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId.trim();
	}

	public java.lang.String getCourseName() {
		return courseName;
	}

	public void setCourseName(java.lang.String courseName) {
		this.courseName = courseName.trim();
	}
	
	
	
	

	public java.lang.String getCourseType() {
		return courseType;
	}

	public void setCourseType(java.lang.String courseType) {
		this.courseType = courseType;
	}

	public java.lang.String getCourseTotalTime() {
		return courseTotalTime;
	}

	public void setCourseTotalTime(java.lang.String courseTotalTime) {
		this.courseTotalTime = courseTotalTime.trim();
	}

	public java.lang.String getCourseTeacher() {
		return courseTeacher;
	}

	public void setCourseTeacher(java.lang.String courseTeacher) {
		this.courseTeacher = courseTeacher.trim();
	}

	public java.lang.String getCourseTeacherNo() {
		return courseTeacherNo;
	}

	public void setCourseTeacherNo(java.lang.String courseTeacherNo) {
		this.courseTeacherNo = courseTeacherNo.trim();
	}

	public java.lang.String getCourseStuOrClass() {
		return courseStuOrClass;
	}

	public void setCourseStuOrClass(java.lang.String courseStuOrClass) {
		this.courseStuOrClass = courseStuOrClass.trim();
	}
	
	

	

	public java.lang.String getClassNo() {
		return classNo;
	}

	public void setClassNo(java.lang.String classNo) {
		this.classNo = classNo;
	}

	public java.lang.String getCourseClass() {
		return courseClass;
	}

	public void setCourseClass(java.lang.String courseClass) {
		this.courseClass = courseClass.trim();
	}

	public java.lang.String getCourseWeek() {
		return courseWeek;
	}

	public void setCourseWeek(java.lang.String courseWeek) {
		this.courseWeek = courseWeek.trim();
	}

	public java.lang.String getCourseSection() {
		return courseSection;
	}

	public void setCourseSection(java.lang.String courseSection) {
		this.courseSection = courseSection.trim();
	}

	public java.lang.String getCourseDepNo() {
		return courseDepNo;
	}

	public void setCourseDepNo(java.lang.String courseDepNo) {
		this.courseDepNo = courseDepNo.trim();
	}

	public java.lang.String getCourseAddr() {
		return courseAddr;
	}

	public void setCourseAddr(java.lang.String courseAddr) {
		this.courseAddr = courseAddr.trim();
	}

	

	@Override
	public String toString() {
		return "ImportFileCourseEntity [courseId=" + courseId + ", courseName=" + courseName + ", courseTotalTime="
				+ courseTotalTime + ",\n courseTeacher=" + courseTeacher + ", courseTeacherNo=" + courseTeacherNo
				+ ", courseStuOrClass=" + courseStuOrClass + ",\n courseClass=" + courseClass + ", courseWeek="
				+ courseWeek + ",\n courseSection=" + courseSection + ", courseDepNo=" + courseDepNo + ", courseAddr="
				+ courseAddr + "]";
	}

}
