package com.service.base;

import java.io.IOException;

import com.jhg.mvc.Action;

public class BaseCheckAction extends Action{
	public void getAllInfo(){
		String result=""; 
		BaseCheckService service=new BaseCheckService();
		String term_no = request.getParameter("term_no");
		String choose_week =request.getParameter("choosedweek");
		/*System.out.println(term_no);
		System.out.println(choose_week);*/
		String schoolFlag = request.getParameter("schoolFlag");
		result=(service.getAllInfo(term_no,choose_week,schoolFlag)).toString();
		try { 
			response.getWriter().write(result); 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getDepDetail(){
		String result=""; 
		BaseCheckService service=new BaseCheckService();
		String dep_no = request.getParameter("dep_no");
		String term_no = request.getParameter("term_no");
		String choose_week =request.getParameter("choosedweek");
		String schoolFlag = request.getParameter("schoolFlag");
		result=(service.getDepDetail(dep_no ,term_no,choose_week,schoolFlag)).toString();
		System.out.println(result);
		try { 
			response.getWriter().write(result); 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getTeaDetail(){
		String result=""; 
		BaseCheckService service=new BaseCheckService();
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no");
		result=(service.getTeaDetail(teacher_no ,term_no)).toString();
		try { 
			response.getWriter().write(result); 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void getTeaDetailInfo(){
		String result=""; 
		BaseCheckService service=new BaseCheckService();
		String sche_no = request.getParameter("sche_no");
		result=(service.getTeaDetailInfo(sche_no)).toString();
		try { 
			response.getWriter().write(result); 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
