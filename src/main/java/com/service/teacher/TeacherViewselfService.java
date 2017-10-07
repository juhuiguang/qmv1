package com.service.teacher;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class TeacherViewselfService {
	public ExecResult getTermInf( ){
		String sql="SELECT term_name ,term_no ,term_status FROM base_term ORDER BY term_no desc";
		JSONResponse js=new JSONResponse();
		ExecResult result=js.getSelectResult(sql, null,"base_term");  
		return result; 
	}
	public ExecResult getTableInf(String term_no,String teacher_no ){
//		String sql="SELECT a.* , b.term_no ,b.course_type , b.course_name ,c.teacher_name , d.class_name FROM qm_master_listen a ,base_teach_task b , base_teacher c ,base_classes d WHERE d.class_no=b.class_no AND c.teacher_no=a.teacher_no AND a.task_no=b.task_no AND b.term_no=''{0}'' AND b.teacher_no=''{1}'' ORDER BY a.listen_time DESC";
		String sql = "SELECT a.* , b.term_no ,b.course_type , b.course_name ,c.teacher_name , d.class_name FROM qm_master_listen a LEFT JOIN base_teach_task b ON b.task_no=a.task_no LEFT JOIN base_teacher c ON c.teacher_no=a.teacher_no LEFT JOIN base_classes d ON d.class_no=b.class_no WHERE b.term_no=''{0}'' AND b.teacher_no=''{1}'' ORDER BY a.listen_time DESC";
		String [] params_=new String[] {term_no,teacher_no};
		JSONResponse js=new JSONResponse();  
		ExecResult result=js.getSelectResult(sql, params_,"qm_master_listen");      
		return result; 
	}
} 
  