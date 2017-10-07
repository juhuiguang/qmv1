<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.Date"%>
<%@page import="com.service.base.ExportExcel"%>
<%@page import="com.service.base.BaseReportAction"%>
<%@page import="org.apache.poi.ss.usermodel.Workbook" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@page import="org.apache.poi.xwpf.usermodel.XWPFDocument" %>
<%@ page language="java" contentType="application/vnd.ms-excel"
    pageEncoding="UTF-8"%><%
	 //接收参数
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String export_id = "";
    String []params = {};
    String type = "";
    String more = "";
	if (request.getParameter("export_id") != null) {
		export_id =  request.getParameter("export_id");
	} 
	if (request.getParameter("more") != null) {
		 more =  request.getParameter("more");
	}
	if (request.getParameter("params")!= null) {
		String temp =  request.getParameter("params");
		System.out.println("temp"+temp);
		/* temp = URLDecoder.decode(temp,"utf-8"); */
		if(Integer.parseInt(more)>1){
			params = temp.split(",,");
			System.out.println("参数为"+params);
		}else{
			params = temp.split(",");
			System.out.println("参数为"+request.getParameter("params"));
		}
	}
	if (request.getParameter("type") != null) {
		 type =  request.getParameter("type");
	}
     ExportExcel excel = new ExportExcel();
	if("word".equals(type)){
	    response.setContentType("application/msword;charset=utf-8");
	    SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");  
        String filename="export_"+format1.format(new Date())+".docx";  
	    response.setHeader("Content-disposition","attachment; filename="+filename+"");
	    XWPFDocument wb = null;
	    if("0".equals(more)){
	    	 wb=excel.exportOneWord(export_id,params);
	    }
	    else if("1".equals(more)){
	       wb=excel.exportWord(export_id,params);
	    }else if("2".equals(more)){
	       wb = excel.exportMoreWord(export_id, params, null);
	    }
	    ServletOutputStream out1 = response.getOutputStream();
	   	wb.write(out1);
		out.clear();  
	   	out = pageContext.pushBody(); 
	}else if("excel".equals(type)){
		System.out.println("more="+more);
		 SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");  
	     String filename="export_"+format1.format(new Date())+".xls";  
		 response.setHeader("Content-disposition","attachment; filename="+filename+"");
		 Workbook wb = null;
		 if("0".equals(more)){
			 wb=excel.exportOneExcel(export_id,params);
	    }
	    else if("1".equals(more)){
	    	 wb=excel.exportExcel(export_id,params);
	    }else{
	    	wb=excel.exportMoreExcel(export_id, params,more);
	    }
		
		   	wb.write(response.getOutputStream());
			out.clear();  
		   	out = pageContext.pushBody(); 
	}
    
    
%>