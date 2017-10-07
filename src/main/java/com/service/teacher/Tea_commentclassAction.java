package com.service.teacher;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class Tea_commentclassAction extends Action{
	public void gettableinformation(){
		String teacher_no=request.getParameter("teacher_no");
		String term_no=request.getParameter("term_no");
		String result="";
		if(teacher_no==null){
			ExecResult er=new ExecResult(false,"教师工号标号传入错误！");
			result=er.toString();
		}else{
			Tea_commentclassService service=new Tea_commentclassService();
			result=(service.gettableinformationService(teacher_no,term_no)).toString();
			
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getPXinformation(){
		String teacher_no=request.getParameter("teacher_no");
		String term_no=request.getParameter("term_no");
		String result="";
		if(teacher_no==null){
			ExecResult er=new ExecResult(false,"教师工号传入错误！");
			result=er.toString();
		}else{
			Tea_commentclassService service=new Tea_commentclassService();
			result=(service.getPXinformationService(teacher_no,term_no)).toString();
			
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	public void getclassmark(){
		String task_no=request.getParameter("task_no");
		String result="";
		if(task_no==null){
			ExecResult er=new ExecResult(false,"课程编号传入错误！");
			result=er.toString();
		}else{
			Tea_commentclassService service=new Tea_commentclassService();
			ExecResult r1=service.getclassmarkService(task_no);
			ExecResult r2=service.getclassmarkperService();
			JSONArray temp=r1.getData();
			JSONArray per=r2.getData();
			JSONArray resulttemp=new JSONArray();
			for(int i=0;i<per.size();i++){
				JSONObject jo=new JSONObject();
				String tempper=per.getJSONObject(i).getString("rule_field");
				jo.put("rule_field", per.getJSONObject(i).getString("rule_field"));
				jo.put("rule_per",temp.getJSONObject(0).getString(tempper));
				resulttemp.add(jo);
                 
			}
			JSONObject jo=new JSONObject();
			jo.put("xxjy",temp.getJSONObject(0).getString("xxjy"));
			resulttemp.add(jo);
			result=resulttemp.toJSONString();
			System.out.println(result);
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public void loadtable(){
		String flag=request.getParameter("flag");
		String result="";
		if(flag==null){
			ExecResult er=new ExecResult(false,"评学标号传入错误！");
			result=er.toString();
		}else{
			Tea_commentclassService service=new Tea_commentclassService();
			result=(service.loadtableService(flag)).toString();
			
		}
		try {
			response.getWriter( ).write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void postListen(){
		String xxjy=request.getParameter("xxjy");
		String total=request.getParameter("total");
		String fields=request.getParameter("fields");
		String task_no=request.getParameter("task_no");
		Map<String,String>param=new HashMap();
		if(fields!=null){
			String [] fieldsarr=fields.split(",");
			for(int i=0;i<fieldsarr.length;i++){
				param.put(fieldsarr[i], request.getParameter(fieldsarr[i]));
			}
		}
		param.put("fields", fields);
		param.put("xxjy", xxjy);
		param.put("total", total);
		param.put("task_no", task_no);
		Tea_commentclassService service=new Tea_commentclassService();
		String result=(service.postListen(param)).toString();
		
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	
	public void postchangeListen(){
		String xxjy=request.getParameter("xxjy");
		String total=request.getParameter("total");
		String fields=request.getParameter("fields");
		String task_no=request.getParameter("task_no");
		Map<String,String>param=new HashMap();
		if(fields!=null){
			String [] fieldsarr=fields.split(",");
			for(int i=0;i<fieldsarr.length;i++){
				param.put(fieldsarr[i], request.getParameter(fieldsarr[i]));
			}
		}
		param.put("fields", fields);
		param.put("xxjy", xxjy);
		param.put("total", total);
		param.put("task_no", task_no);
		Tea_commentclassService service=new Tea_commentclassService();
		String result=(service.postchangeListen(param)).toString();
		
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
}
