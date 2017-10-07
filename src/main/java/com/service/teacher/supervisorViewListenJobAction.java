package com.service.teacher;

import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class supervisorViewListenJobAction extends Action {

	public void getTypeJobXZ() {
		String type = request.getParameter("type");
		String termno = request.getParameter("termno");
		String result="";
		if(type == null || termno == null) {
			ExecResult er = new ExecResult(false,"类型号或学期号获取失败！");
			result = er.toString();
		} else {
			supervisorViewListenJobService service = new supervisorViewListenJobService();
			if(type.equals("xz")) {
				type="行政岗位";
			} else {
				type="教学岗位";
			}
			result = (service.getTypeJobXZ(type,termno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getDetailDataXZ() {
		String termno = request.getParameter("termno");
		String jobname = request.getParameter("jobname");
		String result="";
		if(jobname == null || termno == null) {
			ExecResult er = new ExecResult(false,"行政岗位名或学期号获取失败！");
			result = er.toString();
		} else {
			supervisorViewListenJobService service = new supervisorViewListenJobService();
			result = (service.getDetailDataXZ(termno,jobname)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void GetJobXZGr() {
		String termno = request.getParameter("termno");
		String teano = request.getParameter("teano");
		String result="";
		if(teano == null || termno == null) {
			ExecResult er = new ExecResult(false,"督导号或学期号获取失败！");
			result = er.toString();
		} else {
			supervisorViewListenJobService service = new supervisorViewListenJobService();
			result = (service.GetJobXZGr(termno,teano)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getDepData() {
		String depno = request.getParameter("depno");
		String termno = request.getParameter("termno");
		String type = request.getParameter("type");
		String result="";
		if(depno == null || termno == null || type == null) {
			ExecResult er = new ExecResult(false,"部门编号或学期号或类型号获取失败！");
			result = er.toString();
		} else {
			supervisorViewListenJobService service = new supervisorViewListenJobService();
			if(type.equals("xz")) {
				type="行政岗位";
			} else {
				type="教学岗位";
			}
			if(depno.equals("all")){
				result = (service.getDepData(termno,type)).toString();				
			} else {
				result = (service.getDataJobJX(type,depno,termno)).toString();
			}
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getDetailDataJX(){
		String termno = request.getParameter("termno");
		String jobname = request.getParameter("jobname");
		String depno = request.getParameter("depno");
		String result="";
		if(depno == null || termno == null || jobname == null) {
			ExecResult er = new ExecResult(false,"部门编号或学期号或教学岗位名获取失败！");
			result = er.toString();
		} else {
			supervisorViewListenJobService service = new supervisorViewListenJobService();
			result = (service.getDetailDataJX(termno,jobname,depno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
