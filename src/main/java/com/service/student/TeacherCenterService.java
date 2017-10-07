package com.service.student;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

//与后台之间的交汇
public class TeacherCenterService {
	public ExecResult get_table_listen(String teacher_no,String term_no){//函数方法
		String sql="SELECT b.`teacher_no`,a.`total` FROM qm_master_listen a,base_teach_task b WHERE a.`task_no`=b.`task_no` AND b.`teacher_no`=''{0}'' AND b.`term_no`=''{1}''";
		String [] params=new String[] {teacher_no,term_no};//把数据保存在params中
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");
		//封装好的   依次次填数据库数据  params  和表的名称
		return result;//返回
	}
	
	public ExecResult loadtermyear(){//函数方法
		String sql="SELECT a.`class_session_year` FROM base_classes a GROUP BY a.`class_session_year` ORDER BY a.`class_session_year` DESC  ";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"qm_stu_survey");
		//封装好的   依次次填数据库数据  params  和表的名称
		return result;//返回
	}
	
	public ExecResult loadallclass(String class_year){//获取所有的班级
		String sql="SELECT *FROM base_classes a ,base_department b  WHERE a.`class_session_year`>='"+class_year+"' AND a.dep_no = b.`dep_no`  ORDER BY a.dep_no DESC ";
		String sql_deparment="SELECT * FROM base_department ";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"qm_stu_survey");
		ExecResult result_dep=jr.getSelectResult(sql_deparment, null,"qm_stu_survey");
		System.out.println("**************************************");
		System.out.println(result);
		System.out.println(result_dep);
		System.out.println("**************************************");
		JSONObject object = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		jsonArray=result.getData();
		JSONArray jsonArray_dep = new JSONArray();
		jsonArray_dep = result_dep.getData();
		int number = jsonArray_dep.size();
		JSONObject object_dep = new JSONObject();
		JSONObject jsonObject = new JSONObject();
		int class_year_1 = Integer.parseInt(class_year) + 1;//上一届
		int class_year_2 = Integer.parseInt(class_year) + 2;//再上一届
		for(int i = 0; i < jsonArray_dep.size() ; i ++ ){
			JSONObject jsonObject_ = new JSONObject();
			JSONArray jsonArray_ = new JSONArray();
			JSONArray jsonArray_1 = new JSONArray();
			JSONArray jsonArray_2 = new JSONArray();
			object_dep = jsonArray_dep.getJSONObject(i);
			String dep_no = object_dep.getString("dep_no");
			for(int j = 0 ; j < jsonArray.size() ; j ++){
				object = jsonArray.getJSONObject(j);
				if(dep_no.equals(object.get("dep_no"))){
					if(object.get("class_session_year").equals(class_year)){
						jsonArray_.add(object);
					}
					if(object.get("class_session_year").equals(String.valueOf(class_year_1))){
						jsonArray_1.add(object);
					}
					if(object.get("class_session_year").equals(String.valueOf(class_year_2))){
						jsonArray_2.add(object);
					}
				}	
			}
			jsonObject_.put(class_year, jsonArray_);
			jsonObject_.put(String.valueOf(class_year_1), jsonArray_1);
			jsonObject_.put(String.valueOf(class_year_2), jsonArray_2);
			jsonObject.put(String.valueOf(i),jsonObject_);//已经获取到不同院系的班级,但是年级还没有分
			
		}
		jsonObject.put("number",String.valueOf(number));
		//封装好的   依次次填数据库数据  params  和表的名称
		JSONArray data=new JSONArray();
		data.add(jsonObject);
		ExecResult er=new ExecResult();
		er.setResult(true);
		er.setMessage("");
		er.setData(data);
		return er;
	}
	
	public ExecResult load_time_attendance(String term_no,String time_one,String time_two){//函数方法
		String sql="SELECT *,AVG(check_ratio)AS ratio FROM (SELECT e.`dep_name`,e.dep_sort,LEFT(a.check_time,10) AS kq_time ,a.`check_ratio` FROM qm_stu_check_main a , base_task_sche b ,base_teach_task c ,base_department e,base_classes f  WHERE a.`sche_no`=b.`sche_no` AND b.`task_no`=c.`task_no`    AND a.`check_main_status`=''1'' AND a.`term_no`=''{0}'' AND c.`class_no`=f.`class_no` AND f.`dep_no`=e.`dep_no`)  tb1 WHERE tb1.kq_time >=''{1}'' AND tb1.kq_time <=''{2}'' GROUP BY tb1.dep_name ORDER BY tb1.dep_sort";
		String [] params=new String[] {term_no,time_one,time_two};//把数据保存在params中
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");//封装好的   依次次填数据库数据  params  和表的名称
		return result;//返回
	}
	
	public ExecResult load_time_college(String term_no,String dep_no,String time_one,String time_two){//函数方法
		String sql="SELECT *,AVG(check_ratio)AS ratio  FROM (SELECT e.`dep_name`,LEFT(a.check_time,10) AS kq_time ,a.`check_ratio`,f.`class_name`  FROM qm_stu_check_main a , base_task_sche b ,base_teach_task c ,base_department e,base_classes f   WHERE a.`sche_no`=b.`sche_no` AND b.`task_no`=c.`task_no`    AND a.`check_main_status`=''1'' AND a.`term_no`=''{0}''  AND c.`class_no`=f.`class_no` AND f.`dep_no`=e.`dep_no` AND f.`dep_no`=''{1}'')  tb1 WHERE tb1.kq_time >=''{2}'' AND tb1.kq_time <=''{3}''  GROUP BY tb1.class_name ORDER BY ratio DESC";
		String [] params=new String[] {term_no,dep_no,time_one,time_two};//把数据保存在params中
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");//封装好的   依次次填数据库数据  params  和表的名称
		return result;//返回
	}
	
	public ExecResult get_table_evaluate_numble(String teacher_no,String term_no){//函数方法
		String sql="SELECT a.`stu_no` FROM qm_stu_pj a,base_teach_task b WHERE a.`task_no`=b.`task_no`AND b.`teacher_no`=''{0}'' AND b.`term_no`=''{1}''";
		String [] params=new String[] {teacher_no,term_no};//把数据保存在params中
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");//封装好的   依次次填数据库数据  params  和表的名称
		return result;//返回
	}
	
	public ExecResult get_table_evaluate(String teacher_no,String term_no){//函数方法
		String sql="SELECT AVG (total) AS pj FROM qm_stu_pj a,base_teach_task b  WHERE a.`task_no`=b.`task_no` AND b.`teacher_no`=''{0}'' AND b.`term_no`=''{1}''";
		String [] params=new String[] {teacher_no,term_no};//把数据保存在params中
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");//封装好的   依次次填数据库数据  params  和表的名称
		return result;//返回
	}
	
	public ExecResult get_table_px(String teacher_no,String term_no){//函数方法
		String sql="SELECT tb1.course_name,tb1.class_name,tb2.total FROM(SELECT  a.course_name , c.class_name  FROM base_teach_task a,base_teacher b, base_classes c  WHERE a.teacher_no=b.teacher_no AND b.teacher_no=''{0}'' AND a.term_no=''{1}''  AND c.class_no=a.class_no) tb1 LEFT JOIN (SELECT a.total ,b.course_name,c.`class_name` FROM qm_tea_px a , base_teach_task b,base_classes c WHERE a.`task_no`=b.task_no AND b.class_no=c.`class_no`) tb2 ON tb1.class_name=tb2.class_name AND tb1.course_name=tb2.course_name";
		String [] params=new String[] {teacher_no,term_no};//把数据保存在params中
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");//封装好的   依次次填数据库数据  params  和表的名称
		return result;//返回
	}
	
	public ExecResult get_stu_checking_no(String teacher_no_one,String term_no_one,String term_no_two,String teacher_no_two){//函数方法
		String sql="SELECT tb1.stu_no,tb1.stu_name,SUM(CASE tb2.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END ) kk,SUM(CASE tb2.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END ) cd,SUM(CASE tb2.check_status WHEN ''早退'' THEN totalcount ELSE 0 END ) zt, SUM(CASE tb2.check_status WHEN ''请假'' THEN totalcount ELSE 0 END ) qj FROM  (SELECT c.`stu_no` ,d.`stu_name`,COUNT(1)numble FROM base_teach_task a,base_classes b,base_term_student c,base_student d WHERE a.`teacher_no`=''{0}'' AND a.`class_no`=b.`class_no` AND c.`stu_no`=d.`stu_no` AND b.`class_no`=c.`class_no`AND a.`term_no`=''{1}'' GROUP BY c.`stu_no`,d.`stu_name`) tb1 LEFT JOIN (SELECT a.`stu_no`,a.`check_status` ,COUNT(1)totalcount FROM qm_stu_check a,qm_stu_check_main b,base_task_sche c, base_teach_task d WHERE a.`check_main_no`=b.`check_main_no` AND b.`check_main_status`=''1'' AND b.`term_no`=''{2}'' AND b.`sche_no`=c.`sche_no` AND c.`task_no`=d.`task_no` AND d.`teacher_no`=''{3}'' GROUP BY stu_no) tb2 ON tb1.stu_no=tb2.stu_no GROUP BY tb1.stu_no,tb1.stu_name HAVING (SUM(CASE tb2.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END )=0  AND SUM(CASE tb2.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END )=0 AND SUM(CASE tb2.check_status WHEN ''早退'' THEN totalcount ELSE 0 END )=0 AND SUM(CASE tb2.check_status WHEN ''请假'' THEN totalcount ELSE 0 END )=0)";
		String [] params=new String[] {teacher_no_one,term_no_one,term_no_two,teacher_no_two};//把数据保存在params中
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");//封装好的   依次次填数据库数据  params  和表的名称
		return result;//返回
	}
	
	public ExecResult get_stu_checking_yes(String teacher_no_one,String term_no_one,String term_no_two,String teacher_no_two){//函数方法
		String sql="SELECT tb1.stu_no,tb1.stu_name,SUM(CASE tb2.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END ) kk,SUM(CASE tb2.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END ) cd,SUM(CASE tb2.check_status WHEN ''早退'' THEN totalcount ELSE 0 END ) zt, SUM(CASE tb2.check_status WHEN ''请假'' THEN totalcount ELSE 0 END ) qj FROM  (SELECT c.`stu_no` ,d.`stu_name`,COUNT(1)numble FROM base_teach_task a,base_classes b,base_term_student c,base_student d WHERE a.`teacher_no`=''{0}'' AND a.`class_no`=b.`class_no` AND c.`stu_no`=d.`stu_no` AND b.`class_no`=c.`class_no`AND a.`term_no`=''{1}'' GROUP BY c.`stu_no`,d.`stu_name`) tb1 LEFT JOIN (SELECT a.`stu_no`,a.`check_status` ,COUNT(1)totalcount FROM qm_stu_check a,qm_stu_check_main b,base_task_sche c, base_teach_task d WHERE a.`check_main_no`=b.`check_main_no` AND b.`check_main_status`=''1'' AND b.`term_no`=''{2}'' AND b.`sche_no`=c.`sche_no` AND c.`task_no`=d.`task_no` AND d.`teacher_no`=''{3}'' GROUP BY stu_no) tb2 ON tb1.stu_no=tb2.stu_no GROUP BY tb1.stu_no,tb1.stu_name HAVING NOT (SUM(CASE tb2.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END )=0  AND SUM(CASE tb2.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END )=0 AND SUM(CASE tb2.check_status WHEN ''早退'' THEN totalcount ELSE 0 END )=0)";
		String [] params=new String[] {teacher_no_one,term_no_one,term_no_two,teacher_no_two};//把数据保存在params中
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");//封装好的   依次次填数据库数据  params  和表的名称
		return result;//返回
	}
	
	public ExecResult get_stu_checking_leave(String teacher_no_one,String term_no_one,String term_no_two,String teacher_no_two){//函数方法
		String sql="SELECT tb1.stu_no,tb1.stu_name,SUM(CASE tb2.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END ) kk,SUM(CASE tb2.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END ) cd,SUM(CASE tb2.check_status WHEN ''早退'' THEN totalcount ELSE 0 END ) zt, SUM(CASE tb2.check_status WHEN ''请假'' THEN totalcount ELSE 0 END ) qj FROM  (SELECT c.`stu_no` ,d.`stu_name`,COUNT(1)numble FROM base_teach_task a,base_classes b,base_term_student c,base_student d WHERE a.`teacher_no`=''{0}'' AND a.`class_no`=b.`class_no` AND c.`stu_no`=d.`stu_no` AND b.`class_no`=c.`class_no`AND a.`term_no`=''{1}'' GROUP BY c.`stu_no`,d.`stu_name`) tb1 LEFT JOIN (SELECT a.`stu_no`,a.`check_status` ,COUNT(1)totalcount FROM qm_stu_check a,qm_stu_check_main b,base_task_sche c, base_teach_task d WHERE a.`check_main_no`=b.`check_main_no` AND b.`check_main_status`=''1'' AND b.`term_no`=''{2}'' AND b.`sche_no`=c.`sche_no` AND c.`task_no`=d.`task_no` AND d.`teacher_no`=''{3}'' GROUP BY stu_no) tb2 ON tb1.stu_no=tb2.stu_no GROUP BY tb1.stu_no,tb1.stu_name HAVING NOT (SUM(CASE tb2.check_status WHEN ''请假'' THEN totalcount ELSE 0 END )=0)";
		String [] params=new String[] {teacher_no_one,term_no_one,term_no_two,teacher_no_two};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");
		return result;
	}
	/**
	 * 
	 * @param term_no
	 * @param dep_no
	 * @param grade_no
	 * @param starttime
	 * @param endtime
	 * @return 根据时间段查询不同年级的出勤率，也可以根据时间段查询
	 */
	public ExecResult get_grade_attendace(String term_no,String dep_no,String grade_no,String starttime,String endtime){
		if("".equals(starttime)||"".equals(endtime)||starttime==null ||endtime==null){
			String sql="SELECT * FROM (SELECT f.`class_name`, f.`class_no`,LEFT(f.class_no,4) AS grade, SUM(check_count) AS numble,  AVG(check_ratio) AS ratio   FROM qm_stu_check_main a , base_task_sche b ,base_teach_task c ,base_department e,base_classes f  WHERE a.`sche_no`=b.`sche_no` AND b.`task_no`=c.`task_no`    AND a.`check_main_status`=''1'' AND a.`term_no`=''{0}'' AND c.`class_no`=f.`class_no` AND f.`dep_no`=e.`dep_no`  AND e.`dep_no`= ''{1}'' GROUP BY f.`class_no`  ORDER BY ratio DESC) tb WHERE tb.grade=''{2}'' ORDER BY tb.ratio DESC";
			String [] params=new String[] {term_no,dep_no,grade_no};
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");
			return result;
		}else{
			String sql="SELECT*,AVG(tb.check_ratio) AS ratio,SUM(tb.check_count) AS numble FROM(SELECT f.`class_name`,a.`check_ratio`,a.`check_count`,LEFT(a.`check_time`,10) AS grade_time, f.`class_no`,f.class_session_year  AS grade FROM qm_stu_check_main a , base_task_sche b ,base_teach_task c ,base_department e,base_classes f  WHERE a.`sche_no`=b.`sche_no` AND b.`task_no`=c.`task_no`    AND a.`check_main_status`=''1'' AND a.`term_no`=''{0}'' AND c.`class_no`=f.`class_no` AND f.`dep_no`=e.`dep_no`  AND e.`dep_no`= ''{1}'') tb WHERE tb.grade=''{2}'' AND grade_time>=''{3}'' AND grade_time<=''{4}'' GROUP BY tb.class_no ORDER BY ratio DESC";
			String [] params=new String[] {term_no,dep_no,grade_no,starttime,endtime};
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");
			return result;
		}

	}
	
	public ExecResult get_school_attendancerate(String term_no){
		String sql="SELECT tb1.dep_name,SUM(check_count) AS numble, AVG(check_ratio) AS radio FROM(SELECT a.`check_ratio`,a.`check_count`,e.`dep_name`  FROM qm_stu_check_main a , base_task_sche b ,base_teach_task c ,base_department e,base_classes f WHERE a.`sche_no`=b.`sche_no` AND b.`task_no`=c.`task_no` AND a.`check_main_status`=''1''  AND a.`term_no`=''{0}'' AND c.`class_no`=f.`class_no`  AND f.`dep_no`=e.`dep_no`)tb1  LEFT JOIN base_department f ON tb1.dep_name=f.`dep_name` GROUP BY tb1.dep_name,f.dep_no  ORDER BY radio DESC";
		String [] params=new String[] {term_no};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");
		return result;
	}
	/**
	 * 
	 * @param term_no
	 * @param dep_name
	 * @param starttime
	 * @param endtime
	 * @return 获取院系的所有的班级
	 */
	public ExecResult get_college_attendancerate(String term_no,String dep_name,String starttime,String endtime){
		if("".equals(starttime)||"".equals(endtime)||starttime==null ||endtime==null){
			String sql="SELECT f.`class_name`,f.class_no, SUM(check_count) AS numble, AVG(check_ratio) AS ratio  FROM qm_stu_check_main a , base_task_sche b ,base_teach_task c ,base_department e,base_classes f WHERE a.`sche_no`=b.`sche_no` AND b.`task_no`=c.`task_no`   AND a.`check_main_status`=''1'' AND a.`term_no`=''{0}'' AND c.`class_no`=f.`class_no` AND f.`dep_no`=e.`dep_no` AND e.`dep_name`=''{1}'' GROUP BY f.`class_no`  ORDER BY ratio DESC  ";
			String [] params=new String[] {term_no,dep_name};
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");
			return result;
		}else{
			String sql="SELECT*,AVG(tb.check_ratio) AS ratio,SUM(tb.check_count) AS numble FROM  (SELECT f.`class_name`,f.class_no,a.`check_count`,a.`check_ratio`,LEFT(a.`check_time`,10) AS check_time FROM qm_stu_check_main a , base_task_sche b ,base_teach_task c ,base_department e,base_classes f WHERE a.`sche_no`=b.`sche_no` AND b.`task_no`=c.`task_no`   AND a.`check_main_status`=''1'' AND a.`term_no`=''{0}'' AND c.`class_no`=f.`class_no` AND f.`dep_no`=e.`dep_no` AND e.`dep_name`=''{1}'' AND check_time>''{2}'' AND check_time<''{3}'')tb GROUP BY tb.class_no ORDER BY ratio DESC ";
			String [] params=new String[] {term_no,dep_name,starttime,endtime};
			
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");
			return result;
		}

	}
	
	public ExecResult get_supervisor_tkjl(String teacher_no,String term_no){
	//	String sql="SELECT a.`total`,b.`course_name`,c.`class_name` FROM qm_master_listen a,base_teach_task b,base_classes c WHERE a.`teacher_no`=''{0}'' AND a.`task_no`=b.`task_no`AND b.`class_no`=c.`class_no` AND b.`term_no`=''{1}'' ORDER BY total DESC ";
		
		String sql = "SELECT a.total,b.course_name,c.class_name FROM qm_master_listen a LEFT JOIN base_teach_task b ON b.task_no=a.task_no LEFT JOIN base_classes c ON c.class_no=b.class_no WHERE b.term_no=''{1}'' AND a.teacher_no=''{0}'' ORDER BY total DESC";
		String [] params=new String[] {teacher_no,term_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_stu_survey");
		return result;
	}
	
	public ExecResult get_supervisor_jxrw(String master_teacher_no,String term_no){
		String sql="SELECT*FROM(SELECT a.mark_time,b.teacher_name FROM qm_master_mark a ,base_teacher b WHERE a.master_teacher_no=''{0}'' AND a.term_no=''{1}'' AND a.teacher_no=b.teacher_no  ORDER BY a.mark_time DESC) tb1 LIMIT 1";
		String [] params=new String[] {master_teacher_no,term_no};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_master_mark");
		return result;
	}
	
	public ExecResult get_supervisor_tkjh(String teacher_no,String term_no){
		String sql="SELECT *FROM (SELECT a.`set_time`,a.`plan_time`,a.`plan_week`,c.`teacher_name`,b.`course_name` FROM qm_master_listen_plan a,base_teach_task b,base_teacher c WHERE a.`teacher_no`=''{0}''AND a.`task_no`=b.`task_no` AND b.`term_no`AND b.`teacher_no`=c.`teacher_no`AND b.`term_no`=''{1}'' ORDER BY a.`plan_time`)tb1 LIMIT 1";
		String [] params=new String[] {teacher_no,term_no};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_master_mark");
		return result;
	}
	
	public ExecResult get_supervisor_xnkh(String college_no,String term_no){
		String sql="SELECT tb1.*,tb3.teacher_name FROM  (SELECT LEFT(term_no,4) AS year_no, teacher_no, AVG(total) AS total FROM  qm_teacher_judge GROUP BY year_no ,teacher_no) tb1  JOIN  (SELECT * FROM base_teacher WHERE dep_no=''{0}'')tb2  ON tb1.teacher_no=tb2.teacher_no  LEFT JOIN base_teacher tb3  ON tb3.teacher_no=tb1.teacher_no  WHERE year_no=''{1}'' ORDER BY total DESC LIMIT 1 ";
		String [] params=new String[] {college_no,term_no};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_master_mark");
		return result;
	}
	
	public ExecResult get_supervisor_bmsk(String term_no,String college_no){
		String sql="SELECT b.`course_name`,c.`teacher_name`,AVG(total)AS pj FROM qm_master_listen a,base_teach_task b,base_teacher c,base_department d WHERE a.`task_no`=b.`task_no` AND b.`term_no`=''{0}'' AND c.`teacher_no`=b.`teacher_no` AND c.`dep_no`=d.`dep_no` AND d.`dep_no`=''{1}'' GROUP BY c.`teacher_name` ORDER BY pj DESC";
		String [] params=new String[] {term_no,college_no};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_master_mark");
		return result;
	}
	
	public ExecResult get_supervisor_jxzl(String term_no,String college_no){
		String sql="SELECT * FROM (SELECT a.`total`,b.`teacher_name`,c.`dep_name` FROM qm_teacher_judge a,base_teacher b ,base_department c WHERE a.`teacher_no`=b.`teacher_no` AND b.`dep_no`=c.`dep_no` AND a.`term_no`=''{0}'' AND c.`dep_no`=''{1}'' ORDER BY a.`total` DESC) tb1 LIMIT 1";
		String [] params=new String[] {term_no,college_no};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_master_mark");
		return result;
	}
	
	public ExecResult get_supervisor_jspx(String term_no,String college_no){
		String sql="SELECT * FROM (SELECT a.`task_no`,a.`total`,b.`course_name`,c.`class_name`,AVG(total) AS pj FROM qm_tea_px a,base_teach_task b,base_classes c,base_department d WHERE a.`task_no`=b.`task_no` AND b.`class_no`=c.`class_no` AND c.`dep_no`=d.`dep_no`AND b.`term_no`=''{0}'' AND d.`dep_no`=''{1}'' GROUP BY c.`class_name` ORDER BY pj DESC)tb1 LIMIT 1";
		String [] params=new String[] {term_no,college_no};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_master_mark");
		return result;
	}
	
	public ExecResult loadCheckByClassNo(String term_no,String class_no){
		 String sql="SELECT tb1.stu_no,tb1.stu_name, "+
					"SUM(CASE tb2.check_status WHEN '旷课' THEN numble ELSE 0 END ) kk, "+
					"SUM(CASE tb2.check_status WHEN '迟到' THEN numble ELSE 0 END ) cd, "+
					"SUM(CASE tb2.check_status WHEN '早退' THEN numble ELSE 0 END ) zt, "+
					"SUM(CASE tb2.check_status WHEN '请假' THEN numble ELSE 0 END ) qj , "+
					"SUM( CASE tb2.check_status WHEN '旷课' OR '迟到' OR '早退' OR '请假' THEN numble ELSE 0 END) AS zh  "+
					"FROM(SELECT DISTINCT a.stu_no,b.stu_name FROM base_term_student a,base_student b,base_classes c  "+
					"WHERE a.class_no=c.`class_no` AND c.`class_no`='"+class_no+"'AND b.stu_no=a.stu_no) tb1  "+
					"LEFT JOIN(SELECT a.`stu_no`,a.`check_status`,COUNT(1) AS numble  "+
					"FROM qm_stu_check a ,qm_stu_check_main b,base_task_sche c,base_teach_task d,base_classes e   "+
					"WHERE a.`check_main_no`=b.`check_main_no` AND b.`check_main_status`='1' AND b.`sche_no`=c.`sche_no`  "+
					"AND c.`task_no`=d.`task_no` AND e.`class_no`='"+class_no+"' AND d.`class_no`=e.`class_no`  "+
					"AND b.`term_no`='"+term_no+"' GROUP BY a.stu_no,a.check_status) tb2   "+
					"ON tb1.stu_no=tb2.stu_no GROUP BY tb1.stu_no,tb1.stu_name   "+
					"ORDER BY zh DESC";
					JSONResponse jr=new JSONResponse();
					ExecResult result=jr.getSelectResult(sql, null,"qm_master_mark");
					return result;
	}
	
	public ExecResult get_college_pj(String term_no,String college_no){
		String sql="SELECT AVG(a.total) AS pj FROM qm_master_listen a ,base_teach_task b, base_teacher c WHERE a.`task_no`=b.`task_no` AND b.`term_no`=''{0}'' AND b.`teacher_no`=c.`teacher_no` AND c.`dep_no`=''{1}''";
		String [] params=new String[] {term_no,college_no};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_master_mark");
		return result;
	}
	
	public ExecResult get_school_pj(String term_no){
		String sql="SELECT AVG(a.total) AS pj  FROM qm_master_listen a ,base_teach_task b WHERE a.`task_no`=b.`task_no` AND b.`term_no`=''{0}''";
		String [] params=new String[] {term_no};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_master_mark");
		return result;
	}
	
	public ExecResult get_class_attendancerate(String term_no,String dep_no){
		String sql="SELECT*,MAX(radio) AS zd,MIN(radio)AS zx,AVG(radio) AS pj FROM (SELECT e.`dep_name`,a.`check_ratio`,AVG(a.`check_ratio`)AS radio FROM qm_stu_check_main a , base_task_sche b ,base_teach_task c , base_teacher d,base_department e,base_classes f  WHERE a.`sche_no`=b.`sche_no` AND b.`task_no`=c.`task_no`  AND a.`check_main_status`=''1'' AND a.`term_no`=''{0}''   AND c.`teacher_no`=d.`teacher_no`  AND f.`dep_no`=e.`dep_no` AND c.`class_no`=f.`class_no` AND e.`dep_no`=''{1}''  GROUP BY f.`class_name`) tb1 GROUP BY dep_name";
		String [] params=new String[] {term_no,dep_no};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_master_mark");
		return result;
	}
	/**
	 * 
	 * @param class_no_one
	 * @param term_no_one
	 * @param class_no_two
	 * @param term_no_two
	 * @param starttime
	 * @param endtime
	 * @return 根据时间段判断班级的出勤情况（也可以无日期）
	 */
	public ExecResult get_grade_xq(String class_no_one,String term_no_one,String class_no_two,String term_no_two,String starttime,String endtime){
		if("".equals(starttime)||"".equals(endtime)||starttime==null ||endtime==null){
			String sql="SELECT a.stu_no,a.stu_name, SUM(CASE a.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END ) kk,SUM(CASE a.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END ) cd,SUM(CASE a.check_status WHEN ''早退'' THEN totalcount ELSE 0 END ) zt,SUM(CASE a.check_status WHEN ''请假'' THEN totalcount ELSE 0 END ) qj, SUM( CASE a.check_status WHEN ''旷课'' OR ''迟到'' OR ''早退'' OR ''请假'' THEN totalcount ELSE 0 END) AS zh  FROM (SELECT tb1.stu_no ,tb1.stu_name,tb2.check_status ,tb2.totalcount,tb1.class_no FROM (SELECT a.stu_no,b.stu_name,a.`class_no` FROM base_term_student a,base_student b  WHERE a.stu_no=b.stu_no AND a.class_no=''{0}'' GROUP BY a.`stu_no`)tb1  LEFT JOIN (SELECT a.stu_no,a.stu_name,a.check_status,b.`class_no`,COUNT(1) AS totalcount FROM(SELECT a.`stu_no`,a.`check_status`,c.`stu_name`,b.`term_no` FROM  qm_stu_check a,qm_stu_check_main b,base_student c  WHERE a.`check_main_no`=b.`check_main_no` AND b.`check_main_status`=''1'' AND b.`term_no`=''{1}'' AND a.`stu_no`=c.`stu_no`) a,base_term_student b  WHERE a.stu_no=b.`stu_no` AND b.`class_no`=''{2}'' AND b.`term_no`=''{3}'' GROUP BY b.`stu_no`,a.check_status)tb2 ON tb1.stu_no=tb2.stu_no) a  GROUP BY a.stu_no order by zh desc";
			String [] params=new String[] {class_no_one,term_no_one,class_no_two,term_no_two};
			
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"qm_master_mark");
			return result;	
		}else{
			String sql ="SELECT a.stu_no,a.stu_name, SUM(CASE a.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END ) kk, SUM(CASE a.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END ) cd,SUM(CASE a.check_status WHEN ''早退'' THEN totalcount ELSE 0 END ) zt,SUM(CASE a.check_status WHEN ''请假'' THEN totalcount ELSE 0 END ) qj,  SUM( CASE a.check_status WHEN ''旷课'' OR ''迟到'' OR ''早退'' OR ''请假'' THEN totalcount ELSE 0 END) AS zh   FROM (SELECT tb1.stu_no ,tb1.stu_name,tb2.check_status ,tb2.totalcount,tb1.class_no  FROM (SELECT a.stu_no,b.stu_name,a.`class_no` FROM base_term_student a,base_student b  WHERE a.stu_no=b.stu_no AND a.class_no=''{0}'' GROUP BY a.`stu_no`)tb1  LEFT JOIN (SELECT a.stu_no,a.stu_name,a.check_status,b.`class_no`,COUNT(1) AS totalcount FROM (SELECT a.`stu_no`,a.`check_status`,c.`stu_name`,b.`term_no`,LEFT(b.`check_time`,10) AS grtime FROM  qm_stu_check a,qm_stu_check_main b,base_student c  WHERE a.`check_main_no`=b.`check_main_no`  AND b.`check_main_status`=''1'' AND b.`term_no`=''{1}'' AND a.`stu_no`=c.`stu_no`) a,base_term_student b  WHERE a.stu_no=b.`stu_no` AND b.`class_no`=''{2}'' AND b.`term_no`=''{3}'' AND grtime>=''{4}'' AND grtime<=''{5}''  GROUP BY b.`stu_no`,a.check_status)tb2 ON tb1.stu_no=tb2.stu_no) a   GROUP BY a.stu_no order by zh desc"; 			
			String [] params=new String[] {class_no_one,term_no_one,class_no_two,term_no_two,starttime,endtime};
			
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"qm_master_mark");
			return result;	
		}

	}
	/**
	 * 
	 * @param stu_no
	 * @param term_no
	 * @param starttime
	 * @param endtime
	 * @return 本学期的个人出勤详情，也可以根据时间段查询
 	 */
	public ExecResult get_checking_person(String stu_no,String term_no,String starttime,String endtime ){
		if("".equals(starttime)||"".equals(endtime)||starttime==null ||endtime==null){
			String sql="SELECT a.`check_main_no`, d.`course_name`,e.`teacher_name`,a.`check_status`,a.`check_time`,b.check_week, c.sche_set  FROM qm_stu_check a ,qm_stu_check_main b,base_task_sche c,base_teach_task d ,base_teacher e  WHERE a.`stu_no`=''{0}'' AND a.`check_main_no`=b.`check_main_no` AND b.`check_main_status`=''1'' AND b.`term_no`=''{1}'' AND b.`sche_no`=c.`sche_no` AND c.`task_no`=d.`task_no` AND d.`teacher_no`=e.`teacher_no` ORDER BY a.`check_time` DESC";
			String [] params=new String[] {stu_no,term_no };
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"qm_stu_check");
			return result;
		}else{
			String sql="SELECT*FROM(SELECT d.`course_name`,e.`teacher_name`,a.`check_status`,LEFT(a.`check_time`,10) AS grtime,b.check_week, c.sche_set  FROM qm_stu_check a ,qm_stu_check_main b,base_task_sche c,base_teach_task d ,base_teacher e  WHERE a.`stu_no`=''{0}'' AND a.`check_main_no`=b.`check_main_no` AND b.`check_main_status`=''1'' AND b.`term_no`=''{1}'' AND b.`sche_no`=c.`sche_no` AND c.`task_no`=d.`task_no` AND d.`teacher_no`=e.`teacher_no` ORDER BY a.`check_time`) tb WHERE tb.grtime>=''{2}'' AND tb.grtime<=''{3}''";
			String [] params=new String[] {stu_no,term_no,starttime,endtime};
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"qm_stu_check");
			return result;
		}

	}
}




