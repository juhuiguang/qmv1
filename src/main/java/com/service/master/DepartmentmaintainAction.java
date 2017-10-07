package com.service.master;

import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class DepartmentmaintainAction extends Action {
    public void gettableinformation(){
    	String result="";
    	DepartmentmaintainService service = new DepartmentmaintainService();
    	result=service.gettableinformationService().toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
    }
    }
    public void insertdep(){	
    	String dep_name=request.getParameter("dep_name");
    	String dep_no=request.getParameter("dep_no");
    	String dep_type=request.getParameter("dep_type");
    	String dep_cddw_no=request.getParameter("dep_cddw_no");
    	String dep_sort=request.getParameter("dep_sort");
    	String dep_abbreviation=request.getParameter("dep_abbreviation");
    	String result="";
    	if(dep_name==null ||dep_no==null || dep_type==null || dep_cddw_no==null || dep_sort==null||dep_abbreviation==null ){
			ExecResult er=new ExecResult(false,"信息传入错误");
			result=er.toString();
		}else{
			DepartmentmaintainService service = new DepartmentmaintainService();
	    	result=service.insertService(dep_no,dep_name,dep_type,dep_cddw_no,dep_sort,dep_abbreviation).toString();
		}
    	try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
    }
    }
    
    
    public void updatedep(){	
     	String dep_no1=request.getParameter("dep_no1");
    	String dep_name=request.getParameter("dep_name");
    	String dep_no=request.getParameter("dep_no");
    	String dep_type=request.getParameter("dep_type");
    	String dep_cddw_no=request.getParameter("dep_cddw_no");
    	String dep_sort=request.getParameter("dep_sort");
    	String dep_abbreviation = request.getParameter("dep_abbreviation");
    	String result="";
    	System.out.println(dep_no1);
    	System.out.println(dep_name);
    	System.out.println(dep_no);
    	System.out.println(dep_type);
    	System.out.println(dep_cddw_no);
    	System.out.println(dep_sort);
    	System.out.println(dep_abbreviation);
    	if(dep_name==null ||dep_no==null || dep_type==null || dep_cddw_no==null || dep_sort==null || dep_no1==null ||dep_abbreviation==null){
			ExecResult er=new ExecResult(false,"信息传入错误");
			result=er.toString();
		}else{
			DepartmentmaintainService service = new DepartmentmaintainService();
	    	result=service.updatadepService(dep_no1,dep_no,dep_name,dep_type,dep_cddw_no,dep_sort,dep_abbreviation).toString();
		}
    	try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
    }
    }
    
    
    public void deletedep(){	
    	String dep_no=request.getParameter("dep_no");
    	String result="";
    	if(dep_no==null  ){
			ExecResult er=new ExecResult(false,"部门编号错误");
			result=er.toString();
		}else{
			DepartmentmaintainService service = new DepartmentmaintainService();
	    	result=service.deleteService(dep_no).toString();
		}
    	try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
    }
    }
}
