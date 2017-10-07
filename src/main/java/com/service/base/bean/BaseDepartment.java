package com.service.base.bean;

/**
 * 
 * © 2015 niitSoft
 * 
 * @Title: BaseDepartment.java
 * @Description: 对应表base_department
 * @author LiKun
 * @date 2015年8月5日
 * @version V1.0
 *
 */
public class BaseDepartment {

	/** 院系号 */
	private String dep_no = "";
	/** 院系名称 */
	private String dep_name = "";
	/** 院系类型 */
	private String dep_type = "";
	/**  */
	private String dep_cddw_no = "";
	/** 院系排序 */
	private String dep_sort = "";

	public String getDep_no() {
		return dep_no;
	}

	public void setDep_no(String dep_no) {
		this.dep_no = dep_no;
	}

	public String getDep_name() {
		return dep_name;
	}

	public void setDep_name(String dep_name) {
		this.dep_name = dep_name;
	}

	public String getDep_type() {
		return dep_type;
	}

	public void setDep_type(String dep_type) {
		this.dep_type = dep_type;
	}

	public String getDep_cddw_no() {
		return dep_cddw_no;
	}

	public void setDep_cddw_no(String dep_cddw_no) {
		this.dep_cddw_no = dep_cddw_no;
	}

	public String getDep_sort() {
		return dep_sort;
	}

	public void setDep_sort(String dep_sort) {
		this.dep_sort = dep_sort;
	}

	@Override
	public String toString() {
		return "BaseDepartment [dep_no=" + dep_no + ", dep_name=" + dep_name + ", dep_type=" + dep_type
				+ ", dep_cddw_no=" + dep_cddw_no + ", dep_sort=" + dep_sort + "]";
	}

}
