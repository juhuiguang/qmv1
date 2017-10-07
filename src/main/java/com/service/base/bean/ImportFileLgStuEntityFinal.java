package com.service.base.bean;

import java.io.Serializable;

import org.jeecgframework.poi.excel.annotation.Excel;

public class ImportFileLgStuEntityFinal implements Serializable {
	private static final long serialVersionUID = 1L;
	@Excel(name = "学生学号")
	private String student_no;
	
	@Excel(name = "学生姓名")
	private String student_name;
	
	@Excel(name = "逻辑班级编号")
	private String logic_no;
	
	@Excel(name = "逻辑班级名称")
	private String logic_name;
	
	public ImportFileLgStuEntityFinal() {
		super();
	}
	
	public String getStudent_no() {
		return student_no;
	}

	public void setStudent_no(String student_no) {
		this.student_no = student_no;
	}

	public String getStudent_name() {
		return student_name;
	}

	public void setStudent_name(String student_name) {
		this.student_name = student_name;
	}


	public String getLogic_no() {
		return logic_no;
	}

	public void setLogic_no(String logic_no) {
		this.logic_no = logic_no;
	}

	public String getLogic_name() {
		return logic_name;
	}

	public void setLogic_name(String logic_name) {
		this.logic_name = logic_name;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
		
	
}
