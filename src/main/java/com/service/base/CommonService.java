package com.service.base;

import org.apache.log4j.Logger;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

/**
 * 通用获取 © 2015 niitSoft 
 * 名称：CommonService.java 
 * 描述：
 *
 * @author LiKun
 * @version v1.0 
 * @date：2015年8月1日
 */
public class CommonService {

	private static Logger logger = Logger.getLogger(CommonService.class);

	/**
	 * 获取部门信息
	 * 
	 * @return
	 */
	public ExecResult getBaseDepartmentSelect() {
		String sql = "SELECT * FROM base_department ORDER BY dep_sort";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null , "");
		return result;
	}
	
	/**
	 * 根据部门名称获取部门信息
	 * @param dep_name 部门名称
	 * @return
	 */
	public ExecResult queryDep( String dep_name ){
		JSONResponse jr = new JSONResponse();
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM base_department where dep_name= ");
		sql.append("'" + dep_name + "' ");
		ExecResult result = jr.getSelectResult(sql.toString(), null , "");
		return result;
	}
	
	/**
	 * 获取专业信息
	 * @return
	 */
	public ExecResult getBaseMajorSelect() {
		String sql = "SELECT distinct * FROM base_major"; 
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_major");
		return result;
	}

}
