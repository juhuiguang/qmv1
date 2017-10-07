package com.service.base;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.jhg.common.DateUtils;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

/**
 * 
 * © 2015 niitSoft
 * 
 * @Title: BaseFeedBackService.java
 * @Description:
 * @author LiKun
 * @date 2015年8月19日
 * @version V1.0
 *
 */
public class BaseFeedBackService {

	private static Logger logger = Logger.getLogger(BaseFeedBackService.class);

	public ExecResult addFeedBackService(String stu_no, String task_id, String teach_case, String teach_case_text,
			String teach_conditions_type, String teach_conditions_text, String stu_learningStyle, String stu_other,
			String stu_advice, String stu_remarks) {
		LinkedList<String> sqlList = new LinkedList<String>();

		if (!TypeUtils.isEmpty(teach_case_text)) {
			logger.info("1、教师教学情况(选择反馈的课程)不为空。");
			StringBuilder rem = new StringBuilder();
			rem.append(
					"INSERT INTO qm_stu_feedback(stu_no , feedback_type ,feedback_title , feedback_content ,task_id,feedback_time ) VALUES(");
			rem.append(" '" + stu_no + "',");
			rem.append(" '" + teach_case + "',");
			rem.append(" '" + "教师教学情况" + "',");
			rem.append(" '" + teach_case_text + "',");
			rem.append(" '" + task_id + "',");
			rem.append(" '" + DateUtils.getCurrentDate("yyyy-MM-dd HH:mm:ss") + "')");
			sqlList.add(rem.toString());
		}
		if (!TypeUtils.isEmpty(teach_conditions_text)) {
			logger.info("2、教学条件不为空。");
			StringBuilder rem = new StringBuilder();
			rem.append(
					"INSERT INTO qm_stu_feedback(stu_no , feedback_type ,feedback_title , feedback_content ,feedback_time ) VALUES(");
			rem.append(" '" + stu_no + "',");
			rem.append(" '" + teach_conditions_type + "',");
			rem.append(" '" + "教学条件" + "',");
			rem.append(" '" + teach_conditions_text + "',");
			rem.append(" '" + DateUtils.getCurrentDate("yyyy-MM-dd HH:mm:ss") + "')");
			sqlList.add(rem.toString());
		}
		if (!TypeUtils.isEmpty(stu_learningStyle)) {
			logger.info("3、学风不为空。");
			StringBuilder rem = new StringBuilder();
			rem.append(
					"INSERT INTO qm_stu_feedback(stu_no , feedback_title , feedback_content ,feedback_time ) VALUES(");
			rem.append(" '" + stu_no + "',");
			rem.append(" '" + "学风" + "',");
			rem.append(" '" + stu_learningStyle + "',");
			rem.append(" '" + DateUtils.getCurrentDate("yyyy-MM-dd HH:mm:ss") + "')");
			sqlList.add(rem.toString());
		}
		if (!TypeUtils.isEmpty(stu_other)) {
			logger.info("4、其他不为空。");
			StringBuilder rem = new StringBuilder();
			rem.append(
					"INSERT INTO qm_stu_feedback(stu_no , feedback_title , feedback_content ,feedback_time ) VALUES(");
			rem.append(" '" + stu_no + "',");
			rem.append(" '" + "其他" + "',");
			rem.append(" '" + stu_other + "',");
			rem.append(" '" + DateUtils.getCurrentDate("yyyy-MM-dd HH:mm:ss") + "')");
			sqlList.add(rem.toString());
		}
		if (!TypeUtils.isEmpty(stu_advice)) {
			logger.info("5、措施及建议不为空。");
			StringBuilder rem = new StringBuilder();
			rem.append(
					"INSERT INTO qm_stu_feedback(stu_no , feedback_title , feedback_content ,feedback_time ) VALUES(");
			rem.append(" '" + stu_no + "',");
			rem.append(" '" + "措施及建议" + "',");
			rem.append(" '" + stu_advice + "',");
			rem.append(" '" + DateUtils.getCurrentDate("yyyy-MM-dd HH:mm:ss") + "')");
			sqlList.add(rem.toString());
		}
		if (!TypeUtils.isEmpty(stu_remarks)) {
			logger.info("6、备注不为空。");
			StringBuilder rem = new StringBuilder();
			rem.append(
					"INSERT INTO qm_stu_feedback(stu_no , feedback_title , feedback_content ,feedback_time ) VALUES(");
			rem.append(" '" + stu_no + "',");
			rem.append(" '" + "备注" + "',");
			rem.append(" '" + stu_remarks + "',");
			rem.append(" '" + DateUtils.getCurrentDate("yyyy-MM-dd HH:mm:ss") + "')");
			sqlList.add(rem.toString());
		}
		JSONResponse response = new JSONResponse();
		ExecResult result = response.getExecResult(sqlList, "添加反馈成功", "添加反馈失败");
		logger.info("批量添加反馈业务状态End >>>>>>" + result.getResult() + "," + result.getMessage());
		return result;
	}

