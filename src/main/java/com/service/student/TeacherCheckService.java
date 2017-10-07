package com.service.student;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class TeacherCheckService {
	public ExecResult checkInfo(String currentWeek, String teacher_no, String term_no , String course_type ) {
		JSONResponse jr = new JSONResponse();
		String selectSche = "SELECT c.teacher_no, a.course_type, a.course_name , a.course_week , b.sche_addr , b.sche_no ,b.sche_set , IFNULL( c.class_name,d.logic_name) AS class_name ,c.class_no FROM base_teach_task a left JOIN base_task_sche b ON a.task_no=b.task_no LEFT JOIN base_classes c ON a.class_no=c.class_no LEFT JOIN base_class_logic d ON (a.task_no=d.task_no AND a.term_no=d.term_no) WHERE  a.teacher_no='"
				+ teacher_no + "' AND a.term_no='" + term_no + "' ";
		  
		if(course_type.equals("实训课")){ 
			selectSche += " AND a.`course_type` = '实训课'";
		}else{ 
			selectSche += " AND NOT a.`course_type` = '实训课'"; 
		} 
		
		selectSche += "GROUP BY b.sche_no ORDER BY b.sche_set"; 
		ExecResult result = null; 
		JSONArray data = new JSONArray();
		// 得到所有Sche
		ExecResult scheInfo = jr.getSelectResult(selectSche, null, "base_teach_task");
		if (scheInfo.getResult() > 0) {
			JSONArray scheData = scheInfo.getData();
			for (int i = 0, length = scheData.size(); i < length; i++) {
				// 
				boolean flag = true;
				String courseWeek = scheData.getJSONObject(i).getString("course_week");
				String [] courseWeekArray = courseWeek.split(",");
				int [] weekArray = new int[50];
				int index = 0;
				for (String string : courseWeekArray) {
					String []  courseWeekArray_ = string.split("-");
					if(courseWeekArray_.length == 1){
						weekArray[index ++ ] = Integer.parseInt(courseWeekArray_[0]);
					}else{
						int star = Integer.parseInt(courseWeekArray_[0]);
						int end = Integer.parseInt(courseWeekArray_[1]);
						for(int j = star ; j <= end ; j++ ){
							weekArray[index ++ ] = j;
						}
					}
				}
				int weekFlag = Integer.parseInt(currentWeek);
				for(int value = 0 ; value <weekArray.length ; value++ ){
					if(weekFlag == weekArray[value]){
						flag = false;
						break;
					}
					if(weekArray[value] == 0 ){
						break;
					}
				}
				
				JSONObject item = new JSONObject();
				item.put("teacher_no", scheData.getJSONObject(i).getString("teacher_no"));
				item.put("course_week", scheData.getJSONObject(i).getString("course_week"));
				item.put("task_no", scheData.getJSONObject(i).getString("task_no"));
				item.put("course_no", scheData.getJSONObject(i).getString("course_no"));
				item.put("course_type", scheData.getJSONObject(i).getString("course_type"));
				item.put("sche_addr", scheData.getJSONObject(i).getString("sche_addr")); 
				item.put("course_name", scheData.getJSONObject(i).getString("course_name"));
				item.put("sche_no", scheData.getJSONObject(i).getString("sche_no"));
				item.put("sche_set", scheData.getJSONObject(i).getString("sche_set").trim());
				item.put("class_name", scheData.getJSONObject(i).getString("class_name"));
				item.put("class_no", scheData.getJSONObject(i).getString("class_no"));
				//
				if(flag){ 
					//读出非本周课程  ，  实训除外
					if(!course_type.equals("实训课")){
						item.put("arrangeFlag", "0");
						data.add(item); 
					}
					continue;
				}
				if(!course_type.equals("实训课")){
					String info [] = insertCheckMain(scheData.getJSONObject(i).getString("sche_no") ,currentWeek , term_no , null);
					item.put("check_main_no", info[0]); 
					item.put("check_main_status", info[1]);
				}else{
					//取得实训课考勤主表记录
					String get_sx="SELECT * FROM `qm_stu_check_main` WHERE sche_no = '"+scheData.getJSONObject(i).getString("sche_no")+"' AND term_no = '"+term_no+"' AND check_week = '"+currentWeek+"' and check_main_status = '1' ORDER BY check_week";
					ExecResult rep = jr.getSelectResult(get_sx, null, "");
					if(rep.getResult() > 0){
						item.put("sx_recored", rep.getData());
					}
				}
				
				data.add(item);
				//
			}
			result = new ExecResult(true, "成功返回考勤课程信息");
			result.setData(data);
		} else {
			result = new ExecResult(true, "没有查询到课程信息");
		}
		return result;
	}
	public String[] insertCheckMain(String sche_no , String currentWeek , String term_no , String set){
		JSONResponse jr = new JSONResponse();
		String selectId = "SELECT check_main_no , check_main_status FROM qm_stu_check_main WHERE sche_no='"
				+ sche_no+ "' AND check_week='" + currentWeek
				+ "' AND term_no='" + term_no + "' ";
		if(set != null){
			selectId += " AND check_sx = '"+set+"'";
		}
		ExecResult mainId = null;
		try {
			mainId = jr.getSelectResult(selectId, null, "base_teach_task");
		} catch (Exception e1) {
			return null;
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
			String insert_check_main = "";
			if(set != null){
				insert_check_main = "INSERT INTO qm_stu_check_main(sche_no , check_week ,term_no , check_sx) VALUES('"
						+ sche_no + "','" + currentWeek + "','" + term_no + "','" + set 
						+ "')"; 
			}else{ 
				insert_check_main = "INSERT INTO qm_stu_check_main(sche_no , check_week ,term_no) VALUES('"
						+ sche_no + "','" + currentWeek + "','" + term_no
						+ "')";
			}
			try {
				check_main_no = jr.getExecInsertId(insert_check_main, null, null, null).getMessage();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				return null;
			}
			check_main_status = "0"; 
		}
		return new String[]{check_main_no , check_main_status};
	}
	public ExecResult getStudentCheckInfo(String selectedWeek, String check_main_no, String term_no, String course_type,
			String class_no, String course_set, String sche_no) {
		String sql = "";
		String [] info = null; 
		if ("任选课".equals(course_type)) {
			sql = "select a.check_ktjl , a.check_jsws, c.student_no  as stu_no, e.check_no ,e.check_status , e.check_time , d.stu_name from qm_stu_check_main a "
					+ "left join base_task_sche b " + "on a.sche_no = b.sche_no " + "left join base_class_logic c "
					+ "on c.task_no = b.task_no and c.term_no='" + term_no + "' " + "left join base_student d "
					+ "on d.stu_no = c.student_no  AND d.stu_status ='1' " + "left join qm_stu_check e "
					+ "on e.stu_no = d.stu_no and e.check_main_no='" + check_main_no + "' "
					+ "where a.check_main_no = '" + check_main_no + "' ORDER BY c.`student_no`";
		} else {
			if(course_type.equals("实训课")){
				 info = insertCheckMain( sche_no ,  selectedWeek ,  term_no ,  course_set);
				sql = "select d.`check_jsws` , d.`check_ktjl`, a.stu_no , b.check_no ,b.check_status ,b.check_time,c.stu_name from base_term_student a "
						+ "left join qm_stu_check b " + "on a.stu_no = b.stu_no and b.check_main_no='" + info[0]
						+ "' " + "left join base_student c " + "on c.stu_no= a.stu_no  AND c.stu_status ='1' " + " LEFT JOIN `qm_stu_check_main` d ON b.`check_main_no` = d.`check_main_no` where a.class_no = '" + class_no
						+ "' and a.term_no='" + term_no + "' order by a.stu_no";
			}else{
				sql = "select d.`check_jsws` , d.`check_ktjl`, a.stu_no , b.check_no ,b.check_status ,b.check_time,c.stu_name from base_term_student a "
						+ "left join qm_stu_check b " + "on a.stu_no = b.stu_no and b.check_main_no='" + check_main_no 
						+ "' " + "left join base_student c " + "on c.stu_no= a.stu_no  AND c.stu_status ='1'" + " LEFT JOIN `qm_stu_check_main` d ON b.`check_main_no` = d.`check_main_no` where a.class_no = '" + class_no
						+ "' and a.term_no='" + term_no + "' order by a.stu_no";
			}
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
		if(info != null){
			result.setMessage(info[0]);
		}else{ 
			result.setMessage(check_main_no); 
		}
		return result;
	}
	public ExecResult postStuStatus(String check_main_no, String stu_no, String check_status) {
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
			String check_qj, String check_count, String check_ratio, String jsws, String ktjl ) {
		ExecResult result = null;
		JSONResponse jr = new JSONResponse();
		System.out.println(check_ratio);
		String sql = "UPDATE `qm_stu_check_main` SET ";
		sql += "check_main_status='1' ,check_kk='" + check_kk + "' ,check_cd='" + check_cd + "' , check_zt='" + check_zt
				+ "' , check_qj='" + check_qj + "' , check_ratio='" + check_ratio + "' ,check_count='" + check_count
				+ "'";
		if(jsws != null && ktjl !=null){
			sql+=" , check_jsws = '"+jsws+"' , check_ktjl = '"+ktjl+"'";
		}
		sql +="WHERE check_main_no='" + check_main_no + "'";
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
	public ExecResult checkRecordInfo(String currentWeek, String teacher_no, String term_no) {
		JSONResponse jr = new JSONResponse(); 
		String selectSche = "SELECT c.teacher_no, a.course_type, a.course_name , a.course_week ,  b.sche_no ,b.sche_set , IFNULL( c.class_name,d.logic_name) AS class_name ,c.class_no FROM base_teach_task a left JOIN base_task_sche b ON a.task_no=b.task_no LEFT JOIN base_classes c ON a.class_no=c.class_no LEFT JOIN base_class_logic d ON (a.task_no=d.task_no AND a.term_no=d.term_no) WHERE  a.teacher_no='"
				+ teacher_no + "' AND a.term_no='" + term_no + "' AND LEFT(a.course_week,2) <= "+currentWeek+" GROUP BY b.sche_no ORDER BY b.sche_set"; 
		// 得到所有Sche
		ExecResult scheInfo = jr.getSelectResult(selectSche, null, "base_teach_task");
		return scheInfo; 
	}
	public ExecResult checkRecordDetail(String course_week, String sche_no, String course_type) {
		JSONResponse jr = new JSONResponse(); 
		String selectSche = "SELECT * FROM `qm_stu_check_main` WHERE sche_no = '"+sche_no+"' ORDER BY check_week DESC"; 
		// 得到所有Sche
		ExecResult scheInfo = jr.getSelectResult(selectSche, null, "base_teach_task");
		return scheInfo; 
	}
}
