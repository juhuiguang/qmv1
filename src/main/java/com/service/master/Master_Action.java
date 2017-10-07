package com.service.master;

import java.io.IOException;

import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class Master_Action extends Action {

	public void getMasterLisInf(){
		String pageindex=request.getParameter("pageindex");
		String pageLength=request.getParameter("pageLength");
		String master_no=request.getParameter("master_no");
		String temppage=request.getParameter("temppage");
		String term_no=request.getParameter("term_no");
		String result="";
		JSONObject jo=new JSONObject();
		if(master_no==null){
			ExecResult er=new ExecResult(false,"督学编号传入错误！");
			result=er.toString();
		}else{
			Master_service service=new Master_service();
			ExecResult r1=(service.getMasterLisInfService(master_no,Integer.parseInt(pageLength),Integer.parseInt(pageindex),term_no));
			if(Integer.parseInt(temppage)==1){
			    ExecResult r2=(service.getMasterLisInfServiceCount(master_no,term_no));
			    jo.put("total",r2.getData().getJSONObject(0).getString("totalrows"));
			}
			
			jo.put("rows",r1.getData());
			result=jo.toJSONString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void getMasterSearchLisInf(){
		String pageindex=request.getParameter("pageindex");
		String pageLength=request.getParameter("pageLength");
		String master_no=request.getParameter("master_no");
		String teacher_name=request.getParameter("teacher_name");
		String strart_date=request.getParameter("strart_date");
		String end_date=request.getParameter("end_date");
		String temppage=request.getParameter("temppage");
		String term_no=request.getParameter("term_no");
		String result="";
		JSONObject jo=new JSONObject();
		if(master_no==null){
			ExecResult er=new ExecResult(false,"督学编号传入错误！");
			result=er.toString();
		}else{
			Master_service service=new Master_service();
			ExecResult r1=(service.getMasterLisInfSearchService(master_no,Integer.parseInt(pageLength),Integer.parseInt(pageindex),teacher_name,strart_date,end_date,term_no));
			if(Integer.parseInt(temppage)==1){
				// ExecResult r2=(service.getMasterLisInfServiceCount(master_no));
				 ExecResult r2=(service.getMasterLisInfSearchServiceCount(master_no,teacher_name,strart_date,end_date,term_no));
				 jo.put("total",r2.getData().getJSONObject(0).getString("totalrows"));
			}
			
			jo.put("rows",r1.getData());
			
			result=jo.toJSONString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void getTeaListenTable(){
		String id=request.getParameter("id");
		String term_no=request.getParameter("term_no");
		String result="";
		JSONObject jo=new JSONObject();
		if(id==null){
			ExecResult er=new ExecResult(false,"课程编号传入错误！");
			result=er.toString();
		}else{
			Master_service service=new Master_service(); 
			result=(service.getTeaListenTable(id,term_no)).toString(); 
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public void getTermData(){
		String term_no=request.getParameter("term_no");
		String result="";
		JSONObject jo=new JSONObject();
		if(term_no==null){
			ExecResult er=new ExecResult(false,"学期编号传入错误！");
			result=er.toString();
		}else{
			Master_service service=new Master_service(); 
			result=(service.getTermData(term_no)).toString(); 
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void deletemasterlisten(){
		String task_no=request.getParameter("task_no");
		String listen_time=request.getParameter("listen_time");
		String master_no=request.getParameter("master_no");
		System.out.println(task_no);
		System.out.println(listen_time);
		System.out.println(master_no);
		String result="";
		if(task_no==""||listen_time==""||master_no==""){
			ExecResult er=new ExecResult(false,"数据传入错误！");
		result=er.toString();
	    }else{
	    	Master_service service=new Master_service(); 
			result=(service.deletemasterlistenService(task_no,listen_time,master_no)).toString(); 
	    }
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void postgrand(){
		String id=request.getParameter("id");
		String jxjy=request.getParameter("jxjy"); 
		String jxpj=request.getParameter("jxpj");
		String grand=request.getParameter("grand");
		String result="";
		JSONObject jo=new JSONObject();
		if(id==null){
			ExecResult er=new ExecResult(false,"课程编号传入错误！");
			result=er.toString();
		}else{ 
			Master_service service=new Master_service(); 
			result=(service.postgrand(id,jxjy,jxpj,grand)).toString(); 
		}
		try { 
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
