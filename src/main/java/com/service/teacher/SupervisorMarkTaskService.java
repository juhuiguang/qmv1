package com.service.teacher;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class SupervisorMarkTaskService {
	
	public Object getSupSearchTea(String teaname, String termno) {
		// TODO Auto-generated method stub
		String sql ="SELECT a.teacher_no,a.task_no,a.term_no,a.course_name,b.teacher_name FROM base_teach_task a LEFT JOIN base_teacher b ON a.teacher_no=b.teacher_no WHERE a.term_no='"+termno+"' AND b.teacher_name='"+teaname+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master");
		return result;
	}
	
	public Object getSupSearchCourse(String coursename, String termno) {
		// TODO Auto-generated method stub
		String sql ="SELECT a.teacher_no,a.task_no,a.term_no,a.course_name,b.teacher_name FROM base_teach_task a LEFT JOIN base_teacher b ON a.teacher_no=b.teacher_no WHERE a.term_no='"+termno+"' AND a.course_name='"+coursename+"' ";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master");
		return result;
	}

	public Object getSupMarkTask(String supno, String depno, String termno) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.task_no,a.term_no,a.course_name,COUNT(*) AS teatotal FROM base_teach_task a LEFT JOIN base_teacher b ON a.teacher_no=b.teacher_no WHERE b.dep_no='"+depno+"' AND term_no='"+termno+"' GROUP BY a.course_name";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master");
		return result;
	}

	public Object getSupMarkTaskXQ(String depno,String termno, String coursename) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.teacher_no,a.task_no,a.term_no,a.course_name,b.teacher_name FROM base_teach_task a LEFT JOIN base_teacher b ON a.teacher_no=b.teacher_no WHERE b.dep_no='"+depno+"' AND a.term_no='"+termno+"' AND a.course_name='"+coursename+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master");
		return result;
	}

	public Object getSupMarkTaskADD(String supno, String taskno, String termno) {
		// TODO Auto-generated method stub
		//取系统当前时间
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentdateString=sdf.format(new Date());
		
		String sql = "INSERT INTO qm_master_mark(teacher_no,task_no,term_no,mark_time) VALUES("+"'"+supno+"'"+","+"'"+taskno+"'"+","+"'"+termno+"'"+","+"'"+currentdateString+"'"+")";
		JSONResponse jr = new JSONResponse(); 
		ExecResult result = jr.getExecResult(sql, null, "", ""); 
		return result;
	}

}
