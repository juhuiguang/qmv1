package com.service.student;

import java.awt.List;
import java.text.DecimalFormat;
import java.util.LinkedList;
import java.util.Map;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

//与后台之间的交汇
public class Student_checking_Service {
	
	public ExecResult get_checking_stu(String class_name_one,String term_no_one ,String term_no_two,String teacher_no,String class_name_two,String course_name){
		String sql="SELECT tb1.stu_no,tb1.stu_name,SUM(CASE tb2.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END ) kk,SUM(CASE tb2.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END ) cd,SUM(CASE tb2.check_status WHEN ''早退'' THEN totalcount ELSE 0 END ) zt, SUM(CASE tb2.check_status WHEN ''请假'' THEN totalcount ELSE 0 END ) qj,SUM( CASE tb2.check_status WHEN ''旷课'' OR ''迟到'' OR ''早退'' OR ''请假'' THEN totalcount ELSE 0 END) AS zh  FROM (SELECT a.stu_no,b.stu_name FROM base_term_student a,base_student b,base_classes c WHERE a.class_no=c.`class_no` AND c.class_name=''{0}'' AND a.term_no=''{1}'' AND a.stu_no=b.stu_no) tb1 LEFT JOIN (SELECT d.stu_no,d.check_status,COUNT(1) totalcount FROM qm_stu_check_main c,qm_stu_check d,base_task_sche e,base_teach_task f,base_classes g WHERE check_main_status=''1'' AND c.term_no=''{2}'' AND c.check_main_no=d.check_main_no AND e.sche_no=c.sche_no AND f.task_no=e.task_no AND f.teacher_no=''{3}'' AND f.class_no=g.class_no AND g.class_name=''{4}''AND f.course_name=''{5}'' GROUP BY d.stu_no,d.check_status)  tb2 ON tb1.stu_no=tb2.stu_no GROUP BY tb1.stu_no,tb1.stu_name ";
		String [] params=new String[] {class_name_one,term_no_one ,term_no_two, teacher_no,class_name_two,course_name};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult get_qq_sl(String one,String two ,String three,String four,String five,String six,String seven,String eight,String nine,String ten,String eleven,String twlef,String thirteen){
		String sql="SELECT COUNT(tb.stu_no) AS qjgs FROM (SELECT a.`stu_no`,a.`check_status`,COUNT(1) AS numble FROM qm_stu_check a,qm_stu_check_main b,base_task_sche c,base_teach_task d,base_term_student e,base_classes f WHERE a.`check_main_no`=b.`check_main_no` AND b.`sche_no`=c.`sche_no` AND c.`task_no`=d.`task_no` AND d.`course_name`=''{0}'' AND d.`teacher_no`=''{1}'' AND b.`term_no`=''{2}'' AND b.`check_main_status`=''1'' AND a.`stu_no`=e.`stu_no` AND e.`class_no`=f.`class_no` AND f.`class_name`=''{3}'' AND a.`check_status`<>''请假'' GROUP BY a.`stu_no`,a.`check_status`)tb UNION ALL SELECT COUNT(tb.stu_no) AS qjgs FROM (SELECT a.`stu_no`,a.`check_status`,COUNT(1) AS numble FROM qm_stu_check a,qm_stu_check_main b,base_task_sche c,base_teach_task d,base_term_student e,base_classes f WHERE a.`check_main_no`=b.`check_main_no` AND b.`sche_no`=c.`sche_no` AND c.`task_no`=d.`task_no` AND d.`course_name`=''{4}'' AND d.`teacher_no`=''{5}'' AND b.`term_no`=''{6}'' AND b.`check_main_status`='1' AND a.`stu_no`=e.`stu_no` AND e.`class_no`=f.`class_no` AND f.`class_name`=''{7}'' AND a.`check_status`=''请假'' AND a.check_status<>''旷课''AND a.check_status<>''迟到''AND a.check_status<>''早退'' GROUP BY a.`stu_no`,a.`check_status`)tb UNION ALL SELECT COUNT(1) AS qjgs FROM(SELECT *FROM(SELECT tb1.stu_no,tb1.stu_name, SUM( CASE tb2.check_status WHEN ''旷课'' OR ''迟到'' OR ''早退'' OR ''请假'' THEN totalcount ELSE 0 END) AS zh  FROM (SELECT a.stu_no,b.stu_name FROM base_term_student a,base_student b,base_classes c  WHERE a.class_no=c.`class_no` AND c.`class_name`=''{8}'' AND a.stu_no=b.stu_no) tb1  LEFT JOIN (SELECT d.stu_no,d.check_status,COUNT(1) totalcount   FROM qm_stu_check_main c,qm_stu_check d,base_task_sche e,base_teach_task f,base_classes g  WHERE check_main_status=''1'' AND c.term_no=''{9}'' AND c.check_main_no=d.check_main_no  AND e.sche_no=c.sche_no AND f.task_no=e.task_no AND f.teacher_no=''{10}''  AND f.class_no=g.`class_no` AND g.`class_name`=''{11}''  AND f.`course_name`=''{12}'' GROUP BY d.stu_no,d.check_status) tb2 ON tb1.stu_no=tb2.stu_no  GROUP BY tb1.stu_no,tb1.stu_name) tb WHERE tb.zh=0) tb2";
		String [] params=new String[] {one,two,three,four,five,six,seven,eight,nine,ten,eleven,twlef,thirteen};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult getchange(String check_status,String stu_no,String check_time){
		String sql="UPDATE qm_stu_check  SET `check_status`=''{0}'' WHERE `stu_no`=''{1}'' AND `check_time`=''{2}''";
		String [] params=new String[] {check_status,stu_no,check_time};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getExecResult(sql, params,"","");
		return result;
	}
	
	public ExecResult get_checking_stu_college(String dep_no_one,String term_no_one ,String term_no_two){
		String sql="SELECT tb1.stu_no,tb1.stu_name,tb1.class_name,SUM(CASE tb2.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END ) kk,SUM(CASE tb2.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END ) cd,SUM(CASE tb2.check_status WHEN ''早退'' THEN totalcount ELSE 0 END ) zt,SUM( CASE tb2.check_status WHEN ''旷课'' OR ''迟到'' OR ''早退''  THEN totalcount ELSE 0 END) AS zh  FROM (SELECT a.`class_name`,b.`stu_no`,c.`stu_name`FROM base_classes  a , base_term_student b, base_student c WHERE a.`dep_no`=''{0}'' AND b.`term_no`=''{1}'' AND a.`class_no`=b.`class_no`AND b.`stu_no`=c.`stu_no`)tb1 LEFT JOIN(SELECT a.`stu_no`,a.`check_status`,COUNT(1) AS totalcount FROM qm_stu_check a,qm_stu_check_main b WHERE a.`check_main_no`=b.`check_main_no` AND b.`term_no`=''{2}'' AND b.`check_main_status`=''1'' AND a.`check_status`!=''请假''  GROUP BY a.stu_no,a.`check_status`) tb2 ON tb1.stu_no=tb2.stu_no GROUP BY tb1.stu_no,tb1.stu_name HAVING NOT (SUM(CASE tb2.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END )=0 AND SUM(CASE tb2.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END )=0 AND SUM(CASE tb2.check_status WHEN ''早退'' THEN totalcount ELSE 0 END )=0 ) order by zh desc ";
		String [] params=new String[] {dep_no_one,term_no_one ,term_no_two};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"tb1.stu_no");
		return result;
	}
	
	public ExecResult get_checking_stu_school(String term_no_one ,String term_no_two){
		String sql="SELECT tb1.dep_name , tb1.stu_no , tb1.stu_name , tb1.class_name ,SUM(CASE tb2.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END ) kk,SUM(CASE tb2.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END ) cd,SUM(CASE tb2.check_status WHEN ''早退'' THEN totalcount ELSE 0 END ) zt,SUM( CASE tb2.check_status WHEN ''旷课'' OR ''迟到'' OR ''早退''  THEN totalcount ELSE 0 END) AS zh  FROM ( SELECT a.`stu_no`,b.`stu_name`,c.`class_name`,d.`dep_name`FROM base_term_student a,base_student b,base_classes c,base_department d WHERE a.`term_no`=''{0}''AND a.`stu_no`=b.`stu_no`AND a.`class_no`=c.`class_no` AND c.`dep_no`=d.`dep_no` )tb1  LEFT JOIN (SELECT a.`stu_no`,a.`check_status`,COUNT(1) AS totalcount FROM qm_stu_check a,qm_stu_check_main b WHERE a.`check_main_no`=b.`check_main_no` AND b.`term_no`=''{1}'' AND b.`check_main_status`=''1'' AND a.`check_status`!=''请假''  GROUP BY a.stu_no,a.`check_status`) tb2 ON tb1.stu_no=tb2.stu_no GROUP BY tb1.stu_no,tb1.stu_name HAVING NOT (SUM(CASE tb2.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END )=0  AND SUM(CASE tb2.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END )=0 AND SUM(CASE tb2.check_status WHEN ''早退'' THEN totalcount ELSE 0 END )=0) order by zh desc";
		String [] params=new String[] {term_no_one ,term_no_two};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"tb1.stu_no");
		return result;
	}
	
