package com.service.teacher;

import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class SupervisorMarkAddAction extends Action {

		public void getTeachers() {
			String supno = request.getParameter("supno");
			String depno = request.getParameter("depno");
			String termno = request.getParameter("termno");
			String result = "";
			SupervisorMarkAddService service = new SupervisorMarkAddService();
			if(supno == null || depno == null || termno == null) {
				ExecResult er = new ExecResult(false,"登录用户工号或院系编号或学期号获取失败！");
				result = er.toString();
			} else {	
					result = (service.getTeachers(supno,depno,termno)).toString();
			}
			try {
				response.getWriter().write(result);
			} catch (IOException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
		}
		
		public void getMyMarked(){
			String supno = request.getParameter("supno");
			String termno = request.getParameter("termno");
			String result = "";
			SupervisorMarkAddService service = new SupervisorMarkAddService();
			if(supno == null || termno == null) {
				ExecResult er = new ExecResult(false,"督学编号或学期号传入失败！");
				result = er.toString();
			} else {	
				result = (service.getMyMarkedTeacher(supno,termno)).toString();
			}
			
			try {
				response.getWriter().write(result);
			} catch (IOException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		
		public void getSupMarkAdd() {
			String supno = request.getParameter("supno");
			String teano = request.getParameter("teano");
			String termno = request.getParameter("termno");
			String type = request.getParameter("type");
			String result = "";
			SupervisorMarkAddService service = new SupervisorMarkAddService();
			if(supno == null || teano == null || termno == null) {
				ExecResult er = new ExecResult(false,"未传入当前督学教工号或教师编号！");
				result = er.toString();
			} else {	
				if(type.equals("add")){
					result = (service.getSupMarkAdd(supno,teano,termno)).toString();
				}else{
					result = (service.delSupMark(supno, teano, termno)).toString();
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
			SupervisorMarkAddService service = new SupervisorMarkAddService();
			result=(service.getAllTerm()).toString();
			try {
				response.getWriter().write(result);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		public void getAllDeps() {
			String result = "";
			SupervisorMarkAddService service = new SupervisorMarkAddService();
			result = (service.getAllDeps()).toString();
			try {
				response.getWriter().write(result);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
}
