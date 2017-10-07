package com.service.teacher;
import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;
public class TeacherViewCommentService {
	public ExecResult getTermInf( ){
		String sql="SELECT term_name ,term_no ,term_status FROM base_term ORDER BY term_no desc";
		JSONResponse js=new JSONResponse();
		ExecResult result=js.getSelectResult(sql, null,"base_term");  
		return result; 
	}
	public ExecResult getTableInf(String term_no,String teacher_no ){    
		String sql=
/*				"SELECT tb1.* , tb2.class_stu_check FROM(SELECT a.course_name, b.class_name ,a.task_no,b.class_stu_amount "+
					"FROM base_teach_task a ,base_classes b  ,base_term_student d "+
					"WHERE a.teacher_no=''{1}'' AND a.term_no=''{0}'' AND a.class_no=b.class_no  AND d.class_no=b.class_no "+
					"GROUP BY a.course_name , b.class_name) tb1 LEFT JOIN "+
					"(SELECT task_no , COUNT(1) AS class_stu_check FROM qm_stu_pj GROUP BY task_no)AS tb2 ON tb2.task_no=tb1.task_no "+
					"UNION ALL "+
					"SELECT tb1.* , tb2.class_stu_check FROM (SELECT b.course_name ,  a.logic_name, a.task_no,COUNT(1)AS class_stu_amount "+
					"FROM base_class_logic a , base_teach_task b "+
					"WHERE b.teacher_no=''{1}'' AND b.task_no=a.task_no AND a.term_no=''{0}'' "+
					"GROUP BY a.task_no) AS tb1 LEFT JOIN "+
					"(SELECT task_no , COUNT(1) AS class_stu_check FROM qm_stu_pj GROUP BY task_no)AS tb2 ON tb2.task_no=tb1.task_no "+
					"ORDER BY class_stu_check DESC"; */   
				"SELECT a.course_name,b.class_name,a.task_no,b.class_stu_amount,IFNULL(c.pjamount,0) class_stu_check FROM base_teach_task a LEFT JOIN base_classes b ON b.class_no=a.class_no LEFT JOIN ( SELECT * FROM ( SELECT tb1.task_no,COUNT(DISTINCT tb1.stu_no) pjamount FROM qm_stu_pj tb1,base_teach_task tb2,base_term_student tb3,base_student tb4 WHERE tb1.task_no=tb2.task_no AND tb2.term_no=''{0}'' AND tb3.class_no=tb2.class_no AND tb1.stu_no=tb3.stu_no AND tb3.term_no=tb2.term_no AND tb4.stu_no=tb1.stu_no AND tb4.stu_status='1' AND tb2.teacher_no=''{1}'' GROUP BY tb1.task_no ) tb5 ) c ON a.task_no=c.task_no WHERE a.term_no=''{0}'' AND a.teacher_no=''{1}''";
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
