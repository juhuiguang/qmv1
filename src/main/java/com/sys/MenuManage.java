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

public class MenuManage extends Action {
	/**
	 * 菜单表格数据
	 */
	public void getGridData() {
		System.out.println("in getGridData....");
		String sql = "select t1.menu_id,t1.menu_name,t1.menu_type,t2.menu_name as menu_pid,t1.menu_content,t1.menu_attr,t1.menu_status from tb_menu t1 left join tb_menu t2 on t2.menu_id = t1.menu_pid";
		DataTable objData = DataTable.getDataTable(sql, "tb_menu");
		String out= JSONObject.toJSONString(objData);
		try {
			response.getWriter().write(out);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void addMenu(){
		System.out.println("in addMenu....");
		String menu_name=request.getParameter("menu_name");
		String menu_content=request.getParameter("menu_content");
		String menu_type=request.getParameter("menu_type");
		String menu_pid=request.getParameter("menu_pid");
		String menu_attr=request.getParameter("menu_attr");
		String menu_status=request.getParameter("menu_status");
		String sql = "insert into tb_menu('menu_name','menu_content','menu_type','menu_pid','menu_attr','menu_status')"
				+ " values (''{0}'',''{1}'',''{2}'',{3},''{4}'',''{5}'')";
		String s=MessageFormat.format(sql,new String[]{menu_name,menu_content,menu_type,menu_pid,menu_attr,menu_status});
		DAO dao=new DAO();
		Object o=dao.execInsertId(s);
		try{
			if(o!=null){
				String menu_id=String.valueOf(o);
				if(Integer.parseInt(menu_id)>0){
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
	public void delMenu(){
		System.out.println("in delMenu....");
		String menu_id=request.getParameter("menu_id");
		String sql = "delete from tb_menu where menu_id="+menu_id;
		DAO dao=new DAO();
		try{

			if(dao.execCommand(sql)){
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
	 * 根据菜单编号加载修改页面的初始数据
	 */
	public void loadMenuData(){
		System.out.println("in loadMenuData....");
		String menu_id=request.getParameter("menuid");
		String sql = "select t1.menu_id,t1.menu_name,t1.menu_type,t1.menu_pid,t2.menu_name as menu_pname,t1.menu_content,t1.menu_attr,t1.menu_status from tb_menu t1 left join tb_menu t2 on t2.menu_id = t1.menu_pid where t1.menu_id ="+menu_id;
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
	 * 根据菜单编号修改菜单数据
	 */
	public void updateMenuData(){
		System.out.println("in updateMenuData....");
		String menu_id=request.getParameter("menu_id");
		String menu_name=request.getParameter("menu_name");
		String menu_content=request.getParameter("menu_content");
		String menu_type=request.getParameter("menu_type");
		String menu_pid=request.getParameter("menu_pid");
		String menu_attr=request.getParameter("menu_attr");
		String menu_status=request.getParameter("menu_status");
		String sql = "update tb_menu set 'menu_name' = ''{0}'','menu_content'=''{1}'','menu_type'=''{2}'','menu_pid'=''{3}'','menu_attr'=''{4}'','menu_status'=''{5}'' where 'menu_id'={6}";
		String s=MessageFormat.format(sql,new String[]{
				menu_name,menu_content,menu_type,menu_pid,menu_attr,menu_status,menu_id
		}); 
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
	
	/**
	 * 父类菜单下拉框数据
	 */
	public void getParentMenuData(){
		System.out.println("in getParentMenuData....");
		String sql = "select DISTINCT menu_id,menu_name from tb_menu";
		DataTable objData = DataTable.getDataTable(sql, "tb_menu");
		String out= JSONObject.toJSONString(objData);
		try {
			response.getWriter().write(out);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
