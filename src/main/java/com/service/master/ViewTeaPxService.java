package com.service.master;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class ViewTeaPxService {

	public ExecResult getTableInfoService(String term_no,String dep_no,int pageindex,int pagelength,int totaltemp,String teacher_name){
		int pagenumber = pageindex-1; 
		JSONResponse jResponse = new JSONResponse();
		ExecResult result = new ExecResult();
		JSONArray data = result.getData();
		ExecResult r2 = null;
		if(teacher_name==""||teacher_name==null){
			String []params={term_no,dep_no}; 
			String sql1 = "SELECT a.course_name,a.course_type,d.teacher_name ,f.class_name FROM `base_teach_task` a LEFT JOIN `base_teacher` d ON d.teacher_no =a.teacher_no LEFT JOIN `base_classes` f ON f.`class_no` = a.`class_no` WHERE a.dep_no = ''{1}''  AND a.term_no=''{0}'' AND a.task_no NOT IN (SELECT b.task_no FROM `qm_tea_px` b,`base_teach_task` c WHERE b.task_no=c.task_no AND c.term_no=''{0}'' AND c.dep_no=''{1}'')  ORDER BY CONVERT(d.teacher_name USING gbk)";
			if (pagelength > 0) {
				sql1 += " limit " + (pagenumber * pagelength) + "," + pagelength;
			}
			 r2 = jResponse.getSelectResult(sql1, params, null);
			 data = r2.getData();
			 if(totaltemp ==1){
					String sql = "SELECT COUNT(*) total FROM `base_teach_task` a WHERE dep_no = ''{1}''  AND term_no=''{0}'' AND a.task_no NOT IN (SELECT b.task_no FROM `qm_tea_px` b,`base_teach_task` c WHERE b.task_no=c.task_no AND c.term_no=''{0}'' AND c.dep_no=''{1}'')";
					ExecResult r1 = jResponse.getSelectResult(sql, params, null);
					JSONObject jObject = new JSONObject();
					if(r1.getData().size()!=0){
						jObject.put("total", r1.getData().getJSONObject(0).get("total"));
						data.add(jObject);
					}
				}
		}else{
			String []params={term_no,dep_no,teacher_name}; 
			String sql1 = "SELECT a.course_name,a.course_type,d.teacher_name ,f.class_name FROM `base_teach_task` a LEFT JOIN `base_teacher` d ON d.teacher_no =a.teacher_no LEFT JOIN `base_classes` f ON f.`class_no` = a.`class_no` WHERE a.dep_no = ''{1}''  AND a.term_no=''{0}'' AND a.task_no NOT IN (SELECT b.task_no FROM `qm_tea_px` b,`base_teach_task` c WHERE b.task_no=c.task_no AND c.term_no=''{0}'' AND c.dep_no=''{1}'') AND d.`teacher_name` LIKE ''%{2}%'' ORDER BY CONVERT(d.teacher_name USING gbk)";
			if (pagelength > 0) {
				sql1 += " limit " + (pagenumber * pagelength) + "," + pagelength;
			}
			 r2 = jResponse.getSelectResult(sql1, params, null);
			 data = r2.getData();
			 if(totaltemp ==1){
					String sql = "SELECT COUNT(*) total FROM `base_teach_task` a LEFT JOIN base_teacher d ON d.teacher_no = a.teacher_no WHERE a.dep_no = ''{1}''  AND term_no=''{0}'' AND a.task_no NOT IN (SELECT b.task_no FROM `qm_tea_px` b,`base_teach_task` c WHERE b.task_no=c.task_no AND c.term_no=''{0}'' AND c.dep_no=''{1}'')  AND d.`teacher_name` LIKE ''%{2}%''";
					ExecResult r1 = jResponse.getSelectResult(sql, params, null);
					JSONObject jObject = new JSONObject();
					if(r1.getData().size()!=0){
						jObject.put("total", r1.getData().getJSONObject(0).get("total"));
						data.add(jObject);
					}
				}
			 result.setData(data);
		}
			if(r2.getResult()==1){
			    result.setResult(true);
			}else{
				result.setResult(false);
			}
			result.setMessage(r2.getMessage());
		 result.setData(data);
		return result;
	}
}
