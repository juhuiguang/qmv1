/**
 * 
 */
package com.service.base.bean;

/**
 * 
 * 
 * © 2015 niitSoft
 * 
 * @Title: BaseErrorStuEntity.java
 * @Description: 
 * @author LiKun
 * @date 2015年9月13日
 * @version V1.0
 *
 */
public class BaseErrorStuEntity {
	
	private ImportFileStudentEntity studentEntity;
	private String errorMsg ;
	/**
	 * @return the studentEntity
	 */
	public ImportFileStudentEntity getStudentEntity() {
		return studentEntity;
	}
	/**
	 * @param studentEntity the studentEntity to set
	 */
	public void setStudentEntity(ImportFileStudentEntity studentEntity) {
		this.studentEntity = studentEntity;
	}
	/**
	 * @return the errorMsg
	 */
	public String getErrorMsg() {
		return errorMsg;
	}
	/**
	 * @param errorMsg the errorMsg to set
	 */
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	} 
	
	

}
