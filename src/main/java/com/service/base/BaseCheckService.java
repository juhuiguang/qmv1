package com.service.base;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class BaseCheckService {

	public ExecResult getAllInfo(String term_no,String choose_week, String schoolFlag) {
		String sql ="";
		if("1".equals(schoolFlag)){
			sql = "SELECT tb5.* , tb4.amount  , tb6.amount AS checkAmount "+
					"FROM ( "+
						"SELECT tb2.dep_name,COUNT(DISTINCT tb1.teacher_no) allAmount,tb1.dep_no FROM ( "+
							"SELECT a.teacher_no,a.dep_no FROM `base_teach_task` a  WHERE a.term_no = '"+term_no+"' "+
						") tb1 JOIN base_department tb2 ON tb2.dep_no=tb1.dep_no "+
						"GROUP BY tb1.dep_no ORDER BY tb2.dep_sort "+
					") tb5 "+
					"LEFT JOIN ( "+
					"SELECT  tb.dep_no,COUNT(DISTINCT teacher_no) AS amount FROM  "+
					"( "+
						"SELECT a.check_main_no,c.teacher_no,c.dep_no FROM qm_stu_check_main a,base_task_sche b,base_teach_task c "+
						"WHERE a.check_main_status='1' AND a.`check_week` = '"+choose_week+"' AND c.term_no='"+term_no+"' AND c.task_no=b.task_no AND a.sche_no=b.sche_no "+
						") tb  "+
						"GROUP BY dep_no "+
					") tb4 "+
					"ON tb4.dep_no = tb5.dep_no "+
					"LEFT JOIN "+
					"( "+
						"SELECT a.dep_no , COUNT(1) AS amount FROM `base_teach_task` a "+
						"LEFT JOIN `base_task_sche` b ON a.task_no = b.task_no "+ 
						"JOIN `qm_stu_check_main` c ON c.`sche_no` = b.sche_no  "+
						"WHERE c.check_main_status ='1' AND c.`check_week` = '"+choose_week+"' AND a.term_no = '"+term_no+"' GROUP BY a.dep_no "+
					") tb6 "+
				"ON tb6.dep_no = tb5.dep_no ";
		}else{
			sql = "SELECT tb5.* , tb4.amount  , tb6.amount AS checkAmount "+
					"FROM ( "+
							"SELECT tb2.dep_name,COUNT(DISTINCT tb1.teacher_no) allAmount,tb1.dep_no FROM ( "+
								"SELECT a.teacher_no,b.dep_no FROM `base_teach_task` a , `qm_dep_teacher` b WHERE a.teacher_no = b.teacher_no "+
								"AND b.term_no='"+term_no+"' AND a.term_no = '"+term_no+"' "+
							") tb1 JOIN base_department tb2 ON tb2.dep_no=tb1.dep_no "+
							"GROUP BY tb1.dep_no ORDER BY tb2.dep_sort "+
						") tb5 "+
						"LEFT JOIN ( "+
						"SELECT  tb.dep_no,COUNT(DISTINCT teacher_no) AS amount FROM  "+
								"( "+
									"SELECT a.check_main_no,c.teacher_no,d.dep_no FROM qm_stu_check_main a,base_task_sche b,base_teach_task c,qm_dep_teacher d "+
									"WHERE a.check_main_status='1' AND a.`check_week` = '"+choose_week+"' AND c.term_no='"+term_no+"' AND d.term_no='"+term_no+"' AND c.task_no=b.task_no AND a.sche_no=b.sche_no AND c.teacher_no=d.teacher_no "+
								") tb  "+
								"GROUP BY dep_no "+
							") tb4 "+
							"ON tb4.dep_no = tb5.dep_no "+
						"LEFT JOIN "+
							"( "+
								"SELECT d.dep_no , COUNT(1) AS amount FROM `base_teach_task` a "+
								" LEFT JOIN `base_task_sche` b ON a.task_no = b.task_no "+
								" JOIN `qm_stu_check_main` c ON c.`sche_no` = b.sche_no  "+
								" JOIN `qm_dep_teacher` d ON a.teacher_no = d.teacher_no AND d.term_no='"+term_no+"' "+
								"WHERE c.check_main_status ='1' AND c.`check_week` = '"+choose_week+"' AND a.term_no = '"+term_no+"' GROUP BY d.dep_no "+
							") tb6 "+
						"ON tb6.dep_no = tb5.dep_no ";
		}
		
		JSONResponse jsonResponse = new JSONResponse();
		ExecResult result = jsonResponse.getSelectResult(sql, null, "");
		return result;
	}

	public ExecResult getDepDetail(String dep_no, String term_no,String choose_week,String schoolFlag) {
		String sql = "";
		if("1".equals(schoolFlag)){
			sql = 	"SELECT a.teacher_no ,e.teacher_name , COUNT(CASE WHEN c.`check_main_status`='1' THEN 1 END) totalamount, "+
					"COUNT(CASE WHEN a.`course_type`='实训课' AND  c.`check_main_status`='1' THEN 1 END ) AS sxamount, "+
					"COUNT(CASE WHEN a.`course_type`<>'实训课' AND  c.`check_main_status`='1' THEN 1 END ) AS jsamount "+
					"FROM `base_teach_task` a "+
					"LEFT JOIN `base_task_sche` b ON a.task_no = b.task_no "+
					"LEFT JOIN `qm_stu_check_main` c ON c.`sche_no` = b.sche_no "+
					"LEFT JOIN `base_teacher` e ON e.teacher_no = a.teacher_no "+
					"WHERE a.term_no = '"+term_no+"' AND c.`check_week` = '"+choose_week+"' AND a.`dep_no` = '"+dep_no+"' GROUP BY a.teacher_no "+
					"ORDER BY totalamount ";
		}else{
			sql = 	"SELECT a.teacher_no ,e.teacher_name , COUNT(CASE WHEN c.`check_main_status`='1' THEN 1 END) totalamount, "+
					"COUNT(CASE WHEN a.`course_type`='实训课' AND  c.`check_main_status`='1'THEN 1 END ) AS sxamount, "+
					"COUNT(CASE WHEN a.`course_type`<>'实训课' AND  c.`check_main_status`='1'THEN 1 END ) AS jsamount "+
					"FROM `base_teach_task` a "+
					"LEFT JOIN `base_task_sche` b ON a.task_no = b.task_no "+
					"left JOIN `qm_stu_check_main` c ON c.`sche_no` = b.sche_no "+ 
					"left JOIN `qm_dep_teacher` d ON a.teacher_no = d.teacher_no AND d.term_no='"+term_no+"' "+
					"LEFT JOIN `base_teacher` e ON e.teacher_no = a.teacher_no "+  
					"WHERE  a.term_no = '"+term_no+"' AND c.`check_week` = '"+choose_week+"' AND d.`dep_no` = '"+dep_no+"' GROUP BY a.teacher_no "+
					"ORDER BY totalamount";
		}
		JSONResponse jsonResponse = new JSONResponse();
		ExecResult result = jsonResponse.getSelectResult(sql, null, "");
		return result;
	}

	public ExecResult getTeaDetail(String teacher_no, String term_no) {
		JSONResponse jr = new JSONResponse(); 
		String selectSche = "SELECT a.course_type, a.course_name , a.course_week ,  b.sche_no ,b.sche_set , IFNULL( c.class_name,d.logic_name) AS class_name ,c.class_no FROM base_teach_task a left JOIN base_task_sche b ON a.task_no=b.task_no LEFT JOIN base_classes c ON a.class_no=c.class_no LEFT JOIN base_class_logic d ON (a.task_no=d.task_no AND a.term_no=d.term_no) WHERE  a.teacher_no='"
				+ teacher_no + "' AND a.term_no='" + term_no + "'  GROUP BY b.sche_no ORDER BY b.sche_set"; 
		// 得到所有Sche
		ExecResult scheInfo = jr.getSelectResult(selectSche, null, "base_teach_task");
		return scheInfo; 
	}

	public ExecResult getTeaDetailInfo(String sche_no) {
		JSONResponse jr = new JSONResponse(); 
		String selectSche = "SELECT * FROM `qm_stu_check_main` WHERE sche_no='"+sche_no+"' AND check_main_status='1' ORDER BY check_week DESC"; 
		// 得到所有Sche
		ExecResult scheInfo = jr.getSelectResult(selectSche, null, "base_teach_task");
		return scheInfo; 
	}

}
