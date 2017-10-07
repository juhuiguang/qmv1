/**
 * 
 */
package com.service.base;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;
import com.service.base.bean.BaseLogEntity;

/**
 * 
 * 
 * © 2015 niitSoft
 * 
 * @Title: BaseLogService.java
 * @Description: 异常批处理类
 * @author LiKun
 * @date 2015年9月13日
 * @version V1.0
 *
 */
public class BaseLogService {

	/**
	 * 添加一个异常信息
	 */

	public ExecResult addBaseLogService(BaseLogEntity logEntity) {
		JSONResponse response = new JSONResponse();
		ExecResult result = new ExecResult();
		StringBuilder strSql = new StringBuilder();
		strSql.append(
				"INSERT INTO tb_batch_log(batch_type , batch_status , teacher_no , total , error_total , error_msg , error_data) VALUES(");
		strSql.append(" '" + logEntity.getBatch_type() + "', ");
		strSql.append("'"+logEntity.getBatch_status() + "', ");
		strSql.append("'" + logEntity.getTeacher_no() + " ', ");
		strSql.append("'" + logEntity.getTotal() + "', ");
		strSql.append("'"+logEntity.getError_total() + "', ");
		strSql.append("'" + logEntity.getError_msg() + " ', ");
		strSql.append("'"+logEntity.getError_data() + " ') ");
		result = response.getExecInsertId(strSql.toString(), null, "添加成功", "添加失败");
		return result;
	}

	/**
	 * 
	 */

}
