package com.service.base;

import java.io.IOException;
import java.util.List;
 
import com.alibaba.fastjson.JSONObject;
import com.jhg.common.QMExcelUtil;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.base.bean.ImportFileCourseEntityFinal;
import com.service.base.bean.ImportFileLgStuEntityFinal;

public class BaseCourseWHAction extends Action {   

	public void getCourseData() {
		String depno = request.getParameter("depno");
		String termno = request.getParameter("termno");
		String pagenum = request.getParameter("pagenum");
		String times = request.getParameter("times");   
		String result = "";
		if(depno == null || termno == null || pagenum == null || times == null) {
			ExecResult er = new ExecResult(false,"院系号或学期号或分页号获取失败！");
			result = er.toString();
		} else {	
			BaseCourseWHService service = new BaseCourseWHService();
			result = (service.getCourseData(depno,termno,pagenum,times)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}  
	}
	
	public void getLogicClassData() {
		String taskno = request.getParameter("taskno");
		String termno = request.getParameter("termno");
		String lgtimes = request.getParameter("lgtimes");
		String lgpagenum = request.getParameter("lgpagenum");
		String result = "";
		if(taskno == null || termno == null || lgtimes == null || lgpagenum == null) {
			ExecResult er = new ExecResult(false,"课次号或学期号或分页号获取失败！");
			result = er.toString();
		} else {	
			BaseCourseWHService service = new BaseCourseWHService();
			result = (service.getLogicClassData(taskno,termno,lgtimes,lgpagenum)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void delLogicClassData() {
		String taskno = request.getParameter("taskno");
		String stuno = request.getParameter("stuno");
		String termno = request.getParameter("termno");
		String result = "";
		if(taskno == null || termno == null || stuno == null) {
			ExecResult er = new ExecResult(false,"课次号或学期号或学号获取失败！");
			result = er.toString();
		} else {	
			BaseCourseWHService service = new BaseCourseWHService();
			result = (service.delLogicClassData(taskno,stuno,termno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void SearchlgClassStuData() {
		String termno = request.getParameter("termno");   
		String taskno = request.getParameter("taskno");   
		String result = "";
		if(taskno == null || termno == null) {
			ExecResult er = new ExecResult(false,"课次号或学期号获取失败！");
			result = er.toString();
		} else {	
			BaseCourseWHService service = new BaseCourseWHService();
			result = (service.SearchlgClassStuData(taskno,termno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void AddlgClassStuData() {
		String termno = request.getParameter("termno");   
		String stuno = request.getParameter("stuno");
		String taskno = request.getParameter("taskno");   
		String logicno = request.getParameter("logicno");   
		String logicname = request.getParameter("logicname");    
		String courseno = request.getParameter("courseno");
		String result = "";
		if(taskno == null || termno == null || stuno == null || logicno == null || logicname == null || courseno == null) {
			ExecResult er = new ExecResult(false,"该逻辑班级相关信息获取失败！");
			result = er.toString();
		} else {	
			BaseCourseWHService service = new BaseCourseWHService();
			result = (service.AddlgClassStuData(taskno,stuno,termno,logicno,logicname,courseno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void delClassData() {
		String termno = request.getParameter("termno");
		String taskno = request.getParameter("taskno");    
		String result = "";
		if(termno == null || taskno == null) {
			ExecResult er = new ExecResult(false,"学期号或课次号获取失败！");
			result = er.toString();
		} else {
			BaseCourseWHService service = new BaseCourseWHService();
			result = (service.delClassData(taskno,termno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getCourseTaskInfroData() {
		String termno = request.getParameter("termno");
		String taskno = request.getParameter("taskno");    
		String result = "";
		if(termno == null || taskno == null) {
			ExecResult er = new ExecResult(false,"学期号或课次号获取失败！");
			result = er.toString();
		} else {
			BaseCourseWHService service = new BaseCourseWHService();
			result = (service.getCourseTaskInfroData(taskno,termno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void delCourseTaskSche() {
		String taskno = request.getParameter("taskno");
		String scheno = request.getParameter("scheno");
		String result = "";
		if(taskno == null || scheno == null) {
			ExecResult er = new ExecResult(false,"课次号或节次号获取失败！");
			result = er.toString();
		} else {
			BaseCourseWHService service = new BaseCourseWHService();
			result = (service.delCourseTaskSche(taskno,scheno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getTeasClassesAllData() {
		String result = "";
		BaseCourseWHService service = new BaseCourseWHService();
		result = (service.getTeasClassesAllData()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void UpdCourseInfroData() {
		String taskno = request.getParameter("taskno");
		String termno = request.getParameter("termno");        
		String teano = request.getParameter("teano");
		String classno = request.getParameter("classno");
		String coursename = request.getParameter("coursename");
		String coursetype = request.getParameter("coursetype");    
		String courseweek = request.getParameter("courseweek");
		
		JSONObject courseInfo = (JSONObject)JSONObject.parse(request.getParameter("courseInfo"));
  		
		String result = "";   
		BaseCourseWHService service = new BaseCourseWHService();
		result = (service.UpdCourseInfroData(taskno,termno,teano,classno,coursename,coursetype,courseweek,courseInfo)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void InsCourseInforData() {
		String termno = request.getParameter("termno");
		String courseno = request.getParameter("courseno");
		String coursename = request.getParameter("coursename");
		String courseteano = request.getParameter("courseteano");
		String coursetype = request.getParameter("coursetype");
		String courseattr = request.getParameter("courseattr");
		String courseweek = request.getParameter("courseweek");
		String courseccount = request.getParameter("courseccount");
		String coursescount = request.getParameter("coursescount");
		String coursedep = request.getParameter("coursedep");
		
		JSONObject courseclassno = (JSONObject)JSONObject.parse(request.getParameter("courseclassno"));
		String courseScheString = request.getParameter("coursescheInfor"); 
		JSONObject coursescheInfor = null;
		if(!courseScheString.equals("{}")){   
			coursescheInfor = (JSONObject)JSONObject.parse(request.getParameter("coursescheInfor"));
		}
		System.out.println("aaa"+courseclassno);
		System.err.println("bbb"+coursescheInfor);      
		
		String result = "";
		BaseCourseWHService service = new BaseCourseWHService();
		result = (service.InsCourseInforData(termno,courseno,coursename,courseteano,coursetype,courseattr,courseweek,courseccount,coursescount,courseclassno,coursescheInfor,coursedep)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getSearchCourseData() {
		String depno = request.getParameter("depno");
		String termno = request.getParameter("termno");
		String searchval = request.getParameter("searchval");
		String pagenum = request.getParameter("pagenum");
		String times = request.getParameter("times");   		
		String result = "";
		if(depno == null || termno == null || searchval == null || pagenum == null || times == null) {
			ExecResult er = new ExecResult(false,"学期号或部门号或搜索值或分页号获取失败！");
			result = er.toString();
		} else {
			BaseCourseWHService service = new BaseCourseWHService();
			result = (service.getSearchCourseData(depno,termno,searchval,pagenum,times)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	public void importExcelBaseCourse() {
		ExecResult r = new ExecResult();
		BaseCourseWHService service = new BaseCourseWHService();
		String term_no = request.getParameter("term_no");
		String courseFilePath = request.getParameter("course_file_path");
		String result = "";
		// 0判断文件是否存在
		if (TypeUtils.isEmpty(courseFilePath)) {
			result +="导入异常，上传的excel表失败，请重新导入";
		}else{
			// 1解析导入课程为List
			List<ImportFileCourseEntityFinal> fileCourseEnts = QMExcelUtil.parseImportExcelFileToList(courseFilePath,ImportFileCourseEntityFinal.class);
			if (fileCourseEnts != null && fileCourseEnts.size() > 0) {
				 result = service.importExcelt(fileCourseEnts ,term_no);
			} else {
				result ="导入异常，Excel表内容可能为空，请重新导入";
			}
			if(result==""||result ==null){
				result ="数据插入成功";
			}
            r.setMessage(result);
		}
		try {
			response.getWriter().write(r.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	public void importExcelBaseLgCourse() {
		ExecResult r = new ExecResult();
		BaseCourseWHService service = new BaseCourseWHService();
		String term_no = request.getParameter("term_no");
		String lgStuFilePath = request.getParameter("course_file_path");
		String task_no = request.getParameter("task_no");
		String course_no = request.getParameter("course_no");
		String result = "";
		// 判断文件是否存在
		if (TypeUtils.isEmpty(lgStuFilePath)) {
			result +="导入异常，上传的excel表失败，请重新导入";
		} else {
			// 1解析导入学生为List
			List<ImportFileLgStuEntityFinal> fileLgstuEnts = QMExcelUtil.parseImportExcelFileToList(lgStuFilePath,ImportFileLgStuEntityFinal.class);
			if (fileLgstuEnts != null && fileLgstuEnts.size() > 0) {
				 result = service.importLgStuExcelt(fileLgstuEnts ,term_no,task_no,course_no);
			} else {
				result ="导入异常，Excel表内容可能为空，请重新导入";
			}
			if(result==""||result ==null){
				result ="插入成功";
			}
            r.setMessage(result);
		}
		System.out.println(result);
		try {
			response.getWriter().write(r.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
