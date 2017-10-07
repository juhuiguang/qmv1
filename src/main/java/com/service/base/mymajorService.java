package com.service.base;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class mymajorService {

	//根据专业名字获得专业代码
	public ExecResult getmajorNoBymajorName(String majorName) {
		String sql = "SELECT DISTINCT a.`major_no` FROM base_major a WHERE a.`major_name`='"+majorName+"'";
		JSONResponse js = new JSONResponse();
		ExecResult result = js.getSelectResult(sql, null,"base_major");
		return result;
	}

	public Object dbgetbase_major() {
		String sql = "SELECT * FROM base_major";
		JSONResponse js = new JSONResponse();
		ExecResult result = js.getSelectResult(sql, null,"base_major");  
		return result; 
	}

	public Object insertmajor(String major_no,String major_name) {
		
		String sql="INSERT INTO base_major (major_no,major_name) VALUES('"+major_no+"','"+major_name+"')";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecInsertId(sql, null, "插入成功", "插入失败");
		return result;
	}

	public Object dbsearch_major() {
		String sql="SELECT * FROM base_major";
		JSONResponse jd = new JSONResponse();
		ExecResult result = jd.getExecInsertId(sql, null, "查找成功", "查找失败");
		return result;
	}
	public Object deleteMajor(String major_no,String major_name) {
		JSONResponse jd = new JSONResponse();
		String params [] = new String[]{major_no,major_name};
		String sql="DELETE FROM `base_major` WHERE major_no=''{0}'' AND major_name=''{1}''";
		ExecResult result = jd.getExecResult(sql, params, null, null);
		return result;
	}
}
