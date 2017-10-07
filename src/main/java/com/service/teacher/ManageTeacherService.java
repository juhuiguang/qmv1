package com.service.teacher;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class ManageTeacherService {
	public ExecResult gettermnoinformationService(){
		String sql="SELECT term_no,term_name FROM base_term ORDER BY term_no DESC";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"");
		return result;
	}
	
	
	public ExecResult getjobinformationService(){
		String sql="SELECT job_no,job_name FROM `qm_base_job` WHERE job_type='教学岗位'";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"");
		return result;
	}
	
	public ExecResult getTeacherInfTable(String dep_no/*,int pageindex, int pagelength*/,String term_no){
		/*int start = pageindex-1;
		int length = pagelength;*/
		String sql="SELECT b.`dep_name`,a.`teacher_no`,c.`teacher_name`,c.`teacher_status` ,d.job_name,d.job_no  FROM `qm_dep_teacher` a   LEFT JOIN base_department b ON b.`dep_no`=a.`dep_no`   LEFT JOIN `base_teacher` c ON c.teacher_no=a.`teacher_no`  LEFT JOIN `qm_base_job`d ON a.job_no=d.`job_no`  WHERE a.`dep_no`=''{0}'' AND a.term_no=''{1}''  ORDER BY CONVERT( teacher_name USING gbk ) COLLATE gbk_chinese_ci ASC";
		/*if (length > 0) {
			sql += " limit " + (start * length) + "," + length;
		}*/
		String [] params=new String[] {dep_no,term_no};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		System.out.println(result);
		if (result.getResult()==0 && result.getMessage().equals("数据为空")) {
			String insertsql = "INSERT INTO `qm_dep_teacher` (teacher_no,dep_no,term_no)  SELECT DISTINCT(teacher_no) teacher_no,dep_no,term_no FROM `base_teach_task` WHERE dep_no = ''{0}'' AND term_no = ''{1}''";
			ExecResult result1=jr.getExecResult(insertsql, params,"","");
			if (result1.getResult()==0) {
				result.setMessage("插入教师失败");
			}else{
				result= getTeacherInfTable(dep_no,term_no);
			}
		}
		return result;
	}

	
	public ExecResult getVoidteacherservice(String term_no,String dep_no){
		String sql=" SELECT a.teacher_no,a.teacher_name,c.dep_name FROM `base_teacher` a  LEFT JOIN `qm_dep_teacher` b ON b.`dep_no`=''{1}'' AND b.term_no=''{0}''  AND b.teacher_no = a.teacher_no  JOIN `base_department` c  WHERE a.dep_no=''{1}''  AND b.teacher_no IS NULL AND c.dep_no=a.dep_no  UNION   SELECT  a.`teacher_no`,b.`teacher_name`,c.dep_name FROM (`qm_dep_teacher` a,`base_department` c) LEFT JOIN `base_teacher` b  ON a.teacher_no = b.teacher_no WHERE a.dep_no = ''''  AND b.dep_no = c.dep_no AND a.term_no=''{0}''  ORDER BY CONVERT( teacher_name USING gbk ) COLLATE gbk_chinese_ci ASC";
		String [] params=new String[] {term_no,dep_no};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	
	public ExecResult changeteacherjobservice(String term_no,String teacher_no,String job_no){
		String sql="UPDATE `qm_dep_teacher` SET job_no = ''{2}'' WHERE term_no=''{0}'' AND teacher_no=''{1}'' ";
		String [] params=new String[] {term_no,teacher_no,job_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result= jr.getExecResult(sql,params, "修改成功","修改失败");
		return result;
	}
	
	
	public ExecResult searchteacherservice(String teacher_name,String term_no,String dep_no){
		String sql="SELECT * FROM (SELECT a.teacher_no,a.teacher_name,c.dep_name,c.`dep_no`FROM `base_teacher` a   LEFT JOIN `qm_dep_teacher` b ON  b.term_no=''{1}''  AND b.teacher_no = a.teacher_no  JOIN `base_department` c   WHERE  b.teacher_no IS NULL AND c.dep_no=a.dep_no    UNION    SELECT  a.`teacher_no`,b.`teacher_name`,c.dep_name,c.dep_no FROM (`qm_dep_teacher` a,`base_department` c) LEFT JOIN `base_teacher` b  ON a.teacher_no = b.teacher_no WHERE a.dep_no = ''''  AND b.dep_no = c.dep_no AND a.term_no=''{1}'' ) tb1 WHERE teacher_name LIKE ''%{0}%''";
		String [] params=new String[] {teacher_name,term_no,dep_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	public ExecResult searchlocalteacherservice(String teacher_name,String dep_no,String term_no){
		JSONResponse response=new JSONResponse();
		ExecResult result=null;
		String sqlSelect="SELECT job_no,job_name From `qm_base_job` ";
		ExecResult resultSelect=response.getSelectResult(sqlSelect,null,"");
		if(resultSelect.getData().size()!=0){
			String sql="SELECT a.`teacher_no`,b.`teacher_name`,b.`teacher_status`,c.job_no,c.job_name FROM `qm_dep_teacher` a  LEFT JOIN `base_teacher` b ON b.`teacher_no`=a.`teacher_no` LEFT JOIN `qm_base_job` c ON c.job_no=a.job_no WHERE b.`teacher_name`  LIKE ''%{0}%'' AND a.`dep_no`=''{1}'' AND a.term_no=''{2}''";
			String [] params=new String[] {teacher_name,dep_no,term_no};
			JSONResponse jr=new JSONResponse();
		    result=jr.getSelectResult(sql, params,"");
		}else{
			String sql="SELECT a.`teacher_no`,b.`teacher_name`,b.`teacher_status` FROM `qm_dep_teacher` a  LEFT JOIN `base_teacher` b ON b.`teacher_no`=a.`teacher_no` WHERE b.`teacher_name`  LIKE ''%{0}%'' AND a.`dep_no`=''{1}'' AND a.term_no=''{2}''";
			String [] params=new String[] {teacher_name,dep_no,term_no};
			JSONResponse jr=new JSONResponse();
		    result=jr.getSelectResult(sql, params,"");
		}
		return result;
	}
	public ExecResult addTeacher(String dep_no, String teacher_no,String term_no,String job_no){
		JSONResponse response=new JSONResponse();
		ExecResult result=null;
		String sqlSelect="SELECT teacher_no From qm_dep_teacher WHERE teacher_no=''{1}'' AND term_no=''{2}''";
		String [] params1=new String[] {dep_no,teacher_no,term_no};
		ExecResult resultSelect=response.getSelectResult(sqlSelect, params1,"");
		if(resultSelect.getData().size()!=0){
		String sql="UPDATE qm_dep_teacher SET dep_no=''{0}'' ,job_no='null' WHERE `teacher_no`=''{1}'' AND term_no=''{2}''";
		String [] params=new String[] {dep_no,teacher_no,term_no};
		result= response.getExecResult(sql,params, "添加成功","添加失败");
		}else{
			if(job_no==""){
				String sql="INSERT  INTO  qm_dep_teacher (term_no,dep_no,teacher_no,job_no) VALUES (''{2}'',''{0}'',''{1}'','null')";
				String [] params=new String[] {dep_no,teacher_no,term_no};
				result= response.getExecResult(sql,params, "添加成功","添加失败");
			}else{
				String sql="INSERT  INTO  qm_dep_teacher (term_no,dep_no,teacher_no,job_no) VALUES (''{2}'',''{0}'',''{1}'',''{3}'')";
				String [] params=new String[] {dep_no,teacher_no,term_no,job_no};
				result= response.getExecResult(sql,params, "添加成功","添加失败");
			}
		}
		return result;
	}
	
	
	public ExecResult removeTeacher(String teacher_no,String term_no){
		String sql="UPDATE qm_dep_teacher SET dep_no='''' WHERE `teacher_no`=''{0}'' AND term_no=''{1}''";
		String [] params=new String[] {teacher_no,term_no};
		JSONResponse response=new JSONResponse();
		ExecResult result= response.getExecResult(sql,params, "删除成功","删除失败");
		return result;
	}
}