	public ExecResult get_checking_stu_yes(String class_name_one,String term_no_one ,String term_no_two,String teacher_no,String class_name_two,String course_name){
		String sql="SELECT tb1.stu_no,tb1.stu_name,SUM(CASE tb2.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END ) kk,SUM(CASE tb2.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END ) cd,SUM(CASE tb2.check_status WHEN ''早退'' THEN totalcount ELSE 0 END ) zt, SUM(CASE tb2.check_status WHEN ''请假'' THEN totalcount ELSE 0 END ) qj,SUM( CASE tb2.check_status WHEN ''旷课'' OR ''迟到'' OR ''早退'' OR ''请假'' THEN totalcount ELSE 0 END) AS zh  FROM (SELECT a.stu_no,b.stu_name FROM base_term_student a,base_student b,base_classes c WHERE a.class_no=c.`class_no` AND c.`class_name`=''{0}'' AND a.term_no=''{1}'' AND a.stu_no=b.stu_no) tb1 LEFT JOIN (SELECT d.stu_no,d.check_status,COUNT(1) totalcount  FROM qm_stu_check_main c,qm_stu_check d,base_task_sche e,base_teach_task f,base_classes g WHERE check_main_status=''1'' AND c.term_no=''{2}'' AND c.check_main_no=d.check_main_no AND e.sche_no=c.sche_no AND f.task_no=e.task_no AND f.teacher_no=''{3}'' AND f.class_no=g.`class_no` AND g.`class_name`=''{4}''  AND f.`course_name`=''{5}''GROUP BY d.stu_no,d.check_status) tb2 ON tb1.stu_no=tb2.stu_no GROUP BY tb1.stu_no,tb1.stu_name HAVING NOT (SUM(CASE tb2.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END )=0 AND SUM(CASE tb2.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END )=0 AND SUM(CASE tb2.check_status WHEN ''早退'' THEN totalcount ELSE 0 END )=0 AND SUM(CASE tb2.check_status WHEN ''请假'' THEN totalcount ELSE 0 END )=0)";
		String [] params=new String[] {class_name_one,term_no_one ,term_no_two, teacher_no,class_name_two,course_name};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult get_checking_stu_yes_chart(String class_name_one,String term_no_one ,String term_no_two,String teacher_no,String class_name_two,String course_name){
		String sql="SELECT tb1.stu_no,tb1.stu_name,SUM(CASE tb2.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END ) kk,SUM(CASE tb2.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END ) cd,SUM(CASE tb2.check_status WHEN ''早退'' THEN totalcount ELSE 0 END ) zt, SUM(CASE tb2.check_status WHEN ''请假'' THEN totalcount ELSE 0 END ) qj,SUM( CASE tb2.check_status WHEN ''旷课'' OR ''迟到'' OR ''早退'' OR ''请假'' THEN totalcount ELSE 0 END) AS zh  FROM (SELECT a.stu_no,b.stu_name FROM base_term_student a,base_student b,base_classes c WHERE a.class_no=c.`class_no` AND c.`class_name`=''{0}'' AND a.term_no=''{1}'' AND a.stu_no=b.stu_no) tb1 LEFT JOIN (SELECT d.stu_no,d.check_status,COUNT(1) totalcount  FROM qm_stu_check_main c,qm_stu_check d,base_task_sche e,base_teach_task f,base_classes g WHERE check_main_status=''1'' AND c.term_no=''{2}'' AND c.check_main_no=d.check_main_no AND e.sche_no=c.sche_no AND f.task_no=e.task_no AND f.teacher_no=''{3}'' AND f.class_no=g.`class_no` AND g.`class_name`=''{4}''  AND f.`course_name`=''{5}''GROUP BY d.stu_no,d.check_status) tb2 ON tb1.stu_no=tb2.stu_no GROUP BY tb1.stu_no,tb1.stu_name HAVING NOT (SUM(CASE tb2.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END )=0 AND SUM(CASE tb2.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END )=0 AND SUM(CASE tb2.check_status WHEN ''早退'' THEN totalcount ELSE 0 END )=0)";
		String [] params=new String[] {class_name_one,term_no_one ,term_no_two, teacher_no,class_name_two,course_name};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult get_checking_stu_yes_chart_leave(String class_name_one,String term_no_one ,String term_no_two,String teacher_no,String class_name_two,String course_name){
		String sql="SELECT tb1.stu_no,tb1.stu_name,SUM(CASE tb2.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END ) kk,SUM(CASE tb2.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END ) cd,SUM(CASE tb2.check_status WHEN ''早退'' THEN totalcount ELSE 0 END ) zt, SUM(CASE tb2.check_status WHEN ''请假'' THEN totalcount ELSE 0 END ) qj,SUM( CASE tb2.check_status WHEN ''旷课'' OR ''迟到'' OR ''早退'' OR ''请假'' THEN totalcount ELSE 0 END) AS zh  FROM (SELECT a.stu_no,b.stu_name FROM base_term_student a,base_student b,base_classes c WHERE a.class_no=c.`class_no` AND c.`class_name`=''{0}'' AND a.term_no=''{1}'' AND a.stu_no=b.stu_no) tb1 LEFT JOIN (SELECT d.stu_no,d.check_status,COUNT(1) totalcount  FROM qm_stu_check_main c,qm_stu_check d,base_task_sche e,base_teach_task f,base_classes g WHERE check_main_status=''1'' AND c.term_no=''{2}'' AND c.check_main_no=d.check_main_no AND e.sche_no=c.sche_no AND f.task_no=e.task_no AND f.teacher_no=''{3}'' AND f.class_no=g.`class_no` AND g.`class_name`=''{4}''  AND f.`course_name`=''{5}''GROUP BY d.stu_no,d.check_status) tb2 ON tb1.stu_no=tb2.stu_no GROUP BY tb1.stu_no,tb1.stu_name HAVING NOT (SUM(CASE tb2.check_status WHEN ''请假'' THEN totalcount ELSE 0 END )=0)";
		String [] params=new String[] {class_name_one,term_no_one ,term_no_two, teacher_no,class_name_two,course_name};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult get_checking_stu_no(String class_name_one,String term_no_one ,String term_no_two,String teacher_no,String class_name_two,String course_name){
		String sql="SELECT tb1.stu_no,tb1.stu_name,SUM(CASE tb2.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END ) kk,SUM(CASE tb2.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END ) cd,SUM(CASE tb2.check_status WHEN ''早退'' THEN totalcount ELSE 0 END ) zt, SUM(CASE tb2.check_status WHEN ''请假'' THEN totalcount ELSE 0 END ) qj,SUM( CASE tb2.check_status WHEN ''旷课'' OR ''迟到'' OR ''早退'' OR ''请假'' THEN totalcount ELSE 0 END) AS zh FROM (SELECT a.stu_no,b.stu_name FROM base_term_student a,base_student b,base_classes c WHERE a.class_no=c.`class_no` AND c.`class_name`=''{0}'' AND a.term_no=''{1}'' AND a.stu_no=b.stu_no) tb1 LEFT JOIN (SELECT d.stu_no,d.check_status,COUNT(1) totalcount  FROM qm_stu_check_main c,qm_stu_check d,base_task_sche e,base_teach_task f,base_classes g WHERE check_main_status=''1'' AND c.term_no=''{2}'' AND c.check_main_no=d.check_main_no AND e.sche_no=c.sche_no AND f.task_no=e.task_no AND f.teacher_no=''{3}'' AND f.class_no=g.`class_no` AND g.`class_name`=''{4}''  AND f.`course_name`=''{5}''GROUP BY d.stu_no,d.check_status) tb2 ON tb1.stu_no=tb2.stu_no GROUP BY tb1.stu_no,tb1.stu_name HAVING SUM(CASE tb2.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END )=0 AND SUM(CASE tb2.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END )=0 AND SUM(CASE tb2.check_status WHEN ''早退'' THEN totalcount ELSE 0 END )=0 AND SUM(CASE tb2.check_status WHEN ''请假'' THEN totalcount ELSE 0 END )=0";
		String [] params=new String[] {class_name_one,term_no_one ,term_no_two, teacher_no,class_name_two,course_name};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult get_checking_class(String teacher_no_flag,String term_no ){
		String sql="SELECT  a.course_name , c.class_name FROM base_teach_task a,base_teacher b, base_classes c WHERE a.teacher_no=b.teacher_no AND b.teacher_no=''{0}'' AND a.term_no=''{1}'' AND c.class_no=a.class_no";
		String [] params=new String[] {teacher_no_flag,term_no };
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult get_checking_classcenter(String teacher_no,String term_no ){
		String sql="SELECT a.`class_no`, b.`course_name`,a.`class_name`FROM  base_classes a,base_teach_task b WHERE a.`teacher_no`=''{0}'' AND b.`term_no`=''{1}''  AND a.`class_no`=b.`class_no` GROUP BY b.`course_name` ORDER BY b.`course_name` DESC ";
		String [] params=new String[] {teacher_no,term_no };
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult loadxqjl(String stu_no,String term_no ){
		String sql="SELECT*, SUM(CASE tb1.check_status WHEN ''旷课'' THEN totalcount ELSE 0 END ) kk, SUM(CASE tb1.check_status WHEN ''迟到'' THEN totalcount ELSE 0 END ) cd, SUM(CASE tb1.check_status WHEN ''早退'' THEN totalcount ELSE 0 END ) zt FROM(SELECT a.`check_status`,d.`course_name`,e.`teacher_name`,f.`stu_name`,COUNT(1) AS totalcount FROM qm_stu_check a,qm_stu_check_main b,base_task_sche c,base_teach_task d,base_teacher e,base_student f WHERE a.`stu_no`=''{0}'' AND a.`check_status`<>''请假'' AND b.`check_main_status`=''1'' AND a.`check_main_no`=b.`check_main_no` AND b.`term_no`=''{1}'' AND b.`sche_no`=c.`sche_no` AND c.`task_no`=d.`task_no` AND d.`teacher_no`=e.`teacher_no` AND a.`stu_no`=f.`stu_no` GROUP BY d.`course_name`,a.`check_status`) tb1 GROUP BY tb1.course_name ";
		String [] params=new String[] {stu_no,term_no };
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult get_checking_term(){
		String sql="SELECT a.`term_no`,a.`term_name`,a.`term_startdate`,a.`term_enddate` FROM base_term a";	
		String [] params=new String[] {};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_term");
		return result;
	}
	
	public ExecResult getdelete(String stu_no,String check_time){
		String sql="DELETE FROM qm_stu_check  WHERE stu_no=''{0}'' AND check_time=''{1}''";
		String [] params=new String[] {stu_no, check_time};
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getExecResult(sql, params, "", "");
		return result;//返回
	}
	
	public ExecResult loadstu_xq(String stu_no,String term_no,String teacher_no){
		String sql="SELECT a.`stu_no`,a.`check_status`,a.`check_time`,b.check_week,e.`stu_name`,d.`course_name`,c.`sche_set` FROM qm_stu_check a,qm_stu_check_main b,base_task_sche c,base_teach_task d,base_student e  WHERE a.`stu_no`='"+stu_no+"'AND a.`check_main_no`=b.`check_main_no` AND b.`check_main_status`='1' AND b.`term_no`='"+term_no+"' AND b.`sche_no`=c.`sche_no` AND c.`task_no`=d.`task_no` AND d.`teacher_no`='"+teacher_no+"'  AND a.`stu_no`=e.`stu_no`";	
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"base_term");
		return result;
	}
	
	
	public ExecResult get_checking_person(String stu_no,String term_no ){
		String sql="SELECT d.`course_name`,d.`task_no`,e.`teacher_name`,a.`check_status`,a.`check_time`,b.check_week,c.`sche_set` FROM qm_stu_check a ,qm_stu_check_main b,base_task_sche c,base_teach_task d ,base_teacher e  WHERE a.`stu_no`=''{0}'' AND a.`check_main_no`=b.`check_main_no` AND b.`check_main_status`=''1'' AND b.`term_no`=''{1}'' AND b.`sche_no`=c.`sche_no` AND c.`task_no`=d.`task_no` AND d.`teacher_no`=e.`teacher_no` ORDER BY a.`check_time`";
		String [] params=new String[] {stu_no,term_no };
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_stu_check");
		return result;
	}
	
	public ExecResult get_classes_checking(String class_name_one,String class_name_two,String course_name,String term_no,String selected ){
		if("ALL".equals(selected)){
			System.out.println("123");
			String sql="SELECT tb1.stu_no,tb1.stu_name,SUM(CASE tb2.check_status WHEN '旷课' THEN numble ELSE 0 END ) kk,SUM(CASE tb2.check_status WHEN '迟到' THEN numble ELSE 0 END ) cd,SUM(CASE tb2.check_status WHEN '早退' THEN numble ELSE 0 END ) zt, SUM(CASE tb2.check_status WHEN '请假' THEN numble ELSE 0 END ) qj ,SUM( CASE tb2.check_status WHEN '旷课' OR '迟到' OR '早退' OR '请假' THEN numble ELSE 0 END) AS zh  FROM(SELECT DISTINCT a.stu_no,b.stu_name FROM base_term_student a,base_student b,base_classes c WHERE a.class_no=c.`class_no` AND c.`class_name`='"+class_name_one+"'AND b.stu_no=a.stu_no) tb1 LEFT JOIN(SELECT a.`stu_no`,a.`check_status`,COUNT(1) AS numble FROM qm_stu_check a ,qm_stu_check_main b,base_task_sche c,base_teach_task d,base_classes e  WHERE a.`check_main_no`=b.`check_main_no` AND b.`check_main_status`='1' AND b.`sche_no`=c.`sche_no` AND c.`task_no`=d.`task_no` AND e.`class_name`='"+class_name_one+"' AND d.`class_no`=e.`class_no` AND b.`term_no`='"+term_no+"' GROUP BY a.stu_no,a.check_status) tb2 ON tb1.stu_no=tb2.stu_no GROUP BY tb1.stu_no,tb1.stu_name ORDER BY zh DESC  ";
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql,null,"qm_stu_check");
			return result;
		}else{
			String sql="SELECT tb1.stu_no,tb1.stu_name,SUM(CASE tb2.check_status WHEN ''旷课'' THEN numble ELSE 0 END ) kk,SUM(CASE tb2.check_status WHEN ''迟到'' THEN numble ELSE 0 END ) cd,SUM(CASE tb2.check_status WHEN ''早退'' THEN numble ELSE 0 END ) zt, SUM(CASE tb2.check_status WHEN ''请假'' THEN numble ELSE 0 END ) qj ,SUM( CASE tb2.check_status WHEN ''旷课'' OR ''迟到'' OR ''早退'' OR ''请假'' THEN numble ELSE 0 END) AS zh  FROM(SELECT DISTINCT a.stu_no,b.stu_name FROM base_term_student a,base_student b,base_classes c WHERE a.class_no=c.`class_no` AND c.`class_name`=''{0}''AND b.stu_no=a.stu_no) tb1 LEFT JOIN(SELECT a.`stu_no`,a.`check_status`,COUNT(1) AS numble FROM qm_stu_check a ,qm_stu_check_main b,base_task_sche c,base_teach_task d,base_classes e  WHERE a.`check_main_no`=b.`check_main_no` AND b.`check_main_status`=''1'' AND b.`sche_no`=c.`sche_no` AND c.`task_no`=d.`task_no` AND e.`class_name`=''{1}''  AND d.`course_name`=''{2}'' AND d.`class_no`=e.`class_no` AND b.`term_no`=''{3}'' GROUP BY a.stu_no,a.check_status) tb2 ON tb1.stu_no=tb2.stu_no GROUP BY tb1.stu_no,tb1.stu_name ORDER BY zh DESC  ";
			String [] params=new String[] {class_name_one,class_name_two,course_name, term_no};
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, params,"qm_stu_check");
			return result;	
		}
		
	}
	
	public ExecResult get_classes_checking_yes(String class_name_one,String class_name_two,String course_name,String term_no ){
		String sql="SELECT tb1.stu_no,tb1.stu_name,SUM(CASE tb2.check_status WHEN ''旷课'' THEN numble ELSE 0 END ) kk,SUM(CASE tb2.check_status WHEN ''迟到'' THEN numble ELSE 0 END ) cd,SUM(CASE tb2.check_status WHEN ''早退'' THEN numble ELSE 0 END ) zt, SUM(CASE tb2.check_status WHEN ''请假'' THEN numble ELSE 0 END ) qj ,SUM( CASE tb2.check_status WHEN ''旷课'' OR ''迟到'' OR ''早退'' OR ''请假'' THEN numble ELSE 0 END) AS zh  FROM(SELECT a.stu_no,b.stu_name FROM base_term_student a,base_student b,base_classes c WHERE a.class_no=c.`class_no` AND c.`class_name`=''{0}'' AND a.stu_no=b.stu_no) tb1 LEFT JOIN(SELECT a.`stu_no`,a.`check_status`,COUNT(1) AS numble FROM qm_stu_check a ,qm_stu_check_main b,base_task_sche c,base_teach_task d,base_classes e  WHERE a.`check_main_no`=b.`check_main_no` AND b.`check_main_status`=''1'' AND b.`sche_no`=c.`sche_no` AND c.`task_no`=d.`task_no` AND e.`class_name`=''{1}''  AND d.`course_name`=''{2}'' AND d.`class_no`=e.`class_no` AND b.`term_no`=''{3}'' GROUP BY a.stu_no,a.check_status) tb2 ON tb1.stu_no=tb2.stu_no GROUP BY tb1.stu_no,tb1.stu_name HAVING NOT (SUM(CASE tb2.check_status WHEN ''旷课'' THEN numble ELSE 0 END )=0 AND SUM(CASE tb2.check_status WHEN ''迟到'' THEN numble ELSE 0 END )=0 AND SUM(CASE tb2.check_status WHEN ''早退'' THEN numble ELSE 0 END )=0 AND SUM(CASE tb2.check_status WHEN ''请假'' THEN numble ELSE 0 END )=0)";

		String [] params=new String[] {class_name_one,class_name_two,course_name, term_no };
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"qm_stu_check");
		return result;
	}
	
	public ExecResult get_checking_person_coursename(String stu_no,String term_no,String task_no){
		String sql="SELECT*FROM(SELECT d.`course_name`,d.`task_no`,e.`teacher_name`,a.`check_status`,a.`check_time`,b.check_week,c.`sche_set` FROM qm_stu_check a ,qm_stu_check_main b,base_task_sche c,base_teach_task d ,base_teacher e  WHERE a.`stu_no`='"+stu_no+"' AND a.`check_main_no`=b.`check_main_no` AND b.`check_main_status`='1' AND b.`term_no`='"+term_no+"' AND b.`sche_no`=c.`sche_no` AND c.`task_no`=d.`task_no` AND d.`teacher_no`=e.`teacher_no` ORDER BY a.`check_time`) tb WHERE tb.task_no='"+task_no+"'";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"qm_stu_check");
		return result;
	}
	
	public ExecResult loadall_yeschecking(String term_no,String teacher_no){
		String sql="SELECT tb1.stu_no,tb1.stu_name,SUM(CASE tb2.check_status WHEN '旷课' THEN totalcount ELSE 0 END ) kk,SUM(CASE tb2.check_status WHEN '迟到' THEN totalcount ELSE 0 END ) cd,SUM(CASE tb2.check_status WHEN '早退' THEN totalcount ELSE 0 END ) zt, SUM(CASE tb2.check_status WHEN '请假' THEN totalcount ELSE 0 END ) qj,SUM( CASE tb2.check_status WHEN '旷课' OR '迟到' OR '早退' OR '请假' THEN totalcount ELSE 0 END) AS zh FROM (SELECT c.stu_no,c.stu_name FROM base_teach_task a,base_term_student b,base_student c WHERE a.`teacher_no`='"+teacher_no+"' AND a.`term_no`='"+term_no+"' AND a.`class_no`=b.`class_no` AND b.`stu_no`=c.`stu_no` GROUP BY b.`stu_no`) tb1 LEFT JOIN (SELECT d.stu_no,d.check_status,COUNT(1) totalcount   FROM qm_stu_check_main c,qm_stu_check d,base_task_sche e,base_teach_task f,base_classes g  WHERE check_main_status='1' AND c.term_no='"+term_no+"' AND c.check_main_no=d.check_main_no AND e.sche_no=c.sche_no  AND f.task_no=e.task_no AND f.teacher_no='"+teacher_no+"' AND f.class_no=g.`class_no`GROUP BY d.stu_no,d.check_status) tb2 ON tb1.stu_no=tb2.stu_no  GROUP BY tb1.stu_no,tb1.stu_name";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"qm_stu_check");
		return result;
	}
	
	public ExecResult changecheckrate(String check_main_no,String check_status,String check_change_status){
		System.out.println(check_change_status);
		if(check_change_status.equals("")){
			String sql="SELECT * FROM qm_stu_check_main a WHERE a.`check_main_no` = '"+check_main_no+"'";
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, null,"qm_stu_check");
			JSONArray jsonArray = new JSONArray();
			jsonArray = result.getData();
			JSONObject jsonObject = new JSONObject();
			jsonObject = jsonArray.getJSONObject(0);
			System.out.println(check_status);
			int check_kk = jsonObject.getIntValue("check_kk") ;
			int check_cd = jsonObject.getIntValue("check_cd") ;
			int check_zt = jsonObject.getIntValue("check_zt") ;
			int check_qj = jsonObject.getIntValue("check_qj") ;
			int check_count = jsonObject.getIntValue("check_count");
			System.out.println(check_kk);
			System.out.println(check_cd);
			System.out.println(check_zt);
			System.out.println(check_qj);
			if(check_status.equals("旷课")){
				check_kk -= 1;
			}else if(check_status.equals("迟到")){
				check_cd -= 1;
			}else if(check_status.equals("早退")){
				check_zt -= 1;
			}else{
				check_qj -= 1;
			}
			double check_radio = ((double)(check_count-check_kk-check_cd-check_zt) / (double)check_count)*100;//新的出勤率
			DecimalFormat    df   = new DecimalFormat("######0.00"); //保留两位小数
			String sql_update = "UPDATE qm_stu_check_main SET check_kk = '"+check_kk+"',check_cd = '"+check_cd+"',check_zt = '"+check_zt+"',check_qj = '"+check_qj+"' , check_ratio = '"+df.format(check_radio)+"%' WHERE check_main_no = '"+check_main_no+"'";
			result=jr.getExecResult(sql_update, null);
			return result;
		}else{
			System.out.println("执行到这儿了");
			String sql="SELECT * FROM qm_stu_check_main a WHERE a.`check_main_no` = '"+check_main_no+"'";
			JSONResponse jr=new JSONResponse();
			ExecResult result=jr.getSelectResult(sql, null,"qm_stu_check");
			JSONArray jsonArray = new JSONArray();
			jsonArray = result.getData();
			JSONObject jsonObject = new JSONObject();
			jsonObject = jsonArray.getJSONObject(0);
			System.out.println(check_status);
			int check_kk = jsonObject.getIntValue("check_kk") ;
			int check_cd = jsonObject.getIntValue("check_cd") ;
			int check_zt = jsonObject.getIntValue("check_zt") ;
			int check_qj = jsonObject.getIntValue("check_qj") ;
			double check_count = jsonObject.getDoubleValue("check_count");
			System.out.println(check_kk);
			System.out.println(check_cd);
			System.out.println(check_zt);
			System.out.println(check_qj);
			System.out.println(check_count);
			if(check_status.equals("旷课")){
				check_kk -= 1;
			}else if(check_status.equals("迟到")){
				check_cd -= 1;
			}else if(check_status.equals("早退")){
				check_zt -= 1;
			}else{
				check_qj -= 1;
			}
			if(check_change_status.equals("旷课")){
				check_kk += 1;
			}else if(check_change_status.equals("迟到")){
				check_cd += 1;
			}else if(check_change_status.equals("早退")){
				check_zt += 1;
			}else{
				check_qj += 1;
			}
			
			System.out.println(check_kk);
			System.out.println(check_cd);
			System.out.println(check_zt);
			System.out.println(check_qj);
			double check_radio = ((double)(check_count-check_kk-check_cd-check_zt) / (double)check_count)*100;
			System.out.println(check_radio);
			//新的出勤率
			DecimalFormat    df   = new DecimalFormat("######0.00"); //保留两位小数
			String sql_update = "UPDATE qm_stu_check_main SET check_kk = '"+check_kk+"',check_cd = '"+check_cd+"',check_zt = '"+check_zt+"',check_qj = '"+check_qj+"' , check_ratio = '"+df.format(check_radio)+"%' WHERE check_main_no = '"+check_main_no+"'";
			result=jr.getExecResult(sql_update, null);
			return result;
		}
		
	}

