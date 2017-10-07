package com.service.base;

import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class BaseReportService {
	public ExecResult getReportInf(String term_no, String teacher_no, String dep_no) {
		String sql = "SELECT * FROM qm_patrol_report WHERE term_no=''{0}'' ORDER BY  report_time DESC";
		JSONResponse js = new JSONResponse(); 
		String[] params_ = new String[] { term_no, teacher_no, dep_no };
		ExecResult result = js.getSelectResult(sql, params_, "qm_patrol_report");
		return result;
	}

	public ExecResult getTermInf() {
		String sql = "SELECT term_name ,term_no ,term_status FROM base_term ORDER BY term_no DESC";
		JSONResponse js = new JSONResponse();
		ExecResult result = js.getSelectResult(sql, null, "base_term");
		return result;
	}

	/**
	 * 根据巡查记录表ID查询指定报告
	 * 
	 * @return
	 */
	public ExecResult getPatrolReportInfById(String report_no) {
		if (TypeUtils.isEmpty(report_no)) {
			return null;
		}
		String sql = "SELECT * FROM qm_patrol_report WHERE report_no = " + report_no;
		JSONResponse js = new JSONResponse();
		ExecResult result = js.getSelectResult(sql, null, "qm_patrol_report");
		return result;
	}

	public ExecResult postReportInf(String term_no, String teacher_no, String dep_no, String report_publish,
			String report_week, String report_date, String report_stuattendance, String report_stustudy,
			String report_teateach, String report_teachmanage, String report_teachsecurity, String report_other,
			String id) {

		JSONResponse js = new JSONResponse();
		String[] params = new String[] { term_no, teacher_no, dep_no, report_publish, report_week, report_date,
				report_stuattendance, report_stustudy, report_teateach, report_teachmanage, report_teachsecurity,
				report_other };
		ExecResult result = new ExecResult();
		String sql_judge = "SELECT * FROM qm_patrol_report WHERE term_no=''{0}'' AND report_week=''{4}'' AND teacher_no=''{1}'' AND report_dep=''{2}''";

		if (!id.equals("")) {
			String sql_update = "UPDATE  qm_patrol_report SET term_no=''{0}'' , teacher_no= ''{1}'',  report_date=''{5}'' ,report_dep=''{2}'' ,report_stuattendance=''{6}'',report_stustudy=''{7}'',report_teateach=''{8}'', report_teachmanage=''{9}'',report_teachsecurity=''{10}'',report_other=''{11}'',report_publish=''{3}'' WHERE report_no="
					+ id + "";
			result = js.getExecResult(sql_update, params, "", "");

		} else {
			if (js.getSelectResult(sql_judge, params, "").getResult() > 0) {
				result.setResult(false);
			} else {
				String sql = "INSERT INTO qm_patrol_report(term_no , teacher_no , report_week , report_date ,report_dep ,report_stuattendance,report_stustudy,report_teateach, report_teachmanage,report_teachsecurity,report_other,report_publish) VALUES(''{0}'',''{1}'',''{4}'',''{5}'',''{2}'',''{6}'',''{7}'',''{8}'',''{9}'',''{10}'',''{11}'',''{3}'')";

				result = js.getExecResult(sql, params, "", "");
			}
		}
		return result;
	}

	public ExecResult deleteReportInf(String id) {
		JSONResponse js = new JSONResponse();

		String sql = "DELETE FROM qm_patrol_report WHERE report_no=''{0}''";

		String[] params = new String[] { id };
		ExecResult result = js.getExecResult(sql, params, "", "");
		return result;
	}
}
