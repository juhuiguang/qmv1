package com.service.master;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class View_stu_pjService {
	public ExecResult gettableinformationService(String dep_no,String term_no){
//		String sql="SELECT a.class_no,a.class_name,a.class_stu_amount,MIN(minpert) minpxperson FROM  base_classes a  LEFT JOIN   ( SELECT  a.term_no,a.class_no,a.task_no,a.course_name,a.course_scount, count(b.pj_no) minpert FROM  base_teach_task a   LEFT JOIN qm_stu_pj b   ON b.task_no=a.task_no WHERE  a.term_no=''{0}''  GROUP BY a.task_no) tb1 ON tb1.class_no=a.class_no WHERE a.dep_no=''{1}''  AND tb1.term_no=''{0}''  GROUP BY a.class_no";
		String sql = "SELECT a.class_no,a.class_name,MIN(minpert) minpxperson,e.class_stu_amount FROM base_classes a LEFT JOIN (SELECT  a.term_no,a.class_no,a.task_no,a.course_name,a.course_scount,COUNT(b.pj_no) minpert FROM base_teach_task a LEFT JOIN qm_stu_pj b ON b.task_no=a.task_no WHERE  a.term_no=''{0}'' GROUP BY a.task_no) tb1 ON tb1.class_no=a.class_no LEFT JOIN (SELECT class_no,COUNT(DISTINCT stu_no)AS class_stu_amount FROM base_term_student WHERE term_no=''{0}'' GROUP BY class_no)e ON e.class_no=a.class_no WHERE a.dep_no=''{1}'' AND tb1.term_no=''{0}''  GROUP BY a.class_no";
		String [] params=new String[] {term_no,dep_no};
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
//		String sql="SELECT a.class_no,a.task_no,d.class_name,c.teacher_name,a.course_name,a.course_type,d.class_stu_amount, COUNT(b.total) totalcount FROM base_teach_task a LEFT JOIN qm_stu_pj b ON a.task_no=b.task_no LEFT JOIN base_teacher c  ON a.teacher_no = c.teacher_no LEFT JOIN base_classes d ON  d.class_no=a.class_no WHERE  a.term_no = ''{1}'' AND a.class_no = ''{0}'' GROUP BY a.course_name,c.teacher_name";
		String sql = "SELECT a.class_no,a.course_name,a.course_type,c.teacher_name,a.task_no,d.class_name,COUNT(b.stu_no)AS totalcount,e.class_stu_amount FROM base_teach_task a LEFT JOIN qm_stu_pj b ON b.task_no=a.task_no LEFT JOIN base_teacher c ON c.teacher_no=a.teacher_no LEFT JOIN base_classes d ON d.class_no=a.class_no LEFT JOIN (SELECT class_no,COUNT(DISTINCT stu_no)AS class_stu_amount FROM base_term_student WHERE term_no=''{1}'' GROUP BY class_no)e ON e.class_no=a.class_no WHERE a.term_no=''{1}'' AND a.class_no=''{0}'' GROUP BY a.course_no,a.teacher_no";
		String [] params=new String[] {class_no,term_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	
	public ExecResult getsearchinformationService(String dep_no,String term_no, String class_name){
		String sql="SELECT a.class_no,a.class_name,a.class_stu_amount,MIN(minpert) minpxperson FROM  base_classes a "
				+ "LEFT JOIN  ( SELECT a.term_no,a.class_no,a.task_no,a.course_name,a.course_scount, COUNT(b.pj_no) minpert FROM  base_teach_task a   LEFT JOIN qm_stu_pj b   ON b.task_no=a.task_no WHERE  a.term_no=''{0}''  GROUP BY a.task_no ) tb1 "
				+ "ON tb1.class_no=a.class_no "
				+ "WHERE a.dep_no=''{1}'' AND tb1.term_no=''{0}''  AND a.`class_name` LIKE ''%{2}%'' GROUP BY a.class_no";
		String [] params=new String[] {term_no,dep_no,class_name};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}


	public ExecResult getwpjstusinfo(String class_no,String term_no,String task_no) {
		String sql="SELECT b.stu_name,b.stu_no FROM base_term_student a JOIN base_student b ON a.stu_no=b.stu_no AND a.`term_no`='"+term_no+"' LEFT JOIN qm_stu_pj c ON c.stu_no=b.stu_no  AND c.`task_no`='"+task_no+"' WHERE class_no='"+class_no+"' AND pj_no IS NULL";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null, " ");
		return result;
	}
	
}
