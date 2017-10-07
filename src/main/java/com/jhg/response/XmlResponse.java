package com.jhg.response;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONArray;
import com.jhg.common.TypeUtils;
import com.jhg.db.DataConvert;
import com.jhg.db.ExecResult;
import com.jhg.db.JSONDataResult;



public class XmlResponse implements IResponse{
	@Override
	public ExecResult getSelectResult(String sql,String[] params,String tableName){
		SqlService dba=new SqlService();
		List<Map<String,Object>> result=dba.selectResult(sql, params);
		JSONDataResult jr=new JSONDataResult();
		JSONArray ja=jr.getJSONResult(result);
		ExecResult er=new ExecResult();
		if(ja.size()>0){
			er.setResult(true);
			er.setData(ja);
		}else{
			er.setResult(false);
			er.setMessage("");
		}
		return er;
	}
	
	@Override
	public ExecResult getExecResult(String sql, String[] params) {
		SqlService dba=new SqlService();
		boolean result=dba.executeResult(sql, params);
		ExecResult er=new ExecResult(result,null);
		return er;
	}

	@Override
	public ExecResult getError(String error) {
		ExecResult er=new ExecResult(false,error);
		return er;
	}

	@Override
	public ExecResult getExecResult(String sql, String[] params, String smsg,String fmsg) {
		SqlService dba=new SqlService();
		boolean result=dba.executeResult(sql, params);
		String message=result?smsg:fmsg;
		ExecResult er=new ExecResult(result,message);
		return er;
	}
	
	@Override
	public ExecResult getExecResult(List<String>sql, String smsg,String fmsg) {
		SqlService dba=new SqlService();
		boolean result=dba.execbatch(sql);
		String message=result?smsg:fmsg;
		ExecResult er=new ExecResult(result,message);
		return er;
	}

	@Override
	public ExecResult getExecInsertId(String sql, String[] params, String smsg,
			String fmsg) {
		SqlService dba=new SqlService();
		Object insertid= dba.getInsertId(sql, params);
		boolean result=(insertid!=null);
		String message=result?smsg:fmsg;
		ExecResult er=new ExecResult(result,message);
		if(result){
			er.setMessage(TypeUtils.getString(insertid));
		}
		return er;
	}
}
