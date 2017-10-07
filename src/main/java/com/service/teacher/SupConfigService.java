package com.service.teacher;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class SupConfigService {
	public ExecResult getConfig(String teacher_no){
		String sql="select * from qm_master_config where master_no=''{0}''";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, new String[]{teacher_no},"base_teacher");
		return result;
	}
	
	public ExecResult addConfig(String content,String type,String master_no){
		String sql="insert into qm_master_config (master_no,content,config_type) values(''{0}'',''{1}'',''{2}'')";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getExecInsertId(sql, new String[]{master_no,content,type}, "成功添加常用语。", "常用语保存出错了。");
		return result;
	}
	
	public ExecResult removeConfig(String master_no,String configid){
		String sql="delete from qm_master_config where master_no=''{0}'' and config_no={1}";
		JSONResponse jr=new JSONResponse();
		return jr.getExecResult(sql, new String[]{master_no,configid});
	}
}
