package com.service.master;

import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class ViewTeaPxAction  extends Action {

	private static final String String = null;

	public void getTableInfo(){
		String result ="";
		String pageindex = request.getParameter("pageindex");
		String pagelength = request.getParameter("pagelength");
		String dep_no = request.getParameter("dep_no");
		String term_no = request.getParameter("term_no");
		String totaltemp = request.getParameter("totaltemp");
		String teacher_name = request.getParameter("teacher_name");
		if(pageindex==null||pagelength==null||dep_no==null||term_no==null){
			ExecResult eResult = new ExecResult(false,"数据传入错误");
			result = eResult.toString();
		}else{
			ViewTeaPxService viewTeaPxService = new ViewTeaPxService();
			result = (viewTeaPxService.getTableInfoService(term_no, dep_no, Integer.parseInt(pageindex), Integer.parseInt(pagelength),Integer.parseInt(totaltemp), teacher_name)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
