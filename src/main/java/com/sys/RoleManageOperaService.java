package com.sys;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class RoleManageOperaService {

	public Object getRoleManageView() {
		// TODO Auto-generated method stub
		String sql ="SELECT * FROM tb_role";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "tb_role");
		return result;
	}

	public Object getRoleManageXG(String roleid, String rolename) {
		// TODO Auto-generated method stub
		String sql ="UPDATE tb_role SET role_name ='"+rolename+"' WHERE role_id='"+roleid+"' ";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(sql, null, "", "");
		return result;
	}

	public Object getRoleManageSC(String roleid) {
		// TODO Auto-generated method stub
		String sql ="DELETE FROM tb_role WHERE role_id='"+roleid+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(sql, null);
		return result;	
	}

	public Object getRoleManageADD(String rolename) {
		// TODO Auto-generated method stub
		String sql2 = "SELECT role_name FROM tb_role WHERE role_name='"+rolename+"'";
		JSONResponse jre = new JSONResponse();
		ExecResult result2 = jre.getSelectResult(sql2, null, "tb_role");
		if(result2.getData().size() == 0){
			String sql = "INSERT INTO tb_role(role_name) VALUES ("+"'"+rolename+"'"+")";
			JSONResponse jr = new JSONResponse();
			ExecResult result = jr.getExecResult(sql, null, "新角色添加成功！", "添加新角色失败~"); 
			return result;			
		} else {
			return result2;
		}
	}

}
