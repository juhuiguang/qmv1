package com.service.teacher;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class TeacherAction extends Action {
	
	public void getTeaListenTable(){
		String tableflag=request.getParameter("flag");
		String result="";
		if(tableflag==null){
			ExecResult er=new ExecResult(false,"听课表标记传入错误！");
			result=er.toString();
		}else{
			TeacherListenService service=new TeacherListenService();
			result=(service.getTeaListenTable(tableflag)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void postListen(){
		String jxjy=request.getParameter("jxjy");
		String tkpj=request.getParameter("tkpj");
		String total=request.getParameter("total");
		String tablename=request.getParameter("tablename");
		String fields=request.getParameter("fields");
		String master_no=request.getParameter("master_no");
		String task_no=request.getParameter("task_no");
		String rule_flag=request.getParameter("rule_flag");
		String listendate=request.getParameter("listendate");
		Map<String,String>param=new HashMap();
		if(fields!=null){
			String [] fieldsarr=fields.split(",");
			for(int i=0;i<fieldsarr.length;i++){
				param.put(fieldsarr[i], request.getParameter(fieldsarr[i]));
			}
		}
		param.put("fields", fields);
		param.put("jxjy", jxjy);
		param.put("tkpj", tkpj);
		param.put("total", total);
		param.put("tablename", tablename);
		param.put("master_no", master_no);
		param.put("task_no", task_no);
		param.put("rule_flag", rule_flag);
		param.put("listendate", listendate);
		
		TeacherListenService service=new TeacherListenService();
		
		String result=(service.postListen(param)).toString();
		
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