	public Object getCheckInfo(String term_no, String dep_no, String time_star, String time_end, String student_name, String pageIndex, String pageLength, String flag) {
		ExecResult result = new ExecResult();
		
		String sql = "SELECT tb1.stu_no,tb1.stu_name,tb1.class_name, "+
						"SUM(CASE tb2.check_status WHEN '旷课' THEN totalcount ELSE 0 END ) kkamount,"+
						"SUM(CASE tb2.check_status WHEN '迟到' THEN totalcount ELSE 0 END ) cdamount,"+
						"SUM(CASE tb2.check_status WHEN '早退' THEN totalcount ELSE 0 END ) ztamount,"+
						"SUM( CASE tb2.check_status WHEN '旷课' OR '迟到' OR '早退'  THEN totalcount ELSE 0 END) AS allamount  "+
						"FROM ( "+
							"SELECT a.`class_name`,b.`stu_no`,c.`stu_name` "+
							"FROM base_classes  a , base_term_student b, base_student c "+
							"WHERE  b.`term_no`='"+term_no+"' AND a.`class_no`=b.`class_no`AND b.`stu_no`=c.`stu_no` ";
						if(student_name != null && !"".equals(student_name)){
							sql+="AND c.stu_name  like '%"+student_name+"%' ";
						}	
						if(!dep_no.equals("0")){
							sql+=" AND a.dep_no='"+dep_no+"'  ";
						}
						sql+=" )tb1 "+
						" LEFT JOIN( "+
							" SELECT a.`stu_no`,a.`check_status`,COUNT(1) AS totalcount,a.check_time FROM qm_stu_check a,qm_stu_check_main b "+
							" WHERE a.`check_main_no`=b.`check_main_no` AND b.`term_no`='"+term_no+"' AND b.`check_main_status`='1' AND a.`check_status`<>'请假' "+
							"  AND  LEFT(a.`check_time`,10) >='"+time_star+"' AND LEFT(a.`check_time`,10) <='"+time_end+"' "+
							"  GROUP BY a.stu_no,a.`check_status` "+
						 " ) tb2 ON tb1.stu_no=tb2.stu_no GROUP BY tb1.stu_no,tb1.stu_name "+
						 " HAVING NOT (SUM(CASE tb2.check_status WHEN '旷课' THEN totalcount ELSE 0 END )=0 "+
						 " AND SUM(CASE tb2.check_status WHEN '迟到' THEN totalcount ELSE 0 END )=0 AND "+
						 " SUM(CASE tb2.check_status WHEN '早退' THEN totalcount ELSE 0 END )=0 ) ORDER BY allamount DESC ";
		//
		
		String sql_amount = sql; 
		sql+="limit "+(Integer.parseInt(pageIndex) - 1) * Integer.parseInt(pageLength)+" , "+Integer.parseInt(pageLength)+" ";
		JSONResponse jsonResponse = new JSONResponse();
		result = jsonResponse.getSelectResult(sql, null, "");
		if("first".equals(flag)){
			ExecResult rep = jsonResponse.getSelectResult(sql_amount, null, "");
			if(rep.getResult() > 0){
				result.setMessage(rep.getData().size() + "");
			}else{
				result.setMessage("0");
			}
		}
		return result;
	}

