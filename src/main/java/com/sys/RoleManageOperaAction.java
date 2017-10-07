package com.sys;

import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class RoleManageOperaAction extends Action {
	
	public void getRoleManageView() {
		String result = "";
		RoleManageOperaService service = new RoleManageOperaService();
		result = (service.getRoleManageView()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getRoleManageXG() {
		String roleid = request.getParameter("roleid");
		String rolename = request.getParameter("rolename");
		String result = "";
		if(roleid == null || rolename == null) {
			ExecResult er = new ExecResult(false,"角色编号或角色名字传入失败！");
			result = er.toString();
		} else {	
		    RoleManageOperaService service = new RoleManageOperaService();
			result = (service.getRoleManageXG(roleid,rolename)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getRoleManageSC() {
		String roleid = request.getParameter("roleid");
		String result = "";
		if(roleid == null) {
			ExecResult er = new ExecResult(false,"角色编号传入失败！");
			result = er.toString();
		} else {	
		    RoleManageOperaService service = new RoleManageOperaService();
			result = (service.getRoleManageSC(roleid)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getRoleManageADD() {
		String rolename = request.getParameter("rolename");
		String result = "";
		if(rolename == null) {
			ExecResult er = new ExecResult(false,"角色名字传入失败！");
			result = er.toString();
		} else {	
				RoleManageOperaService service = new RoleManageOperaService();
				result = (service.getRoleManageADD(rolename)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
