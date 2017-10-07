package com.service.teacher;

import java.io.IOException;

import com.jhg.mvc.Action;

public class SupPostTeaManageAction extends Action {

	public void getPostTeaInfor(){
		String job_no = request.getParameter("job_no");
		String term_no = request.getParameter("term_no");
		String result = "";
		SupPostTeaManageService service = new SupPostTeaManageService();
		result = (service.getPostTeaInfor(job_no,term_no)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void DelSinglTeaPostD() {
		String job_no = request.getParameter("job_no");
		String term_no = request.getParameter("term_no");
		String tea_no = request.getParameter("tea_no");
		String result = "";
		SupPostTeaManageService service = new SupPostTeaManageService();
		result = (service.DelSinglTeaPostD(job_no,term_no,tea_no)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void AddSinglTeaPost() {
		String job_no = request.getParameter("job_no");
		String term_no = request.getParameter("term_no");
		String tea_no = request.getParameter("tea_no");
		String result = "";
		SupPostTeaManageService service = new SupPostTeaManageService();
		result = (service.AddSinglTeaPost(job_no,term_no,tea_no)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
