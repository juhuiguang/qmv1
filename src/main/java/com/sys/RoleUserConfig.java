package com.sys;

import java.io.IOException;
import java.util.ArrayList;

import com.alibaba.fastjson.JSONObject;
import com.jhg.db.DAO;
import com.jhg.db.table.DataTable;
import com.jhg.mvc.Action;

public class RoleUserConfig extends Action {
	/**
	 * 获取用户列表数据
	 */
	public void getUserMenuData() {
		String sql = "select user_id,user_name from tb_user";
		DataTable objData = DataTable.getDataTable(sql, "tb_user");
		String out= JSONObject.toJSONString(objData);
		try {
			response.getWriter().write(out);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取角色列表数据
	 */
	public void getRoleMenuData() {
		String user_id=request.getParameter("user_id");
		String sql = "select tb3.role_id,tb3.role_name ,tb5.role_id as is_ck from tb_role tb3 left join"+
		" (select  t1.role_id from tb_role_user t1 left join tb_role t2 on t1.role_id=t2.role_id where user_id="+user_id+")  as tb5"+
		" on tb3.role_id = tb5.role_id";
		DataTable objData = DataTable.getDataTable(sql, "tb_role");
		String out= JSONObject.toJSONString(objData);
		try {
			response.getWriter().write(out);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public void updateData(){
		String user_id=request.getParameter("user_id");
		String role_ids=request.getParameter("role_ids");
		String[] roleidList = role_ids.split(",");
		ArrayList sqlList=new ArrayList();
		String delSql = "delete from tb_role_user where user_id="+user_id;
		sqlList.add(delSql);
		for(int i=0;i<roleidList.length&&role_ids.trim().length()>0;i++){
			String insertSql = "insert into tb_role_user(user_id,role_id) values ("+user_id+","+roleidList[i]+")";
			sqlList.add(insertSql);
		}
		DAO objDAO = new DAO();
		try{
			if(objDAO.executeBatch(sqlList)){
				response.getWriter().write("{\"flag\":\"true\"}");
			}else{
				response.getWriter().write("{\"flag\":\"\"}");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	
}
