package com.service.teacher;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jhg.common.DateUtils;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

/**
 * © 2015 niitSoft 名称：TeacherFeedBackAction.java 描述：教师建议与反馈
 *
 * @author LiKun
 * @version v1.0 @date：2015年7月21日
 */
public class TeacherFeedBackAction extends Action {

	private static Logger logger = Logger.getLogger(TeacherFeedBackAction.class);

	/**
	 * 获取反馈列表
	 */
	public void getFeedBacksTable() {
		String result = "";
		String teacher_no = request.getParameter("teacher_no");
		/* 模拟数据 */
		if (TypeUtils.isEmpty(teacher_no)) {
			teacher_no = "1002333115";
		}
		TeacherFeedBackListenService service = new TeacherFeedBackListenService();
		ExecResult execResult = service.getFeedBacksTable(teacher_no);
		if (execResult.getResult() != 0) {
			/** 总建议与反馈数total_num */
			int total_num = 0;
			/** 正面建议nice_num */
			int nice_num = 0;
			/** 反面建议no_num */
			int no_num = 0;
			/** 已回复reply_num */
			int reply_num = 0;
		}
		try {
			logger.info("获取反馈列表结果为：" + result);
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 添加反馈
	 */
	public void addFeedBack() {
		Map<String, String> params = new HashMap<String, String>();
		/** 教工号 */
		String teacher_no = request.getParameter("teacher_no");
		/** 反馈类型 */
		String feedback_type = request.getParameter("feedback_type");
		/** 反馈标题 */
		String feedback_title = request.getParameter("feedback_title");
		/** 反馈内容 */
		String feedback_content = request.getParameter("feedback_content");
		params.put("teacher_no", teacher_no);
		params.put("feedback_type", feedback_type);
		params.put("feedback_title", feedback_title);
		params.put("feedback_content", feedback_content);
		/** 关联教学任务 */
		params.put("task_id", "0");
		/** 反馈时间 */
		params.put("feedback_time", DateUtils.getCurrentDate("yyyy-MM-dd HH:mm:ss"));
		TeacherFeedBackListenService service = new TeacherFeedBackListenService();
		String result = (service.addFeedBack(params)).toString();
		try {
			logger.info("获取添加反馈结果为：" + result);
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 删除反馈
	 */
	public void delFeedBacks(String teacher_no, List<Map<String, Object>> lists) {

	}

}
