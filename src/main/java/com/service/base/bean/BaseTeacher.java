package com.service.base.bean;

/**
 * 
 * © 2015 niitSoft
 * 
 * @Title: BaseTeachTask.java
 * @Description: base_teach_task
 * @author LiKun
 * @date 2015年8月5日
 * @version V1.0
 *
 */
public class BaseTeacher {

	/** 教工号 */
	private String teacher_no = "";
	/** 教师姓名 */
	private String teacher_name = "";
	/** 所属部门 */
	private String dep_no = "";
	/** 教工状态 */
	private String teacher_status = "";

	public String getTeacher_no() {
		return teacher_no;
	}

	public void setTeacher_no(String teacher_no) {
		this.teacher_no = teacher_no;
	}

	public String getTeacher_name() {
		return teacher_name;
	}

	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}

	public String getDep_no() {
		return dep_no;
	}

	public void setDep_no(String dep_no) {
		this.dep_no = dep_no;
	}

	public String getTeacher_status() {
		return teacher_status;
	}

	public void setTeacher_status(String teacher_status) {
		this.teacher_status = teacher_status;
	}

	@Override
	public String toString() {
		return "BaseTeacher [teacher_no=" + teacher_no + ", teacher_name=" + teacher_name + ", dep_no=" + dep_no
				+ ", teacher_status=" + teacher_status + "]";
	}

}