	public Object getCheckDetailInfo(String term_no, String dep_no, String time_star, String time_end, String stu_no) {
		ExecResult result = new ExecResult();
		String sql = "SELECT  a.`course_name` ,c.check_sx ,b.`sche_set`  ,d.`check_status` ,a.course_type ,  "+
					"c.`check_week` ,a.`teacher_no` , g.`teacher_name` , a.task_no , b.`sche_no` ,a.course_name "+
					"FROM `base_teach_task` a "+
					"JOIN `base_task_sche` b ON b.`task_no` = a.`task_no` "+
					"JOIN `qm_stu_check_main` c ON b.`sche_no` = c.`sche_no` "+
					"JOIN `qm_stu_check` d ON d.`check_main_no` = c.`check_main_no` "+
					"LEFT JOIN `base_student` e ON d.`stu_no` = e.`stu_no` "+
					"LEFT JOIN `base_classes` f ON f.class_no = a.`class_no` "+
					"LEFT JOIN `base_teacher` g ON g.`teacher_no` = a.`teacher_no` "+
					"WHERE a.`term_no` = '"+term_no+"' "+
					"AND NOT d.`check_status` = '请假' "+
					"AND LEFT(d.`check_time`,10) >='"+time_star+"' "+
					"AND LEFT(d.`check_time`,10) <='"+time_end+"' "+
					"AND e.stu_no ='"+stu_no+"' "+
					"ORDER BY c.check_week DESC , b.`sche_set` DESC ";
		JSONResponse jsonResponse = new JSONResponse();
		result = jsonResponse.getSelectResult(sql, null, "");
		return result;
	}
	
	
	
}





