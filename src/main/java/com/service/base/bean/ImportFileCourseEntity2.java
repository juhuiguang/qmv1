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
public class ImportFileCourseEntity2 implements Cloneable {


	/** 承担单位 */
	@Excel(name = "承担单位")
	private String course_dep;
	private String dep_name ;
	private String dep_no ;
	/** 课程 */
	@Excel(name = "课程")
	private String course_idName;
	
	private String course_name ;
	private String course_no ; //课程号
//	/** 学分 */
//	@Excel(name = "学分")
//	private String course_credit;
	/** 总学时 */
	@Excel(name = "总学时")
	private String course_totalTime;
	/** 教师 */
	@Excel(name = "教师")
	private String course_teacher;
	
	private String teacher_name ;
	private String teacher_no ;
	/** 上课人数 */
	@Excel(name = "上课人数")
	private String course_classTotalStu;
	/** 上课班级构成 */
	@Excel(name = "上课班级构成")
	private String classNames;
	private String class_no ; //班级号
	private String class_name ; //班级名称
	/** 周次 */
	@Excel(name = "周次")
	private String course_classWeek;
	/** 节次 */
	@Excel(name = "节次")
	private String course_classScheSet;
	/** 地点 */
	@Excel(name = "地点")
	private String course_scheAddr ;
	/** 课程类别一 */
	@Excel(name = "课程类别一")
	private String course_type1 ;
	/** 课程类别二 */
	@Excel(name = "课程类别二")
	private String course_type2 ;
	/** 是否逻辑班级 */
	@Excel(name = "是否逻辑班级")
	private String course_logic ;
	
	
	
	
	public String getCourse_dep() {
		return course_dep;
	}




	public void setCourse_dep(String course_dep) {
		this.course_dep = course_dep;
	}




	public String getDep_name() {
		return dep_name;
	}




	public void setDep_name(String dep_name) {
		this.dep_name = dep_name;
	}




	public String getDep_no() {
		return dep_no;
	}




	public void setDep_no(String dep_no) {
		this.dep_no = dep_no;
	}




	public String getCourse_idName() {
		return course_idName;
	}




	public void setCourse_idName(String course_idName) {
		this.course_idName = course_idName;
	}




	public String getCourse_name() {
		return course_name;
	}




	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}




	public String getCourse_no() {
		return course_no;
	}




	public void setCourse_no(String course_no) {
		this.course_no = course_no;
	}




	public String getCourse_totalTime() {
		return course_totalTime;
	}




	public void setCourse_totalTime(String course_totalTime) {
		this.course_totalTime = course_totalTime;
	}




	public String getCourse_teacher() {
		return course_teacher;
	}




	public void setCourse_teacher(String course_teacher) {
		this.course_teacher = course_teacher;
	}




	public String getTeacher_name() {
		return teacher_name;
	}




	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}




	public String getTeacher_no() {
		return teacher_no;
	}




	public void setTeacher_no(String teacher_no) {
		this.teacher_no = teacher_no;
	}




	public String getCourse_classTotalStu() {
		return course_classTotalStu;
	}




	public void setCourse_classTotalStu(String course_classTotalStu) {
		this.course_classTotalStu = course_classTotalStu;
	}




	public String getClassNames() {
		return classNames;
	}




	public void setClassNames(String classNames) {
		this.classNames = classNames;
	}




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




	public String getCourse_classWeek() {
		return course_classWeek;
	}




	public void setCourse_classWeek(String course_classWeek) {
		this.course_classWeek = course_classWeek;
	}




	public String getCourse_classScheSet() {
		return course_classScheSet;
	}




	public void setCourse_classScheSet(String course_classScheSet) {
		this.course_classScheSet = course_classScheSet;
	}




	public String getCourse_scheAddr() {
		return course_scheAddr;
	}




	public void setCourse_scheAddr(String course_scheAddr) {
		this.course_scheAddr = course_scheAddr;
	}




	public String getCourse_type1() {
		return course_type1;
	}




	public void setCourse_type1(String course_type1) {
		this.course_type1 = course_type1;
	}




	public String getCourse_type2() {
		return course_type2;
	}




	public void setCourse_type2(String course_type2) {
		this.course_type2 = course_type2;
	}




	public String getCourse_logic() {
		return course_logic;
	}




	public void setCourse_logic(String course_logic) {
		this.course_logic = course_logic;
	}




	@Override
	public String toString() {
		return "ImportFileCourseEntity2 [course_dep=" + course_dep + ", dep_name=" + dep_name + ", dep_no=" + dep_no
				+ ",\n course_idName=" + course_idName + ", course_name=" + course_name + ", course_no=" + course_no
				+ ",\n course_totalTime=" + course_totalTime + ", course_teacher=" + course_teacher + ", teacher_name="
				+ teacher_name + ", teacher_no=" + teacher_no + ", course_classTotalStu=" + course_classTotalStu
				+ ",\n classNames=" + classNames + ", class_no=" + class_no + ", class_name=" + class_name
				+ ",\n course_classWeek=" + course_classWeek + ", course_classScheSet=" + course_classScheSet
				+ ",\n course_scheAddr=" + course_scheAddr + ", course_type1=" + course_type1 + ", course_type2="
				+ course_type2 + ", course_logic=" + course_logic + "]";
	}

	
	
	
	public Object clone(){  
        ImportFileCourseEntity2 bankAccount = null;  
        try {  
            bankAccount = (ImportFileCourseEntity2)super.clone();  
        } catch (CloneNotSupportedException e) {  
            e.printStackTrace();  
        }  
        return bankAccount;  
    }  
	
	
	
	

	
	
	

}
