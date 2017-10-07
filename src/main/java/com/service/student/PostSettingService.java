package com.service.student;

import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class PostSettingService {
	public ExecResult loadposttype(){//函数方法
		String sql="SELECT a.`job_type` FROM qm_base_job a GROUP BY a.`job_type` ORDER BY a.`job_type` DESC ";//获取所有的不同类型的岗位
		String [] params=new String[] {};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");
		return result;//返回
	}
	
	public ExecResult loadpost(String job_type){//函数方法
		String sql="SELECT * FROM qm_base_job a  WHERE a.`job_type`=''{0}''";//获取所有的岗位
		String [] params=new String[] {job_type};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");
		return result;//返回
	}
	
	public ExecResult loadchange(String job_type,String job_name,String job_kh){
        if(job_kh.equals("1")){
        	String sql="UPDATE qm_base_job a SET a.`job_kh`=''0''  WHERE a.`job_type`=''{0}'' AND a.`job_name`=''{1}''";//获取所有的岗位
    		String [] params=new String[] {job_type,job_name};
    		
    		JSONResponse jr=new JSONResponse();
    		ExecResult result=jr.getExecResult(sql, params,"","");
    		return result;//返回
        }
        else{
        	String sql="UPDATE qm_base_job a SET a.`job_kh`=''1''  WHERE a.`job_type`=''{0}'' AND a.`job_name`=''{1}''";//获取所有的岗位
    		String [] params=new String[] {job_type,job_name};
    		
    		JSONResponse jr=new JSONResponse();
    		ExecResult result=jr.getExecResult(sql, params,"","");
    		return result;//返回
        }
		
	}
	
	public ExecResult loaddelete(String job_type,String job_name){//函数方法
		String sql="DELETE FROM  qm_base_job  WHERE  job_type=''{0}'' AND job_name=''{1}''";//获取所有的岗位
		String [] params=new String[] {job_type,job_name};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getExecResult(sql, params, "", "");
		return result;//返回
	}
	
	public ExecResult loadadd(Map<String,String> param){//函数方法
		String sql="INSERT INTO qm_base_job (job_name,job_kh,job_type) VALUES('"+param.get("job_name")+"','1','"+param.get("job_type")+"')";//获取所有的岗位
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getExecResult(sql,null,"添加成功！", "添加失败！");
		return result;//返回
	}
}
