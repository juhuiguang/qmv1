package com.service.teacher;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class SupervisorListenPlanService {

	public Object getSupViewMarkTea(String supno, String termno) {
		// TODO Auto-generated method stub
		String sql ="SELECT a.term_no,a.teacher_no,b.teacher_name FROM qm_master_mark a LEFT JOIN base_teacher b ON b.teacher_no=a.teacher_no WHERE a.master_teacher_no='"+supno+"' AND a.term_no='"+termno+"' GROUP BY b.teacher_name ORDER BY CONVERT( b.teacher_name USING gbk ) COLLATE gbk_chinese_ci ASC";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master");
		return result;
	}

	public Object getSupViewMarkTeaTask(String teano,String termno) {
		// TODO Auto-generated method stub
		String sql = "SELECT c.term_name,a.task_no,a.course_name,b.teacher_name,d.class_name FROM base_teach_task a LEFT JOIN base_teacher b ON b.teacher_no=a.teacher_no LEFT JOIN base_term c ON a.term_no=c.term_no LEFT JOIN base_classes d ON a.class_no=d.class_no WHERE a.teacher_no='"+teano+"' AND a.term_no='"+termno+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master");
		return result;
	}

	public Object getSupPlanAdd(String supno, String termno,String taskno, String plantime,String currentweek) {
		// TODO Auto-generated method stub
		//取系统当前时间
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentdateString=sdf.format(new Date());
		//算周次
		String sql = "SELECT TIMESTAMPDIFF(WEEK, ' "+currentdateString+" ' ,'"+plantime+"') as timeminus ";		
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master");		
		JSONArray atime=result.getData();
		String timeminus=atime.getJSONObject(0).getString("timeminus");
		String week=""+(Integer.parseInt(timeminus)+Integer.parseInt(currentweek)+1); 		
		String sql3 = "SELECT * FROM qm_master_listen_plan WHERE teacher_no='"+supno+"' AND term_no='"+termno+"' AND task_no='"+taskno+"' AND plan_time='"+plantime+"' AND plan_week='"+week+"'";
		JSONResponse jrr = new JSONResponse();
		ExecResult result3 = jrr.getSelectResult(sql3, null, "qm_listen_plan");
//	    System.out.println(result3.getData().size());
		if(result3.getData().size() == 0){
			String sql2 = "INSERT INTO qm_master_listen_plan(term_no,teacher_no,task_no,plan_time,plan_week,set_time) VALUES("+"'"+termno+"'"+","+"'"+supno+"'"+","+"'"+taskno+"'"+","+"'"+plantime+"'"+","+"'"+week+"'"+","+"'"+currentdateString+"'"+")";
			JSONResponse jre = new JSONResponse();
			ExecResult result2 = jre.getExecInsertId(sql2, null, "制定听课计划成功", "制定听课计划失败"); 
//			System.out.println(result2);
			return result2;
		} else {
//			System.out.println(result3);
			return result3;
		}
		
	}

	public Object getViewPlan(String supno, String termno) throws ParseException {
		// TODO Auto-generated method stub
		//取系统当前时间
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		String currentdateString=sdf.format(new Date());
		
		String sql = "SELECT a.plan_no,a.plan_time,a.plan_week,a.set_time,b.course_name,c.teacher_name,d.class_name,a.task_no FROM qm_master_listen_plan a LEFT JOIN base_teach_task b ON b.task_no=a.task_no AND b.term_no=a.term_no LEFT JOIN base_teacher c ON c.teacher_no=b.teacher_no LEFT JOIN base_classes d ON d.class_no=b.class_no WHERE a.teacher_no='"+supno+"' AND a.term_no='"+termno+"'";
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

	public Object getDeletePlan(String planno) {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM qm_master_listen_plan WHERE plan_no='"+planno+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(sql, null,"删除成功！","删除失败");
		return result;
	}

	public Object getUpdataPlan(String planno, String supno, String termno, String taskno,
			String plantime, String currentweek) {
		// TODO Auto-generated method stub
		//取系统当前时间
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
				String currentdateString=sdf.format(new Date());				
				String sql = "SELECT TIMESTAMPDIFF(WEEK, ' "+currentdateString+" ' ,'"+plantime+"') as timeminus ";
				JSONResponse jr = new JSONResponse();
				ExecResult result = jr.getSelectResult(sql, null, "qm_master");				
				JSONArray atime=result.getData();
				String timeminus=atime.getJSONObject(0).getString("timeminus");
				String week=""+(Integer.parseInt(timeminus)+Integer.parseInt(currentweek)); 
	
				String sql2 ="UPDATE qm_master_listen_plan SET term_no ='"+termno+"',teacher_no='"+supno+"',task_no='"+taskno+"',plan_time='"+plantime+"',plan_week='"+week+"',set_time='"+currentdateString+"' WHERE plan_no='"+planno+"'";
				JSONResponse jre = new JSONResponse();
				ExecResult result2 = jre.getExecResult(sql2, null, "", "");
				return result2;
	
	}

}
