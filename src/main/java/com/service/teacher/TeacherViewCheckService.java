package com.service.teacher;
import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;
public class TeacherViewCheckService {
	public ExecResult getTermInf( ){
		String sql="SELECT term_name ,term_no ,term_status FROM base_term ORDER BY term_no";
		JSONResponse js=new JSONResponse();
		ExecResult result=js.getSelectResult(sql, null,"base_term");  
		return result; 
	}
	public ExecResult getTableInf(String term_no,String teacher_no ){
		String sql="select a.course_name, b.class_name ,b.class_stu_amount ,c.task_no,count(1) as class_stu_check "+
				"from base_teach_task a ,base_classes b  ,qm_stu_pj c ,base_term_student d "+
				"where a.teacher_no=''{1}'' and a.term_no=''{0}'' and a.class_no=b.class_no and c.task_no=a.task_no and d.class_no=b.class_no  and d.stu_no=c.stu_no  "+
				"group by a.course_name , b.class_name  ";
		String [] params_=new String[] {term_no,teacher_no};
		JSONResponse js=new JSONResponse();  
		ExecResult result=js.getSelectResult(sql, params_,"qm_stu_pj");      
		return result; 
	}public ExecResult getTableDetail(String task_no ){
		String sql="SELECT jxpj , jxjy FROM qm_stu_pj WHERE task_no=''{0}'' AND NOT(jxpj IS NULL AND jxjy IS  NULL)";
		String [] params_=new String[] {task_no}; 
		JSONResponse js=new JSONResponse();  
		ExecResult result=js.getSelectResult(sql, params_,"qm_stu_pj");      
		return result; 
	}
}
