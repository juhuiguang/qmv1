package com.service.app;


import java.text.SimpleDateFormat;
import java.util.Date;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class AppService {
	public ExecResult checkInfo(String currentWeek, String teacher_no, String term_no) {
		JSONResponse jr = new JSONResponse(); 
		String selectSche = "SELECT a.course_type, a.course_name , a.course_week ,  b.sche_no ,b.sche_set , IFNULL( c.class_name,d.logic_name) AS class_name ,c.class_no FROM base_teach_task a left JOIN base_task_sche b ON a.task_no=b.task_no LEFT JOIN base_classes c ON a.class_no=c.class_no LEFT JOIN base_class_logic d ON (a.task_no=d.task_no AND a.term_no=d.term_no) WHERE  a.teacher_no='"
				+ teacher_no + "' AND a.term_no='" + term_no + "' AND LEFT(a.course_week,2) <= "+currentWeek+" GROUP BY b.sche_no ORDER BY b.sche_set"; 
		ExecResult result = null; 
		JSONArray data = new JSONArray();
		// 得到所有Sche
		ExecResult scheInfo = jr.getSelectResult(selectSche, null, "base_teach_task");
		if (scheInfo.getResult() > 0) {
			JSONArray scheData = scheInfo.getData();
			
			for (int i = 0, length = scheData.size(); i < length; i++) {
				JSONObject item = new JSONObject();
				item.put("task_no", scheData.getJSONObject(i).getString("task_no"));
				item.put("course_no", scheData.getJSONObject(i).getString("course_no"));
				item.put("course_type", scheData.getJSONObject(i).getString("course_type"));
				item.put("course_name", scheData.getJSONObject(i).getString("course_name"));
				item.put("sche_no", scheData.getJSONObject(i).getString("sche_no"));
				item.put("sche_set", scheData.getJSONObject(i).getString("sche_set").trim());
				item.put("class_name", scheData.getJSONObject(i).getString("class_name"));
				item.put("class_no", scheData.getJSONObject(i).getString("class_no"));
				String selectId = "SELECT check_main_no , check_main_status FROM qm_stu_check_main WHERE sche_no='"
						+ scheData.getJSONObject(i).getString("sche_no") + "' AND check_week='" + currentWeek
						+ "' AND term_no='" + term_no + "' ";
				ExecResult mainId = null;
				try {
					mainId = jr.getSelectResult(selectId, null, "base_teach_task");
				} catch (Exception e1) {
					result = new ExecResult(false, "数据提取异常");
					return result;
				}
				// 查询Sche 当前周是否已经存在主表
				String check_main_no = "";
				String check_main_status = "";
				if (mainId.getResult() > 0) {

					JSONArray ja = mainId.getData();
					if (ja.size() > 0) {
						check_main_no = ja.getJSONObject(0).getString("check_main_no");
						check_main_status = ja.getJSONObject(0).getString("check_main_status");
					}

				}
				// 考勤主表存在数据
				else {
					String insert_check_main = "INSERT INTO qm_stu_check_main(sche_no , check_week ,term_no) VALUES('"
							+ scheData.getJSONObject(i).getString("sche_no") + "','" + currentWeek + "','" + term_no
							+ "')";
					try {
						check_main_no = jr.getExecInsertId(insert_check_main, null, null, null).getMessage();
					} catch (Exception e) {
						// TODO Auto-generated catch block
						result = new ExecResult(false, "数据提取异常");
						return result;
					}
					check_main_status = "0";
				}

				item.put("check_main_no", check_main_no);
				item.put("check_main_status", check_main_status);
				data.add(item);
			}
			result = new ExecResult(true, "成功返回考勤课程信息");
			result.setData(data);
		} else {
			result = new ExecResult(true, "没有查询到课程信息");
		}
		return result;
	}

	public ExecResult StudentCheckInfo(String check_main_no, String class_no, String term_no, String course_type) {
		String sql = "";
		if ("任选课".equals(course_type)) {
			sql = "select c.student_no  , e.check_no ,e.check_status , e.check_time , d.stu_name from qm_stu_check_main a "
					+ "left join base_task_sche b " + "on a.sche_no = b.sche_no " + "left join base_class_logic c "
					+ "on c.task_no = b.task_no and c.term_no='" + term_no + "' " + "left join base_student d "
					+ "on d.stu_no = c.student_no " + "left join qm_stu_check e "
					+ "on e.stu_no = d.stu_no and e.check_main_no='" + check_main_no + "' "
					+ "where a.check_main_no = '" + check_main_no + "' ORDER BY c.`student_no`";
		} else {
			sql = "select a.stu_no , b.check_no ,b.check_status ,b.check_time,c.stu_name from base_term_student a "
					+ "left join qm_stu_check b " + "on a.stu_no = b.stu_no and b.check_main_no='" + check_main_no
					+ "' " + "left join base_student c " + "on c.stu_no= a.stu_no " + "where a.class_no = '" + class_no
					+ "' and a.term_no='" + term_no + "' order by a.stu_no";
		}
		JSONResponse jr = new JSONResponse();
		ExecResult result = null;
		try {
			result = jr.getSelectResult(sql, null, "");
		} catch (Exception e) {
			result = new ExecResult(false, "数据提取异常");
			return result;
		}
		if (!(result.getResult() > 0)) {
			result = new ExecResult(true, "没有查询到学生信息");
		}else{
			result.setMessage("");
		}
		return result;
	}

	public ExecResult departmentInfo() {
		ExecResult result = null;
		JSONResponse jr = new JSONResponse();
		String sql = "SELECT * FROM base_department ORDER BY dep_sort";
		try {
			result = jr.getSelectResult(sql, null, "");
		} catch (Exception e) {
			result = new ExecResult(false, "部门表提取失败");
		}
		if (result.getResult() > 0) {
			result.setMessage("部门表提取成功");
		} else {
			result = new ExecResult(true, "部门表为空");
		}
		return result;

	}

	public Object teacherListenStandard(String term_no) {
		ExecResult result = null;
		JSONResponse jr = new JSONResponse();

		String sql = "SELECT * FROM qm_xnxq_rule_version a " + "LEFT JOIN qm_rule b "
				+ "ON a.rule_type = b.rule_version_flag AND a.rule_version = b.rule_version AND b.rule_status = '1' "
				+ "WHERE a.term_no='" + term_no + "' AND a.rule_type='TK_JS' " + "ORDER BY rule_field";
		try {
			result = jr.getSelectResult(sql, null, "");
		} catch (Exception e) {
			result = new ExecResult(false, "听课标准提取失败");
		}
		if (result.getResult() > 0) {
			result.setMessage("听课标准提取成功");
		} else {
			result = new ExecResult(true, "听课标准为空");
		}
		return result;
	}

	public Object getConfig(String teacher_no, String key) {
		ExecResult result = null;
		JSONResponse jr = new JSONResponse();
		String config_type = "";
		
		
		String sql = "SELECT * FROM `qm_master_config` WHERE master_no='" + teacher_no + "' "; 
		 
		if(!"".equals(key)){
			if("comment".equals(key.trim())){
				config_type="听课评价";
			}else if("suggest".equals(key.trim())){
				config_type="教学建议";
			}
			sql+=" and config_type ='"+config_type+"'";
		}
		
	
		
		try {
			result = jr.getSelectResult(sql, null, "");
		} catch (Exception e) {
			result = new ExecResult(false, "数据提取失败");
		}
		if (result.getResult() > 0) {
			result.setMessage("常用语提取成功");
		} else {
			result = new ExecResult(true, "常用语为空");
		}
		return result;
	}

	public JSONArray getAttentionTea(String teacher_no, String term_no) {
		String sql = " SELECT c.task_no , e.dep_name , a.teacher_no , c.course_name , b.teacher_name , c.course_type , c.class_no,f.class_name,d.sche_set ,d.sche_addr "
				+ "FROM `qm_master_mark` a " + "LEFT JOIN base_teacher  b " + "ON a.teacher_no = b.`teacher_no` "
				+ "LEFT JOIN base_teach_task c " + "ON c.teacher_no = a.teacher_no AND c.term_no='" + term_no + "' "
				+ "LEFT JOIN base_task_sche d " + "ON d.task_no = c.task_no " + "LEFT JOIN base_department e "
				+ "ON e.`dep_no` = b.`dep_no` " + "LEFT JOIN base_classes f " + "ON f.class_no = c.class_no "
				+ "WHERE a.master_teacher_no='" + teacher_no + "' AND a.term_no='" + term_no + "' ";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "");
		if (!(result.getResult() > 0)) {
			return new JSONArray();
		}
		return result.getData();
	}

	public Object getListenInfo(String teacher_no, String task_no, String listen_time) {
		ExecResult result = null;
		JSONResponse jr = new JSONResponse();
		String sql = "SELECT * FROM `qm_master_listen` WHERE teacher_no='" + teacher_no + "' AND task_no='" + task_no
				+ "' AND LEFT(listen_time , 10) = '" + listen_time + "' order by listen_time";
		try {
			result = jr.getSelectResult(sql, null, "");
		} catch (Exception e) {
			result = new ExecResult(false, "听课记录提取失败");
		}
		if (result.getResult() > 0) {
			result.setMessage("听课记录提取成功");
		} else {
			result = new ExecResult(true, "没有听课记录");
		}
		return result;
	}

	public Object postStuCheckInfo(String check_main_no, String stu_no, String check_status) {
		ExecResult result = null;
		JSONResponse jr = new JSONResponse();
		if ("到勤".equals(check_status)) {
			// delete
			String sql_delete = "DELETE FROM `qm_stu_check` WHERE check_main_no='" + check_main_no + "' AND stu_no='"
					+ stu_no + "'";
			result = jr.getExecResult(sql_delete, null);
			result = new ExecResult(true, "保存成功");
		} else {
			// 查询
			String sql_select = "SELECT * FROM qm_stu_check WHERE check_main_no='" + check_main_no + "' AND stu_no='"
					+ stu_no + "'";
			result = jr.getSelectResult(sql_select, null, "");
			if (result.getResult() > 0) {
				// 有 更新
				String sql_update = "UPDATE qm_stu_check SET check_status='" + check_status + "' WHERE check_main_no='"
						+ check_main_no + "' AND stu_no='" + stu_no + "'";
				result = jr.getExecResult(sql_update, null, "", "");

				if (result.getResult() > 0 ) {

					result = new ExecResult(true, "保存成功");
				} else {
					result = new ExecResult(false, "保存失败");
				}
			} else {
				// 没有 提交
				String sql_insert = "INSERT into qm_stu_check(check_main_no , stu_no , check_status) VALUES('"
						+ check_main_no + "','" + stu_no + "','" + check_status + "')";
				result = jr.getExecInsertId(sql_insert, null, "", "");

				if (result.getResult() > 0 ) {
					result = new ExecResult(true, "保存成功");
				} else {
					result = new ExecResult(false, "保存失败");
				}
			}
		}
		changeCheckMain(check_main_no);
		return result;
	}

	public void changeCheckMain(String check_main_no ) {
		JSONResponse jr = new JSONResponse();
		String sql="UPDATE `qm_stu_check_main` "+
					"SET check_kk = IFNULL((SELECT COUNT(1) FROM `qm_stu_check` WHERE check_main_no = '"+check_main_no+"' AND check_status='旷课' GROUP BY check_status),0),"+
					"check_cd = IFNULL((SELECT COUNT(1) FROM `qm_stu_check` WHERE check_main_no = '"+check_main_no+"' AND check_status='迟到' GROUP BY check_status),0),"+
					"check_zt = IFNULL((SELECT COUNT(1) FROM `qm_stu_check` WHERE check_main_no = '"+check_main_no+"' AND check_status='早退' GROUP BY check_status),0),"+
					"check_qj = IFNULL((SELECT COUNT(1) FROM `qm_stu_check` WHERE check_main_no = '"+check_main_no+"' AND check_status='请假' GROUP BY check_status),0)"+
					"WHERE check_main_no = '"+check_main_no+"'";
		jr.getExecResult(sql, null, "", "");
		String sql_ = "UPDATE `qm_stu_check_main` SET check_ratio = ROUND((1-(IFNULL(check_kk,0)+IFNULL(check_cd,0)+IFNULL(check_zt,0))/IFNULL(check_count,0))*100,4) WHERE check_main_no='"+check_main_no+"'";
		jr.getExecResult(sql_, null, "", "");
	}

	public Object postMainCheckInfo(String check_main_no, String check_kk, String check_cd, String check_zt,
			String check_qj, String check_count, String check_ratio, String check_sx) {
		ExecResult result = null;
		JSONResponse jr = new JSONResponse();
		String sql = "UPDATE `qm_stu_check_main` SET ";
		if (!"".equals(check_sx)) {
			sql += "check_sx = '" + check_sx + "' ";
		}
		sql += "check_main_status='1' ,check_kk='" + check_kk + "' ,check_cd='" + check_cd + "' , check_zt='" + check_zt
				+ "' , check_qj='" + check_qj + "' , check_ratio='" + check_ratio + "' ,check_count='" + check_count
				+ "' WHERE check_main_no='" + check_main_no + "'";
		try {
			result = jr.getExecResult(sql, null, "", "");
		} catch (Exception e) {
			result = new ExecResult(false, "保存异常");
		}
		if (result.getResult() > 0) {
			result = new ExecResult(true, "保存成功");
		} else {
			result = new ExecResult(false, "保存失败");
		}
		return result;
	}

	public Object postListenInfo(String listen_no, String teacher_no, String task_no, String jxjy, String skpj,
			String per , String listen_time) {
		listen_time +=" 00:00:00";
		String[] perArray = per.split("-");
		ExecResult result = null;
		JSONResponse jr = new JSONResponse();
		double total = 0;
		if (!"".equals(listen_no)) {
			// update
			String sql_update = "UPDATE `qm_master_listen` SET ";
			
			for (int i = 0; i < perArray.length; i++) {
				sql_update += " per1" + (i + 1) + " = '" + perArray[i] + "', ";  
				total += Double.parseDouble(perArray[i]);
			}
			sql_update += "jxjy='" + jxjy + "' , skpj='" + skpj + "' , total='" + total + "'  WHERE listen_no='" + listen_no + "'";
			try {
				result = jr.getExecResult(sql_update, null, "", "");
			} catch (Exception e) {
				result = new ExecResult(false, "保存异常");
			}
			if (result.getResult() > 0) {
				result = new ExecResult(true, "保存成功");
			} else {
				result = new ExecResult(false, "保存失败");
			}
		} else {
			// insert
			String sql_insert = "INSERT INTO qm_master_listen(rule_flag , teacher_no , task_no ,";
			for (int i = 0; i < perArray.length; i++) {
				sql_insert += " per1" + (i + 1) + " ,";
			}
			sql_insert += " total , jxjy , skpj ,listen_time) values('TK_JS','" + teacher_no + "' , '" + task_no + "' ,  ";
			for (int i = 0; i < perArray.length; i++) {
				sql_insert += " '" + perArray[i] + "' ,";
				total += Double.parseDouble(perArray[i]);
			}
			sql_insert += "'"+total+"' , '"+jxjy+"' , '"+skpj+"' , '"+listen_time+"')";
			try {
				result = jr.getExecInsertId(sql_insert, null, "", "");
			} catch (Exception e){
				result = new ExecResult(false, "保存异常");
			}
			if (result.getResult() > 0) {
				result = new ExecResult(true, "保存成功");
			} else {
				result = new ExecResult(false, "保存失败");
			}
		}
		return result;
	}

	public Object getTeacherName(String keyWord, String dep_no, String teacher_no, String term_no) {
		ExecResult result = null;
		JSONResponse jr = new JSONResponse();
		
		
		String sql ="";
		if(teacher_no.equals("")||term_no.equals("")){
			sql= "SELECT a.teacher_name , a.teacher_no , a.dep_no FROM base_teacher a WHERE a.teacher_name LIKE '%"+keyWord+"%' and a.teacher_status = '1' ";
		}else{
			sql=" SELECT b.mark_no, a.teacher_name , a.teacher_no , a.dep_no FROM base_teacher a LEFT JOIN `qm_master_mark` b ON a.`teacher_no` = b.teacher_no AND b.master_teacher_no='"+teacher_no+"' AND term_no='"+term_no+"' WHERE a.teacher_name LIKE '%"+keyWord+"%' AND a.teacher_status = '1'";
		}
		if(!dep_no.equals("ALL")){
			sql+=" and a.dep_no='"+dep_no+"'";
		} 
		sql+=" order by a.teacher_no ";   
		try {
			result = jr.getSelectResult(sql, null, "");
		} catch (Exception e) {
			result = new ExecResult(false, "查询教师失败");
		}
		if (result.getResult() > 0) { 
			result.setMessage("查询教师成功");
		} else {
			result = new ExecResult(true, "暂无教师");
		}
		return result;
	} 

	public Object studentCheckWeekInfo(String selectWeek, String sche_no, String class_no, String course_type, String term_no) {
		
		
		
		JSONResponse jr = new JSONResponse();
		String selectId = "SELECT check_main_no , check_main_status FROM qm_stu_check_main WHERE sche_no='"
				+ sche_no + "' AND check_week='" + selectWeek
				+ "' AND term_no='" + term_no + "' ";
		ExecResult mainId = jr.getSelectResult(selectId, null, "base_teach_task");
		String check_main_no = "";
		if (mainId.getResult() > 0) {

			JSONArray ja = mainId.getData();
			if (ja.size() > 0) {
				check_main_no = ja.getJSONObject(0).getString("check_main_no");
			}

		}
		// 考勤主表存在数据
		else {
			String insert_check_main = "INSERT INTO qm_stu_check_main(sche_no , check_week ,term_no) VALUES('"
					+ sche_no + "','" + selectWeek + "','" + term_no
					+ "')";
			check_main_no = jr.getExecInsertId(insert_check_main, null, null, null).getMessage();
		}
		
		String sql = "";
		if ("任选课".equals(course_type)){
			sql = "select c.student_no  , e.check_no ,e.check_status , e.check_time , d.stu_name from qm_stu_check_main a "
					+ "left join base_task_sche b " + "on a.sche_no = b.sche_no " + "left join base_class_logic c "
					+ "on c.task_no = b.task_no and c.term_no='" + term_no + "' " + "left join base_student d "
					+ "on d.stu_no = c.student_no " + "left join qm_stu_check e "
					+ "on e.stu_no = d.stu_no and e.check_main_no='" + check_main_no + "' "
					+ "where a.check_main_no = '" + check_main_no + "' ORDER BY c.`student_no`";
		} else {
			sql = "select a.stu_no , b.check_no ,b.check_status ,b.check_time,c.stu_name from base_term_student a "
					+ "left join qm_stu_check b " + "on a.stu_no = b.stu_no and b.check_main_no='" + check_main_no
					+ "' " + "left join base_student c " + "on c.stu_no= a.stu_no " + "where a.class_no = '" + class_no
					+ "' and a.term_no='" + term_no + "' order by a.stu_no";
		}
		ExecResult result_studnet = null;
		try {
			result_studnet = jr.getSelectResult(sql, null, "");
		} catch (Exception e) {
			result_studnet = new ExecResult(false, "查询异常");
		}
		if (!(result_studnet.getResult() > 0)) {
			result_studnet = new ExecResult(true, "没有查询到学生信息");
		}else{
			result_studnet.setMessage(check_main_no);
			result_studnet.setResult(true);
		}
		return result_studnet;
	}

	public Object getCheckRecord(String selectWeek, String teacher_no, String term_no) {
		JSONResponse jr = new JSONResponse();
		String sql_course = "SELECT e.*, a.task_no,a.course_week, a.course_type, a.course_name ,b.sche_set , IFNULL( c.class_name,d.logic_name) AS class_name ,c.class_no FROM base_teach_task a left JOIN base_task_sche b ON a.task_no=b.task_no LEFT JOIN base_classes c ON a.class_no=c.class_no LEFT JOIN base_class_logic d ON (a.task_no=d.task_no AND a.term_no=d.term_no) JOIN `qm_stu_check_main` e ON e.sche_no = b.sche_no AND e.check_week='"+selectWeek+"'  WHERE  a.teacher_no='"
				+ teacher_no + "' AND a.term_no='" + term_no + "' AND LEFT(a.course_week,2) <= "+selectWeek+" GROUP BY b.sche_no ORDER BY b.sche_set";
		
		ExecResult course = null;
		try {
			 course = jr.getSelectResult(sql_course, null, ""); 
		} catch (Exception e) {
			course = new ExecResult(false, "查询异常"); 
		}
		if(course.getResult() > 0){ 
			
			course.setMessage("考勤信息返回成功");
		}else{
			course = new ExecResult(true , "没有查询到考勤信息！");
		}
		return course;
	}

	public ExecResult setConfig(String content, String key, String teacher_no) {
		JSONResponse jr = new JSONResponse();
		ExecResult result = new ExecResult(); 
		key = "comment".equals(key)?"听课评价":"教学建议";
		String setConfig = "INSERT INTO `qm_master_config`(master_no , content , config_type) VALUES('"+teacher_no+"','"+content+"','"+key+"')";
		
		try {
			result = jr.getExecResult(setConfig, null, "", "");  
		} catch (Exception e) {
			result = new ExecResult(false, "查询异常");  
		}
		if(result.getResult() > 0){
			result.setMessage("常用语添加成功");
		}else{ 
			result = new ExecResult(false , "常用语保存失败");
		}  
		return result;
	}

	public ExecResult removeConfig(String config_no) {
		JSONResponse jr = new JSONResponse();
		ExecResult result = new ExecResult(); 
		String removeConfig = "DELETE FROM `qm_master_config` WHERE config_no='"+config_no+"'";
		try {
			result = jr.getExecResult(removeConfig, null, "", "");  
		} catch (Exception e) {
			result = new ExecResult(false, "删除异常");  
		}
		if(result.getResult() > 0){ 
			result.setMessage("常用语删除成功"); 
		}else{ 
			result = new ExecResult(false , "常用语删除失败");  
		}  
		return result;
	}

	public ExecResult getMarkTeacher(String teacher_no, String term_no) {
		JSONResponse jr = new JSONResponse();
		ExecResult result = new ExecResult(); 
		String getMarkTeacher=" SELECT a.teacher_no , a.mark_time , a.mark_no , b.teacher_name , b.dep_no ,b.teacher_title FROM `qm_master_mark` a LEFT JOIN `base_teacher` b ON a.teacher_no = b.teacher_no WHERE master_teacher_no='"+teacher_no+"' AND term_no='"+term_no+"' ORDER BY a.mark_time DESC";
		try {
			result = jr.getSelectResult(getMarkTeacher, null, "");  
		} catch (Exception e) {
			result = new ExecResult(false, "查询异常");  
		}
		if(result.getResult() > 0){ 
			result.setMessage("关注教师提取成功"); 
		}else{ 
			result = new ExecResult(true , "暂未关注教师");    
		}  
		return result;
	}

	public ExecResult changeMarkStatus(String master_teacher_no, String teacher_no, String term_no) {
		JSONResponse jr = new JSONResponse();
		ExecResult result = new ExecResult(); 
		String select_having ="SELECT * FROM qm_master_mark WHERE master_teacher_no = '"+master_teacher_no+"' AND teacher_no='"+teacher_no+"' AND term_no='"+term_no+"'";
		String sql = "";
		if(jr.getSelectResult(select_having, null, "").getResult() > 0 ){
			//delete
			sql = "DELETE FROM qm_master_mark where master_teacher_no = '"+master_teacher_no+"' AND teacher_no='"+teacher_no+"' AND term_no='"+term_no+"'";
			try {
				result = jr.getExecResult(sql, null, "", "");  
			} catch (Exception e) { 
				result = new ExecResult(false, "操作异常");  
			}  
		}else{
			//insert
			Date date = new Date();
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			sql = "INSERT INTO qm_master_mark(master_teacher_no , teacher_no , term_no , mark_time) VALUES('"+master_teacher_no+"','"+teacher_no+"','"+term_no+"' ,'"+simpleDateFormat.format(date)+"')";
			try {
				result = jr.getExecInsertId(sql, null	, "", "");  
			} catch (Exception e) {
				result = new ExecResult(false, "操作异常");  
			}
		}
		
		
		if(result.getResult() > 0){ 
			result.setMessage("切换关注状态成功");  
		}else{ 
			result = new ExecResult(false , "切换关注状态失败");    
		}  
		return result;
	}

	public ExecResult getOwnListenInfo(String teacher_no, String term_no) {
		JSONResponse jr = new JSONResponse();
		ExecResult result = new ExecResult();
		String sql = "SELECT a.task_no , a.course_no ,a.course_name , a.course_type, a.course_week ,a.class_no , b.listen_no  ,b.* ,c.class_name ,d.teacher_name AS master_teacher_name FROM `base_teach_task` a "+
					"JOIN `qm_master_listen` b ON a.task_no = b.task_no "+
					"LEFT JOIN `base_classes` c ON c.class_no = a.class_no "+
					"LEFT JOIN base_teacher d ON d.teacher_no = b.teacher_no " +
					"WHERE a.teacher_no = '"+teacher_no+"' AND a.term_no='"+term_no+"'";
		
		try {
			result = jr.getSelectResult(sql, null, "");
		} catch (Exception e) {
			result = new ExecResult(false , "查询异常");
		}
		if(result.getResult() > 0){
			result.setMessage("被听课记录提取成功");
		}else{
			result = new ExecResult(true , "暂无被听课记录");
		} 
		return result;
	}

	public ExecResult getMasterOwnListenInfo(String teacher_no, String term_no, int paginal, int amount) {
		
		JSONResponse jr = new JSONResponse();
		ExecResult result = new ExecResult();
		
		String sql = "SELECT a.* , b.course_no , b.course_name , b.course_type , b.course_week , b.class_no , c.teacher_name ,c.teacher_no , c.dep_no , d.class_name FROM `qm_master_listen` a "+
					"JOIN `base_teach_task` b "+
					"ON a.task_no = b.task_no AND b.term_no='"+term_no+"' "+
					"LEFT JOIN base_teacher c ON c.teacher_no = b.teacher_no "+
					"LEFT JOIN base_classes d ON b.class_no = d.class_no "+
					"WHERE a.teacher_no = '"+teacher_no+"' "+
					"ORDER BY a.listen_time DESC ";
		if(paginal > 0 && amount > 0){
			sql+=" limit "+(paginal - 1)*amount + ","+amount;
		}
		try {
			result = jr.getSelectResult(sql, null, "");
		} catch (Exception e) {
			result = new ExecResult(false , "查询异常");
		}
		if(result.getResult() > 0){ 
			result.setMessage("听课记录提取成功");
		}else{
			result = new ExecResult(true , "暂无听课记录");
		} 
		return result;
	}

	public ExecResult removeMasterOwnListenInfo(String listen_no) {
		JSONResponse jr = new JSONResponse();
		ExecResult result = new ExecResult();
		
		String sql = "DELETE FROM `qm_master_listen` WHERE listen_no='"+listen_no+"'";
		try {
			result = jr.getExecResult(sql, null, "", "");
		} catch (Exception e) {
			result = new ExecResult(false , "删除异常");
		}
		if(result.getResult() > 0){ 
			result.setMessage("听课记录删除成功");
		}else{
			result = new ExecResult(false , "听课记录删除失败");
		} 
		return result;
	}

	public ExecResult getTeacherCheckInfo(String teacher_no, String term_no) {
		JSONResponse jr = new JSONResponse();
		ExecResult result = new ExecResult();
		String sql = "SELECT a.`task_no` ,a.course_no, a.course_name , a.`teacher_no` , a.course_type , a.course_week , a.`class_no`,e.class_name , c.`teacher_name` FROM `base_teach_task` a  LEFT JOIN base_teacher c ON a.`teacher_no` = c.teacher_no LEFT JOIN base_classes e ON e.class_no = a.class_no WHERE a.teacher_no='"+teacher_no+"' AND a.term_no='"+term_no+"'";
		ExecResult sche_sql = null;
		try {
			sche_sql = jr.getSelectResult(sql, null, "");
		} catch (Exception e) {
			result = new ExecResult(false , "查询异常");
		}
		if(sche_sql.getResult() > 0){
			result =new ExecResult(true , "查询成功");
			result.setData(sche_sql.getData());
		}else{
			result =new ExecResult(true , "没有查询到课程信息");
		}
		
		/*System.out.println("================================="+sql);
		ExecResult sche_sql = null;
		JSONArray rep = new JSONArray();
		try {
			sche_sql = jr.getSelectResult(sql, null, "");
		} catch (Exception e) { 
			result = new ExecResult(false , "提取教师考勤记录异常");
		}
		if(sche_sql.getResult() > 0){
			JSONArray scheInfo = sche_sql.getData();
			 
			for(int i = 0 , length =scheInfo.size() ; i < length ; i++){
			
				String sql_class="";
				if(scheInfo.getJSONObject(i).get("course_type").equals("任选课")){
					//逻辑班级表
					sql_class="SELECT login_name AS class_name FROM `base_class_logic` WHERE task_no='"+scheInfo.getJSONObject(i).get("task_no")+"' AND course_no='"+scheInfo.getJSONObject(i).get("course_no")+"'";
					System.out.println("================================="+sql_class);
				}else{
					//班级表
					sql_class="SELECT class_name FROM `base_classes` WHERE class_no='"+scheInfo.getJSONObject(i).get("class_no")+"'";
					System.out.println("================================="+sql_class);
				}
				ExecResult select_class = null;
				try {
					select_class = jr.getSelectResult(sql_class, null, "");
				} catch (Exception e) {
					result = new ExecResult(false , "班级名称获取异常");
				} 
				
				JSONObject item = new JSONObject();
				
				item.put("task_no", scheInfo.getJSONObject(i).get("task_no"));
				item.put("course_name", scheInfo.getJSONObject(i).get("course_name"));
				item.put("teacher_no", scheInfo.getJSONObject(i).get("teacher_no"));
				item.put("course_type", scheInfo.getJSONObject(i).get("course_type"));
				item.put("course_week", scheInfo.getJSONObject(i).get("course_week"));
				item.put("class_no", scheInfo.getJSONObject(i).get("class_no"));
				item.put("teacher_name", scheInfo.getJSONObject(i).get("teacher_name"));
				item.put("class_name", select_class.getData().getJSONObject(0).get("class_name"));
				String sql_check = "SELECT b.check_main_no ,b.check_week , b.sche_no , c.stu_no , c.check_status ,c.check_time , d.stu_name FROM `base_task_sche` a LEFT JOIN `qm_stu_check_main` b ON a.sche_no = b.sche_no JOIN `qm_stu_check` c ON c.check_main_no = b.check_main_no LEFT JOIN `base_student` d  ON d.stu_no = c.stu_no WHERE a.task_no='"+scheInfo.getJSONObject(i).get("task_no")+"' order by c.stu_no "; 
				System.out.println("================================="+sql_check);
				ExecResult select_check = null;
				try {
					select_check = jr.getSelectResult(sql_check, null, "");
				} catch (Exception e) { 
					result = new ExecResult(false , "考勤数据获取异常");
				} 
				
				if(select_check.getData().size() > 0){
					JSONArray selectCheckArray = select_check.getData();
					String stu_no="";
					JSONArray checkData = new JSONArray();
					JSONObject stuCheck = new JSONObject();
					JSONArray stuCheckInfo = new JSONArray();
					
					for(int j = 0 ; j < selectCheckArray.size() ; j++){
					
						if(selectCheckArray.getJSONObject(j).getString("stu_no").equals(stu_no)){
						}else{
							stu_no = selectCheckArray.getJSONObject(j).getString("stu_no"); 
							if(j > 0){
								
								stuCheck.put("studentCheckInfo", stuCheckInfo); 
								checkData.add(stuCheck);
								stuCheckInfo = new JSONArray();
							}
							stuCheck = new JSONObject();
							stuCheck.put("stu_no", selectCheckArray.getJSONObject(j).getString("stu_no"));
							stuCheck.put("stu_name", selectCheckArray.getJSONObject(j).getString("stu_name"));
							
						}
						JSONObject stuCheckInfoObject = new JSONObject();
						stuCheckInfoObject.put("check_main_no",selectCheckArray.getJSONObject(j).getString("check_main_no") );
						stuCheckInfoObject.put("check_week",selectCheckArray.getJSONObject(j).getString("check_week") );
						stuCheckInfoObject.put("sche_no",selectCheckArray.getJSONObject(j).getString("sche_no") );
						stuCheckInfoObject.put("check_status",selectCheckArray.getJSONObject(j).getString("check_status") );
						stuCheckInfoObject.put("check_time",selectCheckArray.getJSONObject(j).getString("check_time") );
						stuCheckInfo.add(stuCheckInfoObject);
						if(j == selectCheckArray.size() - 1){ 
						
							stuCheck.put("studentCheckInfo", stuCheckInfo);  
							checkData.add(stuCheck);
						}
					}
					System.out.println(checkData); 
					item.put("checkMainInfo", checkData); 
				}else{
					item.put("checkMainInfo", new JSONArray());
				}
				
				rep.add(item); 
				result.setResult(true); 
				result.setData(rep); 
				result.setMessage("提取课程考勤信息成功");
			}
		}else{
			result = new ExecResult(true , "该教师暂无课程");
		}
		*/
		return result;
	}

	public ExecResult getTeacherCheckDetail(String task_no) {
		String sql = "SELECT a.sche_no , a.sche_set,b.check_main_no ,b.check_week , d.stu_no ,d.stu_name  , c.check_status ,c.check_time  FROM `base_task_sche` a LEFT JOIN `qm_stu_check_main` b ON a.sche_no = b.sche_no JOIN `qm_stu_check` c ON c.check_main_no = b.check_main_no LEFT JOIN base_student d ON d.stu_no = c.stu_no  WHERE task_no = '"+task_no+"' ORDER BY c.stu_no, c.check_status";
		JSONResponse jr = new JSONResponse();
		ExecResult result = new ExecResult();
		ExecResult rep = null;
		try {
			rep = jr.getSelectResult(sql, null, "");
		} catch (Exception e) {
			result = new ExecResult(false , "查询异常");
		} 
		if(rep.getResult() > 0){
			result = new ExecResult(true , "查询成功"); 
			result.setData(rep.getData());
		}else{
			result = new ExecResult(true , "没有缺勤数据");
		}
		
		return result;
	}

	public ExecResult getAllTeacher() {
		String sql="SELECT *FROM `base_teacher` WHERE teacher_status = '1'";
		JSONResponse jr = new JSONResponse();
		ExecResult rep = jr.getSelectResult(sql, null, "");
		return rep;
	}

	public ExecResult getDepTeacher(String dep_no) {
		String sql="SELECT *FROM `base_teacher` WHERE teacher_status = '1' and dep_no='"+dep_no+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult rep = jr.getSelectResult(sql, null, "");
		return rep;
	}

	public ExecResult getTeacherByID(String teacher_no) {
		String sql="SELECT *FROM `base_teacher` WHERE teacher_status = '1' and teacher_no='"+teacher_no+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult rep = jr.getSelectResult(sql, null, "");
		return rep;
	}

	public ExecResult getTeacherByName(String teacher_name) {
		String sql="SELECT *FROM `base_teacher` WHERE teacher_status = '1' and teacher_name='%"+teacher_name+"%'";
		JSONResponse jr = new JSONResponse();
		ExecResult rep = jr.getSelectResult(sql, null, "");
		return rep;
	}

	public ExecResult getClassByMajor(String major_no) {
		String sql="SELECT * FROM `base_classes` WHERE class_isover = '0' AND major_no='"+major_no+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult rep = jr.getSelectResult(sql, null, "");
		return rep;
	}

	public ExecResult getClassByDep(String dep_no) {
		String sql="SELECT * FROM `base_classes` WHERE class_isover = '0' AND dep_no='"+dep_no+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult rep = jr.getSelectResult(sql, null, "");
		return rep;
	}

	public ExecResult getClassByName(String class_name) {
		String sql="SELECT * FROM `base_classes` WHERE class_isover = '0' AND class_name='%"+class_name+"%'";
		JSONResponse jr = new JSONResponse();
		ExecResult rep = jr.getSelectResult(sql, null, "");
		return rep;
	}

	public ExecResult getClassByGrade(String grade) {
		String sql="SELECT * FROM `base_classes` WHERE class_isover = '0' AND left(class_no , 4) = '"+grade+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult rep = jr.getSelectResult(sql, null, "");
		return rep;
	}

	public ExecResult changeClassMajor(String class_no, String major_no) {
		String sql = "update base_classes set major_no = '"+major_no+"' where class_no='"+class_no+"' ";
		JSONResponse jr = new JSONResponse();
		ExecResult rep = jr.getExecResult(sql,null ,  "", "");
		return rep;
	}

	public ExecResult getClassByDepAndYear(String dep_no, String year, String limitYear) {
		int yearInt = Integer.parseInt(year);
		String sql="SELECT * FROM `base_classes` WHERE class_isover = '0'";
				if(!dep_no.equals("ALL")){
					sql+=" and dep_no='"+dep_no+"'";
				}
				sql+=" AND LEFT(class_no , 4) <= "+yearInt+" AND LEFT(class_no , 4) > "+(yearInt - Integer.parseInt(limitYear))+"";
		JSONResponse jr = new JSONResponse();
		ExecResult rep = jr.getSelectResult(sql, null, "");
		return rep;
	}

	public ExecResult getClassByMajorAndYear(String major_no, String year) {
		String sql="SELECT * FROM `base_classes` WHERE class_isover = '0' and major_no = '"+major_no+"' AND left(class_no , 4) = '"+year+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult rep = jr.getSelectResult(sql, null, "");
		return rep;
	} 

//	public Object demo(String stu_no, String stu_name) {
//		String sql = "INSERT INTO `base_student`(stu_no , stu_name , stu_year , stu_status ) VALUES('"+stu_no+"','"+stu_name+"','2015','1')";
//		JSONResponse jr = new JSONResponse();
//		jr.getExecInsertId(sql, null, "", "");
//		return null;
//	}
//
//	public Object demo2(String stu_no, String class_no) {
//		String sql = "INSERT INTO `base_term_student`(term_no , stu_no , class_no) VALUES('20150','"+stu_no+"','"+class_no+"')";
//		JSONResponse jr = new JSONResponse();
//		jr.getExecInsertId(sql, null, "", "");
//		return null;
//	}
}
