package com.sys;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jhg.common.DateUtils;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.teacher.TeacherViewJudgeService;
public class RoleUserConfigAction extends Action {
	public void get_initInf(){
		String result=""; 
		RoleUserConfigService service=new RoleUserConfigService();
		result=(service.get_initInf()).toString(); 
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block   
			e.printStackTrace();
		}
	}
	public void get_role(){
		String result=""; 
		String user_id=request.getParameter("user_id");
		RoleUserConfigService service=new RoleUserConfigService();
		result=(service.get_role(user_id)).toString(); 
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block   
			e.printStackTrace();
		}
	}
	public void post_role(){
		String result=""; 
		String post_user=request.getParameter("post_user");
		String post_Role=request.getParameter("post_Role");
		RoleUserConfigService service=new RoleUserConfigService();
		result=(service.post_role(post_user,post_Role)).toString(); 
		try {  
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block   
			e.printStackTrace();
		}
	}
}
