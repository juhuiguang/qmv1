package com.service.teacher;

import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;
import com.service.system.SystemStart;


public class TeacherListenService {
	public ExecResult getTeaListenTable(String tableflag){
		String currentterm=SystemStart.getSys().getString("term_no");
		String sql="SELECT * FROM qm_rule WHERE rule_version_flag=''{0}'' AND rule_status='1' AND rule_version=(SELECT rule_version FROM qm_xnxq_rule_version WHERE term_no=''{1}'' AND rule_type=''{2}'')";
		String [] params=new String[] {tableflag,currentterm,tableflag};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_teacher_rule");
		return result;
	}
	
	public ExecResult postListen(Map<String,String> param){
		String validateSql="select count(1) rownumber from "+param.get("tablename")
			+" where teacher_no='"+param.get("master_no")+"' and task_no="+param.get("task_no")+" and DATE_FORMAT(listen_time,'%Y-%m-%d')='"+param.get("listendate")+"'";
		
		
		String fields=param.get("fields");
		String sql="insert into "+param.get("tablename")+" ("+fields+" ,total,skpj,jxjy,teacher_no,task_no,listen_time,rule_flag) values "
				+ "(";
		String [] fieldsarr=fields.split(",");
		for(int i=0;i<fieldsarr.length;i++){
			sql+=param.get(fieldsarr[i])+",";
		}
		sql+=param.get("total")+",";
		sql+="'"+param.get("tkpj")+"',";
		sql+="'"+param.get("jxjy")+"',";
		sql+="'"+param.get("master_no")+"',";
		sql+="'"+param.get("task_no")+"',";
		sql+="'"+param.get("listendate")+"',";
		sql+="'"+param.get("rule_flag")+"')";
		JSONResponse response=new JSONResponse();
		ExecResult validate= response.getSelectResult(validateSql, null,"");
		if(validate.getResult()>0 && validate.getData().size()>0){
			JSONObject jo=validate.getData().getJSONObject(0);
			if(jo.getInteger("rownumber")>0){
				ExecResult result= new ExecResult(false,"今日已经为此教学任务打过分。");
				return result;
			}else{
				ExecResult result= response.getExecResult(sql, null, "听课打分成功","听课打分失败");
				return result;
			}
		}else{
			ExecResult result= response.getExecResult(sql, null, "听课打分成功","听课打分失败");
			return result;
		}
		
	}

}
