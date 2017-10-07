package com.sys;
import java.util.Map;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;
public class RoleUserConfigService {
	public ExecResult get_initInf(){ 
		String sql="SELECT role_id , role_name FROM tb_role";
		JSONResponse js=new JSONResponse();
		JSONArray tb_role=js.getSelectResult(sql, null,"tb_role").getData(); 
		
	
		
		JSONObject item=new JSONObject(); 
		
		item.put("tb_role", tb_role);
		JSONArray getresult=new JSONArray();
		getresult.add(item);
		ExecResult rep=new ExecResult(); 
		rep.setResult(true);
		rep.setMessage("");
		rep.setData(getresult);    
		
		return rep; 
	}
	public ExecResult get_role(String user_id){
		String sql="SELECT role_id FROM tb_role_user WHERE user_id=''{0}''";
		String [] params=new String[] {user_id};	
		JSONResponse jr=new JSONResponse(); 
		ExecResult result=jr.getSelectResult(sql, params,"tb_role_user");
		return result;
	}
	public ExecResult post_role(String post_user,String post_Role){
		
		String sql="DELETE FROM tb_role_user WHERE user_id="+post_user+"";
		JSONResponse jr=new JSONResponse(); 
		ExecResult result=jr.getExecResult(sql, null,null,null); 
		
		String [] post_role=post_Role.split("-");
		for(int i=0;i<post_role.length;i++){
			String sql_="INSERT INTO tb_role_user(role_id , user_id) VALUES("+post_role[i]+","+post_user+")";
			jr.getExecInsertId(sql_, null,null,null); 
		} 
		return result;
	}
}
