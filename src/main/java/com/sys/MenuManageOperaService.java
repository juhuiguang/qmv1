package com.sys;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONArray;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;
import com.jhg.utils.Azdg;
import com.service.system.SystemService;

public class MenuManageOperaService {

	public Object getMenuManageView() {
		// TODO Auto-generated method stub
		String sql = "SELECT t1.menu_id,t1.menu_name,t1.menu_type,t2.menu_name AS menu_pid,t1.menu_content,t1.menu_attr,t1.menu_status,t1.menu_sort FROM tb_menu t1 LEFT JOIN tb_menu t2 ON t2.menu_id = t1.menu_pid";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "tb_menu");
		return result;
	}
	
	public Object get_user() {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM tb_user";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "tb_menu");
		return result;
	}
	
	public Object load_delete( String user_loginname) {
		List<String> sqls=new ArrayList<String>();
		sqls.add("delete from tb_role_user where user_id in(select user_id from tb_user where user_loginname='"+user_loginname+"' )");
		sqls.add( "DELETE  FROM  tb_user   WHERE user_loginname='"+user_loginname+"'");
		
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(sqls,"删除成功！","删除失败");
		return result;
	}
	
	public Object load_type() {
		String sql = "SELECT * FROM tb_role ";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null,"删除成功！");
		return result;
	}
	
	public Object getMenuManageXG(String menuid, String menuname,
			String menutype, String menupid, String menucontent,
			String menuattr, String menustatus, String menusort) {
		
		if(menutype.equals("0")){
			menutype = "子功能";
		} else {
			menutype = "模块";
		}
		
		// TODO Auto-generated method stub
		String sql ="UPDATE tb_menu SET menu_name ='"+menuname+"',menu_content='"+menucontent+"',menu_type='"+menutype+"',menu_pid='"+menupid+"',menu_attr='"+menuattr+"',menu_status='"+menustatus+"',menu_sort='"+menusort+"' WHERE menu_id='"+menuid+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(sql, null, "", "");
		return result;
	}
	
	public Object get_search(String name_no) {
		// TODO Auto-generated method stub
		String sql ="SELECT * FROM tb_user a  WHERE a.`user_name` LIKE '"+name_no+"%' OR a.`user_name` LIKE '%"+name_no+"' OR a.`user_name` LIKE '%"+name_no+"%' OR a.`user_loginname` LIKE '%"+name_no+"' OR a.`user_loginname`LIKE '"+name_no+"%' OR a.`user_loginname`LIKE '%"+name_no+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "tb_menu");
		return result;
	}

	public Object getMenuManageDropdown() {
		// TODO Auto-generated method stub
		String sql ="SELECT menu_id,menu_name FROM tb_menu WHERE menu_type='模块' ";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "tb_menu");
		return result;
	}

	public Object getMenuManageSC(String menuid,String menutype) {
		// TODO Auto-generated method stub
		ExecResult result=null;
		if(menutype.equals("模块")){
			JSONResponse jr = new JSONResponse();
			String sql2 = "SELECT menu_id FROM tb_menu WHERE menu_id='"+menuid+"' OR menu_pid='"+menuid+"'";
			ExecResult result2 = jr.getSelectResult(sql2, null, "");
			JSONArray menu = result2.getData();
	//		System.out.println(menu.toJSONString());
			for(int i=0; i<menu.size();i++) {	
				String sql3 = "DELETE FROM tb_role_menu WHERE menu_id='"+result2.getData().getJSONObject(i).getString("menu_id")+"'";
				ExecResult result3= jr.getExecResult(sql3, null, "", "");
				System.out.println(result3);
			}
			 String sql = "DELETE FROM tb_menu WHERE menu_id='"+menuid+"' OR menu_pid ='"+menuid+"' ";
			 result= jr.getExecResult(sql, null, "", "");
		} else {
			String sql ="DELETE FROM tb_menu WHERE menu_id='"+menuid+"'";
			JSONResponse jr = new JSONResponse();
		    result = jr.getExecResult(sql, null, "", "");
		}
		return result;	
	}

	public Object getMenuManageADD(String menuname, String menutype,
			String menupid, String menucontent, String menuattr,
			String menustatus, String menusort) {
		// TODO Auto-generated method stub
		
		if(menutype.equals("0")){
			menutype = "子功能";
		} else if(menutype.equals("2")){
			menutype = "";
		} else {
			menutype = "模块";
		}
		
		String sql1 = "SELECT * FROM tb_menu WHERE menu_name='"+menuname+"' AND menu_type='"+menutype+"'";
		JSONResponse jr1 = new JSONResponse();
		ExecResult result1 = jr1.getSelectResult(sql1, null, "tb_menu");
		if(result1.getData().size() == 0) {
			String sql = "INSERT INTO tb_menu(menu_name,menu_type,menu_pid,menu_content,menu_attr,menu_status,menu_sort) VALUES ("+"'"+menuname+"'"+","+"'"+menutype+"'"+","+"'"+menupid+"'"+","+"'"+menucontent+"'"+","+"'"+menuattr+"'"+","+"'"+menustatus+"'"+","+"'"+menusort+"'"+")";
			JSONResponse jr = new JSONResponse();
			ExecResult result = jr.getExecResult(sql, null, "新菜单添加成功！", "添加新菜单失败~"); 
			return result;			
		} else {
			return result1;
		}
		
	}
	
	public ExecResult save_table(Map<String,String> param){
		String sql1="insert into tb_user (user_loginname,user_pwd,user_name,user_type,user_purview,user_status) values "
				+ "(";
			sql1+="'"+param.get("user_loginname")+"',";
		sql1+="'"+param.get("user_pwd")+"',";
		sql1+="'"+param.get("user_name")+"',";
		sql1+="'"+param.get("user_type")+"',";
		sql1+="'"+param.get("user_purview")+"',";
		sql1+="'"+param.get("user_status")+"')";
		
		JSONResponse response=new JSONResponse();
		ExecResult result= response.getExecInsertId(sql1,null,"新用户创建成功","新用户创建失败");
		ExecResult er= new ExecResult();
		if(Integer.parseInt(result.getMessage())>0){
			SystemService ss=new SystemService();
			ss.genRoleData(result.getMessage(), param.get("user_type"));
			
			er.setResult(true);
			er.setMessage("新用户创建成功");
		}else{
			er.setResult(false);
			er.setMessage("新用户创建失败");
		}
		return er;
		
}
	
	public ExecResult change_table(Map<String,String> param){
		String sql;
		sql= "UPDATE tb_user  SET user_name="+"'"+param.get("user_name")+"'"+", user_type="+"'"+param.get("user_type")+"'"+", user_purview="+"'"+param.get("user_purview")+"'"+" ,user_status= "+"'"+param.get("user_status")+"'"+ " WHERE user_loginname= "+"'"+param.get("user_loginname")+"'";
		JSONResponse response=new JSONResponse();
		ExecResult result= response.getExecResult(sql,null,"修改成功","修改失败");
		return result;	
}
	/**
	 * 根据教工号改变初始密码
	 * @param user_loginname
	 * @return 
	 */
	public ExecResult changepwd(String user_loginname,String user_type){
		String sql="";
		String pwd="111111";
		if(user_type.equals("学生")){
			pwd="123456";
		}
		Azdg az=new Azdg();
		pwd=az.encrypt(pwd);
		sql= "UPDATE tb_user a SET a.`user_pwd`='"+pwd+"' WHERE a.`user_loginname`='"+user_loginname+"'";
		JSONResponse response=new JSONResponse();
		ExecResult result= response.getExecResult(sql,null,"密码重置成功","密码重置失败");
		return result;	
}

}
