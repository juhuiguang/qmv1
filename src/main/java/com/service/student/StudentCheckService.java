package com.service.student;

import java.util.Map;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;
import com.service.app.AppService;

public class StudentCheckService {
	public ExecResult getStuCheckInf(String tea_no ,String term_no){
		String sql="SELECT a.course_type, a.course_name , b.sche_no ,b.sche_set , IFNULL( c.class_name,d.logic_name) AS class_name FROM base_teach_task a left JOIN base_task_sche b ON a.task_no=b.task_no LEFT JOIN base_classes c ON a.class_no=c.class_no LEFT JOIN base_class_logic d ON (a.task_no=d.task_no AND a.term_no=d.term_no) WHERE  a.teacher_no=''{0}'' AND a.term_no=''{1}'' GROUP BY b.sche_no ORDER BY b.sche_set";
		String [] params_=new String[] {tea_no,term_no};  
		    
		JSONResponse js=new JSONResponse();
		ExecResult result=js.getSelectResult(sql, params_,"base_teach_task");
		return result;
	}
	public ExecResult getStuCheckClassInf(String sche_no ,String term_no,String course_type){
		if(course_type.equals("任选课")){    
			String sql_="SELECT b.course_week ,b.course_scount ,c.student_no as stu_no,d.stu_name FROM base_task_sche a JOIN base_teach_task b ON a.task_no=b.task_no JOIN base_class_logic c ON c.course_no=b.course_no AND c.task_no=b.task_no JOIN base_student d ON d.stu_no=c.student_no AND d.stu_status = 1 WHERE a.sche_no=''{0}'' AND c.term_no=''{1}'' ORDER BY c.student_no";
			String [] params_=new String[] {sche_no,term_no};  
			 
			JSONResponse js_=new JSONResponse();  
			ExecResult result_=js_.getSelectResult(sql_, params_,"base_teach_task");
			return result_;  
		}else{  
			
			String sql="SELECT b.course_week ,b.course_scount ,c.stu_no ,d.stu_name FROM base_task_sche a JOIN base_teach_task b ON a.task_no=b.task_no JOIN base_term_student c ON c.class_no=b.class_no JOIN base_student d ON d.stu_no=c.stu_no AND d.stu_status = 1 WHERE a.sche_no=''{0}'' AND c.term_no=''{1}'' order by c.stu_no";
			String [] params_=new String[] {sche_no,term_no}; 
			 
			JSONResponse js=new JSONResponse();
			ExecResult result=js.getSelectResult(sql, params_,"base_teach_task");
			return result;
		}
	}
	
	public ExecResult getStuStatus(String sche_no ,String currentweek ,String term_no){
		String sql="SELECT check_main_no FROM qm_stu_check_main WHERE sche_no=''{0}'' AND check_week=''{1}'' AND term_no=''{2}'' ";
		String [] params_=new String[] {sche_no,currentweek,term_no};
		
		JSONResponse js=new JSONResponse();
		ExecResult result=js.getSelectResult(sql, params_,"base_teach_task");
		String mainid="";
		JSONArray checklist=new JSONArray();
		//考勤主表不存在数据
		if(result.getResult()==0){
			
			String sql_="INSERT INTO qm_stu_check_main(sche_no , check_week ,term_no) VALUES(''{0}'',''{1}'',''{2}'')";
			
			mainid=js.getExecInsertId(sql_,params_,null,null).getMessage();
			
		}
		//考勤主表存在数据
		else{
			JSONArray ja=result.getData();
			if(ja.size()>0){
				 mainid=ja.getJSONObject(0).getString("check_main_no");
			}
			
			String [] _params=new String[] {mainid};
			String _sql="SELECT * FROM qm_stu_check WHERE check_main_no=''{0}''";
			result=js.getSelectResult(_sql, _params,"checklist");
			if(result.getResult()>0){
				checklist=result.getData();
			}
		}
		JSONArray getresult=new JSONArray();
		JSONObject item=new JSONObject();
		item.put("mainid", mainid);
		item.put("checklist",checklist);
		getresult.add(item);
		
		ExecResult er=new ExecResult();
		er.setResult(true);
		er.setMessage("");
		er.setData(getresult);
		return er;	
	}
	
