package com.sys;

import java.io.IOException;
import java.util.ArrayList;

import com.alibaba.fastjson.JSONObject;
import com.jhg.db.DAO;
import com.jhg.db.ExecResult;
import com.jhg.db.table.DataTable;
import com.jhg.mvc.Action;
import com.service.master.Checkteacherpxservice;

public class RoleMenuConfig extends Action {
	/**
	 * 获取角色列表数据
	 */
	public void getRoleMenuData() {
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
	
	
	public void loadtable(){
		String result="";
		RoleMenuConfigService service=new RoleMenuConfigService();
		result=(service.loadtableService()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void gettableinformation(){
		String role_id=request.getParameter("role_id");
		String result="";
		JSONObject jo=new JSONObject();
		if(role_id==null){
			ExecResult er=new ExecResult(false,"角色ID传入错误！");
			result=er.toString();
		}else{
			RoleMenuConfigService service=new RoleMenuConfigService();
			result=(service.gettableinformationService(role_id)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void deletemenu(){
		String role_id=request.getParameter("role_id");
		String menu_id=request.getParameter("menu_id");
		String menu_mkid=request.getParameter("menu_mkid");
		String result="";
		JSONObject jo=new JSONObject();
		if(role_id==null ||menu_id==null){
			ExecResult er=new ExecResult(false,"角色ID或者模块ID传入错误！");
			result=er.toString();
		}else{
			RoleMenuConfigService service=new RoleMenuConfigService();
			result=(service.deletemenuService(role_id,menu_id,menu_mkid)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void addmenu(){
		String role_id=request.getParameter("role_id");
		String menu_id=request.getParameter("menu_id");
		String result="";
		JSONObject jo=new JSONObject();
		if(role_id==null ||menu_id==null){
			ExecResult er=new ExecResult(false,"角色ID或者模块ID传入错误！");
			result=er.toString();
		}else{
			RoleMenuConfigService service=new RoleMenuConfigService();
			result=(service.addmenuService(role_id,menu_id)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
}
