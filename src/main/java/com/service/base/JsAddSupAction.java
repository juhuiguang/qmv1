package com.service.base;
import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action; 
import com.service.base.bean.BaseTeacherEntity;
import com.service.teacher.Tea_check_class_situationService;
public class JsAddSupAction extends Action{
	public void getAddTeacher() {
		String result ="";
		String dep_no = request.getParameter("dep_no");
		JsAddSupService service = new JsAddSupService();
		if(dep_no.equals("sch")) dep_no="all";
			result = (service.getAddTeacher(dep_no)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public void postSup() {
		String result ="";
		String teacher_name = request.getParameter("teacher_name");
		String teacher_no = request.getParameter("teacher_no");
		String type = request.getParameter("type"); 
		String id = request.getParameter("id"); 
		JsAddSupService service = new JsAddSupService();
			result = (service.postSup(teacher_no,teacher_name,type,id)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
