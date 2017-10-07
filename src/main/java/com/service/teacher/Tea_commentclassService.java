package com.service.teacher;

import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class Tea_commentclassService {
	public ExecResult gettableinformationService(String teacher_no,String term_no){
	//	String sql="SELECT  a.course_scount,a.task_no,a.course_name,b.teacher_name,c.class_name ,c.`class_no`FROM base_teach_task a  LEFT JOIN base_teacher b  ON b.teacher_no=a.teacher_no  LEFT JOIN base_classes c  ON c.class_no=a.class_no  WHERE  a.teacher_no=''{0}'' AND a.term_no=''{1}'' ";
		String sql = "SELECT d.course_scount,a.task_no,a.course_name,b.teacher_name,c.class_name ,c.class_no FROM base_teach_task a LEFT JOIN base_teacher b  ON b.teacher_no=a.teacher_no LEFT JOIN base_classes c  ON c.class_no=a.class_no LEFT JOIN (SELECT COUNT(DISTINCT a.stu_no)AS course_scount,b.class_no FROM base_term_student a LEFT JOIN base_teach_task b ON b.class_no=a.class_no WHERE b.teacher_no=''{0}'' AND a.term_no=''{1}'' AND b.term_no=''{1}'' GROUP BY a.class_no)d ON d.class_no=a.class_no WHERE a.teacher_no=''{0}'' AND a.term_no=''{1}''";
		String [] params=new String[] {teacher_no,term_no};	
		JSONResponse jr=new JSONResponse();  
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	
	public ExecResult getPXinformationService(String teacher_no,String term_no){
		String sql="SELECT b.`task_no`,DATE_FORMAT(a.`px_time`,''%Y-%m-%d'') px_time FROM qm_tea_px a  LEFT JOIN base_teach_task b  ON a.`task_no`=b.`task_no`  WHERE b.`teacher_no`=''{0}''  AND b.`term_no`=''{1}''";
		String [] params=new String[] {teacher_no,term_no};	
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	
	public ExecResult getclassmarkService(String task_no){
		String sql="SELECT *FROM qm_tea_px WHERE task_no=''{0}''";
		String [] params=new String[] {task_no};	
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	
	public ExecResult getclassmarkperService(){	
		String sql="SELECT LOWER(rule_field) rule_field FROM `qm_rule` WHERE rule_status='1' AND rule_version_flag='PJ_PX'";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql,null,"");
		return result;
	}
	
	
	public ExecResult loadtableService(String flag){
		String sql="SELECT  rule_title,rule_content,LOWER(rule_field) rule_field,rule_goal FROM qm_rule WHERE rule_version_flag=''{0}'' AND rule_status=''1''";
		String [] params=new String[] {flag};	
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"");
		return result;
	}
	
	public ExecResult postListen(Map<String,String> param){
		String fields=param.get("fields");
		String sql="insert into qm_tea_px (task_no,"+fields+",total,xxjy) values "+ "(";
		sql+=param.get("task_no")+",";
		String [] fieldsarr=fields.split(",");
		for(int i=0;i<fieldsarr.length;i++){
			sql+=param.get(fieldsarr[i])+",";
		}
		sql+=param.get("total")+",";
		sql+="'"+param.get("xxjy")+"')";
		JSONResponse response=new JSONResponse();
		ExecResult result= response.getExecResult(sql, null, "听课打分成功","听课打分失败");
		String sqlT="SELECT a.course_name,b.teacher_name,c.class_name,c.teacher_no,d.teacher_name main_tea FROM `base_teach_task` a  LEFT JOIN `base_teacher` b ON a.teacher_no = b.`teacher_no` LEFT JOIN `base_classes` c ON a.class_no = c.class_no  LEFT JOIN `base_teacher` d ON d.teacher_no = c.teacher_no WHERE a.task_no= '"+param.get("task_no")+"'";
		ExecResult result2 = response.getSelectResult(sqlT, null, null);
		if(result2.getResult()==1){
			result.setData(result2.getData());
		}else{
			result.setResult(false);
			result.setMessage("消息信息查询失败");
		}
		return result;
	}
	public ExecResult postchangeListen(Map<String,String> param){
		String fields=param.get("fields");
		String [] fieldsarr=fields.split(",");
		String sql="UPDATE qm_tea_px SET " ;
				for(int i=0;i<fieldsarr.length;i++)
				{
					sql+=fieldsarr[i]+'='+param.get(fieldsarr[i])+",";
				}
		sql+="total"+"="+param.get("total")+",";
		sql+="xxjy"+"="+"'"+param.get("xxjy")+"'"+",";
		sql+="px_time"+"="+"NOW()"+" ";
		sql+="WHERE task_no="+"'"+param.get("task_no")+"'";
		JSONResponse response=new JSONResponse();
		ExecResult result= response.getExecResult(sql, null, "评学修改成功","评学修改失败");
		String sqlT="SELECT a.course_name,b.teacher_name,c.class_name,c.teacher_no,d.teacher_name main_tea FROM `base_teach_task` a  LEFT JOIN `base_teacher` b ON a.teacher_no = b.`teacher_no` LEFT JOIN `base_classes` c ON a.class_no = c.class_no  LEFT JOIN `base_teacher` d ON d.teacher_no = c.teacher_no WHERE a.task_no= '"+param.get("task_no")+"'";
		ExecResult result2 = response.getSelectResult(sqlT, null, null);
		if(result2.getResult()==1){
			result.setData(result2.getData());
		}else{
			result.setResult(false);
			result.setMessage("消息信息查询失败");
		}
		return result;
	}

}
