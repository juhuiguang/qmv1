package com.service.master;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class Master_view_stu_pjService {
	public ExecResult gettableinformationService(String dep_name,String term_no){
		String sql=" SELECT a.class_no,a.class_name,a.class_stu_amount,MIN(minpert) minpxperson FROM  base_classes a    LEFT JOIN    ( SELECT  a.term_no,a.class_no,a.task_no,a.course_name,a.course_scount, COUNT(b.pj_no) minpert FROM  base_teach_task a    LEFT JOIN qm_stu_pj b   ON b.task_no=a.task_no WHERE  a.term_no=''{0}''   GROUP BY a.task_no) tb1 ON tb1.class_no=a.class_no   LEFT JOIN  `base_department` b ON b.dep_no=a.dep_no  WHERE b.dep_name=''{1}''  AND tb1.term_no=''{0}''  GROUP BY a.class_no";
		String [] params=new String[] {term_no,dep_name};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	
	
	public ExecResult gettermnoinformationService(){
		String sql="SELECT term_no,term_name FROM base_term ORDER BY term_no DESC";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"");
		return result;
	}
	
	public ExecResult getmodeltableinformationService(String class_no,String term_no){
		String sql="SELECT a.class_no,a.task_no,d.class_name,c.teacher_name,a.course_name,a.course_type,d.class_stu_amount, COUNT(b.total) totalcount FROM base_teach_task a LEFT JOIN qm_stu_pj b ON a.task_no=b.task_no LEFT JOIN base_teacher c  ON a.teacher_no = c.teacher_no LEFT JOIN base_classes d ON  d.class_no=a.class_no WHERE  a.term_no = ''{1}'' AND a.class_no = ''{0}'' GROUP BY a.course_name,c.teacher_name";
		String [] params=new String[] {class_no,term_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	
	public ExecResult getsearchinformationService(String dep_name,String term_no, String class_name){
		String sql="SELECT a.class_no,a.class_name,a.class_stu_amount,MIN(minpert) minpxperson FROM  base_classes a   LEFT JOIN   (SELECT  a.term_no,a.class_no,a.task_no,a.course_name,a.course_scount, COUNT(b.pj_no) minpert FROM  base_teach_task a    LEFT JOIN qm_stu_pj b   ON b.task_no=a.task_no WHERE  a.term_no=''{0}''  GROUP BY a.task_no) tb1  ON tb1.class_no=a.class_no   LEFT JOIN `base_department` b ON b.dep_no=a.dep_no  WHERE b.dep_name=''{1}''  AND tb1.term_no=''{0}'' AND a.`class_name` LIKE ''%{2}%''  GROUP BY a.class_no";
		String [] params=new String[] {term_no,dep_name,class_name};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
}
