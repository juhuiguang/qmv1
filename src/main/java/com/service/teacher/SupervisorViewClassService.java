package com.service.teacher;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class SupervisorViewClassService {
	

	public Object getViewTerm() {
		// TODO Auto-generated method stub
		String sql = "SELECT term_no,term_name FROM base_term";
		JSONResponse jr =new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master");
		return result;
	}


	public Object getSupViewClass(String supnoflag, String depnameflag, String termnoflag) {
		// TODO Auto-generated method stub
/*		String sql = "SELECT a.total,lj.teacher_name,lj.dep_no,lj1.dep_name,a.task_no,b.course_name,b.teacher_no,COUNT(a.listen_no) AS listentotal FROM qm_master_listen a LEFT JOIN base_teach_task b ON b.task_no=a.task_no  LEFT JOIN base_teacher lj ON lj.teacher_no=b.teacher_no LEFT JOIN base_department lj1 ON lj.dep_no=lj1.dep_no WHERE lj.dep_no='"+depnoflag+"' GROUP BY lj.teacher_name";
*/		
/*		String sql = "SELECT lj.teacher_name,lj.dep_no,lj1.dep_name,b.teacher_no,b.term_no,COUNT(a.listen_no) AS listentotal,ROUND(AVG(total),2) total FROM qm_master_listen a LEFT JOIN base_teach_task b ON b.task_no=a.task_no  LEFT JOIN base_teacher lj ON lj.teacher_no=b.teacher_no LEFT JOIN base_department lj1 ON lj.dep_no=lj1.dep_no WHERE lj1.dep_name='"+depnameflag+"' AND b.term_no='"+termnoflag+"' GROUP BY lj.teacher_no ORDER BY total DESC";
*/		JSONResponse jr = new JSONResponse();
		
		String sql = "SELECT a.teacher_name,a.dep_no,b.dep_name,c.teacher_no,c.term_no,COUNT(d.listen_no) AS listentotal,ROUND(AVG(total),2) total FROM base_teacher a LEFT JOIN base_department b ON b.dep_no=a.dep_no LEFT JOIN base_teach_task c ON c.teacher_no=a.teacher_no LEFT JOIN qm_master_listen d ON c.task_no=d.task_no WHERE b.dep_name='"+depnameflag+"' AND c.term_no='"+termnoflag+"' GROUP BY a.teacher_no ORDER BY total DESC";
		ExecResult result = jr.getSelectResult(sql, null, "qm_master");
		return result;
	}

	public Object getSupViewClassXQ(String teanoflag,String termnoflag) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.teacher_no,a.task_no,a.total,a.jxjy,a.skpj,a.listen_time,c.teacher_name,b.course_name FROM qm_master_listen a LEFT JOIN base_teach_task b ON b.task_no=a.task_no LEFT JOIN base_teacher c ON a.teacher_no=c.teacher_no WHERE b.teacher_no='"+teanoflag+"' AND b.term_no='"+termnoflag+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result2 = jr.getSelectResult(sql, null, "qm_master");
		return result2;
	}
	
	public ExecResult getDetails(String teano,String taskno,String termno) {
		String sql = "SELECT a.rule_title,a.rule_field FROM qm_rule a LEFT JOIN (SELECT rule_flag FROM qm_master_listen WHERE teacher_no='"+teano+"' AND task_no='"+taskno+"')tb1 ON a.rule_version_flag=tb1.rule_flag LEFT JOIN (SELECT rule_version FROM qm_xnxq_rule_version a LEFT JOIN (SELECT rule_flag FROM qm_master_listen WHERE teacher_no='"+teano+"' AND task_no='"+taskno+"')tb1 ON a.rule_type=tb1.rule_flag WHERE a.term_no='"+termno+"' AND a.rule_type=tb1.rule_flag) tb2 ON a.rule_version=tb2.rule_version WHERE a.rule_version_flag=tb1.rule_flag AND a.rule_version=tb2.rule_version";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_rule");
		JSONArray rule = result.getData(); 
		
		
		JSONArray getresult = new JSONArray();
		String sql2 = "SELECT per11,per12,per13,per14,per15 FROM qm_master_listen WHERE teacher_no='"+teano+"' AND task_no='"+taskno+"'";
		ExecResult result2 = jr.getSelectResult(sql2, null, "qm_rule");
		JSONArray pers =result2.getData();
		for(int i=0;i<rule.size();i++){

			JSONObject item = new JSONObject();
			item.put("rule_title", rule.getJSONObject(i).getString("rule_title"));
			item.put("rule_field", rule.getJSONObject(i).getString("rule_field"));
			String per=rule.getJSONObject(i).getString("rule_field").toLowerCase();   //将PER11(12，13，14，15) 转化成小写的
			
			item.put("rule_per", pers.getJSONObject(0).getString(per)); 
			getresult.add(item);
		}
		ExecResult rep=new ExecResult();
		rep.setData(getresult);
		rep.setMessage("");
		rep.setResult(true);
		
		return rep;
	}


	public Object getAllTerm() {
		// TODO Auto-generated method stub
		String sql="SELECT term_no,term_name FROM base_term";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"");
		return result;
	}
	


}
