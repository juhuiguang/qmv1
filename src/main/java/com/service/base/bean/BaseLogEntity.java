/**
 * 
 */
package com.service.base.bean;

/**
 * 
 * 
 * © 2015 niitSoft
 * 
 * @Title: BaseLogEntity.java
 * @Description:
 * @author LiKun
 * @date 2015年9月13日
 * @version V1.0
 *
 */
public class BaseLogEntity {

	private int batch_id;
	private int batch_type;
	private int batch_status;
	private String teacher_no;
	private int total;
	private int error_total;
	private String error_msg;
	private String error_data;
	private String batch_time;

	/**
	 * @return the batch_id
	 */
	public int getBatch_id() {
		return batch_id;
	}

	/**
	 * @param batch_id
	 *            the batch_id to set
	 */
	public void setBatch_id(int batch_id) {
		this.batch_id = batch_id;
	}

	/**
	 * @return the batch_type
	 */
	public int getBatch_type() {
		return batch_type;
	}

	/**
	 * @param batch_type
	 *            the batch_type to set
	 */
	public void setBatch_type(int batch_type) {
		this.batch_type = batch_type;
	}

	/**
	 * @return the batch_status
	 */
	public int getBatch_status() {
		return batch_status;
	}

	/**
	 * @param batch_status
	 *            the batch_status to set
	 */
	public void setBatch_status(int batch_status) {
		this.batch_status = batch_status;
	}

	/**
	 * @return the teacher_no
	 */
	public String getTeacher_no() {
		return teacher_no;
	}

	/**
	 * @param teacher_no
	 *            the teacher_no to set
	 */
	public void setTeacher_no(String teacher_no) {
		this.teacher_no = teacher_no;
	}

	/**
	 * @return the total
	 */
	public int getTotal() {
		return total;
	}

	/**
	 * @param total
	 *            the total to set
	 */
	public void setTotal(int total) {
		this.total = total;
	}

	/**
	 * @return the error_total
	 */
	public int getError_total() {
		return error_total;
	}

	/**
	 * @param error_total
	 *            the error_total to set
	 */
	public void setError_total(int error_total) {
		this.error_total = error_total;
	}

	/**
	 * @return the error_msg
	 */
	public String getError_msg() {
		return error_msg;
	}

	/**
	 * @param error_msg
	 *            the error_msg to set
	 */
	public void setError_msg(String error_msg) {
		this.error_msg = error_msg;
	}

	/**
	 * @return the error_data
	 */
	public String getError_data() {
		return error_data;
	}

	/**
	 * @param error_data
	 *            the error_data to set
	 */
	public void setError_data(String error_data) {
		this.error_data = error_data;
	}

	/**
	 * @return the batch_time
	 */
	public String getBatch_time() {
		return batch_time;
	}

	/**
	 * @param batch_time
	 *            the batch_time to set
	 */
	public void setBatch_time(String batch_time) {
		this.batch_time = batch_time;
	}

}
