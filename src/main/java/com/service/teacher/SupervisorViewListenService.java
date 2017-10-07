package com.service.teacher;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class SupervisorViewListenService {

	public Object getSupViewListen(String supno,String termno) {
		// TODO Auto-generated method stub
/*		String sql = "SELECT a.teacher_no,lj.teacher_name,lj.dep_no,lj1.dep_name,COUNT(a.listen_no) AS listentotal FROM qm_master_listen a LEFT JOIN base_teacher lj ON lj.teacher_no=a.teacher_no LEFT JOIN base_department lj1 ON lj.dep_no=lj1.dep_no GROUP BY teacher_no,lj.teacher_name,lj.dep_no,lj1.dep_name";
*/		
		//该条语句没有去除校领导
	 /*String sql = "SELECT "+
							"a.dep_no gid, "+
							"a.dep_name gname, "+
							"lj.listentotal AS listentotal "+ 
							"FROM "+
							 " base_department a "+ 
							 "LEFT JOIN( "+
							 "SELECT b.dep_no,COUNT(1) listentotal FROM qm_master_listen a,base_teacher b,base_teach_task c  "+
							 "WHERE a.teacher_no=b.teacher_no AND a.task_no=c.task_no AND c.term_no='"+termno+"' "+
							 "GROUP BY b.dep_no) lj "+
							 "ON lj.dep_no=a.dep_no "+
							 "ORDER BY a.dep_no";*/
		
		String sql = "SELECT a.dep_no gid, a.dep_name gname, lj.listentotal AS listentotal FROM base_department a LEFT JOIN( SELECT b.dep_no,COUNT(1) listentotal FROM qm_master_listen a,base_teacher b,base_teach_task c ,qm_master d WHERE a.teacher_no=b.teacher_no AND a.task_no=c.task_no AND c.term_no='"+termno+"' AND d.teacher_no = a.teacher_no AND d.master_type='院系督学' GROUP BY b.dep_no ) lj ON lj.dep_no=a.dep_no " +
				" WHERE a.dep_no IN(SELECT DISTINCT dep_no FROM base_teacher WHERE teacher_no IN(SELECT DISTINCT teacher_no FROM qm_master WHERE qm_master.`master_status`='1' AND master_type='院系督学')) " +
				"ORDER BY a.dep_no";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master");
		return result;
	}

	public Object getSupViewListenYX(String supno, String depno, String termno) {
		// TODO Auto-generated method stub
/*		String sql = "SELECT a.teacher_no,lj.teacher_name,lj.dep_no,lj1.dep_name,COUNT(a.listen_no) AS listentotal FROM qm_master_listen a LEFT JOIN base_teacher lj ON lj.teacher_no=a.teacher_no LEFT JOIN base_department lj1 ON lj.dep_no=lj1.dep_no WHERE lj.dep_no='"+depno+"' GROUP BY teacher_no,lj.teacher_name,lj.dep_no,lj1.dep_name";
*/		
/*		String sql = "SELECT a.teacher_no gid,lj.teacher_name gname,lj.dep_no,lj1.dep_name,c.term_no term,COUNT(a.listen_no) AS listentotal FROM qm_master_listen a LEFT JOIN base_teacher lj ON lj.teacher_no=a.teacher_no LEFT JOIN base_department lj1 ON lj.dep_no=lj1.dep_no LEFT JOIN base_teach_task c ON c.task_no= a.task_no WHERE lj.dep_no='"+depno+"' AND c.term_no='"+termno+"' GROUP BY a.teacher_no,lj.teacher_name,lj.dep_no,lj1.dep_name,c.term_no";
*/		
		String sql = "SELECT a.teacher_no gid,lj.teacher_name gname,lj.dep_no,lj1.dep_name,c.term_no term,COUNT(a.listen_no) AS listentotal FROM qm_master_listen a LEFT JOIN base_teacher lj ON lj.teacher_no=a.teacher_no LEFT JOIN base_department lj1 ON lj.dep_no=lj1.dep_no LEFT JOIN base_teach_task c ON c.task_no= a.task_no LEFT JOIN qm_master b ON b.teacher_no= a.teacher_no WHERE lj.dep_no='"+depno+"' AND c.term_no='"+termno+"' AND b.master_type='院系督学' GROUP BY a.teacher_no,lj.teacher_name,lj.dep_no,lj1.dep_name,c.term_no";
		JSONResponse jr = new JSONResponse();
		ExecResult result2 = jr.getSelectResult(sql, null, "qm_master");
		return result2;
	}


	public Object getDepSupViewListenXQ(String depname,String termno) {
		// TODO Auto-generated method stub
//		String sql = "SELECT a.teacher_no,c.teacher_name,COUNT(*) AS suptotal FROM qm_master_listen a,base_teach_task b,base_teacher c,base_department d WHERE a.task_no= b.task_no AND b.term_no='"+termno+"' AND a.teacher_no=c.teacher_no AND c.dep_no=d.dep_no AND d.dep_name='"+depname+"' GROUP BY c.teacher_name";
		String sql = "SELECT a.teacher_no,c.teacher_name,COUNT(*) AS suptotal  FROM qm_master_listen a,base_teach_task b,base_teacher c,base_department d,qm_master e WHERE a.task_no= b.task_no AND b.term_no='"+termno+"' AND a.teacher_no=c.teacher_no AND c.dep_no=d.dep_no AND d.dep_name='"+depname+"' AND e.teacher_no=a.teacher_no AND e.master_type='院系督学' GROUP BY c.teacher_name";
		JSONResponse jr = new JSONResponse();
		ExecResult result2 = jr.getSelectResult(sql, null, "qm_master");
		return result2;
	}

	public Object getDepSupViewListenGR(String supno,String termno) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.total,a.jxjy,a.skpj,DATE_FORMAT(a.listen_time,'%Y-%m-%d') listen_time,c.teacher_name teaname,b.course_name FROM qm_master_listen a LEFT JOIN base_teach_task b ON b.task_no=a.task_no LEFT JOIN base_teacher c ON b.teacher_no=c.teacher_no WHERE a.teacher_no='"+supno+"' AND b.term_no='"+termno+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result2 = jr.getSelectResult(sql, null, "qm_master");
		return result2;
	}

	public Object getSupViewListenGR(String depno, String teaname,String termno) {
		// TODO Auto-generated method stub
		String sql ="SELECT d.teacher_name,c.course_name,a.jxjy,a.skpj,a.total,DATE_FORMAT(a.listen_time,'%Y-%m-%d') listen_time FROM qm_master_listen a LEFT JOIN base_teacher b ON a.teacher_no=b.teacher_no LEFT JOIN base_teach_task c ON c.task_no = a.task_no LEFT JOIN base_teacher d ON d.teacher_no=c.teacher_no WHERE b.teacher_name='"+teaname+"' AND b.dep_no='"+depno+"'AND c.term_no='"+termno+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result2 = jr.getSelectResult(sql, null, "qm_master");
		return result2;
	}
	
	public Object getAllTerm() {
		// TODO Auto-generated method stub
		String sql="SELECT term_no,term_name FROM base_term";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"");
		return result;
	}

	public Object getMasterViewListen(String depno, String termno) {
		// TODO Auto-generated method stub
/*		String sql = "SELECT a.teacher_no gid,lj.teacher_name gname,lj.dep_no,lj1.dep_name,c.term_no term,COUNT(a.listen_no) AS listentotal FROM qm_master_listen a LEFT JOIN base_teacher lj ON lj.teacher_no=a.teacher_no LEFT JOIN base_department lj1 ON lj.dep_no=lj1.dep_no LEFT JOIN base_teach_task c ON c.task_no= a.task_no LEFT JOIN qm_master b ON b.teacher_no= a.teacher_no WHERE c.term_no='"+termno+"' AND b.master_type='校级督学' GROUP BY a.teacher_no,lj.teacher_name,lj.dep_no,lj1.dep_name,c.term_no";
*/		String sql = "SELECT a.teacher_no gid,b.teacher_name gname,lj.listentotal AS listentotal FROM qm_master a LEFT JOIN (SELECT a.teacher_no,COUNT(a.listen_no) AS listentotal FROM qm_master_listen a,base_teacher b,base_teach_task c ,qm_master d WHERE a.teacher_no=b.teacher_no AND a.task_no=c.task_no AND c.term_no='"+termno+"' AND d.teacher_no = a.teacher_no AND d.master_type='校级督学' GROUP BY a.teacher_no)lj ON lj.teacher_no=a.teacher_no LEFT JOIN base_teacher b ON b.teacher_no=a.teacher_no LEFT JOIN base_department c ON c.dep_no=b.dep_no WHERE a.master_type='校级督学' ORDER BY a.teacher_no";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"");   
		return result;
	}

	public Object getSupViewListenSchGR(String depno, String teaname,
			String termno) {
		// TODO Auto-generated method stub
		String sql = "SELECT d.teacher_name,c.course_name,a.jxjy,a.skpj,a.total,DATE_FORMAT(a.listen_time,'%Y-%m-%d') listen_time FROM qm_master_listen a LEFT JOIN base_teach_task c ON c.task_no = a.task_no LEFT JOIN base_teacher d ON d.teacher_no=c.teacher_no WHERE a.teacher_no='"+teaname+"' AND c.term_no='"+termno+"'";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"");
		return result;
	}	

}