	public ExecResult changeStuStatus(Map<String,String> param){
		String sql="UPDATE qm_stu_check SET check_status=";
				sql+="'"+param.get("check_status")+"'";
				
		sql+=" "+ "WHERE check_status="+"'"+param.get("old_check_status")+"'" +" "+"AND check_main_no="+param.get("mainid")+" AND stu_no="+"'"+param.get("stu_no")+"'"+"";
		JSONResponse response=new JSONResponse();
		ExecResult result= response.getExecResult(sql, null, null,null);
		
		new AppService().changeCheckMain(param.get("mainid"));
		return result;
	}
	public ExecResult saveStuStatus(Map<String,String> param){
		String sql="insert into qm_stu_check(check_main_no , stu_no ,check_status) values(";
				sql+=param.get("mainid")+",";
				sql+="'"+param.get("stu_no")+"',";
				sql+="'"+param.get("check_status")+"')";
		JSONResponse response=new JSONResponse();
		ExecResult result= response.getExecInsertId(sql, null, null,null);
		new AppService().changeCheckMain(param.get("mainid"));
		
		return result;
	}
	public ExecResult removeStuStatus(Map<String,String> param){
		String sql="DELETE FROM qm_stu_check WHERE check_status=";
				sql+="'"+param.get("check_status")+"'" ;
				sql+=" "+"and stu_no="+"'"+param.get("stu_no")+"'";
				sql+=" "+"and check_main_no="+param.get("mainid");
				
		JSONResponse response=new JSONResponse();
		ExecResult result= response.getExecResult(sql, null, null,null);
		new AppService().changeCheckMain(param.get("mainid"));
		return result;
	}
	public ExecResult getsxStuStatus(String sche_no ,String currentweek ,String term_no , String check_sx){
		String sql="SELECT check_main_no FROM qm_stu_check_main WHERE sche_no=''{0}'' AND check_week=''{1}'' AND term_no=''{2}'' AND check_sx=''{3}''";
		String [] params_=new String[] {sche_no,currentweek,term_no,check_sx};
		
		JSONResponse js=new JSONResponse();
		ExecResult result=js.getSelectResult(sql, params_,"base_teach_task");
		String mainid="";
		JSONArray checklist=new JSONArray();
		//考勤主表不存在数据
		if(result.getResult()==0){
			
			String sql_="INSERT INTO qm_stu_check_main(sche_no , check_week ,term_no,check_sx) VALUES(''{0}'',''{1}'',''{2}'',''{3}'')";
			
			mainid=js.getExecInsertId(sql_,params_,null,null).getMessage();
			System.out.println(mainid);
		}
		//考勤主表存在数据
		else{
			JSONArray ja=result.getData();
			if(ja.size()>0){
				 mainid=ja.getJSONObject(0).getString("check_main_no");
			}
			
			String [] _params=new String[] {mainid};
			String _sql="SELECT * FROM qm_stu_check WHERE check_main_no=''{0}''";
			result=js.getSelectResult(_sql, _params,"checklist");
			if(result.getResult()>0){
				checklist=result.getData();
			}
		}
		JSONArray getresult=new JSONArray();
		JSONObject item=new JSONObject();
		item.put("mainid", mainid);
		item.put("checklist",checklist);
		getresult.add(item);
		
		ExecResult er=new ExecResult();
		er.setResult(true);
		er.setMessage("");
		er.setData(getresult);
		return er;	
	}
	public ExecResult postsxStuStatus(String sche_no ,String currentweek ,String term_no ,String check_sx ,String check_kk , String check_cd , String check_zt,String check_qj,String check_count,String check_ration){
		String sql="UPDATE qm_stu_check_main SET check_main_status=1 ,check_kk=''{4}'' ,check_cd=''{5}'', check_zt=''{6}'' ,check_qj=''{7}'' ,check_count=''{8}'',check_ratio=''{9}'' WHERE sche_no=''{0}''  AND check_week=''{1}''  AND term_no=''{2}'' AND check_sx=''{3}''";
		String [] params_=new String[] {sche_no,currentweek,term_no,check_sx,check_kk,check_cd,check_zt,check_qj,check_count,check_ration};
		
		JSONResponse response=new JSONResponse();
		ExecResult result= response.getExecResult(sql, params_, "考勤记录提交成功","考勤记录提交失败");
		return result;
	} 
	public ExecResult postStuStatus(String sche_no ,String currentweek ,String term_no ,String check_kk , String check_cd , String check_zt,String check_qj,String check_count,String check_ration){
		String sql="UPDATE qm_stu_check_main SET check_main_status=1 ,check_kk=''{3}'' ,check_cd=''{4}'' ,check_zt=''{5}'', check_qj=''{6}'',check_count=''{7}'',check_ratio=''{8}'' WHERE sche_no=''{0}''  AND check_week=''{1}''  AND term_no=''{2}'' ";
		String [] params_=new String[] {sche_no,currentweek,term_no,check_kk,check_cd,check_zt,check_qj,check_count,check_ration}; 
		 
		JSONResponse response=new JSONResponse();
		ExecResult result= response.getExecResult(sql, params_, "考勤记录提交成功","考勤记录提交失败");
		return result;
	}
	public ExecResult getsxweeksSta(String sche_no ,String term_no , String check_sx){
		String sql="SELECT  check_week FROM qm_stu_check_main WHERE sche_no=''{0}'' AND check_sx=''{2}'' AND term_no=''{1}'' and check_main_status=1";
		String [] params_=new String[] {sche_no,term_no ,check_sx};
		 
		JSONResponse js=new JSONResponse();
		ExecResult result=js.getSelectResult(sql, params_,"qm_stu_check_main");
		
		return result;
	}
	public ExecResult getweeksSta(String sche_no ,String term_no ){
		String sql="SELECT  check_week FROM qm_stu_check_main WHERE sche_no=''{0}''  AND term_no=''{1}'' and check_main_status=1";
		String [] params_=new String[] {sche_no,term_no};
		
		JSONResponse js=new JSONResponse();
		ExecResult result=js.getSelectResult(sql, params_,"qm_stu_check_main");
		return result;
	} 
	public ExecResult getCheckRecord(String check_sche_no) {
		
		String sql="SELECT * FROM `qm_stu_check_main` WHERE sche_no='"+check_sche_no+"' ORDER BY check_week desc";
		
		JSONResponse js=new JSONResponse();
		ExecResult result=js.getSelectResult(sql, null,"");
		return result;
	} 
	public ExecResult loadSwitch(String term_no) {
		String sql="SELECT * FROM base_term WHERE term_no='"+term_no+"'";
		JSONResponse js=new JSONResponse(); 
		ExecResult result=js.getSelectResult(sql, null,"");
		return result;
	}
}
