package com.service.base.bean;

/**
 * 
 * © 2015 niitSoft
 * 
 * @Title: BaseTaskSche.java
 * @Description: base_task_sche
 * @author LiKun
 * @date 2015年8月5日
 * @version V1.0
 *
 */
public class BaseTaskSche {

	/** 课程表编号 */
	private String sche_no = "";
	/** 教学任务编号 */
	private String task_no = "";
	/** 节次（K31,K44） */
	private String sche_set = "";
	/** 上课地点 */
	private String sche_addr = "";

	public String getSche_no() {
		return sche_no;
	}

	public void setSche_no(String sche_no) {
		this.sche_no = sche_no;
	}

	public String getTask_no() {
		return task_no;
	}

	public void setTask_no(String task_no) {
		this.task_no = task_no;
	}

	public String getSche_set() {
		return sche_set;
	}

	public void setSche_set(String sche_set) {
		this.sche_set = sche_set;
	}

	public String getSche_addr() {
		return sche_addr;
	}

	public void setSche_addr(String sche_addr) {
		this.sche_addr = sche_addr;
	}

	@Override
	public String toString() {
		return "BaseTaskSche [sche_no=" + sche_no + ", task_no=" + task_no + ", sche_set=" + sche_set + ", sche_addr="
				+ sche_addr + "]";
	}
	
	

}
