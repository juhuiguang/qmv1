package com.service.teacher;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class TeacherListenTotalService {

	public Object getTeaLisInfor(String term_no, String dep_no) {
		// TODO Auto-generated method stub
		String sql = "";
		if(dep_no.equals("all")) {
			sql = "SELECT a.dep_no,a.dep_name,COUNT(DISTINCT b.teacher_no)AS zrs,g.tkzcs,h.tkrs,e.btkrs FROM base_department a LEFT JOIN qm_dep_teacher b ON b.dep_no=a.dep_no LEFT JOIN (SELECT c.dep_no,COUNT(DISTINCT a.teacher_no)AS tkrs FROM qm_master_listen a LEFT JOIN base_teach_task b ON b.task_no=a.task_no LEFT JOIN qm_dep_teacher c ON c.teacher_no=a.teacher_no WHERE b.term_no='"+term_no+"' AND c.term_no='"+term_no+"' GROUP BY c.dep_no)h ON h.dep_no=a.dep_no LEFT JOIN (SELECT c.dep_no,COUNT(DISTINCT b.teacher_no)AS btkrs FROM qm_master_listen a LEFT JOIN base_teach_task b ON b.task_no=a.task_no LEFT JOIN qm_dep_teacher c ON c.teacher_no=b.teacher_no WHERE b.term_no='"+term_no+"'  AND c.term_no='"+term_no+"' GROUP BY c.dep_no)e ON e.dep_no=a.dep_no LEFT JOIN (SELECT b.dep_no,COUNT(*) tkzcs FROM qm_master_listen a,qm_dep_teacher b,base_teach_task c WHERE a.teacher_no=b.teacher_no AND a.task_no=c.task_no AND c.term_no='"+term_no+"' AND b.term_no='"+term_no+"' GROUP BY b.dep_no)g ON g.dep_no=a.dep_no WHERE b.term_no='"+term_no+"' GROUP BY a.dep_no ORDER BY a.dep_no"; 
		} else {
			sql = "SELECT a.dep_no,a.dep_name,COUNT(DISTINCT b.teacher_no)AS zrs,g.tkzcs,h.tkrs,e.btkrs FROM base_department a LEFT JOIN qm_dep_teacher b ON b.dep_no=a.dep_no LEFT JOIN (SELECT c.dep_no,COUNT(DISTINCT a.teacher_no)AS tkrs FROM qm_master_listen a LEFT JOIN base_teach_task b ON b.task_no=a.task_no LEFT JOIN qm_dep_teacher c ON c.teacher_no=a.teacher_no WHERE b.term_no='"+term_no+"' AND c.term_no='"+term_no+"'  AND c.dep_no='"+dep_no+"' GROUP BY c.dep_no)h ON h.dep_no=a.dep_no LEFT JOIN (SELECT c.dep_no,COUNT(DISTINCT b.teacher_no)AS btkrs FROM qm_master_listen a LEFT JOIN base_teach_task b ON b.task_no=a.task_no LEFT JOIN qm_dep_teacher c ON c.teacher_no=b.teacher_no WHERE b.term_no='"+term_no+"'  AND c.term_no='"+term_no+"' AND c.dep_no='"+dep_no+"' GROUP BY c.dep_no)e ON e.dep_no=a.dep_no LEFT JOIN (SELECT b.dep_no,COUNT(*) tkzcs FROM qm_master_listen a,qm_dep_teacher b,base_teach_task c WHERE a.teacher_no=b.teacher_no AND a.task_no=c.task_no AND c.term_no='"+term_no+"' AND b.dep_no='"+dep_no+"' AND b.term_no='"+term_no+"' GROUP BY b.dep_no)g ON g.dep_no=a.dep_no WHERE a.dep_no='"+dep_no+"' AND b.term_no='"+term_no+"'";
		}
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_department");
		return result;
	}

	public Object getSinglDepLisInfor(String term_no, String dep_no) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.dep_no,b.dep_name,a.teacher_no,c.teacher_name,a.job_no,d.job_name,d.job_listen_times,h.grtkcs,g.bbrtkrs FROM qm_dep_teacher a LEFT JOIN base_department b ON b.dep_no=a.dep_no LEFT JOIN base_teacher c ON c.teacher_no=a.teacher_no LEFT JOIN qm_base_job d ON d.job_no=a.job_no LEFT JOIN (SELECT a.teacher_no,COUNT(*)AS grtkcs FROM qm_master_listen a LEFT JOIN qm_dep_teacher b ON a.teacher_no=b.teacher_no LEFT JOIN base_teach_task c ON a.task_no=c.task_no WHERE b.term_no='"+term_no+"' AND c.term_no='"+term_no+"' AND b.dep_no='"+dep_no+"' GROUP BY a.teacher_no)h ON h.teacher_no=a.teacher_no LEFT JOIN (SELECT b.teacher_no,COUNT(DISTINCT a.teacher_no)AS bbrtkrs FROM qm_master_listen a LEFT JOIN base_teach_task b ON b.task_no=a.task_no LEFT JOIN qm_dep_teacher c ON c.teacher_no=b.teacher_no WHERE b.term_no='"+term_no+"' AND c.term_no='"+term_no+"' AND c.dep_no='"+dep_no+"' GROUP BY b.teacher_no)g ON g.teacher_no=a.teacher_no WHERE a.dep_no='"+dep_no+"' AND a.term_no='"+term_no+"' GROUP BY a.teacher_no";
		JSONResponse jr = new JSONResponse();  
		ExecResult result = jr.getSelectResult(sql, null, "qm_dep_teacher");
		return result;
	}

	public Object getSinglDepTeaInfor(String term_no, String tea_no) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.total,a.jxjy,a.skpj,DATE_FORMAT(a.listen_time,'%Y-%m-%d') listen_time,c.teacher_name teaname,b.course_name FROM qm_master_listen a LEFT JOIN base_teach_task b ON b.task_no=a.task_no LEFT JOIN base_teacher c ON b.teacher_no=c.teacher_no WHERE a.teacher_no='"+tea_no+"' AND b.term_no='"+term_no+"'";
		JSONResponse jr = new JSONResponse();  
		ExecResult result = jr.getSelectResult(sql, null, "qm_master_listen");
		return result;
	}

	public Object getJobTeaLisInfor(String term_no) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.job_no,a.job_name,a.job_listen_times,COUNT(*)AS gjobrs,g.gjobtkcs,h.gjobtkrs FROM qm_base_job a LEFT JOIN qm_dep_teacher b ON b.job_no=a.job_no LEFT JOIN (SELECT c.job_no,COUNT(*)AS gjobtkcs FROM qm_master_listen a LEFT JOIN base_teach_task b ON b.task_no=a.task_no LEFT JOIN qm_dep_teacher c ON c.teacher_no=a.teacher_no WHERE b.term_no='"+term_no+"' AND c.term_no='"+term_no+"' GROUP BY c.job_no)g ON g.job_no=a.job_no LEFT JOIN (SELECT c.job_no,COUNT(DISTINCT a.teacher_no)AS gjobtkrs FROM qm_master_listen a LEFT JOIN base_teach_task b ON b.task_no=a.task_no LEFT JOIN qm_dep_teacher c ON c.teacher_no=a.teacher_no WHERE b.term_no='"+term_no+"' AND c.term_no='"+term_no+"' GROUP BY c.job_no)h ON h.job_no=a.job_no WHERE b.term_no='"+term_no+"' GROUP BY a.job_no";
		JSONResponse jr = new JSONResponse();  
		ExecResult result = jr.getSelectResult(sql, null, "qm_base_job");
		return result;
	}

	public Object getSinglJobLisInfor(String term_no, String job_no) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.job_no,b.job_name,a.teacher_no,c.teacher_name,d.dep_name,b.job_listen_times,g.grtkcs FROM qm_dep_teacher a LEFT JOIN qm_base_job b ON b.job_no=a.job_no LEFT JOIN base_teacher c ON c.teacher_no=a.teacher_no LEFT JOIN base_department d ON d.dep_no=a.dep_no LEFT JOIN (SELECT a.teacher_no,COUNT(*)AS grtkcs FROM qm_master_listen a LEFT JOIN base_teach_task b ON b.task_no=a.task_no LEFT JOIN qm_dep_teacher c ON c.teacher_no=a.teacher_no WHERE b.term_no='"+term_no+"' AND c.term_no='"+term_no+"' AND c.job_no='"+job_no+"' GROUP BY a.teacher_no)g ON g.teacher_no=a.teacher_no WHERE a.term_no='"+term_no+"' AND a.job_no='"+job_no+"'";
		JSONResponse jr = new JSONResponse();  
		ExecResult result = jr.getSelectResult(sql, null, "qm_dep_teacher");
		return result; 
	} 

}
