package com.service.teacher;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class SupervisorleadViewListenPlanService {

	public Object getSupDep(String supno) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.teacher_no,b.teacher_name FROM qm_master a LEFT JOIN base_teacher b ON b.teacher_no=a.teacher_no WHERE b.dep_no=(SELECT c.dep_no FROM base_department c LEFT JOIN base_teacher b ON b.teacher_no=b.teacher_no AND c.dep_no=b.dep_no WHERE b.teacher_no='"+supno+"')";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master");
		return result;
	}

	public Object getAllDepPlan(String supbj, String termno,String depno) throws ParseException {
		// TODO Auto-generated method stub
		//取系统当前时间
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		String currentdateString=sdf.format(new Date());
		String sql="";
		if(supbj.equals("all")) {
			sql = "SELECT a.plan_no,a.plan_time,a.plan_week,a.set_time,b.course_name,c.teacher_name,d.class_name,a.task_no FROM qm_master_listen_plan a LEFT JOIN base_teach_task b ON b.task_no=a.task_no AND b.term_no=a.term_no LEFT JOIN base_teacher c ON c.teacher_no=b.teacher_no LEFT JOIN base_classes d ON d.class_no=b.class_no LEFT JOIN base_teacher e ON e.teacher_no=a.teacher_no WHERE a.term_no='"+termno+"' AND e.dep_no='"+depno+"'";			
		} else {			
			sql = "SELECT a.plan_no,a.plan_time,a.plan_week,a.set_time,b.course_name,c.teacher_name,d.class_name,a.task_no FROM qm_master_listen_plan a LEFT JOIN base_teach_task b ON b.task_no=a.task_no AND b.term_no=a.term_no LEFT JOIN base_teacher c ON c.teacher_no=b.teacher_no LEFT JOIN base_classes d ON d.class_no=b.class_no WHERE a.teacher_no='"+supbj+"' AND a.term_no='"+termno+"'";
		}
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master");
		JSONArray plan = result.getData();
		JSONArray getresult = new JSONArray();
		
		for(int i=0; i<plan.size();i++) {
			JSONObject item = new JSONObject();
			item.put("plan_no", plan.getJSONObject(i).getString("plan_no"));
			item.put("plan_time", plan.getJSONObject(i).getString("plan_time"));
			item.put("plan_week", plan.getJSONObject(i).getString("plan_week"));
			item.put("set_time", plan.getJSONObject(i).getString("set_time"));
			item.put("course_name", plan.getJSONObject(i).getString("course_name"));
			item.put("teacher_name", plan.getJSONObject(i).getString("teacher_name"));
			item.put("class_name", plan.getJSONObject(i).getString("class_name"));
			item.put("task_no", plan.getJSONObject(i).getString("task_no"));           
			String nowtime = currentdateString;
			String plantime = plan.getJSONObject(i).getString("plan_time");			
			Date datenow = sdf.parse(nowtime);
			Date dataplan = sdf.parse(plantime);			
			long gap = dataplan.getTime() - datenow.getTime();
			gap = gap / 1000 / 60 / 60 / 24;
			item.put("day_gap", gap);
			getresult.add(item);
		}
		ExecResult rep = new ExecResult();
		rep.setData(getresult);
		rep.setMessage("");
		rep.setResult(true);
		return rep;
			
	}

	public Object getAllDepPlanWeek(String supbj,String weekbj, String termno,String depno) throws ParseException {
		// TODO Auto-generated method stub
		//取系统当前时间
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		String currentdateString=sdf.format(new Date());
		String sql="";
		if(supbj.equals("all")) {
			sql = "SELECT a.plan_no,a.plan_time,a.plan_week,a.set_time,b.course_name,c.teacher_name,d.class_name,a.task_no FROM qm_master_listen_plan a LEFT JOIN base_teach_task b ON b.task_no=a.task_no AND b.term_no=a.term_no LEFT JOIN base_teacher c ON c.teacher_no=b.teacher_no LEFT JOIN base_classes d ON d.class_no=b.class_no LEFT JOIN base_teacher e ON e.teacher_no=a.teacher_no WHERE a.term_no='"+termno+"' AND a.plan_week='"+weekbj+"' AND e.dep_no='"+depno+"'";			
		} else {
			sql = "SELECT a.plan_no,a.plan_time,a.plan_week,a.set_time,b.course_name,c.teacher_name,d.class_name,a.task_no FROM qm_master_listen_plan a LEFT JOIN base_teach_task b ON b.task_no=a.task_no AND b.term_no=a.term_no LEFT JOIN base_teacher c ON c.teacher_no=b.teacher_no LEFT JOIN base_classes d ON d.class_no=b.class_no WHERE a.teacher_no='"+supbj+"' AND a.term_no='"+termno+"' AND a.plan_week='"+weekbj+"'";				
		}
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master_listen_plan");
		JSONArray plan = result.getData();
		JSONArray getresult = new JSONArray();
		
		for(int i=0; i<plan.size();i++) {
			JSONObject item = new JSONObject();
			item.put("plan_no", plan.getJSONObject(i).getString("plan_no"));
			item.put("plan_time", plan.getJSONObject(i).getString("plan_time"));
			item.put("plan_week", plan.getJSONObject(i).getString("plan_week"));
			item.put("set_time", plan.getJSONObject(i).getString("set_time"));
			item.put("course_name", plan.getJSONObject(i).getString("course_name"));
			item.put("teacher_name", plan.getJSONObject(i).getString("teacher_name"));
			item.put("class_name", plan.getJSONObject(i).getString("class_name"));
			item.put("task_no", plan.getJSONObject(i).getString("task_no"));           
			String nowtime = currentdateString;
			String plantime = plan.getJSONObject(i).getString("plan_time");			
			Date datenow = sdf.parse(nowtime);
			Date dataplan = sdf.parse(plantime);			
			long gap = dataplan.getTime() - datenow.getTime();
			gap = gap / 1000 / 60 / 60 / 24;
			item.put("day_gap", gap);
			getresult.add(item);
		}
		ExecResult rep = new ExecResult();
		rep.setData(getresult);
		rep.setMessage("");
		rep.setResult(true);
		return rep;
	}

	public Object getSupPlanCount(String depno, String termno) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.teacher_no,COUNT(a.teacher_no) AS plantotal FROM qm_master_listen_plan a LEFT JOIN base_teacher b ON b.teacher_no=a.teacher_no WHERE a.term_no='"+termno+"' AND b.dep_no='"+depno+"' GROUP BY a.teacher_no";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master_listen_plan");
		return result;
	}
		

}
