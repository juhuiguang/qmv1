package com.service.student;


import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class Student_kcb_Service {
	public ExecResult getStuClassnoService(String class_no,String term_no,String stu_no){
		String sql="SELECT a.`task_no`,b.`sche_set`,a.`course_name`,a.`course_week`,b.`sche_addr`,c.`teacher_name` ,d.total FROM base_teach_task  a   LEFT JOIN base_task_sche b  ON a.`task_no`=b.`task_no`   LEFT JOIN base_teacher c  ON c.teacher_no=a.`teacher_no`   LEFT JOIN qm_stu_pj d  ON d.task_no=a.task_no AND d.stu_no=''{0}''  WHERE a.class_no=''{1}'' AND a.term_no=''{2}'' GROUP BY b.sche_no  UNION   SELECT a.`task_no`,b.`sche_set`,e.`course_name`,e.`course_week`,b.`sche_addr`,c.`teacher_name` ,d.total FROM base_class_logic a  LEFT JOIN `base_teach_task` e ON e.task_no=a.task_no  LEFT JOIN base_task_sche b  ON a.`task_no`=b.`task_no`   LEFT JOIN base_teacher c  ON c.teacher_no=e.`teacher_no`   LEFT JOIN qm_stu_pj d  ON d.task_no=a.task_no AND d.stu_no=''{0}''   WHERE a.student_no=''{0}'' AND a.term_no=''{2}'' GROUP BY b.sche_no";
		String [] params=new String[] {stu_no,class_no,term_no};	
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_term_student");
		return result;
	}
	
	public ExecResult getclassinformationService(String class_no){
		String sql="  SELECT b.major_name FROM `base_classes` a,`base_major` b WHERE a.major_no=b.major_no AND a.class_no=''{0}''  GROUP BY a.class_no";
		String [] params=new String[] {class_no};	
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	
	public ExecResult getMoblieInfo(String class_no,String term_no,String stu_no){
		String sql="  SELECT a.task_no ,a.course_name,a.teacher_name,a.course_type,a.total,b.checkTime  FROM(SELECT a.`task_no`,b.`sche_set`,a.`course_name`,a.course_type,a.`course_week`,b.`sche_addr`,c.`teacher_name` ,d.total FROM base_teach_task  a    LEFT JOIN base_task_sche b  ON a.`task_no`=b.`task_no`    LEFT JOIN base_teacher c  ON c.teacher_no=a.`teacher_no`    LEFT JOIN qm_stu_pj d  ON d.task_no=a.task_no AND d.stu_no=''{2}''   WHERE a.class_no=''{0}'' AND a.term_no=''{1}'' GROUP BY b.sche_no   UNION    SELECT a.`task_no`,b.`sche_set`,e.`course_name`,e.course_type,e.`course_week`,b.`sche_addr`,c.`teacher_name` ,d.total  FROM base_class_logic a   LEFT JOIN `base_teach_task` e ON e.task_no=a.task_no   LEFT JOIN base_task_sche b  ON a.`task_no`=b.`task_no`    LEFT JOIN base_teacher c  ON c.teacher_no=e.`teacher_no`    LEFT JOIN qm_stu_pj d  ON d.task_no=a.task_no AND d.stu_no=''{2}''    WHERE a.student_no=''{2}'' AND a.term_no=''{1}'' GROUP BY b.sche_no) a LEFT JOIN (SELECT e.teacher_name,d.course_name,COUNT(*) checkTime FROM (`qm_stu_check_main` a,`qm_stu_check` b,base_teacher e) LEFT JOIN `base_task_sche` c ON c.sche_no = a.sche_no LEFT JOIN `base_teach_task` d ON d.task_no = c.task_no WHERE a.term_no=''{1}'' AND b.check_main_no=a.check_main_no AND b.stu_no=''{2}'' AND d.teacher_no = e.teacher_no  AND b.check_status!=''请假'' GROUP BY e.teacher_name ,d.course_name) b ON b.course_name = a.course_name AND b.teacher_name = a.teacher_name  GROUP BY a.task_no  ORDER BY CONVERT(a.teacher_name USING gbk) ";
		String [] params=new String[] {class_no,term_no,stu_no};	
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	
}




