package com.service.master;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class MasterViewJudgeService {
	public ExecResult getTermInf( ){
		String sql="SELECT term_name ,term_no ,term_status FROM base_term ORDER BY term_no desc";
		JSONResponse js=new JSONResponse(); 
		ExecResult result=js.getSelectResult(sql, null,"base_term");  
		return result; 
	}
	public ExecResult getteacher(String dep_no,String term_no){ 
		String sql=" SELECT b.teacher_no ,b.teacher_name,b.teacher_title FROM qm_dep_teacher  a  JOIN   base_teacher b ON a.teacher_no=b.teacher_no WHERE a.dep_no=''{0}'' AND a.term_no=''{1}'' ORDER BY b.teacher_type DESC, a.teacher_no ";
		String [] params_=new String[] {dep_no,term_no};
		JSONResponse js=new JSONResponse(); 
		 
		JSONArray getresult=new JSONArray();
		
		ExecResult result=js.getSelectResult(sql, params_,"base_teacher");
		JSONArray ja=result.getData();
		for(int i=0;i<ja.size();i++){
			JSONObject item=new JSONObject(); 
			item.put("teacher_no", ja.getJSONObject(i).getString("teacher_no"));
			item.put("teacher_title", ja.getJSONObject(i).getString("teacher_title"));
			item.put("teacher_name", ja.getJSONObject(i).getString("teacher_name"));
			ExecResult judge=getjudgeinf(term_no ,ja.getJSONObject(i).getString("teacher_no"),ja.getJSONObject(i).getString("teacher_title"));
			JSONArray teacher_inf=judge.getData();
			item.put("teacher_inf", teacher_inf);
			getresult.add(item);
		}
		ExecResult rep=new ExecResult();
		rep.setResult(true);
		rep.setMessage("");
		rep.setData(getresult);
		return rep;  
	}
	public ExecResult getjudgerule(String term_no , String tea_no){ 
		String sql="SELECT * FROM(SELECT b.rule_title , b.rule_item_title,b.rule_item_field , b.rule_item_formula FROM qm_xnxq_rule_version a JOIN qm_judge_rule b ON a.rule_version=b.rule_version WHERE a.rule_type=''{1}'' AND a.term_no=''{0}'') tb1,(SELECT d.dep_name,d.dep_no FROM base_teacher c JOIN base_department d ON c.dep_no=d.dep_no WHERE teacher_no=''{2}'') tb2";
		String [] params_=new String[] {term_no,"judge",tea_no};
		JSONResponse js=new JSONResponse();  
		ExecResult result=js.getSelectResult(sql, params_,"qm_xnxq_rule_version");   
		return result; 
	}
	public ExecResult getjudgeinf(String term_no,String teacher_no,String teacher_title ){
		String sql="SELECT * FROM qm_teacher_judge WHERE term_no=''{0}'' AND teacher_no=''{1}''";
		String [] params_=new String[] {term_no,teacher_no};
		JSONResponse js=new JSONResponse();  
		ExecResult result=js.getSelectResult(sql, params_,"qm_teacher_judge");    
		String switch_kh="SELECT term_kh FROM base_term WHERE term_no=''{0}''";
		String [] params_switch=new String[]{term_no};
		 
		if(js.getSelectResult(switch_kh, params_switch, "").getData().getJSONObject(0).getString("term_kh").equals("1")){
			 
		}else{
		if(result.getResult()==0){
			
			String sql_="SELECT COUNT(1) AS amount FROM base_teach_task a  JOIN qm_stu_pj b ON a.task_no=b.task_no  WHERE a.term_no=''{0}''  AND a.teacher_no=''{1}''";	
			ExecResult result_=js.getSelectResult(sql_,params_,"base_teach_task");	
			JSONArray ja=result_.getData();
			String commentscore="0";
			 
			if(ja.size()>0){  
				
				String commentmount=ja.getJSONObject(0).getString("amount");
				int comment=Integer.parseInt(commentmount);
				
				if(comment>0){
					String frist=""+comment*5/100;
					String end=""+(comment-Integer.parseInt(frist)*2);
					
					
					String sql_comment="SELECT AVG(total) AS result FROM (SELECT b.total FROM base_teach_task a  JOIN qm_stu_pj b ON a.task_no=b.task_no  WHERE a.term_no=''{0}''  AND a.teacher_no=''{1}'' ORDER BY b.total LIMIT "+frist+","+end+") tb";
					ExecResult result_comment=js.getSelectResult(sql_comment, params_,"qm_stu_pj"); 
					JSONArray score=result_comment.getData();
					commentscore=score.getJSONObject(0).getString("result");//学生评教的平均分
				}	
			}
			
			String _sql="SELECT COUNT(1) AS acount FROM base_teach_task a JOIN qm_master_listen b ON a.task_no=b.task_no JOIN qm_dep_teacher c ON b.teacher_no=c.teacher_no  AND c.term_no=''{0}'' WHERE a.teacher_no=''{1}'' AND a.term_no=''{0}''AND NOT EXISTS(SELECT * FROM qm_base_job d WHERE c.job_no = d.job_no AND NOT job_kh=1)";
			ExecResult _result=js.getSelectResult(_sql,params_,"base_teach_task"); 
			JSONArray jl=_result.getData(); 
			String listenscore="0";
			if(jl.size()>0){ 
		
				String listenmount=jl.getJSONObject(0).getString("acount");   
				int listen=Integer.parseInt(listenmount);   
				 
				if(listen>0){
					if(listen>2){
						String frist="1" ;
						String end=""+(listen-2);    
						
						String sql_listen="SELECT AVG(total) AS result FROM (SELECT b.total FROM base_teach_task a JOIN qm_master_listen b ON a.task_no=b.task_no JOIN qm_dep_teacher c ON b.teacher_no=c.teacher_no AND c.term_no=''{0}'' WHERE a.teacher_no=''{1}'' AND a.term_no=''{0}'' AND NOT EXISTS(SELECT * FROM qm_base_job d WHERE c.job_no = d.job_no AND NOT job_kh=1) ORDER BY b.total LIMIT "+frist+","+end+") AS tb";
						ExecResult result_listen=js.getSelectResult(sql_listen, params_,"base_teach_task");
						JSONArray score=result_listen.getData();
						listenscore=score.getJSONObject(0).getString("result"); //老师听课平均分
					}else{
						String listen_sql="SELECT AVG(total) as result FROM (SELECT b.total FROM base_teach_task a JOIN qm_master_listen b ON a.task_no=b.task_no JOIN qm_dep_teacher c ON b.teacher_no=c.teacher_no and c.term_no=''{0}'' WHERE a.teacher_no=''{1}'' AND a.term_no=''{0}'' AND NOT EXISTS(SELECT * FROM qm_base_job d WHERE c.job_no = d.job_no AND NOT job_kh=1) ORDER BY b.total ) AS tb";
						ExecResult listen_result=js.getSelectResult(listen_sql, params_,"base_teach_task");
						JSONArray score=listen_result.getData();  
						listenscore=score.getJSONObject(0).getString("result"); 
					}
				}
			}  
			String sql_percent="SELECT b.rule_item_formula FROM qm_xnxq_rule_version a JOIN qm_judge_rule b ON a.rule_version=b.rule_version AND (b.rule_item_field=''{2}'' OR b.rule_item_field=''{3}'') WHERE term_no=''{0}'' AND a.rule_type=''{4}'' ORDER BY b.rule_item_field";//保存到考核表
			String [] params_percent=new String[] {term_no,teacher_no,"ddtk","xspj","judge"};
			ExecResult percent_result=js.getSelectResult(sql_percent, params_percent,"qm_xnxq_rule_version");
			JSONArray percent=percent_result.getData(); 
			String ddtk_percent=percent.getJSONObject(0).getString("rule_item_formula"); 
			String xspj_percent=percent.getJSONObject(1).getString("rule_item_formula");
			
			
			String ddtk=""+(double)Math.round(Double.parseDouble(listenscore)*Double.parseDouble(ddtk_percent))/100;
			String xspj=""+(double)Math.round(Double.parseDouble(commentscore)*Double.parseDouble(xspj_percent))/100;
			String total=""+(Double.parseDouble(ddtk)+Double.parseDouble(xspj));
			
			String [] params_judge=new String[]{term_no,teacher_no ,ddtk , xspj,total,teacher_title};
			String judge="INSERT INTO qm_teacher_judge(term_no , teacher_no ,ddtk ,xspj,total ,teacher_title) VALUES(''{0}''  ,''{1}'',''{2}'',''{3}'',''{4}'',''{5}'')";
			ExecResult judge_result=js.getExecInsertId(judge, params_judge, "教师考核数据生成成功", "教师考核数据生成失败");
		}
		else{
			
				//更新数据
				String sql_="SELECT COUNT(1) AS amount FROM base_teach_task a  JOIN qm_stu_pj b ON a.task_no=b.task_no  WHERE a.term_no=''{0}''  AND a.teacher_no=''{1}''";	
				ExecResult result_=js.getSelectResult(sql_,params_,"base_teach_task");	
				JSONArray ja=result_.getData();
				String commentscore="0";
				   
				if(ja.size()>0){   
					
					String commentmount=ja.getJSONObject(0).getString("amount");
					int comment=Integer.parseInt(commentmount);
					 
					if(comment>0){  
						String frist=""+comment*5/100;
						String end=""+(comment-Integer.parseInt(frist)*2);
						
						
						String sql_comment="SELECT AVG(total) AS result FROM (SELECT b.total FROM base_teach_task a  JOIN qm_stu_pj b ON a.task_no=b.task_no  WHERE a.term_no=''{0}''  AND a.teacher_no=''{1}'' ORDER BY b.total LIMIT "+frist+","+end+") tb";
						ExecResult result_comment=js.getSelectResult(sql_comment, params_,"qm_stu_pj"); 
						JSONArray score=result_comment.getData();
						commentscore=score.getJSONObject(0).getString("result");//学生评教的平均分
					}	
				}
				
				String _sql="SELECT COUNT(1) AS acount FROM base_teach_task a JOIN qm_master_listen b ON a.task_no=b.task_no JOIN qm_master c ON b.teacher_no=c.teacher_no  WHERE a.teacher_no=''{1}'' AND a.term_no=''{0}''";
				ExecResult _result=js.getSelectResult(_sql,params_,"base_teach_task"); 
				JSONArray jl=_result.getData(); 
				String listenscore="0";
				if(jl.size()>0){ 
			
					String listenmount=jl.getJSONObject(0).getString("acount");   
					int listen=Integer.parseInt(listenmount);   
					 
					if(listen>0){
						if(listen>2){
							String frist="1";
							String end=""+(listen-2);  
							
							String sql_listen="SELECT AVG(total) as result FROM (SELECT b.total FROM base_teach_task a JOIN qm_master_listen b ON a.task_no=b.task_no JOIN qm_master c ON b.teacher_no=c.teacher_no  WHERE a.teacher_no=''{1}'' AND a.term_no=''{0}'' ORDER BY b.total LIMIT "+frist+","+end+") AS tb";
							ExecResult result_listen=js.getSelectResult(sql_listen, params_,"base_teach_task");
							JSONArray score=result_listen.getData();
							listenscore=score.getJSONObject(0).getString("result"); //老师听课平均分
						}else{
							String listen_sql="SELECT AVG(total) as result FROM (SELECT b.total FROM base_teach_task a JOIN qm_master_listen b ON a.task_no=b.task_no JOIN qm_master c ON b.teacher_no=c.teacher_no  WHERE a.teacher_no=''{1}'' AND a.term_no=''{0}'' ORDER BY b.total ) AS tb";
							ExecResult listen_result=js.getSelectResult(listen_sql, params_,"base_teach_task");
							JSONArray score=listen_result.getData();  
							listenscore=score.getJSONObject(0).getString("result"); 
						}
					}
				}  
				String sql_percent="SELECT b.rule_item_formula FROM qm_xnxq_rule_version a JOIN qm_judge_rule b ON a.rule_version=b.rule_version AND (b.rule_item_field=''{2}'' OR b.rule_item_field=''{3}'') WHERE term_no=''{0}'' AND a.rule_type=''{4}'' ORDER BY b.rule_item_field";//保存到考核表
				String [] params_percent=new String[] {term_no,teacher_no,"ddtk","xspj","judge"};
				ExecResult percent_result=js.getSelectResult(sql_percent, params_percent,"qm_xnxq_rule_version");
				JSONArray percent=percent_result.getData(); 
				String ddtk_percent=percent.getJSONObject(0).getString("rule_item_formula"); 
				String xspj_percent=percent.getJSONObject(1).getString("rule_item_formula");
				
				
				String ddtk=""+(double)Math.round(Double.parseDouble(listenscore)*Double.parseDouble(ddtk_percent))/100;
				String xspj=""+(double)Math.round(Double.parseDouble(commentscore)*Double.parseDouble(xspj_percent))/100;
				JSONArray jq=result.getData();
				
				String per1=jq.getJSONObject(0).getString("per11");
				if(per1==""){
					per1="0";
				}
				String per2=jq.getJSONObject(0).getString("per12");
				if(per2==""){
					per2="0";
				}
				String per3=jq.getJSONObject(0).getString("per13");
				if(per3==""){
					per3="0";
				}
				String per4=jq.getJSONObject(0).getString("per14");
				if(per4==""){
					per4="0";
				}
				String total=""+(Double.parseDouble(ddtk)+Double.parseDouble(xspj)+Double.parseDouble(per1)+Double.parseDouble(per2)+Double.parseDouble(per3)+Double.parseDouble(per4)); 
			  
				String [] params_judge=new String[]{term_no,teacher_no ,ddtk , xspj,total,teacher_title};
				String judge="UPDATE qm_teacher_judge SET ddtk=''{2}''  ,xspj=''{3}'' ,total=''{4}'' ,teacher_title=''{5}'' WHERE teacher_no=''{1}'' AND term_no=''{0}''";
				ExecResult result_judge=js.getExecResult(judge, params_judge, "教师考核数据更新成功", "教师考核数据更新失败");
			}
			
		}  
		String sql_get_inf="SELECT * FROM qm_teacher_judge WHERE term_no=''{0}'' AND teacher_no=''{1}''";
		ExecResult get_result=js.getSelectResult(sql_get_inf, params_,"qm_teacher_judge"); //提取
		return get_result;  
	}
	public ExecResult savescore(String term_no , String teacher_no ,String score, String field , String newsum){
		String sql="UPDATE qm_teacher_judge SET "+field+"=''{2}'' ,total=''{3}'' WHERE teacher_no=''{1}'' AND term_no=''{0}''";
		String [] params_=new String[]{term_no,teacher_no ,score ,newsum}; 
		JSONResponse response=new JSONResponse(); 
		ExecResult result= response.getExecResult(sql, params_, "分数修改成功","分数修改失败");
		
		return result;
	} 
	
	public ExecResult getddtk(String term_no ,String teacher_no){ 
		String sql="SELECT a.* , b.term_no ,b.course_type , b.course_name ,c.teacher_name , d.class_name FROM qm_master_listen a ,base_teach_task b , base_teacher c ,base_classes d WHERE d.class_no=b.class_no AND c.teacher_no=a.teacher_no AND a.task_no=b.task_no AND b.term_no=''{0}'' AND b.teacher_no=''{1}'' ORDER BY a.listen_time DESC";
		String [] params_=new String[] {term_no ,teacher_no};
		JSONResponse js=new JSONResponse();   
		ExecResult result=js.getSelectResult(sql, params_,"");    
		return result; 
	} 
	public ExecResult getxspj(String term_no ,String teacher_no){  
		String sql="select a.course_name, b.class_name ,b.class_stu_amount ,c.task_no,count(1) as class_stu_check  ,SUM(c.total) AS total "+
				"from base_teach_task a ,base_classes b  ,qm_stu_pj c ,base_term_student d "+
				"where a.teacher_no=''{1}'' and a.term_no=''{0}'' and a.class_no=b.class_no and c.task_no=a.task_no and d.class_no=b.class_no  and d.stu_no=c.stu_no  AND d.term_no='"+term_no+"' "+
				"group by a.course_name , b.class_name  ";
		String [] params_=new String[] {term_no ,teacher_no};
		JSONResponse js=new JSONResponse();    
		ExecResult result=js.getSelectResult(sql, params_,"qm_stu_pj");     
		return result; 
	}
}
