package com.service.master;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class Master_service {

	public ExecResult getMasterLisInfService(String master_no,int pageLength,int pageNumber,String term_no){
		int start = pageNumber-1;
		int length = pageLength;
		String sql="SELECT a.listen_no,c.teacher_name,b.course_name,b.course_type,a.total,DATE_FORMAT(a.listen_time,''%Y-%m-%d'') listen_time,a.task_no FROM qm_master_listen a LEFT JOIN base_teach_task b ON a.`task_no`=b.`task_no`   LEFT JOIN base_teacher c  ON b.`teacher_no`=c.`teacher_no`   WHERE a.`teacher_no`=''{0}'' AND b.`term_no`=''{1}'' ORDER BY a.listen_time DESC";
		if (length > 0) {
			sql += " limit " + (start * length) + "," + length;
		}
		String [] params=new String[] {master_no,term_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	
	public ExecResult getMasterLisInfServiceCount(String master_no,String term_no){
		String sql="SELECT COUNT(1) totalrows FROM qm_master_listen a LEFT JOIN base_teach_task b ON b.`task_no`=a.`task_no` LEFT JOIN base_teacher c ON b.`teacher_no`=c.`teacher_no` WHERE a.`teacher_no`=''{0}'' AND b.`term_no`=''{1}''";
		String [] params=new String[] {master_no,term_no};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	public ExecResult getMasterLisInfSearchService(String master_no,int pageLength,int pageNumber,String teacher_name,String strart_date,String end_date,String term_no){
		int start = pageNumber-1;
		int length = pageLength;
		if (teacher_name!="" && strart_date==""&& end_date=="")
		{
	       String sql="SELECT base_teacher.teacher_name,base_teach_task.course_name,base_teach_task.`course_type`,qm_master_listen.total,DATE_FORMAT(qm_master_listen.listen_time,''%Y-%m-%d %H:%i:%s'') listen_time,qm_master_listen.`listen_no`,qm_master_listen.`task_no`  FROM qm_master_listen LEFT JOIN base_teach_task ON base_teach_task.`task_no`=qm_master_listen.`task_no` LEFT JOIN base_teacher ON base_teach_task.`teacher_no`=base_teacher.`teacher_no` WHERE qm_master_listen.`teacher_no` =''{0}'' AND base_teacher.teacher_name LIKE ''%{1}%'' AND base_teach_task.`term_no`=''{2}'' ORDER BY qm_master_listen.listen_time DESC";
		if (length > 0) {
			sql += " limit " + (start * length) + "," + length;
		}
		  String [] params=new String[] {master_no,teacher_name,term_no}; 
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
		}
		if(teacher_name=="" && strart_date!=""&& end_date=="")
		{
	       String sql="SELECT base_teacher.teacher_name,base_teach_task.course_name,base_teach_task.`course_type`,qm_master_listen.total,DATE_FORMAT(qm_master_listen.listen_time,''%Y-%m-%d %H:%i:%s'') listen_time,qm_master_listen.`listen_no`,qm_master_listen.`task_no`  FROM qm_master_listen LEFT JOIN base_teach_task ON base_teach_task.`task_no`=qm_master_listen.`task_no` LEFT JOIN base_teacher ON base_teach_task.`teacher_no`=base_teacher.`teacher_no` WHERE qm_master_listen.`teacher_no` =''{0}'' AND qm_master_listen.listen_time >= ''{1}'' AND base_teach_task.`term_no`=''{2}'' ORDER BY qm_master_listen.listen_time DESC";
		if (length > 0) {
			sql += " limit " + (start * length) + "," + length;
		}
		  String [] params=new String[] {master_no,strart_date,term_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
		}
		if( teacher_name=="" && strart_date==""&& end_date!="")
		{
	       String sql="SELECT base_teacher.teacher_name,base_teach_task.course_name,base_teach_task.`course_type`,qm_master_listen.total,DATE_FORMAT(qm_master_listen.listen_time,''%Y-%m-%d %H:%i:%s'') listen_time,qm_master_listen.`listen_no`,qm_master_listen.`task_no`  FROM qm_master_listen LEFT JOIN base_teach_task ON base_teach_task.`task_no`=qm_master_listen.`task_no` LEFT JOIN base_teacher ON base_teach_task.`teacher_no`=base_teacher.`teacher_no` WHERE qm_master_listen.`teacher_no` =''{0}'' AND qm_master_listen.`listen_time` <= ''{1}'' AND base_teach_task.`term_no`=''{2}'' ORDER BY qm_master_listen.listen_time DESC";
		if (length > 0) {
			sql += " limit " + (start * length) + "," + length;
		}
		  String [] params=new String[] {master_no,end_date,term_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
		}
		if(teacher_name=="" && strart_date!=""&& end_date!="")
		{
	       String sql="SELECT base_teacher.teacher_name,base_teach_task.course_name,base_teach_task.`course_type`,qm_master_listen.total,DATE_FORMAT(qm_master_listen.listen_time,''%Y-%m-%d %H:%i:%s'') listen_time,qm_master_listen.`listen_no`,qm_master_listen.`task_no`  FROM qm_master_listen LEFT JOIN base_teach_task ON base_teach_task.`task_no`=qm_master_listen.`task_no` LEFT JOIN base_teacher ON base_teach_task.`teacher_no`=base_teacher.`teacher_no` WHERE qm_master_listen.`teacher_no` = ''{0}'' AND qm_master_listen.`listen_time` >= ''{1}'' AND  qm_master_listen.`listen_time` <= ''{2}'' AND base_teach_task.`term_no`=''{3}'' ORDER BY qm_master_listen.listen_time DESC";
		if (length > 0) {
			sql += " limit " + (start * length) + "," + length;
		}
		  String [] params=new String[] {master_no,strart_date,end_date,term_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
		}
		if(teacher_name!="" && strart_date==""&& end_date!="")
		{
	       String sql="SELECT base_teacher.teacher_name,base_teach_task.course_name,base_teach_task.`course_type`,qm_master_listen.total,DATE_FORMAT(qm_master_listen.listen_time,''%Y-%m-%d %H:%i:%s'') listen_time,qm_master_listen.`listen_no`,qm_master_listen.`task_no`  FROM qm_master_listen LEFT JOIN base_teach_task ON base_teach_task.`task_no`=qm_master_listen.`task_no` LEFT JOIN base_teacher ON base_teach_task.`teacher_no`=base_teacher.`teacher_no` WHERE qm_master_listen.`teacher_no` = ''{0}'' AND base_teacher.`teacher_name` LIKE ''%{1}%'' AND qm_master_listen.`listen_time` <= ''{2}'' AND base_teach_task.`term_no`=''{3}'' ORDER BY qm_master_listen.listen_time DESC";
		if (length > 0) {
			sql += " limit " + (start * length) + "," + length;
		}
		  String [] params=new String[] {master_no,teacher_name,end_date,term_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
		}
		if(teacher_name!="" && strart_date!=""&& end_date=="")
		{
	       String sql="SELECT base_teacher.teacher_name,base_teach_task.course_name,base_teach_task.`course_type`,qm_master_listen.total,DATE_FORMAT(qm_master_listen.listen_time,''%Y-%m-%d %H:%i:%s'') listen_time,qm_master_listen.`listen_no`,qm_master_listen.`task_no`  FROM qm_master_listen LEFT JOIN base_teach_task ON base_teach_task.`task_no`=qm_master_listen.`task_no` LEFT JOIN base_teacher ON base_teach_task.`teacher_no`=base_teacher.`teacher_no` WHERE qm_master_listen.`teacher_no` = ''{0}'' AND base_teacher.`teacher_name` LIKE ''%{1}%'' AND qm_master_listen.`listen_time` >= ''{2}'' AND base_teach_task.`term_no`=''{3}'' ORDER BY qm_master_listen.listen_time DESC";
		if (length > 0) {
			sql += " limit " + (start * length) + "," + length;
		}
		  String [] params=new String[] {master_no,teacher_name,strart_date,term_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
		}
		if(teacher_name!="" && strart_date!=""&& end_date!="")
		{
	       String sql="SELECT base_teacher.teacher_name,base_teach_task.course_name,base_teach_task.`course_type`,qm_master_listen.total,DATE_FORMAT(qm_master_listen.listen_time,''%Y-%m-%d %H:%i:%s'') listen_time,qm_master_listen.`listen_no`,qm_master_listen.`task_no`  FROM qm_master_listen LEFT JOIN base_teach_task ON base_teach_task.`task_no`=qm_master_listen.`task_no` LEFT JOIN base_teacher ON base_teach_task.`teacher_no`=base_teacher.`teacher_no` WHERE qm_master_listen.`teacher_no` = ''{0}'' AND base_teacher.`teacher_name` LIKE ''%{1}%'' AND qm_master_listen.`listen_time` >= ''{2}'' AND qm_master_listen.`listen_time` <= ''{3}'' AND base_teach_task.`term_no`=''{4}'' ORDER BY qm_master_listen.listen_time DESC";
	       if (length > 0) {
				sql += " limit " + (start * length) + "," + length;
			}
			  String [] params=new String[] {master_no,teacher_name,strart_date,end_date,term_no};
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"");
			return result;
		}
		return null;
	}
	
	public ExecResult getMasterLisInfSearchServiceCount(String master_no,String teacher_name,String strart_date,String end_date,String term_no){

		if(teacher_name!="" && strart_date==""&& end_date=="")
		{
	       String sql="SELECT COUNT(1) totalrows FROM qm_master_listen LEFT JOIN base_teach_task ON base_teach_task.`task_no`=qm_master_listen.`task_no` LEFT JOIN base_teacher ON base_teach_task.`teacher_no`=base_teacher.`teacher_no` WHERE qm_master_listen.`teacher_no` =''{0}'' AND base_teacher.teacher_name LIKE ''%{1}%'' AND base_teach_task.`term_no`=''{2}''";
	       String [] params=new String[] {master_no,teacher_name,term_no};
			
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"");
			return result;
		}
		if(teacher_name=="" && strart_date!=""&& end_date=="")
		{
	       String sql="SELECT COUNT(1) totalrows FROM qm_master_listen LEFT JOIN base_teach_task ON base_teach_task.`task_no`=qm_master_listen.`task_no` LEFT JOIN base_teacher ON base_teach_task.`teacher_no`=base_teacher.`teacher_no` WHERE qm_master_listen.`teacher_no` =''{0}'' AND qm_master_listen.listen_time >= ''{1}'' AND base_teach_task.`term_no`=''{2}''";
		   String [] params=new String[] {master_no,strart_date,term_no};
		   JSONResponse jr=new JSONResponse();
		   ExecResult result=jr.getSelectResult(sql, params,"");
		   return result;
		}
		if(teacher_name=="" && strart_date==""&& end_date!="")
		{
	       String sql="SELECT COUNT(1) totalrows FROM qm_master_listen LEFT JOIN base_teach_task ON base_teach_task.`task_no`=qm_master_listen.`task_no` LEFT JOIN base_teacher ON base_teach_task.`teacher_no`=base_teacher.`teacher_no` WHERE qm_master_listen.`teacher_no` =''{0}'' AND qm_master_listen.`listen_time` <= ''{1}'' AND base_teach_task.`term_no`=''{2}''";
	       String [] params=new String[] {master_no,end_date,term_no};
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"");
			return result;
		}
		if(teacher_name=="" && strart_date!=""&& end_date!="")
		{
	       String sql="SELECT COUNT(1) totalrows FROM qm_master_listen LEFT JOIN base_teach_task ON base_teach_task.`task_no`=qm_master_listen.`task_no` LEFT JOIN base_teacher ON base_teach_task.`teacher_no`=base_teacher.`teacher_no` WHERE qm_master_listen.`teacher_no` = ''{0}'' AND qm_master_listen.`listen_time` >= ''{1}'' AND  qm_master_listen.`listen_time` <= ''{2}'' AND base_teach_task.`term_no`=''{3}''";
	       String [] params=new String[] {master_no,strart_date,end_date,term_no};
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"");
			return result;
		}
		if(teacher_name!="" && strart_date==""&& end_date!="")
		{
	       String sql="SELECT COUNT(1) totalrows FROM qm_master_listen LEFT JOIN base_teach_task ON base_teach_task.`task_no`=qm_master_listen.`task_no` LEFT JOIN base_teacher ON base_teach_task.`teacher_no`=base_teacher.`teacher_no` WHERE qm_master_listen.`teacher_no` = ''{0}'' AND base_teacher.`teacher_name` LIKE ''%{1}%'' AND qm_master_listen.`listen_time` >= ''{2}'' AND base_teach_task.`term_no`=''{3}''";
	       String [] params=new String[] {master_no,teacher_name,end_date,term_no};
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"");
			return result;
		}
		if(teacher_name!="" && strart_date!=""&& end_date=="")
		{
	       String sql="SELECT COUNT(1) totalrows FROM qm_master_listen LEFT JOIN base_teach_task ON base_teach_task.`task_no`=qm_master_listen.`task_no` LEFT JOIN base_teacher ON base_teach_task.`teacher_no`=base_teacher.`teacher_no` WHERE qm_master_listen.`teacher_no` = ''{0}'' AND base_teacher.`teacher_name` LIKE ''%{1}%'' AND qm_master_listen.`listen_time` >= ''{2}'' AND base_teach_task.`term_no`=''{3}''";
	       String [] params=new String[] {master_no,teacher_name,strart_date,term_no};
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"");
			return result;
		}
		if(teacher_name!="" && strart_date!=""&& end_date!="")
		{
	       String sql="SELECT COUNT(1) totalrows FROM qm_master_listen LEFT JOIN base_teach_task ON base_teach_task.`task_no`=qm_master_listen.`task_no` LEFT JOIN base_teacher ON base_teach_task.`teacher_no`=base_teacher.`teacher_no` WHERE qm_master_listen.`teacher_no` = ''{0}'' AND base_teacher.`teacher_name` LIKE ''%{1}%'' AND qm_master_listen.`listen_time` >= ''{2}'' AND qm_master_listen.`listen_time` <= ''{3}'' AND base_teach_task.`term_no`=''{4}''";
	       String [] params=new String[] {master_no,teacher_name,strart_date,end_date,term_no};
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"");
			return result;
		}
		return null;
	}
	public ExecResult deletemasterlistenService(String task_no,String listen_time,String master_no){
		ExecResult result=null;
 		String sqlinsert="DELETE FROM `qm_master_listen` WHERE task_no=''{0}'' AND listen_time=''{1}'' AND teacher_no=''{2}''";
 		JSONResponse response=new JSONResponse();
 		String [] insert =new String[]{task_no,listen_time,master_no};
 		result= response.getExecResult(sqlinsert, insert, "删除成功","删除失败"); 
 		return result;
	}
	
	
	public ExecResult getTermData(String term_no){
		ExecResult result=null;
 		String sqlinsert="SELECT DATE_FORMAT(a.term_startdate, ''%Y/%m/%d'') term_startdate ,tb1.term_enddate FROM `base_term` a LEFT JOIN ( SELECT DATE_FORMAT(term_startdate, ''%Y/%m/%d'') term_enddate FROM base_term   WHERE term_no > ''{0}'' LIMIT 1 )tb1 ON tb1.term_enddate IS NOT NULL WHERE a.term_no=''{0}''";
 		JSONResponse response=new JSONResponse();
 		String [] insert =new String[]{term_no};
 		result= response.getSelectResult(sqlinsert, insert,"");
 		return result;
	}
	
	
	public ExecResult getTeaListenTable(String id , String term_no){

		String sql="SELECT * FROM qm_master_listen WHERE listen_no=''{0}''";
		String [] params=new String[] {id,term_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_master_listen");
		JSONArray getresult=new JSONArray();
		ExecResult rep=new ExecResult();
		if(result.getResult()==0){
			rep.setResult(false);
		}else{
			
			JSONArray grand=new JSONArray(); 
			grand=result.getData();
			String sql_rule="SELECT * FROM qm_rule WHERE rule_version_flag=''{1}'' AND rule_status='1' AND rule_version=(SELECT rule_version FROM qm_xnxq_rule_version WHERE term_no=''{0}'' AND rule_type=''{1}'')"; 
			String [] params_=new String[] {term_no,grand.getJSONObject(0).getString("rule_flag")};
			ExecResult result_rule=jr.getSelectResult(sql_rule, params_,"qm_master_listen"); 
			if(result_rule.getResult()==0){
				rep.setResult(false); 
			}else{
				JSONArray rule=new JSONArray();
				rule=result_rule.getData();
				
				for(int i=0;i<rule.size();i++){
					JSONObject item=new JSONObject();  
					item.put("rule_version_title", rule.getJSONObject(i).getString("rule_version_title"));
					item.put("rule_goal", rule.getJSONObject(i).getString("rule_goal"));
					item.put("rule_title", rule.getJSONObject(i).getString("rule_title"));
					item.put("rule_field", rule.getJSONObject(i).getString("rule_field"));
					String per=rule.getJSONObject(i).getString("rule_field").toLowerCase();
					item.put("grand", grand.getJSONObject(0).getString(per));
					item.put("jxjy", grand.getJSONObject(0).getString("jxjy"));
					item.put("skpj", grand.getJSONObject(0).getString("skpj"));
					getresult.add(item); 
				}
				
				rep.setResult(true);
			}
		}
		rep.setData(getresult); 
		rep.setMessage(""); 
		return rep; 
	}
	public ExecResult postgrand(String id,String jxjy,String jxpj,String grand){
		String [] paramgrand=grand.split(",");
		String sql="UPDATE  qm_master_listen SET ";
		int total=0;
				for(int i=0;i<paramgrand.length;i++){
					String [] param=paramgrand[i].split("-");
					sql+=param[0].toLowerCase()+"="+param[1]+", "; 
					total+=Integer.parseInt(param[1]); 
				} 
				sql+="total="+total+", "; 
				sql+="jxjy="+"'"+jxjy+"'"+" ,skpj="+"'"+jxpj+"'"+" WHERE listen_no="+"'"+id+"'";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getExecResult(sql, null, "", "");   
		return result;
	}
}
