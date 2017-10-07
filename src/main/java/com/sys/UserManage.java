package com.sys;

import java.io.IOException;
import java.text.MessageFormat;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.jhg.common.TypeUtils;
import com.jhg.db.DAO;
import com.jhg.db.table.DataTable;
import com.jhg.mvc.Action;
import com.jhg.utils.Azdg;
import com.service.system.SystemService;

public class UserManage extends Action {
	/**
	 * 菜单表格数据
	 */
	public void getGridData() {
		System.out.println("in getGridData....");
		String sql = "select user_id,user_loginname,user_name,user_createtime,user_lastlogin,user_type,user_purview,user_status from tb_user";
		DataTable objData = DataTable.getDataTable(sql, "tb_user");
		String out= JSONObject.toJSONString(objData);
		try {
			response.getWriter().write(out);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void addUser(){
		System.out.println("in addUser....");
		String user_loginname=request.getParameter("user_loginname");
		String user_name=request.getParameter("user_name");
		String user_type=request.getParameter("user_type");
		String user_purview=request.getParameter("user_purview");
		String user_status=request.getParameter("user_status");
		String user_createtime = TypeUtils.getTime();
		Azdg a=new Azdg();
		String user_pwd = a.encrypt("111111");
		String sql = "insert into tb_user('user_loginname','user_name','user_type','user_purview','user_status','user_createtime','user_pwd')"
				+ " values (''{0}'',''{1}'',''{2}'',''{3}'',''{4}'',''{5}'',''{6}'')";
		String s=MessageFormat.format(sql,new String[]{user_loginname,user_name,user_type,user_purview,user_status,user_createtime,user_pwd});
		DAO dao=new DAO();
		Object o=dao.execInsertId(s);
		try{
			if(o!=null){
				String user_id=String.valueOf(o);
				if(Integer.parseInt(user_id)>0){
					//SystemService ss=new SystemService();
					//ss.genRoleData(user_id, user_type);
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
	 * 删除菜单
	 */
	public void delUser(){
		System.out.println("in delUser....");
		String user_id=request.getParameter("user_id");
		String sql = "delete from tb_user where user_id="+user_id;
		DAO dao=new DAO();
		try{

			if(dao.execCommand(sql)){
				String delroleSql = "delete from tb_role_user where user_id="+user_id;
				dao.execCommand(delroleSql);
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
	 * 根据用户编号加载修改页面的初始数据
	 */
	public void loadUserData(){
		System.out.println("in loadUserData....");
		String user_id=request.getParameter("userid");
		String sql = "select user_id,user_loginname,user_name,user_type,user_purview,user_status"
				+ " from tb_user where user_id="+user_id;
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
	 * 根据用户编号修改菜单数据
	 */
	public void updateUserData(){
		System.out.println("in updateUserData....");
		String user_id=request.getParameter("user_id");
		String user_loginname=request.getParameter("user_loginname");
		String user_name=request.getParameter("user_name");
		String user_type=request.getParameter("user_type");
		String user_purview=request.getParameter("user_purview");
		String user_status=request.getParameter("user_status");
		String s = new String();
		if(request.getParameter("user_pwd").trim().length()>0){
			Azdg a=new Azdg();
			String user_pwd = a.encrypt(request.getParameter("user_pwd"));
			String sql = "update tb_user set 'user_loginname' = ''{0}'','user_name'=''{1}'','user_type'=''{2}'','user_purview'=''{3}'','user_status'=''{4}'','user_pwd'=''{5}'' where 'user_id'={6}";
			s=MessageFormat.format(sql,new String[]{user_loginname,user_name,user_type,user_purview,user_status,user_pwd,user_id}); 
		}else{
			String sql = "update tb_user set 'user_loginname' = ''{0}'','user_name'=''{1}'','user_type'=''{2}'','user_purview'=''{3}'','user_status'=''{4}'' where 'user_id'={5}";
			s=MessageFormat.format(sql,new String[]{user_loginname,user_name,user_type,user_purview,user_status,user_id}); 	
		}
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
}
