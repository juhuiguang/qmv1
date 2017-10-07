package com.service.master;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class Checkteacherpxservice {

	public ExecResult gettermnoinformationService(){
		String sql="SELECT term_no,term_name FROM base_term ORDER BY term_no DESC";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"");
		return result;
	}
	
	public ExecResult gettableinformationService(String dep_no,String term_no){
		String sql="SELECT  a.class_no,a.`class_name`,ROUND(AVG(total),1) avgmark FROM base_classes a , base_teach_task b ,qm_tea_px c   WHERE a.class_isover!=1 AND a.dep_no=''{0}'' AND b.`term_no`=''{1}'' AND b.class_no=a.`class_no` AND c.`task_no`=b.`task_no`  GROUP BY class_name  ORDER BY  avgmark DESC";
		String [] params=new String[] {dep_no,term_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	
	public ExecResult getclassdetailinformation(String class_no,String term_no){
		String sql="SELECT c.class_name,d.teacher_name,a.course_name,b.total FROM base_teach_task a JOIN base_classes c ON c.class_no=a.`class_no` LEFT JOIN base_teacher d ON d.teacher_no=a.`teacher_no` LEFT JOIN qm_tea_px b ON b.`task_no`=a.task_no WHERE a.`class_no`=''{0}'' AND a.term_no=''{1}''";
		String [] params=new String[] {class_no,term_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}

	
	
	public ExecResult getdetailclassinformationService(String class_name,String term_no,String dep_no){
		String sql="SELECT a.class_no,a.`class_name`,ROUND(AVG(total),1) avgmark FROM base_classes a LEFT JOIN  base_teach_task b ON b.`class_no`=a.`class_no` LEFT JOIN qm_tea_px c ON c.`task_no`=b.`task_no` WHERE a.class_name LIKE ''%{0}%'' AND b.term_no=''{1}'' AND a.`dep_no`=''{2}'' GROUP BY a.`class_name`";
		String [] params=new String[] {class_name,term_no,dep_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
}
