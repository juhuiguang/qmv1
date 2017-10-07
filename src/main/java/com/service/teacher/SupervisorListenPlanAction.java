package com.service.teacher;

import java.io.IOException;
import java.text.ParseException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class SupervisorListenPlanAction extends Action {

	 public void getSupViewMarkTea() {
		 String supno = request.getParameter("supno");
		 String termno = request.getParameter("termno");
		 String result = "";
		 if(supno == null || termno == null) {
			 ExecResult er = new ExecResult(false,"登录教工号或学期号获取失败！");
			 result = er.toString();
		 } else {
			SupervisorListenPlanService service = new SupervisorListenPlanService();
			result = (service.getSupViewMarkTea(supno,termno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	 }
	 
	 public void getSupViewMarkTeaTask() {
		 String teano = request.getParameter("teano");
		 String termno = request.getParameter("termno");
		 String result = "";
		 if(teano == null) {
			 ExecResult er = new ExecResult(false,"教师工号获取失败！");
			 result = er.toString();
		 } else {
			 SupervisorListenPlanService service = new SupervisorListenPlanService();
				result = (service.getSupViewMarkTeaTask(teano,termno)).toString();
		 }
		 try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	 }
	 
	 public void getSupPlanAdd() {		 
		 String supno = request.getParameter("supno");
		 String termno =request.getParameter("termno");
		 String taskno = request.getParameter("taskno");
		 String plantime = request.getParameter("plantime");
		 String currentweek = request.getParameter("currentweek");
		 String result = "";
		 if (supno == null || termno == null || taskno == null || plantime == null || currentweek == null) {
			 ExecResult er = new ExecResult(false,"登录工号或教学任务号或计划时间或当前周次获取失败！");
			 result = er.toString();		
		} else {
			 SupervisorListenPlanService service = new SupervisorListenPlanService();
			 result = (service.getSupPlanAdd(supno,termno,taskno,plantime,currentweek)).toString();
		 }
		 try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	 }
	 
	 public void getViewPlan() {
		 String supno = request.getParameter("supno");
		 String termno = request.getParameter("termno");
		 String result = "";
		 if(supno == null || termno == null) {
			 ExecResult er = new ExecResult(false,"登录教工号或学期号获取失败！");
			 result = er.toString();
		 } else {
			SupervisorListenPlanService service = new SupervisorListenPlanService();
			try {
				result = (service.getViewPlan(supno,termno)).toString();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	 }
	 
	 public void getDeletePlan() {
		 String planno = request.getParameter("planno");
		 String result = "";
		 if(planno == null) {
			 ExecResult er = new ExecResult(false,"听课计划号获取失败！");
			 result = er.toString();
		 } else {
			SupervisorListenPlanService service = new SupervisorListenPlanService();
			result = (service.getDeletePlan(planno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	 }
	 
	 public void getUpdataPlan() {
		 String planno = request.getParameter("planno");
		 String supno = request.getParameter("supno");
		 String termno =request.getParameter("termno");
		 String taskno = request.getParameter("taskno");
		 String plantime = request.getParameter("plantime");
		 String currentweek = request.getParameter("currentweek");
		 String result = "";
		 if (planno == null || supno == null || termno == null || taskno == null || plantime == null || currentweek == null) {
			 ExecResult er = new ExecResult(false,"计划编号或登录工号或教学任务号或计划时间或当前周次获取失败！");
			 result = er.toString();		
		} else {
			 SupervisorListenPlanService service = new SupervisorListenPlanService();
			 result = (service.getUpdataPlan(planno,supno,termno,taskno,plantime,currentweek)).toString();
		 }
		 try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	 }
}
