package com.service.student;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class ClasscheckpxService {
	public ExecResult gettermnoinformationService(){
		String sql="SELECT term_no,term_name FROM base_term ORDER BY term_no DESC";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"");
		return result;
	}
	
	public ExecResult gettableinformationService(String class_no,String term_no){
		String sql="SELECT a.`class_name`,d.`teacher_name`,b.`course_name`,c.`total`,DATE_FORMAT(c.`px_time`,''%Y-%m-%d'') px_time FROM base_classes a LEFT JOIN base_teach_task b ON b.`class_no`=a.`class_no` LEFT JOIN qm_tea_px c ON c.`task_no`=b.`task_no` LEFT JOIN base_teacher d ON d.`teacher_no`=b.`teacher_no` WHERE a.class_no=''{0}'' AND b.term_no=''{1}''";
		String [] params=new String[] {class_no,term_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	
	
	public ExecResult getteaclassService(String teacher_no){
		String sql="SELECT class_no,class_name FROM base_classes WHERE  teacher_no=''{0}''";
		String [] params=new String[] {teacher_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	
	
	
	public ExecResult getstuclassService(String stu_no){
		String sql="SELECT class_no FROM base_classes WHERE  stu_no=''{0}''";
		String [] params=new String[] {stu_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	
	

	
}
