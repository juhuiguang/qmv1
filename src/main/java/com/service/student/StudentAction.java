package com.service.student;
import java.io.IOException;
import java.sql.ResultSet;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
public class StudentAction extends Action{
	public void getStuViewTable() {
		String stuflag = request.getParameter("stuno");
		String termflag = request.getParameter("termno");
		String result = "";
		if(stuflag == null || termflag == null) {
			ExecResult rs = new ExecResult(false,"学生学号或学期号获取错误！");
			result = rs.toString();
		} else {
			StudentViewService service = new StudentViewService();
			result = (service.getStuViewTable(stuflag, termflag)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
}
