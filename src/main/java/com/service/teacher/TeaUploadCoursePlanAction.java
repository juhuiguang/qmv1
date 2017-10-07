package com.service.teacher;

import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class TeaUploadCoursePlanAction extends Action {
	
	public void getTeaAllCourseData() {
		String termno = request.getParameter("termno");
		String teano = request.getParameter("teano");
		String result = "";
		if(termno == null || teano == null) {
			ExecResult er = new ExecResult(false,"学期号或登录教工号获取失败！");
			result = er.toString();
		} else {
			TeaUploadCoursePlanService service = new TeaUploadCoursePlanService();
			result = (service.getTeaLisInfor(termno,teano)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getSinglCourseAllFileData() {
		String termno = request.getParameter("termno");
		String courseno = request.getParameter("courseno");
		String teano = request.getParameter("teano");
		String result = "";
		if(termno == null || courseno == null || teano == null) { 
			ExecResult er = new ExecResult(false,"学期号或课程号或登录工号获取失败！");
			result = er.toString();
		} else {
			TeaUploadCoursePlanService service = new TeaUploadCoursePlanService();
			result = (service.getSinglCourseAllFileData(termno,courseno,teano)).toString();
		} 
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void DelSinglCourseFileData() {
		String termno = request.getParameter("termno");
		String courseno = request.getParameter("courseno");
		String teano = request.getParameter("teano");
		String fileno = request.getParameter("fileno");
		String filetype=request.getParameter("filetype");
		String result = "";
		if(termno == null || courseno == null || teano == null || fileno == null) { 
			ExecResult er = new ExecResult(false,"学期号或课程号或登录工号或授课计划id号获取失败！");
			result = er.toString();
		} else {
			TeaUploadCoursePlanService service = new TeaUploadCoursePlanService();
			if(filetype.equals("1")){
				result = (service.DelSinglCourseFileData(termno,courseno,teano,fileno)).toString();
			}else{
				result = (service.DelSinglCourseFileData2(termno,courseno,teano,fileno)).toString();
			}
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void AddThisCoursePlanInfor() {
		String termno = request.getParameter("termno");
		String courseno = request.getParameter("courseno");
		String teano = request.getParameter("teano");
		String fileno = request.getParameter("fileno");
		String fileurl = request.getParameter("fileurl");
		String filename = request.getParameter("filename");
		String filetype=request.getParameter("filetype");
		String result = "";
		if(termno == null || courseno == null || teano == null || fileno == null || fileurl == null || filename == null) { 
			ExecResult er = new ExecResult(false,"学期号或课程号或登录工号或授课计划id号或文件地址或文件名称获取失败！");
			result = er.toString();
		} else {
			TeaUploadCoursePlanService service = new TeaUploadCoursePlanService();
			if(filetype.equals("1")){
				result = (service.AddThisCoursePlanInfor(termno,courseno,teano,fileno,fileurl,filename)).toString();
			}else{
				result = (service.AddThisCoursePlanInfor2(termno,courseno,teano,fileno,fileurl,filename)).toString();
			}

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public void insertFile() {
		String term_no = request.getParameter("term_no");
		String teacher_no = request.getParameter("teacher_no");
		String file_name = request.getParameter("file_name");
		String course_no = request.getParameter("course_no");
		String url = request.getParameter("url");
		String filetype=request.getParameter("filetype");
		String result = "";
		if(term_no == null || teacher_no == null || file_name == null || course_no == null ||url==null) { 
			ExecResult er = new ExecResult(false,"参数传递失败！");
			result = er.toString();
		} else {
			TeaUploadCoursePlanService service = new TeaUploadCoursePlanService();
			if(filetype.equals("1")){
				result = (service.insertFile(term_no,file_name,teacher_no,course_no,"template"+url)).toString();
			}else{
				result = (service.insertFile2(term_no,file_name,teacher_no,course_no,"template"+url)).toString();
			}

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

}
