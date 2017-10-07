package com.service.base.bean;

/**
 * 
 * © 2015 niitSoft
 * 
 * @Title: BaseMajor.java
 * @Description: 对应base_major表
 * @author LiKun
 * @date 2015年8月5日
 * @version V1.0
 *
 */
public class BaseMajor {

	/** 专业代码 */
	private String major_no = "";
	/** 专业名称 */
	private String major_name = "";

	public String getMajor_no() {
		return major_no;
	}

	public void setMajor_no(String major_no) {
		this.major_no = major_no;
	}

	public String getMajor_name() {
		return major_name;
	}

	public void setMajor_name(String major_name) {
		this.major_name = major_name;
	}

}
