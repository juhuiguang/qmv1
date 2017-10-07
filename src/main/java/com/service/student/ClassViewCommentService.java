package com.service.student;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;
public class ClassViewCommentService {
	
	public ExecResult getTermInf( ){
		String sql="SELECT term_name ,term_no ,term_status FROM base_term ORDER BY term_no desc";
		JSONResponse js=new JSONResponse();
		ExecResult result=js.getSelectResult(sql, null,"base_term");  
		return result; 
	}
	
	public ExecResult getClassPJD(String termno,String userno, String flag){
		String sql = "";  
		//信息员
		if(flag.equals("0")) {   
			sql = "SELECT a.task_no,a.course_name,a.teacher_no,b.class_no,d.`teacher_name`,b.`class_stu_amount`,IFNULL(c.pjamount,0) pj_count FROM base_teach_task a LEFT JOIN base_classes b ON b.class_no=a.`class_no` LEFT JOIN base_teacher d ON d.`teacher_no`=a.`teacher_no` LEFT JOIN ( SELECT * FROM ( SELECT tb1.task_no,COUNT(DISTINCT tb1.`stu_no`) pjamount FROM qm_stu_pj tb1,base_teach_task tb2,base_term_student tb3 WHERE tb1.`task_no`=tb2.`task_no` AND tb2.term_no='"+termno+"' AND tb3.`class_no`=tb2.`class_no` AND tb1.`stu_no`=tb3.`stu_no` AND tb3.`term_no`=tb2.`term_no` AND tb2.`class_no`=(SELECT class_no FROM base_classes WHERE stu_no='"+userno+"') GROUP BY tb1.task_no ) tb4 ) c ON a.task_no=c.`task_no`  WHERE a.term_no='"+termno+"' AND a.class_no=(SELECT class_no FROM base_classes WHERE stu_no='"+userno+"')";
		//班主任
		} else if(flag.equals("1")) {
		    sql="SELECT a.task_no,a.course_name,a.teacher_no,b.class_no,d.`teacher_name`,b.`class_stu_amount`,IFNULL(c.pjamount,0) pj_count FROM base_teach_task a "
				+ "LEFT JOIN base_classes b ON b.class_no=a.`class_no` "
				+ "LEFT JOIN base_teacher d ON d.`teacher_no`=a.`teacher_no` "
				+ "LEFT JOIN ( "
				+ "SELECT * FROM ( "
				+ "SELECT tb1.task_no,COUNT(DISTINCT tb1.`stu_no`) pjamount FROM qm_stu_pj tb1,base_teach_task tb2,base_term_student tb3 WHERE tb1.`task_no`=tb2.`task_no` AND tb2.term_no='"+termno+"' "
				+ "AND tb3.`class_no`=tb2.`class_no` "
				+ "AND tb1.`stu_no`=tb3.`stu_no` "
				+ "AND tb3.`term_no`=tb2.`term_no` "
				+ "AND tb2.`class_no`='"+userno+"' "
				+ "GROUP BY tb1.task_no "
				+ ") tb4 "
				+ ") c "
				+ "ON a.task_no=c.`task_no` "
				+ " WHERE a.term_no='"+termno+"' AND a.class_no='"+userno+"'";
		}		
		JSONResponse js=new JSONResponse();  
		ExecResult result=js.getSelectResult(sql, null,"qm_stu_pj");       
		return result; 
	}
	
	public ExecResult getClassPJDetailD(String taskno ,String classno,String termno){
		String sql="SELECT b.stu_name , b.stu_no FROM base_term_student a JOIN base_student b ON a.stu_no=b.stu_no and a.term_no=''{2}'' LEFT JOIN qm_stu_pj c ON c.stu_no=b.stu_no  AND c.task_no=''{0}'' WHERE class_no=''{1}'' AND  pj_no IS NULL AND b.stu_status='1'";
		String [] params_=new String[] {taskno,classno,termno}; 
		JSONResponse js=new JSONResponse();  
		ExecResult result=js.getSelectResult(sql, params_,"qm_stu_pj");       
		return result; 
	}
	
	public Object getClasses(String teano) {
		// TODO Auto-generated method stub
		String sql = "SELECT class_no,class_name FROM base_classes WHERE teacher_no='"+teano+"' OR stu_no='"+teano+"'"; 
		JSONResponse jr=new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_classes");
		return result;
	}
}
