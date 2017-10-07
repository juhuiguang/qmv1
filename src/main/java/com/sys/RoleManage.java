package com.sys;

import java.io.IOException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.jhg.common.TypeUtils;
import com.jhg.db.DAO;
import com.jhg.db.table.DataTable;
import com.jhg.mvc.Action;

public class RoleManage extends Action {
	/**
	 * 菜单表格数据
	 */
	public void getGridData() {
		System.out.println("in getGridData....");
		String sql = "select role_id,role_name from tb_role";
		DataTable objData = DataTable.getDataTable(sql, "tb_role");
		String out= JSONObject.toJSONString(objData);
		try {
			response.getWriter().write(out);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public void addRole(){
		System.out.println("in addRole....");
		String role_name=request.getParameter("role_name");
		String sql = "insert into tb_role('role_name') values (''{0}'')";
		String s=MessageFormat.format(sql,new String[]{role_name});
		DAO dao=new DAO();
		Object o=dao.execInsertId(s);
		try{
			if(o!=null){
				String role_id=String.valueOf(o);
				if(Integer.parseInt(role_id)>0){
					response.getWriter().write("{\"flag\":\"true\"}");
				}else{
					response.getWriter().write("{\"flag\":\"\"}");
				}
			}else{
				response.getWriter().write("{\"flag\":\"\"}");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 删除角色
	 */
	public void delRole(){
		System.out.println("in delRole....");
		String role_id=request.getParameter("role_id");
		String sql = "delete from tb_role where role_id="+role_id;
		DAO dao=new DAO();
		try{

			if(dao.execCommand(sql)){
				String delUserRoleSql = "delete from tb_user_role where role_id="+role_id;
				dao.execCommand(delUserRoleSql);
				response.getWriter().write("{\"flag\":\"true\"}");
			}else{
				response.getWriter().write("{\"flag\":\"\"}");
			}
		}catch(IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 根据角色编号修改角色名称
	 */
	public void updateRoleData(){
		System.out.println("in updateRoleData....");
		String role_id=request.getParameter("role_id");
		String role_name=request.getParameter("role_name");
		String sql = "update tb_role set 'role_name' = ''{0}'' where 'role_id'={1}";
		String s=MessageFormat.format(sql,new String[]{role_name,role_id}); 
		DAO dao=new DAO();
		try{
			if(dao.execCommand(s)){
				response.getWriter().write("{\"flag\":\"true\"}");
				//后期增加删除关联表数据
			}else{
				response.getWriter().write("{\"flag\":\"\"}");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void loadRoleData(){
		System.out.println("in loadMenuData....");
		String role_id=request.getParameter("roleid");
		String sql = "select role_id,role_name from tb_role where role_id="+role_id;
		DAO dao = new DAO();
		List<Map<String,Object>> result=dao.getDataSet(sql);
		String resultJSONStr = "";
		if(result!=null && result.size()>0){
			//JSONObject op=new JSONObject();
			resultJSONStr= JSONObject.toJSONString(result.get(0));
		}
		try {
			response.getWriter().write(resultJSONStr);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 查询角色名称是否重名
	 */
	
}
