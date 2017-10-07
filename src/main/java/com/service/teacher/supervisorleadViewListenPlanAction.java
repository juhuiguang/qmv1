package com.service.teacher;

import java.io.IOException;
import java.text.ParseException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class supervisorleadViewListenPlanAction extends Action {

	public void getSupDep() {
		String supno = request.getParameter("supno");
		String result = "";
		SupervisorleadViewListenPlanService service = new SupervisorleadViewListenPlanService();
		if(supno == null) {
			ExecResult er = new ExecResult(false,"登录用户工号获取失败！");
			result = er.toString();
		} else {	
				result = (service.getSupDep(supno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getAllDepPlan() throws ParseException {
		String supbj = request.getParameter("supbj");
		String depno = request.getParameter("depno");
		String termno = request.getParameter("termno");
		String weekbj = request.getParameter("weekbj");
		String result="";
		if(supbj == null || termno == null || weekbj == null || depno == null) {
			ExecResult er = new ExecResult(false,"标记号或学期号或周数号或院系号获取失败！");
			result = er.toString();
		} else {	
			SupervisorleadViewListenPlanService service = new SupervisorleadViewListenPlanService();
			if(Integer.parseInt(weekbj) >=1 && Integer.parseInt(weekbj) <= 18) {
				result = (service.getAllDepPlanWeek(supbj,weekbj,termno,depno)).toString();
			} else {
				result = (service.getAllDepPlan(supbj,termno,depno)).toString();
			}				
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	public void getSupPlanCount(){
		String depno = request.getParameter("depno");
		String termno = request.getParameter("termno");
		String result = "";
		SupervisorleadViewListenPlanService service = new SupervisorleadViewListenPlanService();
		if(depno == null || termno == null) {
			ExecResult er = new ExecResult(false,"登录用户工号或学期号获取失败！");
			result = er.toString();
		} else {	
				result = (service.getSupPlanCount(depno,termno)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
