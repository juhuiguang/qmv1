package com.service.base.bean;

import org.jeecgframework.poi.excel.annotation.Excel;


public class ImportFileCourseLogicEntity implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	/** 序号 */
	@Excel(name = "序号")
	// @ExcelVerify(notNull = true)
	// @ExcelVerify(notNull = true, regex = "^[0-9]*$", regexTip = "不是数字")
	private String courseId;

	/** 课程编号 */
	@Excel(name = "课程编号")
	// @ExcelVerify(notNull = true)
	// @ExcelVerify(notNull = true)
	private java.lang.String courseNo;
	
	/** 课程名称 */
	@Excel(name = "课程名称")
	// @ExcelVerify(notNull = true)
	// @ExcelVerify(notNull = true)
	private java.lang.String courseName;
	
	/** 课程类型 */
	@Excel(name = "课程类型")
	// @ExcelVerify(notNull = true)
	// @ExcelVerify(notNull = true)
	private java.lang.String courseType = "任选课";
	
	/** 班级代码 */
	@Excel(name = "所在班级代码")
	// @ExcelVerify(notNull = true)
	private java.lang.String classNo;

	/** 行政班级 */
	@Excel(name = "班级名称")
	// @ExcelVerify(notNull = true)
	private java.lang.String className;

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

	

	

}
