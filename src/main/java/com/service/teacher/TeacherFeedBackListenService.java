package com.service.teacher;

import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class TeacherFeedBackListenService {

	/**
	 * 根据教工号获取反馈列表
	 * 
	 * @param teacher_no
	 *            教工号
	 * @return ExecResult 结果集
	 */
	public ExecResult getFeedBacksTable(String teacherNo) {
		String sql = "SELECT feedback_time,feedback_type,feedback_title,feedback_content FROM qm_tea_feedback WHERE teacher_no=''{0}''";
		String[] params = new String[] { teacherNo };
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "qm_tea_feedback");
		if (result.getResult() != 0) {
			// 改造data数据
		}
		return result;
	}

	/**
	 * 添加反馈
	 * 
	 * @param params
	 *            反馈数据集
	 * @return ExecResult 结果集
	 */
	public ExecResult addFeedBack(Map<String, String> params) {
		String sql = "insert into qm_tea_feedback"
				+ "(teacher_no,feedback_type,feedback_title,feedback_content,task_id,feedback_time) values (";
		sql += "'"+params.get("teacher_no") + "',";
		sql += "'" + params.get("feedback_type") + "',";
		sql += "'" + params.get("feedback_title") + "',";
		sql += "'" + params.get("feedback_content") + "',";
		sql += "'" + params.get("task_id") + "',";
		sql += "'" + params.get("feedback_time") + "')";
		JSONResponse response = new JSONResponse();
		ExecResult result = response.getExecResult(sql, null, "提交反馈成功", "提交反馈失败");
		return result;
	}

}
