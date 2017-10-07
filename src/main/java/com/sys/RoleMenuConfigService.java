package com.sys;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class RoleMenuConfigService {
	public ExecResult loadtableService(){
		String sql="SELECT a.menu_id amenu_id,b.menu_id bmenu_id,b.menu_name menu_name2,b.menu_type FROM  tb_menu a   JOIN `tb_menu` b ON a.menu_pid=b.menu_id OR a.menu_id=b.menu_pid  GROUP BY b.menu_id ORDER BY menu_type desc ,bmenu_id";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql,null,"");
		return result;
	}
	public ExecResult gettableinformationService(String role_id){
		String sql="SELECT d.`menu_id` amenu_id,d.menu_pid,d.`menu_name`,d.`menu_name`,e.`role_id`,d.menu_type FROM tb_menu d  LEFT JOIN tb_role_menu e ON e.`menu_id`=d.`menu_id` WHERE e.`role_id`=''{0}''  AND d.menu_type != ''模块'' ORDER BY amenu_id";
		String [] params=new String[] {role_id};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	
		public ExecResult deletemenuService(String role_id,String menu_id,String menu_mkid){
			String sql="DELETE FROM tb_role_menu WHERE role_id=''{0}'' AND menu_id=''{1}''";
			String [] params=new String[] {role_id,menu_id};
			JSONResponse jr=new JSONResponse();
			ExecResult result= jr.getExecResult(sql, params, "删除成功","删除失败");
			String [] paramscheck=new String[] {role_id,menu_mkid};
			String sqlcheck=" SELECT b.menu_id FROM `tb_role_menu` a LEFT JOIN tb_menu b ON b.menu_id=a.`menu_id` WHERE a.role_id=''{0}'' AND b.menu_pid=''{1}''";
			 ExecResult resultcheck= jr.getSelectResult(sqlcheck, paramscheck, "");
			 if(resultcheck.getData().size()==0){
				 String [] paramsdeletemk=new String[] {role_id,menu_mkid};
				 String sqldeletemk="DELETE FROM tb_role_menu WHERE role_id=''{0}'' AND menu_id=''{1}''";
				 ExecResult resultdeletemk= jr.getExecResult(sql, paramsdeletemk, "删除成功","删除失败");
			 }
			return result;
		}
		public ExecResult addmenuService(String role_id,String menu_id){
			JSONResponse jr=new JSONResponse();
			ExecResult result=null;
			String [] params=new String[] {role_id,menu_id};
			String sql2="SELECT a.menu_pid,b.role_id FROM `tb_menu` a LEFT JOIN `tb_role_menu` b ON a.menu_pid=b.`menu_id` WHERE a.menu_id=''{1}'' AND b.menu_id=a.menu_pid AND b.role_id=''{0}''";
			ExecResult result1= jr.getSelectResult(sql2, params, "");
			if(result1.getData().size()==0){
				String [] params1=new String[] {menu_id};
			    String sql3="SELECT a.menu_pid FROM `tb_menu` a WHERE a.`menu_id`=''{0}''";
			    ExecResult resultmenu_pid= jr.getSelectResult(sql3, params1, "");
			    String temp=resultmenu_pid.getData().getJSONObject(0).getString("menu_pid");
			    String [] params2=new String[] {role_id,temp};
			    String sqlinsert="INSERT INTO tb_role_menu (role_id,menu_id) VALUES (''{0}'',''{1}'')";
			    ExecResult resultinsert= jr.getExecResult(sqlinsert, params2, "","");
			}
			String sql="INSERT INTO tb_role_menu (role_id,menu_id) VALUES (''{0}'',''{1}'')";
			result= jr.getExecResult(sql, params, "添加成功","添加失败");
			return result;
	}

}
