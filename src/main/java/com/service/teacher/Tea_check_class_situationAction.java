package com.service.teacher;

import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class Tea_check_class_situationAction extends Action{
	public void getDepartmentListenmark() {
		String term_no=request.getParameter("term_no");
		String result ="";
		if(term_no==null)
		{
			ExecResult er=new ExecResult(false,"学期编号传入错误！");
			result=er.toString();
		}
		else{
		Tea_check_class_situationService service = new Tea_check_class_situationService();
			result = (service.getDepartmentListenmarkservice(term_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getDepartmentteassru_pj() {
		String term_no=request.getParameter("term_no");
		String result ="";
		if(term_no==null)
		{
			ExecResult er=new ExecResult(false,"学期编号传入错误！");
			result=er.toString();
		}
		else{
		Tea_check_class_situationService service = new Tea_check_class_situationService();
			result = (service.getDepartmentteassru_pjService(term_no)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}


    public void getDepartmentmaster_pj() {
        String term_no=request.getParameter("term_no");
        String dep_name=request.getParameter("dep_name");
        String result ="";
        if(term_no==null||dep_name==null)
        {
            ExecResult er=new ExecResult(false,"数据传入错误！");
            result=er.toString();
        }
        else{
            Tea_check_class_situationService service = new Tea_check_class_situationService();
            result = (service.getDepartmentmaster_pjService(term_no,dep_name)).toString();
        }
        try {
            response.getWriter().write(result);
        } catch (IOException e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }

    //获得督学评教  部门教师个人详细数据
    public void getTeacherMasterListenmark() {
        String term_no=request.getParameter("term_no");
        String dep_name=request.getParameter("dep_name");
        String teacher_name= request.getParameter("teacher_name");
        String result ="";
        if(term_no==null||dep_name==null)
        {
            ExecResult er=new ExecResult(false,"数据传入错误！");
            result=er.toString();
        }
        else{
            Tea_check_class_situationService service = new Tea_check_class_situationService();
            result = (service.getDepartmentPersonmaster_pjService(term_no,dep_name,teacher_name)).toString();
        }
        try {
            response.getWriter().write(result);
        } catch (IOException e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }

    //获得学生评教  部门教师个人详细数据
    public void getTeacherStudentListenmark() {
        String term_no=request.getParameter("term_no");
        String dep_name=request.getParameter("dep_name");
        String teacher_name= request.getParameter("teacher_name");
        String result ="";
        if(term_no==null||dep_name==null)
        {
            ExecResult er=new ExecResult(false,"数据传入错误！");
            result=er.toString();
        }
        else{
            Tea_check_class_situationService service = new Tea_check_class_situationService();
            result = (service.getDepartmentPersonstudent_pjService(term_no,dep_name,teacher_name)).toString();
        }
        try {
            response.getWriter().write(result);
        } catch (IOException e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }
    public void getDepartmentstudent_pj() {
        String term_no=request.getParameter("term_no");
        String dep_name=request.getParameter("dep_name");
        String result ="";
        if(term_no==null||dep_name==null)
        {
            ExecResult er=new ExecResult(false,"数据传入错误！");
            result=er.toString();
        }
        else{
            Tea_check_class_situationService service = new Tea_check_class_situationService();
            result = (service.getDepartmentstudent_pjService(term_no,dep_name)).toString();
            System.out.println("result"+result);
        }
        try {
            response.getWriter().write(result);
        } catch (IOException e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }
	
	public void getTermno() {
		String result ="";
		Tea_check_class_situationService service = new Tea_check_class_situationService();
			result = (service.getTermnoservice()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getTeacherlistendetails() {
		String dep_name=request.getParameter("dep_name");
		String mark=request.getParameter("mark");
		String term_no=request.getParameter("term_no");
		String result ="";
		Tea_check_class_situationService service = new Tea_check_class_situationService();
			result = (service.getTeacherlistendetailsservice(dep_name,mark,term_no)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	public void getStudentpxdetails() {
		String dep_name=request.getParameter("dep_name");
		String mark=request.getParameter("mark");
		String term_no=request.getParameter("term_no");
		String result ="";
		Tea_check_class_situationService service = new Tea_check_class_situationService();
			result = (service.getStudentpxdetailsservice(dep_name,mark,term_no)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
