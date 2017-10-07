package com.service.master; 
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse; 
public class MasterJudgeChartService {
	public ExecResult getyearInf(){ 
		String sql=" SELECT DISTINCT LEFT(term_startdate,4)AS year_no FROM base_term ORDER BY term_no DESC";
		JSONResponse js=new JSONResponse();
		ExecResult result=js.getSelectResult(sql, null,"base_term");     
		return result; 
	} 
	public ExecResult getgrand( String dep_no ,String year_no){ 
		JSONResponse js=new JSONResponse();
		
		String sql="SELECT tb1.*,tb3.teacher_name FROM "+
					"(SELECT LEFT(b.term_startdate,4) AS year_no, a.teacher_no, AVG(total) AS total FROM  qm_teacher_judge a left join base_term b on a.term_no=b.term_no GROUP BY year_no ,a.teacher_no) tb1 "+
					"JOIN "+
					"(SELECT * FROM base_teacher WHERE dep_no=''{0}'')tb2 "+
					"ON tb1.teacher_no=tb2.teacher_no "+
					"LEFT JOIN base_teacher tb3 "+
					"ON tb3.teacher_no=tb1.teacher_no "+
					"WHERE year_no=''{1}'' "+
					"ORDER BY total DESC";
		String [] params=new String[]{dep_no ,year_no};
		
		ExecResult result=js.getSelectResult(sql, params,"qm_teacher_judge"); 
		
		JSONArray getresult=new JSONArray();
		
		ExecResult rep=new ExecResult();
		String sql_judge_rule="SELECT judge_type, judge_youxiu , judge_lianghao FROM qm_judge_config WHERE judge_set=1 AND year_no=''{1}''";
		ExecResult result_judge=js.getSelectResult(sql_judge_rule, params,"qm_judge_config");
		if(result_judge.getResult()==0){
			rep.setResult(false); 
		}else{
			JSONArray rule=result_judge.getData();
			String youxiu=rule.getJSONObject(0).getString("judge_youxiu");
			String lianghao=rule.getJSONObject(0).getString("judge_lianghao");
			if(rule.getJSONObject(0).getString("judge_type").equals("percent")){
				if(result.getResult()==0){
					rep.setResult(false);
				}else{
					int youxiu_tea=0;
					int lianghao_tea=0;
					int jige_tea=0;
					JSONObject amount=new JSONObject();
					JSONArray allgrand=result.getData(); 
					int Youxiu=allgrand.size()*Integer.parseInt(youxiu)/100;
					int Lianghao=allgrand.size()*Integer.parseInt(lianghao)/100;
					for(int i=0;i<allgrand.size();i++){
						String tea_no=allgrand.getJSONObject(i).getString("teacher_no");
							//教师职称   
					
						String [] params_teacher=new String[]{year_no ,tea_no};   
						String sql_teacher="SELECT teacher_title FROM base_teacher WHERE teacher_no=''{1}''";
						String teacher_title=""; 
						ExecResult result_tea=js.getSelectResult(sql_teacher, params_teacher, "");
						if(result_tea.getResult()>0){
							teacher_title=result_tea.getData().getJSONObject(0).getString("teacher_title");
						}
							String grand="";
							String year_sql="SELECT teacher_level FROM qm_teacher_judge_year WHERE teacher_no=''{1}'' AND judge_year=''{0}''";//先读year_judge表
							ExecResult result_year=js.getSelectResult(year_sql, params_teacher, "");
							if(result_year.getResult()>0){
								grand=result_year.getData().getJSONObject(0).getString("teacher_level");
							}
							JSONObject item=new JSONObject();
							item.put("teacher_title",teacher_title);
							
							if(i<=Youxiu){
								
								item.put("average", allgrand.getJSONObject(i).getString("total"));
								if(!grand.equals("")){
									if(grand.equals("优秀")){
										youxiu_tea++;
									}
									if(grand.equals("良好")){
										lianghao_tea++;
									}
									if(grand.equals("及格")){
										jige_tea++;
									}

									item.put("grand", grand);
								}else{ 
									item.put("grand", "优秀");
									youxiu_tea++;
								}
								
								item.put("teacher_name", allgrand.getJSONObject(i).getString("teacher_name"));
								item.put("teacher_no", allgrand.getJSONObject(i).getString("teacher_no"));
								
							}
							if(i>Youxiu&&i<=Lianghao){
								
								item.put("average", allgrand.getJSONObject(i).getString("total"));
								if(!grand.equals("")){
									if(grand.equals("优秀")){
										youxiu_tea++;
									}
									if(grand.equals("良好")){
										lianghao_tea++;
									}
									if(grand.equals("及格")){
										jige_tea++;
									}
									item.put("grand", grand);
								}else{
									lianghao_tea++;
									item.put("grand", "良好");
								}
								item.put("teacher_name", allgrand.getJSONObject(i).getString("teacher_name"));
								item.put("teacher_no", allgrand.getJSONObject(i).getString("teacher_no"));
								
							}
							if(i>Lianghao){
								
								item.put("average", allgrand.getJSONObject(i).getString("total"));
								if(!grand.equals("")){
									if(grand.equals("优秀")){
										youxiu_tea++;
									}
									if(grand.equals("良好")){
										lianghao_tea++;
									}
									if(grand.equals("及格")){
										jige_tea++;
									}
									item.put("grand", grand);
								}else{
									item.put("grand", "及格");
									jige_tea++; 
								}
								item.put("teacher_name", allgrand.getJSONObject(i).getString("teacher_name"));
								item.put("teacher_no", allgrand.getJSONObject(i).getString("teacher_no"));
								 
							}
							getresult.add(item);	
							
					}
					amount.put("youxiu_tea", youxiu_tea);
					amount.put("lianghao_tea", lianghao_tea);
					amount.put("jige_tea", jige_tea);
					getresult.add(amount);
					rep.setResult(true);
					
					
				}	
			}else{
				JSONArray allgrand=result.getData();
				int youxiu_tea=0;
				int lianghao_tea=0;
				int jige_tea=0;
				JSONObject amount=new JSONObject();
				for(int i=0;i<allgrand.size();i++){
					String tea_no=allgrand.getJSONObject(i).getString("teacher_no");
					//教师职称 
					
						
						String [] params_teacher=new String[]{year_no ,tea_no};  
						String sql_teacher="SELECT teacher_title FROM base_teacher WHERE teacher_no=''{1}''";
						String teacher_title="";
						ExecResult result_teacher=js.getSelectResult(sql_teacher, params_teacher, "");
						if(result_teacher.getResult()>0){
							teacher_title=result_teacher.getData().getJSONObject(0).getString("teacher_title");
						} 
						JSONObject item=new JSONObject();
						item.put("teacher_title",teacher_title);
						
						String grand="";
						String year_sql="SELECT teacher_level FROM qm_teacher_judge_year WHERE teacher_no=''{1}'' AND judge_year=''{0}''";//先读year_judge表
						ExecResult result_year=js.getSelectResult(year_sql, params_teacher, "");
						if(result_year.getResult()>0){
							grand=result_year.getData().getJSONObject(0).getString("teacher_level");
						}
						
						if(Double.parseDouble(allgrand.getJSONObject(i).getString("total"))>=Double.parseDouble(youxiu)){
							
							item.put("average", allgrand.getJSONObject(i).getString("total"));
							if(!grand.equals("")){
								if(grand.equals("优秀")){
									youxiu_tea++;
								}
								if(grand.equals("良好")){
									lianghao_tea++;
								}
								if(grand.equals("及格")){
									jige_tea++;
								}

								item.put("grand", grand);
							}else{
								youxiu_tea++;
								item.put("grand", "优秀");
							} 
							item.put("teacher_name", allgrand.getJSONObject(i).getString("teacher_name"));
							item.put("teacher_no", allgrand.getJSONObject(i).getString("teacher_no"));
							
						} 
						if(Double.parseDouble(allgrand.getJSONObject(i).getString("total"))<Double.parseDouble(youxiu)&&Double.parseDouble(allgrand.getJSONObject(i).getString("total"))>=Double.parseDouble(lianghao)){
							
							item.put("average", allgrand.getJSONObject(i).getString("total"));
							if(!grand.equals("")){
								if(grand.equals("优秀")){
									youxiu_tea++;
								}
								if(grand.equals("良好")){
									lianghao_tea++;
								}
								if(grand.equals("及格")){
									jige_tea++;
								}
								item.put("grand", grand);
							}else{
								item.put("grand", "良好");
								lianghao_tea++;
							}
							item.put("teacher_name", allgrand.getJSONObject(i).getString("teacher_name"));
							item.put("teacher_no", allgrand.getJSONObject(i).getString("teacher_no"));
							
						}
						if(Double.parseDouble(allgrand.getJSONObject(i).getString("total"))<Double.parseDouble(lianghao)){
							
							item.put("average", allgrand.getJSONObject(i).getString("total"));
							if(!grand.equals("")){
								if(grand.equals("优秀")){
									youxiu_tea++;
								}
								if(grand.equals("良好")){
									lianghao_tea++;
								}
								if(grand.equals("及格")){
									jige_tea++;
								}
								item.put("grand", grand);
							}else{
								item.put("grand", "及格"); 
								jige_tea++;
							}
							item.put("teacher_name", allgrand.getJSONObject(i).getString("teacher_name"));
							item.put("teacher_no", allgrand.getJSONObject(i).getString("teacher_no"));
							
						}
						getresult.add(item); 
						
				}
				amount.put("youxiu_tea", youxiu_tea); 
				amount.put("lianghao_tea", lianghao_tea);
				amount.put("jige_tea", jige_tea);
				getresult.add(amount);
				rep.setResult(true); 
			}
		}
		
		rep.setMessage(""); 
		rep.setData(getresult);  
		return rep;  
	}
	 