	public ExecResult queryStudentFeedBackListService() {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM qm_stu_feedback a,base_teacher b  WHERE a.`account_no`=b.`teacher_no`");
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql.toString(), null, "");
		return result;
	}

	/**
	 * 根据学号获取相关反馈信息员的信息
	 * 
	 * @param stu_no
	 *            学号
	 * @return
	 */
	public Object queryStudentFeedBackListService(String stu_no) {
		StringBuilder sql = new StringBuilder();
		StringBuilder selsql = new StringBuilder();
		JSONObject jo = new JSONObject(); 
		sql.append("SELECT * FROM qm_stu_feedback a LEFT JOIN base_teach_task b ON b.task_no=a.task_id WHERE a.stu_no='"+stu_no+"'");
		selsql.append("SELECT a.class_name,b.dep_name,d.user_loginname,d.user_name,e.role_id FROM base_classes a LEFT JOIN base_department b ON b.dep_no=a.dep_no LEFT JOIN qm_dep_teacher c ON c.dep_no=a.dep_no LEFT JOIN tb_user d ON (d.user_loginname=c.teacher_no OR d.user_purview=a.dep_no) LEFT JOIN tb_role_user e ON e.user_id=d.user_id WHERE a.stu_no='"+stu_no+"' AND (e.role_id='7' OR e.role_id='11') GROUP BY e.user_id ");
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql.toString(), null, "");
		ExecResult selresult = jr.getSelectResult(selsql.toString(), null,"");
		jo.put("result", result);
		jo.put("selresult", selresult);
		return jo;
	}

	/**
	 * 根据部门号获取相关反馈信息员的信息
	 * 
	 * @param dep_no
	 *            部门号
	 * @param term_no 
	 * @return
	 */
	public ExecResult queryStudentFeedBackByDepNoListService(String dep_no, String term_no) {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT a.*,d.teacher_name,e.course_name FROM qm_stu_feedback a ");
		sql.append(" LEFT JOIN base_term_student b ON b.stu_no=a.stu_no ");
		sql.append(" LEFT JOIN base_classes c ON c.class_no=b.class_no ");
		sql.append(" LEFT JOIN base_teacher d ON d.teacher_no=a.account_no "); 
		sql.append(" LEFT JOIN base_teach_task e ON e.task_no=a.task_id ");
		sql.append(" WHERE c.dep_no='"+dep_no+"' AND b.term_no='"+term_no+"'");

		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql.toString(), null, "");
		return result;
	}

	/**
	 * 根据教工号获取相关巡查记录的信息
	 * 
	 * @param teacher_no
	 *            教工号
	 * @return
	 */
	public ExecResult queryQmReportsByTeacherNoListService(String teacher_no) {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM qm_patrol_report WHERE teacher_no=");
		sql.append("'" + teacher_no + "'");
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql.toString(), null, "");
		return result;
	}

	public ExecResult queryStudentClassByIdListService(String term_no, String stu_no, String class_no) {
		// int start = pageNumber - 1;
		// int length = pageLength;
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM base_term_student a ");
		sql.append("LEFT JOIN base_teach_task b ON b.class_no=a.class_no  AND b.term_no='"+term_no+"' ");
		sql.append("WHERE a.stu_no='"+stu_no+"' AND a.term_no='"+term_no+"' ");
		// if (length > 0) {
		// sql.append(" limit " + (start * length) + "," + length); 
		// }
		// String[] params = new String[] { dep_no };
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql.toString(), null, "");
		return result;

	}
	
	public ExecResult savetable(Map<String,String> param){
		//取系统当前时间
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentdateString=sdf.format(new Date());
		String sql = "UPDATE qm_stu_feedback SET resp_content='"+param.get("resp_content")+"',resp_time='"+currentdateString+"',account_no='"+param.get("account_no")+"' WHERE feedback_no='"+param.get("feedback_no")+"'";
		JSONResponse response=new JSONResponse();
		ExecResult result= response.getExecResult(sql,null,"回复成功!","回复失败!"); 
		return result;	
}

}
