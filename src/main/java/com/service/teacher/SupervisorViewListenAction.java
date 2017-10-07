package com.service.teacher;

import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.student.studentMessengerMaintainService;

public class SupervisorViewListenAction extends Action {
	
	public void getSupViewListen() {
		String supno = request.getParameter("supno");
		String depno = request.getParameter("depno");
		String termno = request.getParameter("termno");
		String result = "";
		if(supno == null || depno == null) {
			ExecResult er = new ExecResult(false,"登录用户工号或院系编号获取错误！");
			result = er.toString();
		} else {	
			if(depno.equals("all")) {
				SupervisorViewListenService service = new SupervisorViewListenService();
				result = (service.getSupViewListen(supno,termno)).toString();
			} else {
				SupervisorViewListenService service = new SupervisorViewListenService();
				result = (service.getSupViewListenYX(supno,depno,termno)).toString();
			}	
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	public void getMasterViewListen() {
		String depno = request.getParameter("dep");
		String termno = request.getParameter("termno");
		String result = "";
		if(termno == null || depno == null) {
			ExecResult er = new ExecResult(false,"学期号或权限号获取错误！");
			result = er.toString();
		} else {	
				SupervisorViewListenService service = new SupervisorViewListenService();
				result = (service.getMasterViewListen(depno,termno)).toString();			
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
		
	public void getDepSupViewListenXQ(){
		String depname = request.getParameter("depname");
		String termno = request.getParameter("termno");
		String result = "";
		if(depname == null || termno == null) {
			ExecResult er = new ExecResult(false,"院系名称或学期号获取错误！");
			result = er.toString();
		} else {
			SupervisorViewListenService service = new SupervisorViewListenService();
			result = (service.getDepSupViewListenXQ(depname,termno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getDepSupViewListenGR(){
		String supno = request.getParameter("supno");
		String termno = request.getParameter("termno");
		String result = "";
		if(supno == null || termno == null) {
			ExecResult er = new ExecResult(false,"督学教工号或学期号获取错误！");
			result = er.toString();
		} else {
			SupervisorViewListenService service = new SupervisorViewListenService();
			result = (service.getDepSupViewListenGR(supno,termno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	public void getSupViewListenGR(){
		String depno = request.getParameter("depno");
		String teaname = request.getParameter("teaname");
		String termno = request.getParameter("termno");
		String result = "";
		if(depno == null || teaname == null || termno == null) {
			ExecResult er = new ExecResult(false,"院系号或教工姓名或学期号获取错误！");
			result = er.toString();
		} else {
			SupervisorViewListenService service = new SupervisorViewListenService();
			if(depno.equals("Sch")) {
				result = (service.getSupViewListenSchGR(depno,teaname,termno)).toString();
			} else {
				result = (service.getSupViewListenGR(depno,teaname,termno)).toString();
			}
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getAllTerm() {
		String result="";
		SupervisorViewListenService service = new SupervisorViewListenService();
		result=(service.getAllTerm()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}

