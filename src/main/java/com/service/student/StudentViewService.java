package com.service.student;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class StudentViewService {

	public ExecResult getStuViewTable(String stuflag , String termflag) {
		// TODO Auto-generated method stub
/*		String sql="SELECT a.teacher_name,b.* FROM base_teacher a,base_teach_task b,base_term_student c WHERE b.class_no=c.class_no AND a.teacher_no=b.teacher_no AND c.stu_no='"+stuflag+"' AND b.term_no='"+termflag+"' AND c.term_no=b.term_no";
*/		
		String sql="SELECT tb6.* , g.pj_no FROM(SELECT IFNULL(teacher_name ,teacher_name_two)AS teacher_name , IFNULL(task_no ,task_no_two)AS task_no , IFNULL(course_name, course_name_two)AS course_name  FROM (SELECT * FROM (SELECT c.teacher_name , b.task_no ,b.course_name  FROM base_term_student a "+
						"JOIN  base_teach_task b ON a.class_no=b.class_no AND a.stu_no='"+stuflag+"' AND b.term_no="+termflag+" "+
						"JOIN base_teacher c ON c.teacher_no=b.teacher_no )tb1 "+
						"LEFT JOIN "+
						"(SELECT f.teacher_name AS teacher_name_two ,d.task_no AS task_no_two,e.course_name AS course_name_two FROM base_class_logic d  JOIN base_teach_task e ON e.task_no=d.task_no AND d.student_no='"+stuflag+"' AND d.term_no="+termflag+" JOIN base_teacher f ON f.teacher_no=e.teacher_no)tb2 "+
						"ON tb1.task_no=tb2.task_no_two "+
						"UNION ALL "+
						"SELECT * FROM (SELECT c.teacher_name , b.task_no ,b.course_name  FROM base_term_student a "+
						"JOIN  base_teach_task b ON a.class_no=b.class_no AND a.stu_no='"+stuflag+"' AND b.term_no="+termflag+" "+
						"JOIN base_teacher c ON c.teacher_no=b.teacher_no )tb3 "+
						"RIGHT JOIN "+ 
						"(SELECT  f.teacher_name AS teacher_name_two ,d.task_no AS task_no_two,e.course_name AS course_name_two  FROM base_class_logic d  JOIN base_teach_task e ON e.task_no=d.task_no AND d.student_no='"+stuflag+"' AND d.term_no="+termflag+" JOIN base_teacher f ON f.teacher_no=e.teacher_no)tb4 "+
						"ON tb3.task_no=tb4.task_no_two) tb5)tb6 "+
						"LEFT JOIN qm_stu_pj g ON tb6.task_no=g.task_no AND g.stu_no='"+stuflag+"' "+
						"GROUP BY task_no "+ 
						"ORDER BY task_no";
		
		JSONResponse jr=new JSONResponse(); 
		ExecResult result=jr.getSelectResult(sql, null,"base_teach_task");
		return result;
		
/*		这里是上面sql语句的另一种写法，于是下面的写法也要跟着变！*/
/*		String sql="SELECT a.teacher_name,b.* FROM base_teacher a,base_teach_task b,base_term_student c WHERE b.class_no=c.class_no AND a.teacher_no=b.teacher_no AND c.stu_no=''{0}'' AND b.term_no=''{1}'' AND c.term_no=b.term_no";
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, new String[]{stuflag,termflag},"base_teach_task");
		return result;*/	
	}


	
}
