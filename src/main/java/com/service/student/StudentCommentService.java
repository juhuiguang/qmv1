package com.service.student;

import java.util.Map;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class StudentCommentService {
	public ExecResult getStuCommentTable(String tableflag){
		String sql="SELECT * FROM qm_rule WHERE rule_version_flag=''{0}'' AND rule_status='1' ORDER BY rule_field";
		String [] params=new String[] {tableflag};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_rule");
		return result;
	}
	public ExecResult getStuCommentResult(String class_No , String student_no){
		String sql="SELECT per11 , per12, per13 , per14 , per15 ," +
				"per16 , per17, per18 , per19 , per20, " +
				"per21 , per22, per23 , per24 , per25,per26,jxpj , jxjy  FROM qm_stu_pj WHERE task_no=''{0}'' AND stu_no=''{1}''";
		String [] params=new String[] {class_No,student_no};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_stu_pj"); 
		return result;
	}
	public ExecResult getStuCommentInf(String Class_no,String term_no){
		JSONResponse js=new JSONResponse();
		String [] params_=new String[] {Class_no,term_no};

		String sql_="select term_pj from base_term where term_no=''{1}''";
		ExecResult result_=js.getSelectResult(sql_, params_, "");
		if(result_.getResult()>0){
			if(result_.getData().getJSONObject(0).getString("term_pj").equals("1")){
				result_.setResult(false);
				return result_; 
			}else{
				String sql="SELECT DISTINCT a.course_no,a.course_name ,b.teacher_name ,c.dep_name ,a.course_week ,CURDATE() AS nowdate  FROM base_teach_task a JOIN base_teacher b ON a.teacher_no=b.teacher_no left JOIN base_department c ON b.dep_no=c.dep_no WHERE a.task_no=''{0}''";
				ExecResult result=js.getSelectResult(sql, params_,"base_teach_task");
				return result;
			}
		}else{
			result_.setResult(false);
			return result_;
		}
	}
	
	public ExecResult postComment(Map<String,String> param){
		String status=param.get("status");
		status = judgeExist( param.get("stu_no"),  param.get("task_no"));
		if(Integer.parseInt(status)==0)
		{
			String fields=param.get("fields");
			String sql="INSERT INTO qm_stu_pj(stu_no,task_no,"+fields+",total,jxpj, jxjy ) VALUES "
					+ "(";
			sql+="'"+param.get("stu_no")+"',";
			sql+="'"+param.get("task_no")+"',";
			String [] fieldsarr=fields.split(",");
			for(int i=0;i<fieldsarr.length;i++){
				sql+=param.get(fieldsarr[i])+",";
			}
			sql+=param.get("total")+",";
			sql+="'"+param.get("jxpj")+"',";
			sql+="'"+param.get("jxjy")+"')";
			
			JSONResponse response=new JSONResponse();
			ExecResult result= response.getExecResult(sql, null, "评教打分成功","评教打分失败");
			return result;
		}
		else
		{
			String fields=param.get("fields");
			String [] fieldsarr=fields.split(",");
			String sql="UPDATE qm_stu_pj SET " ;
					for(int i=0;i<fieldsarr.length;i++)
					{
						sql+=fieldsarr[i]+'='+param.get(fieldsarr[i])+",";
					}
			sql+="total"+"="+param.get("total")+",";
			sql+="jxpj"+"="+"'"+param.get("jxpj")+"'"+",";
			sql+="jxjy"+"="+"'"+param.get("jxjy")+"'"+" ";
			sql+="WHERE stu_no="+"'"+param.get("stu_no")+"'";
			sql+=" AND task_no="+"'"+param.get("task_no")+"'";
			
			
			JSONResponse response=new JSONResponse();
			ExecResult result= response.getExecResult(sql, null, "评教打分成功","评教打分失败");
			return result;
		}
		
	}
	public ExecResult getTableMobile(String flag, String student_no, String task_no) {
		ExecResult rep = new ExecResult();
		JSONResponse jr=new JSONResponse();
		String sql="SELECT rule_title ,rule_field ,rule_goal ,rule_content FROM qm_rule WHERE rule_version_flag='PJ_PJ' AND rule_status='1' ORDER BY rule_field";
		ExecResult result=jr.getSelectResult(sql, null,"qm_rule");
		if(result.getResult() > 0){
			if("0".equals(flag)){
				rep = result;
			}else{
				String sql_="SELECT *  FROM qm_stu_pj WHERE task_no='"+task_no+"' AND stu_no='"+student_no+"'";
				ExecResult result_ = jr.getSelectResult(sql_, null, "");
				if(result_.getResult() > 0){
					//拼接
					JSONArray jsonArray = new JSONArray();
					JSONObject item =null;
					for(int i = 0 ,length = result.getData().size() ; i < length ; i++){
						item = new JSONObject();
						item.put("rule_title", result.getData().getJSONObject(i).getString("rule_title"));
						
						item.put("rule_goal", result.getData().getJSONObject(i).getString("rule_goal"));
						String field = result.getData().getJSONObject(i).getString("rule_field").toLowerCase();
						item.put("rule_field", field);
						item.put("rule_score" , result_.getData().getJSONObject(0).getString(field));
						jsonArray.add(item);
					}
					item = new JSONObject();
					item.put("jxpj",  result_.getData().getJSONObject(0).getString("jxpj"));
					jsonArray.add(item);
					item = new JSONObject();
					item.put("jxjy",  result_.getData().getJSONObject(0).getString("jxjy"));
					jsonArray.add(item);
					item = new JSONObject();
					item.put("total",  result_.getData().getJSONObject(0).getString("total"));
					jsonArray.add(item);
					rep.setData(jsonArray);
					rep.setResult(true); 
					rep.setMessage(result.getData().size()+""); 
				}else{
					rep = result;
				}
			}
			
		}else{
			rep = new ExecResult(false , "评教标准获取失败");
		}
		return rep;
	}
	public ExecResult postCommentMobile(String stu_no, String task_no, String flag, String jxjy, String jxpj,
			String[] perAll) {
		flag = judgeExist( stu_no,  task_no);
		String sql = "";
		ExecResult result = null;
		JSONResponse jr=new JSONResponse();
		if(flag.trim().equals("0")){
			//insert
			sql+="INSERT INTO `qm_stu_pj`(stu_no , task_no ,";
			for(int i = 0 ; i < perAll.length ; i ++){
				if(i>=9){
					sql+="per2"+((i-9)) + ",";
				}else{
					sql+="per1"+(i+1) + ",";
				}

			}
			sql+="total,jxpj , jxjy) values( '"+stu_no+"' , '"+task_no+"' ,";
			int total = 0;
			for(int i = 0 ; i < perAll.length ; i ++){
				sql+="'"+perAll[i]+ "',";
				total += Integer.parseInt(perAll[i]);
			}
			sql+="'"+total+"' , '"+jxpj+"' , '"+jxjy+"')";
			result = jr.getExecInsertId(sql, null, "", "");
		}else{
			//update
			sql+="UPDATE `qm_stu_pj` SET ";
			int total = 0;
			for(int i = 0 ; i < perAll.length ; i ++){
				if(i>=9){
					sql+="per2"+(i-9) + " = '" + perAll[i] + "',";
				}else{
					sql+="per1"+(i+1) + " = '" + perAll[i] + "',";
				}

				total += Integer.parseInt(perAll[i]);
			}
			sql+="total = '"+total+"' , jxpj = '"+jxpj+"' , jxjy = '"+jxjy+"' where stu_no = '"+stu_no+"' and task_no='"+task_no+"'";
			result = jr.getExecResult(sql, null, "", "");
		}
		
		
		return result; 
	}
	
	public String judgeExist(String stu_no, String task_no){
		JSONResponse jr=new JSONResponse();
		String sql="SELECT * FROM qm_stu_pj WHERE stu_no='"+stu_no+"' AND task_no='"+task_no+"' ";
		if(jr.getSelectResult(sql, null, "").getResult()  > 0){
			return "1";
		}
		return "0";
	}
}
