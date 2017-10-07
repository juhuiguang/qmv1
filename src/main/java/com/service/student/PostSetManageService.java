package com.service.student;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class PostSetManageService {

	public Object getPostInfor() {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM qm_base_job ";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_base_job");
		return result;
	}

	public Object savePostData(String post_name, String post_times, String status) {
		// TODO Auto-generated method stub
		JSONResponse jr = new JSONResponse();
		ExecResult result = new ExecResult(true,""); 
		String sqlsel = "SELECT * FROM qm_base_job WHERE job_name='"+post_name+"'";
		ExecResult result2 = jr.getSelectResult(sqlsel, null, "qm_base_job");
		if(result2.getResult() > 0) {
			return result = new ExecResult(false , "添加失败，新添内容已存在");
		} else {
			String sql = "INSERT INTO qm_base_job (job_name,job_kh,job_type,job_listen_times) VALUES('"+post_name+"','"+status+"','教学岗位','"+post_times+"')";
			result = jr.getExecInsertId(sql, null, "新添岗位成功！", "岗位添加失败！");
		}
		return result;  
	}

	public Object UpdPostSinglData(String post_no, String post_name,
			String post_times, String status) {
		// TODO Auto-generated method stub
		String sql = "UPDATE qm_base_job SET job_name='"+post_name+"',job_kh='"+status+"',job_listen_times='"+post_times+"' WHERE job_no='"+post_no+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(sql, null, "", ""); 
		return result; 
	}

	public Object DelPostSinglData(String post_no) {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM qm_base_job WHERE job_no='"+post_no+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(sql, null, "", "");
		return result;
	}

}
