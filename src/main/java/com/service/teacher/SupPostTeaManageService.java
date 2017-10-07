package com.service.teacher;

import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class SupPostTeaManageService {

	public Object getPostTeaInfor(String job_no, String term_no) {
		// TODO Auto-generated method stub
		JSONResponse jr = new JSONResponse();
		JSONObject jo = new JSONObject(); 
		//所有没有岗位的教师 
		String Sqlallteas = "SELECT a.*,b.teacher_name,c.dep_name FROM qm_dep_teacher a LEFT JOIN base_teacher b ON b.teacher_no=a.teacher_no LEFT JOIN base_department c ON c.dep_no=a.dep_no WHERE a.term_no='"+term_no+"' AND (a.job_no IS NULL OR a.job_no='') AND b.teacher_status='1' GROUP BY a.teacher_no";
		//某一岗位的所属教师
		String Sqljobteas = "SELECT a.teacher_no,a.dep_no,a.job_no,a.term_no,b.teacher_name,b.teacher_status FROM qm_dep_teacher a LEFT JOIN base_teacher b ON b.teacher_no=a.teacher_no WHERE a.job_no='"+job_no+"' AND a.term_no='"+term_no+"' GROUP BY a.teacher_no ORDER BY CONVERT( b.teacher_name USING gbk ) COLLATE gbk_chinese_ci ASC";
		
		ExecResult allteas = jr.getSelectResult(Sqlallteas, null, "qm_dep_teacher");
		ExecResult jobteas = jr.getSelectResult(Sqljobteas, null, "qm_dep_teacher");
		jo.put("allteas", allteas);
		jo.put("jobteas", jobteas);
		return jo;  
	}

	public Object DelSinglTeaPostD(String job_no, String term_no, String tea_no) {
		// TODO Auto-generated method stub
		String sql = "UPDATE qm_dep_teacher SET job_no = NULL WHERE teacher_no='"+tea_no+"' AND term_no='"+term_no+"' AND job_no='"+job_no+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(sql, null, "", ""); 
		return result; 
	}

	public Object AddSinglTeaPost(String job_no, String term_no, String tea_no) {
		// TODO Auto-generated method stub
		JSONResponse jr = new JSONResponse();
		ExecResult result = new ExecResult(true,""); 
		String select = "SELECT * FROM qm_dep_teacher WHERE term_no='"+term_no+"' AND teacher_no='"+tea_no+"' AND job_no='"+job_no+"'";
		ExecResult result2 = jr.getSelectResult(select, null, "qm_dep_teacher");
		if(result2.getResult() > 0) { 
			result = new ExecResult(false , "添加失败，此岗位新添教师已存在");

		} else {
			String sql = "UPDATE qm_dep_teacher SET job_no='"+job_no+"' WHERE teacher_no='"+tea_no+"' AND term_no='"+term_no+"' AND job_no IS NULL";
			result = jr.getExecResult(sql, null, "", "本岗位此教师添加失败！"); 
			
		}
		return result; 
	}

}
