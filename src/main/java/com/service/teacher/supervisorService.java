package com.service.teacher;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;
import com.service.*;
import com.service.system.SystemService;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
public class supervisorService {
	public ExecResult loadall(){//函数方法
		String sql="SELECT * FROM qm_master a,base_teacher b,base_department c WHERE a.`teacher_no`=b.`teacher_no` AND b.`dep_no`=c.`dep_no` ORDER BY a.master_type";
		String [] params=new String[] {};//把数据保存在params中
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");
		return result;//返回
	}
	
	public ExecResult loadchange(String teacher_no,String master_status){//函数方法
		if( master_status.equals("0"))
		{
			String sql="UPDATE qm_master a SET a.`master_status`=''1''  WHERE a.`teacher_no`=''{0}'' ";
			String [] params=new String[] {teacher_no};//把数据保存在params中
			
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getExecResult(sql, params, "", "");
			return result;//返回
			
		}else
		{
			String sql="UPDATE qm_master a SET a.`master_status`=''0''  WHERE a.`teacher_no`=''{0}'' ";
			String [] params=new String[] {teacher_no};//把数据保存在params中
			
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getExecResult(sql, params, "", "");
			return result;//返回
		}

	}
	
	public ExecResult loaddelete(String teacher_no,String master_type){//函数方法
			JSONResponse jr=new JSONResponse();
			String [] params=new String[] {teacher_no};//把数据保存在params中
			String sql="DELETE FROM  qm_master WHERE qm_master.`teacher_no`=''{0}'' ";
			String sql_="SELECT user_id FROM tb_user WHERE user_loginname=''{0}''";
			ExecResult getresult=new ExecResult();
			getresult=jr.getSelectResult(sql_, params, "");
			
			if(getresult.getResult()>0){ 
				SystemService service=new SystemService();
				String user_id=getresult.getData().getJSONObject(0).getString("user_id");
				service.removeRoleUser(user_id,master_type);
			}
			
			ExecResult result=jr.getExecResult(sql, params, "删除成功", "删除失败");
			return result;//返回
	}
	
	public ExecResult loadallcollege(String dep_no){
		if(dep_no.equals("sch")){//所有校级督学
			String sql="SELECT * FROM qm_master a,base_teacher b,base_department c  WHERE a.`master_type`='校级督学'  AND a.`teacher_no`=b.`teacher_no` AND b.`dep_no`=c.`dep_no`";
			String [] params=new String[] {};//把数据保存在params中
			
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");
			return result;//返回
			
		}else if(dep_no.equals("all")){//所有督学
			String sql="SELECT * FROM qm_master a,base_teacher b,base_department c WHERE a.`teacher_no`=b.`teacher_no` AND b.`dep_no`=c.`dep_no` ORDER BY a.master_type";
			String [] params=new String[] {};//把数据保存在params中
			
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");
			return result;//返回
			
		}else{
			String sql="SELECT * FROM qm_master a,base_teacher b,base_department c WHERE a.`master_type`=''院系督学'' AND a.`teacher_no`=b.`teacher_no` AND b.`dep_no`=c.`dep_no`AND b.`dep_no`=''{0}'' ORDER BY c.`dep_name` DESC";
			String [] params=new String[] {dep_no};//把数据保存在params中
			
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");
			return result;//返回
		}//函数方法

	}

}
