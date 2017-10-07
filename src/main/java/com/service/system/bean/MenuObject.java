package com.service.system.bean;

import java.util.List;
import java.util.Map;

import com.jhg.common.TypeUtils;
import com.jhg.response.SqlService;

public class MenuObject {
	private String menu_id;
	private String menu_type;
	private String menu_name;
	private String menu_link;
	private String menu_attr;
	private String menu_desc;
	public String getMenu_desc() {
		return menu_desc;
	}
	public void setMenu_desc(String menu_desc) {
		this.menu_desc = menu_desc;
	}
	public String getMenu_attr() {
		return menu_attr;
	}
	public void setMenu_attr(String menu_attr) {
		this.menu_attr = menu_attr;
	}


	private MenuObject[] menu_children;
	public String getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(String menu_id) {
		this.menu_id = menu_id;
	}
	public String getMenu_type() {
		return menu_type;
	}
	public void setMenu_type(String menu_type) {
		this.menu_type = menu_type;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public String getMenu_link() {
		return menu_link;
	}
	public void setMenu_link(String menu_link) {
		this.menu_link = menu_link;
	}
	public MenuObject[] getMenu_children() {
		return menu_children;
	}
	public void setMenu_children(MenuObject[] menu_children) {
		this.menu_children = menu_children;
	}
	
	
	public static MenuObject [] getMenu(String userid,String pid,String purview){
		purview="";
		SqlService dba=new SqlService();
		String managerSql="SELECT COUNT(1) rownumber FROM tb_role_menu WHERE role_id IN(SELECT role_id FROM tb_role_user WHERE user_id="+userid+") AND menu_id='ALL' ";
		List<Map<String,Object>> manageresult=dba.selectResult(managerSql,null);
		//如果角色菜单表中有ALL的记录，表示为全集菜单
		if(manageresult!=null&&manageresult.size()>0){
			Map<String,Object> item=manageresult.get(0);
			int rownumber=TypeUtils.getInt(item.get("ROWNUMBER"));
			if(rownumber>0)purview="ALL";
		}
		String rolemenusql="SELECT c.menu_id FROM tb_role a,tb_role_user b,tb_role_menu c WHERE a.role_id=b.role_id AND a.role_id=c.role_id AND b.user_id="+userid;
		String sql="SELECT menu_id,menu_name,menu_type,menu_content,menu_attr,(SELECT COUNT(1) FROM tb_menu b "+ 
						"WHERE b.menu_pid=a.menu_id AND b.menu_status=1 "+
						") isleaf FROM tb_menu a "+
						"WHERE a.`menu_pid`="+pid+" AND a.menu_status=1 ";
		if(!purview.toUpperCase().equals("ALL")){
			sql+=" and a.menu_id in("+rolemenusql+")";
		}
		
		sql+=" order by menu_sort";
		
		List<Map<String,Object>> result=dba.selectResult(sql,null);
		if(result==null||result.size()==0) return null;
		MenuObject [] menus=new MenuObject [result.size()];
		for(int i=0;i<menus.length;i++){
			Map<String,Object> item=result.get(i);
			menus[i]=new MenuObject();
			menus[i].setMenu_id(TypeUtils.getString(item.get("MENU_ID")));
			menus[i].setMenu_link(TypeUtils.getString(item.get("MENU_CONTENT")));
			menus[i].setMenu_name(TypeUtils.getString(item.get("MENU_NAME")));
			menus[i].setMenu_type(TypeUtils.getString(item.get("MENU_TYPE")));
			menus[i].setMenu_attr(TypeUtils.getString(item.get("MENU_ATTR")));
			int hasleaf=TypeUtils.getInt(item.get("ISLEAF"));
			if(hasleaf>0){
				menus[i].setMenu_children(getMenu(userid,menus[i].getMenu_id(),purview));
			}
		}
		return menus;
	}
	
	public static MenuObject [] getLogicMenu(String userid,String pid,String purview){
		purview="";
		SqlService dba=new SqlService();
		String managerSql="SELECT COUNT(1) rownumber FROM tb_role_menu WHERE role_id IN(SELECT role_id FROM tb_role_user WHERE user_id="+userid+") AND menu_id='ALL' ";
		List<Map<String,Object>> manageresult=dba.selectResult(managerSql,null);
		//如果角色菜单表中有ALL的记录，表示为全集菜单
		if(manageresult!=null&&manageresult.size()>0){
			Map<String,Object> item=manageresult.get(0);
			int rownumber=TypeUtils.getInt(item.get("ROWNUMBER"));
			if(rownumber>0)purview="ALL";
		}
		String rolemenusql="SELECT c.menu_id FROM tb_role a,tb_role_user b,tb_role_menu c WHERE a.role_id=b.role_id AND a.role_id=c.role_id AND b.user_id="+userid;
		String sql="SELECT menu_id,menu_name,menu_type,menu_content,menu_attr,menu_desc,(SELECT COUNT(1) FROM tb_menu_logic b "+ 
						"WHERE b.menu_pid=a.menu_id AND b.menu_status=1 "+
						") isleaf FROM tb_menu_logic a "+
						"WHERE a.`menu_pid`="+pid+" AND a.menu_status=1 ";
		if(!purview.toUpperCase().equals("ALL")){
			//sql+=" and a.menu_id in("+rolemenusql+")";
		}
		
		sql+=" order by menu_sort";
		
		List<Map<String,Object>> result=dba.selectResult(sql,null);
		if(result==null||result.size()==0) return null;
		MenuObject [] menus=new MenuObject [result.size()];
		for(int i=0;i<menus.length;i++){
			Map<String,Object> item=result.get(i);
			menus[i]=new MenuObject();
			menus[i].setMenu_id(TypeUtils.getString(item.get("MENU_ID")));
			menus[i].setMenu_link(TypeUtils.getString(item.get("MENU_CONTENT")));
			menus[i].setMenu_name(TypeUtils.getString(item.get("MENU_NAME")));
			menus[i].setMenu_type(TypeUtils.getString(item.get("MENU_TYPE")));
			menus[i].setMenu_attr(TypeUtils.getString(item.get("MENU_ATTR")));
			menus[i].setMenu_desc(TypeUtils.getString(item.get("MENU_DESC")));
			int hasleaf=TypeUtils.getInt(item.get("ISLEAF"));
			if(hasleaf>0){
				menus[i].setMenu_children(getLogicMenu(userid,menus[i].getMenu_id(),purview));
			}
		}
		return menus;
	}
	
}
