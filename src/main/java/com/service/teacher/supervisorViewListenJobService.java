package com.service.teacher;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class supervisorViewListenJobService {

	public Object getTypeJobXZ(String type, String termno) {
		// TODO Auto-generated method stub
		String sql = "SELECT b.job_name,COUNT(b.job_name) AS total FROM qm_master_listen a LEFT JOIN qm_dep_teacher c ON c.teacher_no=a.teacher_no LEFT JOIN qm_base_job b ON b.job_no=c.job_no LEFT JOIN base_teach_task d ON d.task_no=a.task_no WHERE c.term_no='"+termno+"' AND b.job_type='"+type+"' AND d.term_no='"+termno+"' GROUP BY b.job_name";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master_listen");
		return result;
	}

	public Object getDetailDataXZ(String termno, String jobname) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.teacher_no,d.teacher_name,b.term_no,COUNT(a.teacher_no) AS listentotal FROM qm_master_listen a LEFT JOIN qm_dep_teacher b ON b.teacher_no=a.teacher_no LEFT JOIN qm_base_job c ON c.job_no=b.job_no LEFT JOIN base_teacher d ON d.teacher_no=a.teacher_no LEFT JOIN base_teach_task e ON e.task_no=a.task_no WHERE c.job_name='"+jobname+"' AND b.term_no='"+termno+"' AND e.term_no='"+termno+"' GROUP BY a.teacher_no";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master_listen");
		return result;
	}

	public Object GetJobXZGr(String termno, String teano) {
		// TODO Auto-generated method stub
		String sql = "SELECT c.teacher_name,a.jxjy,a.skpj,a.total,DATE_FORMAT(a.listen_time,'%Y-%m-%d') listen_time,b.course_name FROM qm_master_listen a LEFT JOIN base_teach_task b ON a.task_no=b.task_no LEFT JOIN base_teacher c ON b.teacher_no=c.teacher_no WHERE a.teacher_no='"+teano+"' AND b.term_no='"+termno+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master_listen");
		return result;
	}

	public Object getDepData(String termno,String type) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.dep_no gid, a.dep_name gname, lj.listentotal AS listentotal FROM base_department a LEFT JOIN(SELECT b.dep_no,COUNT(1) listentotal FROM qm_master_listen a,qm_dep_teacher b,base_teach_task c,qm_base_job d WHERE a.teacher_no=b.teacher_no AND a.task_no=c.task_no AND c.term_no='"+termno+"' AND b.term_no='"+termno+"' AND b.job_no=d.job_no AND d.job_kh='1' AND job_type='"+type+"' GROUP BY b.dep_no)lj ON lj.dep_no=a.dep_no ORDER BY a.dep_no";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_department");
		return result;
	}


	public Object getDataJobJX(String type, String depno, String termno) {
		// TODO Auto-generated method stub
		String sql = "SELECT b.job_name,COUNT(b.job_name) AS total FROM qm_master_listen a LEFT JOIN qm_dep_teacher c ON c.teacher_no=a.teacher_no LEFT JOIN qm_base_job b ON b.job_no=c.job_no LEFT JOIN base_teach_task d ON d.task_no=a.task_no WHERE c.term_no='"+termno+"' AND b.job_type='"+type+"' AND d.term_no='"+termno+"' AND c.dep_no='"+depno+"' GROUP BY b.job_name,c.dep_no";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master_listen");
		return result;
	}

	public Object getDetailDataJX(String termno, String jobname, String depno) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.teacher_no,d.teacher_name,b.term_no,COUNT(a.teacher_no) AS listentotal FROM qm_master_listen a LEFT JOIN qm_dep_teacher b ON b.teacher_no=a.teacher_no LEFT JOIN qm_base_job c ON c.job_no=b.job_no LEFT JOIN base_teacher d ON d.teacher_no=a.teacher_no LEFT JOIN base_teach_task e ON e.task_no=a.task_no WHERE c.job_name='"+jobname+"' AND b.term_no='"+termno+"' AND e.term_no='"+termno+"' AND b.dep_no='"+depno+"' GROUP BY a.teacher_no";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master_listen");
		return result;
	}



}
