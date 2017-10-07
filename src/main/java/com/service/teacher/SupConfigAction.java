package com.service.teacher;

import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class SupConfigAction extends Action {
	public void getConfig(){
		SupConfigService scs=new SupConfigService();
		String master_no=request.getParameter("master_no");
		ExecResult er=scs.getConfig(master_no);
		try {
			response.getWriter().write(er.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void AddConfig(){
		String master_no=request.getParameter("master_no");
		String content=request.getParameter("content");
		String type=request.getParameter("type");
		SupConfigService scs=new SupConfigService();
		
		ExecResult er=scs.addConfig(content, type, master_no);
		try {
			response.getWriter().write(er.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void removeConfig(){
		String master_no=request.getParameter("master_no");
		String configid=request.getParameter("configid");
		SupConfigService scs=new SupConfigService();
		
		ExecResult er=scs.removeConfig(master_no, configid);
		try {
			response.getWriter().write(er.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
}
