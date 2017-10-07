package com.sys;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.jhg.utils.Azdg;
import com.service.student.MassService;

public class MenuManageOperaAction extends Action {
	
	public void getMenuManageView() {
		String result = "";
		MenuManageOperaService service = new MenuManageOperaService();
		result = (service.getMenuManageView()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void get_search() {
		String name_no = request.getParameter("name_no");
		String result = "";
		MenuManageOperaService service = new MenuManageOperaService();
		result = (service.get_search(name_no)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getMenuManageXG() {
		String menuid = request.getParameter("menuid");
		String menuname = request.getParameter("menuname");
		String menutype = request.getParameter("menutype");
		String menupid = request.getParameter("menupid");
		String menucontent = request.getParameter("menucontent");
		String menuattr = request.getParameter("menuattr");
		String menustatus = request.getParameter("menustatus");
		String menusort = request.getParameter("menusort");
		String result = "";
		if(menuid == null || menuname == null || menutype == null || menupid == null || menucontent == null || menuattr == null || menustatus == null || menusort == null) {
			ExecResult er = new ExecResult(false,"其中某一项的值获取失败！");
			result = er.toString();
		} else {	
			    MenuManageOperaService service = new MenuManageOperaService();
				result = (service.getMenuManageXG(menuid,menuname,menutype,menupid,menucontent,menuattr,menustatus,menusort)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getMenuManageDropdown() {
		String result = "";
		MenuManageOperaService service = new MenuManageOperaService();
		result = (service.getMenuManageDropdown()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getMenuManageSC() {
		String menuid = request.getParameter("menuid");
		String menutype = request.getParameter("menutype");
		String result = "";
		if(menuid == null || menutype == null) {
			ExecResult er = new ExecResult(false,"菜单的ID号或菜单类型获取失败！");
			result = er.toString();
		} else {	
			    MenuManageOperaService service = new MenuManageOperaService();
				result = (service.getMenuManageSC(menuid,menutype)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}		
	}
	
	public void getMenuManageADD() {
		String menuname = request.getParameter("menuname");
		String menutype = request.getParameter("menutype");
		String menupid = request.getParameter("menupid");
		String menucontent = request.getParameter("menucontent");
		String menuattr = request.getParameter("menuattr");
		String menustatus = request.getParameter("menustatus");
		String menusort = request.getParameter("menusort");
		String result = "";
		if(menuname == null || menutype == null || menupid == null || menucontent == null || menuattr == null || menustatus == null || menusort == null) {
			ExecResult er = new ExecResult(false,"其中某一项的值获取失败！");
			result = er.toString();
		} else {	
			    MenuManageOperaService service = new MenuManageOperaService();
				result = (service.getMenuManageADD(menuname,menutype,menupid,menucontent,menuattr,menustatus,menusort)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	public void get_user() {
		String result = "";
		MenuManageOperaService service = new MenuManageOperaService();
		result = (service.get_user()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void load_type() {
		String result = "";
		MenuManageOperaService service = new MenuManageOperaService();
		result = (service.load_type()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public void changepwd() {
		String user_loginname = request.getParameter("user_loginname");
		String user_type = request.getParameter("user_type");
		String result = "";
		MenuManageOperaService service = new MenuManageOperaService();
		result = (service.changepwd(user_loginname,user_type)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void load_delete() {
		String user_loginname=request.getParameter("user_loginname");
		String result = "";
		if(user_loginname==null)
		{
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		}
		else
		{
			MenuManageOperaService service = new MenuManageOperaService();
			result = (service.load_delete(user_loginname)).toString();
		}

		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	

		public void save_table(){
			String user_loginname=request.getParameter("user_loginname");
			String user_name=request.getParameter("user_name");
			Azdg a=new Azdg();
			String user_pwd = a.encrypt("111111");
			String user_purview=request.getParameter("user_purview");
			String user_type=request.getParameter("user_type");
			String user_status=request.getParameter("user_status");
	
			
			
			Map<String,String>param=new HashMap();	
			param.put("user_loginname", user_loginname);
			param.put("user_name", user_name);
			param.put("user_pwd", user_pwd);
			param.put("user_purview", user_purview);
			param.put("user_type",user_type);
			param.put("user_status", user_status);

			MenuManageOperaService service = new MenuManageOperaService();
			String result=(service.save_table(param)).toString();
			try {
				response.getWriter().write(result);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		public void change_table(){
			String user_loginname=request.getParameter("user_loginname");
			String user_name=request.getParameter("user_name");
			String user_purview=request.getParameter("user_purview");
			String user_type=request.getParameter("user_type");
			String user_status=request.getParameter("user_status");
	
			
			Map<String,String>param=new HashMap();	
			param.put("user_loginname", user_loginname);
			param.put("user_name", user_name);
			param.put("user_purview", user_purview);
			param.put("user_type",user_type);
			param.put("user_status", user_status);

			MenuManageOperaService service = new MenuManageOperaService();
			String result=(service.change_table(param)).toString();
			try {
				response.getWriter().write(result);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	
	

}