	public ExecResult getTeacherInf(String teacher_no ,String year_no){  
		JSONResponse js=new JSONResponse();
		String sql="SELECT term_name ,term_no ,term_status FROM base_term WHERE LEFT(term_startdate,4)="+year_no+" ORDER BY term_no DESC";
		
		

		JSONArray getresult=new JSONArray();    
	
		 
		ExecResult result=js.getSelectResult(sql, null,"base_term");
		JSONArray ja=result.getData(); 
		for(int i=0;i<ja.size();i++){   
			JSONObject item=new JSONObject(); 
			item.put("term_name", ja.getJSONObject(i).getString("term_name"));
			item.put("term_no", ja.getJSONObject(i).getString("term_no"));
			ExecResult rule=getjudgerule(ja.getJSONObject(i).getString("term_no"));
			if(rule.getResult()>0){
				JSONArray table_rule=rule.getData();
				item.put("table_rule", table_rule);
				
			} 
			else{ 
				continue; 
			}
			  
			ExecResult content=getjudgeinf(ja.getJSONObject(i).getString("term_no"),teacher_no );//
			if(content.getResult()>0){
				JSONArray table_content=content.getData();
				item.put("table_content", table_content);  
			}	
			else{
				continue;
			} 
			getresult.add(item);
		} 
		
		ExecResult rep=new ExecResult();
		rep.setResult(true);
		rep.setMessage("");
		rep.setData(getresult); 
		return rep;  
	}
	public ExecResult getjudgerule(String term_no ){ 
		String sql="SELECT b.rule_title , b.rule_item_title,b.rule_item_field , b.rule_item_formula FROM qm_xnxq_rule_version a JOIN qm_judge_rule b ON a.rule_version=b.rule_version WHERE a.rule_type=''{1}'' AND a.term_no=''{0}''";
		String [] params_=new String[] {term_no,"judge"};
		JSONResponse js=new JSONResponse();
		ExecResult result=js.getSelectResult(sql, params_,"qm_xnxq_rule_version");   
		return result; 
	}
	public ExecResult getjudgeinf(String term_no,String teacher_no ){ //
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
						String frist="1";
						String end=""+(listen-2);  
						
						String sql_listen="SELECT AVG(total) AS result FROM (SELECT b.total FROM base_teach_task a JOIN qm_master_listen b ON a.task_no=b.task_no JOIN qm_dep_teacher c ON b.teacher_no=c.teacher_no AND c.term_no=''{0}'' WHERE a.teacher_no=''{1}'' AND a.term_no=''{0}'' AND NOT EXISTS(SELECT * FROM qm_base_job d WHERE c.job_no = d.job_no AND NOT job_kh=1) ORDER BY b.total LIMIT "+frist+","+end+") AS tb";
						ExecResult result_listen=js.getSelectResult(sql_listen, params_,"base_teach_task");
						JSONArray score=result_listen.getData();
						listenscore=score.getJSONObject(0).getString("result"); //老师听课平均分
					}else{
						String listen_sql="SELECT AVG(total) AS result FROM (SELECT b.total FROM base_teach_task a JOIN qm_master_listen b ON a.task_no=b.task_no JOIN qm_dep_teacher c ON b.teacher_no=c.teacher_no AND c.term_no=''{0}'' WHERE a.teacher_no=''{1}'' AND a.term_no=''{0}'' AND NOT EXISTS(SELECT * FROM qm_base_job d WHERE c.job_no = d.job_no AND NOT job_kh=1) ORDER BY b.total ) AS tb";
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
			
			String [] params_judge=new String[]{term_no,teacher_no ,ddtk , xspj,total};
			String judge="INSERT INTO qm_teacher_judge(term_no , teacher_no ,ddtk ,xspj,total) VALUES(''{0}''  ,''{1}'',''{2}'',''{3}'',''{4}'')";
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
	  
				String [] params_judge=new String[]{term_no,teacher_no ,ddtk , xspj,total};
				String judge="UPDATE qm_teacher_judge SET ddtk=''{2}''  ,xspj=''{3}'' ,total=''{4}'' WHERE teacher_no=''{1}'' AND term_no=''{0}''";
				ExecResult result_judge=js.getExecResult(judge, params_judge, "教师考核数据更新成功", "教师考核数据更新失败");
			}
			
		}  
		String sql_get_inf="SELECT * FROM qm_teacher_judge WHERE term_no=''{0}'' AND teacher_no=''{1}''";
		ExecResult get_result=js.getSelectResult(sql_get_inf, params_,"qm_teacher_judge"); //提取
		return get_result;  
	} 
	public ExecResult changegrade(String teacher_no ,String year_no , String grade ){ 
		String sql="DELETE FROM qm_teacher_judge_year WHERE judge_year=''{1}'' AND teacher_no=''{0}''";
		String [] params_=new String[] {teacher_no,year_no,grade};
		JSONResponse js=new JSONResponse();
		js.getExecResult(sql, params_, null, null);    
		String sql_="INSERT INTO qm_teacher_judge_year(judge_year , teacher_no , teacher_level) VALUES(''{1}'',''{0}'',''{2}'')";
		ExecResult result=js.getExecInsertId(sql_, params_, null, null);
		return result;  
	}
}
