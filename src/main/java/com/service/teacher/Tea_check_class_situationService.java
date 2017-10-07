package com.service.teacher;

import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

import java.util.Map;

public class Tea_check_class_situationService {
	public ExecResult getDepartmentListenmarkservice (String term_no) {
		// TODO Auto-generated method stub
		JSONResponse jr = new JSONResponse();
		ExecResult result=null;
		String sqlselect="SELECT job_no FROM `qm_base_job`";
		ExecResult resultselect = jr.getSelectResult(sqlselect, null, "");
		if(resultselect.getData().size()==0){
		String sql = "SELECT a.dep_name,a.dep_no,MAX(avgmark) maxmark,MIN(avgmark) minmark,ROUND(AVG(avgmark),2) avgmark1 FROM `base_department` a  JOIN `qm_dep_teacher` b  JOIN   (SELECT b.teacher_no,ROUND(AVG(total),2) avgmark  FROM qm_master_listen a ,`base_teach_task` b  WHERE  a.task_no=b.task_no AND b.term_no=''{0}''   GROUP BY b.teacher_no) tb1  WHERE a.dep_no =b.dep_no AND b.term_no=''{0}''  AND b.teacher_no=tb1.teacher_no  GROUP BY a.dep_name    ORDER BY a.`dep_sort` ";
		String[] params = new String[] {term_no};
		result = jr.getSelectResult(sql, params, "");
		}else{
			String sql = "SELECT a.dep_name,a.dep_no,MAX(avgmark) maxmark,MIN(avgmark) minmark,ROUND(AVG(avgmark),2) avgmark1 FROM `base_department` a   JOIN `qm_dep_teacher` b  JOIN (SELECT tb0.teacher_no,ROUND(AVG(total),2) avgmark FROM    (SELECT a.teacher_no master_no, b.teacher_no,total FROM qm_master_listen a ,`base_teach_task` b   WHERE  a.task_no=b.task_no AND b.term_no=''{0}''  ) tb0   LEFT JOIN `qm_dep_teacher` a ON  a.teacher_no  = tb0.master_no AND a.term_no = ''{0}'' LEFT JOIN `qm_base_job` b ON b.job_no=a.job_no WHERE b.job_kh='1' GROUP BY tb0.teacher_no ) tb1 WHERE a.dep_no =b.dep_no AND b.term_no=''{0}''  AND b.teacher_no=tb1.teacher_no GROUP BY a.dep_name    ORDER BY a.`dep_sort`";
			String[] params = new String[] {term_no};
			result = jr.getSelectResult(sql, params, "");
		}
		return result;
	}

	//获取院系详细督学评教数据的平均值（列出所有教师姓名）
        public ExecResult getDepartmentmaster_pjService (String term_no,String dep_name) {
            // TODO Auto-generated method stub
            String depsql="SELECT a.dep_no FROM base_department a WHERE a.dep_name='"+dep_name+"'";
            JSONResponse jr1 = new JSONResponse();
            ExecResult result1 = jr1.getSelectResult(depsql,null, "");
            JSONObject department_noObject = new JSONObject((Map<String, Object>) result1.getData().get(0));
            String dep_no = department_noObject.getString("dep_no");
            String sql = "SELECT tb1.*,teacher.dep_no,teacher.`teacher_no`,teacher.teacher_name FROM (SELECT b.`term_no`,b.`course_name`,b.`teacher_no`,AVG(a.per11) per11,AVG(a.per12) per12,AVG(a.per13) per13,AVG(a.per14) per14,AVG(a.per15) per15,AVG(a.total) total FROM qm_master_listen a,base_teach_task b WHERE a.`task_no`=b.`task_no` AND a.`total`>0 AND b.`term_no`=''{0}''  GROUP BY b.`term_no`,b.`teacher_no`) tb1 RIGHT JOIN (SELECT n.teacher_name,m.* FROM qm_dep_teacher m,base_teacher n WHERE m.`teacher_no`=n.`teacher_no` AND m.`term_no`=''{0}'' ) teacher ON teacher.teacher_no=tb1.teacher_no AND teacher.term_no=tb1.term_no WHERE teacher.dep_no=''{1}'' ORDER BY tb1.total DESC ";
            String[] params = new String[] {term_no,dep_no};
            JSONResponse jr = new JSONResponse();
            ExecResult result = jr.getSelectResult(sql, params, "");
            return result;
        }

    //获得督学评教  部门教师个人详细数据
    public ExecResult getDepartmentPersonmaster_pjService (String term_no,String dep_name,String teacher_name) {
        // TODO Auto-generated method stub
        String depsql="SELECT a.dep_no FROM base_department a WHERE a.dep_name='"+dep_name+"'";
        JSONResponse jr1 = new JSONResponse();
        ExecResult result1 = jr1.getSelectResult(depsql,null, "");
        JSONObject department_noObject = new JSONObject((Map<String, Object>) result1.getData().get(0));
        String dep_no = department_noObject.getString("dep_no");

        System.out.println("teacher_name"+teacher_name);
        String teachersql="SELECT a.teacher_no FROM base_teacher a WHERE a.teacher_name='"+teacher_name+"'";
        JSONResponse jr2 = new JSONResponse();
        ExecResult result2 = jr2.getSelectResult(teachersql,null, "");
        JSONObject teacher_noObject = new JSONObject((Map<String, Object>) result2.getData().get(0));
        String teacher_no = teacher_noObject.getString("teacher_no");
        String sql ="SELECT b.term_no,a.teacher_no master_no,b.course_name,d.teacher_no,d.teacher_name,c.dep_no,e.dep_name,AVG(a.per11) per11,AVG(a.per12) per12,AVG(a.per13) per13,AVG(a.per14) per14,AVG(a.per15) per15,AVG(a.per16) per16,AVG(a.total) total FROM qm_master_listen a,base_teach_task b,qm_dep_teacher c,base_teacher d,base_department e WHERE a.task_no=b.task_no AND b.term_no=c.term_no AND b.teacher_no=c.teacher_no AND c.teacher_no=d.teacher_no AND e.dep_no=c.dep_no AND e.dep_no=''{1}'' AND c.term_no=''{0}'' AND c.teacher_no=''{2}'' GROUP BY b.term_no,a.teacher_no,b.course_name,d.teacher_name,c.dep_no ";
        String[] params = new String[] {term_no,dep_no,teacher_no};
        JSONResponse jr = new JSONResponse();
        ExecResult result = jr.getSelectResult(sql, params, "");
        return result;
    }

    //获得督学评教  部门教师个人详细数据
    public ExecResult getDepartmentPersonstudent_pjService (String term_no,String dep_name,String teacher_name) {
        // TODO Auto-generated method stub
        String depsql="SELECT a.dep_no FROM base_department a WHERE a.dep_name='"+dep_name+"'";
        JSONResponse jr1 = new JSONResponse();
        ExecResult result1 = jr1.getSelectResult(depsql,null, "");
        JSONObject department_noObject = new JSONObject((Map<String, Object>) result1.getData().get(0));
        String dep_no = department_noObject.getString("dep_no");

        System.out.println("teacher_name"+teacher_name);
        String teachersql="SELECT a.teacher_no FROM base_teacher a WHERE a.teacher_name='"+teacher_name+"'";
        JSONResponse jr2 = new JSONResponse();
        ExecResult result2 = jr2.getSelectResult(teachersql,null, "");
        JSONObject teacher_noObject = new JSONObject((Map<String, Object>) result2.getData().get(0));
        String teacher_no = teacher_noObject.getString("teacher_no");
        String sql = "SELECT tb1.*,teacher.dep_no,dep.dep_name,tea.teacher_name FROM (SELECT b.`term_no`,b.`course_name`,b.`teacher_no`,AVG(a.per11) per11,AVG(a.per12) per12,AVG(a.per13) per13,AVG(a.per14) per14,AVG(a.per15) per15,AVG(a.total) total FROM qm_stu_pj a,base_teach_task b WHERE a.`task_no`=b.`task_no` AND a.`total`>0 AND b.`term_no`=''{0}'' AND b.`dep_no`=''{1}'' AND b.`teacher_no`=''{2}'' GROUP BY b.`term_no`,b.`task_no`) tb1 LEFT JOIN qm_dep_teacher teacher ON teacher.teacher_no=tb1.teacher_no AND teacher.term_no=tb1.term_no LEFT JOIN base_department dep ON dep.dep_no=teacher.dep_no LEFT JOIN base_teacher tea ON tea.teacher_no=teacher.teacher_no ";
        String[] params = new String[] {term_no,dep_no,teacher_no};
        JSONResponse jr = new JSONResponse();
        ExecResult result = jr.getSelectResult(sql, params, "");
        return result;
    }




    //获取院系详细学生评教数据的平均值（列出所有教师姓名）
    public ExecResult getDepartmentstudent_pjService (String term_no,String dep_name) {
        // TODO Auto-generated method stub
        String depsql="SELECT a.dep_no FROM base_department a WHERE a.dep_name='"+dep_name+"'";
        JSONResponse jr1 = new JSONResponse();
        ExecResult result1 = jr1.getSelectResult(depsql,null, "");
        JSONObject department_noObject = new JSONObject((Map<String, Object>) result1.getData().get(0));
        String dep_no = department_noObject.getString("dep_no");
        System.out.println("dep_no"+dep_no);
        String sql = "SELECT tb1.*,teacher.dep_no,teacher.`teacher_no`,teacher.teacher_name FROM (SELECT b.`term_no`,b.`course_name`,b.`teacher_no`,AVG(a.per11) per11,AVG(a.per12) per12,AVG(a.per13) per13,AVG(a.per14) per14,AVG(a.per15) per15,AVG(a.total) total FROM qm_stu_pj a,base_teach_task b WHERE a.`task_no`=b.`task_no` AND a.`total`>0 AND b.`term_no`=''{0}''  GROUP BY b.`term_no`,b.`teacher_no`) tb1 RIGHT JOIN (SELECT n.teacher_name,m.* FROM qm_dep_teacher m,base_teacher n WHERE m.`teacher_no`=n.`teacher_no` AND m.`term_no`=''{0}'' ) teacher ON teacher.teacher_no=tb1.teacher_no AND teacher.term_no=tb1.term_no WHERE teacher.dep_no=''{1}'' ORDER BY tb1.total DESC";
        String[] params = new String[] {term_no,dep_no};
        JSONResponse jr = new JSONResponse();
        ExecResult result = jr.getSelectResult(sql, params, "");
        return result;
    }
	
	public ExecResult getDepartmentteassru_pjService (String term_no) {
		// TODO Auto-generated method stub
		String sql = "SELECT  a.dep_name,a.dep_no, MAX(avgmark2) maxmark,MIN(avgmark2) minmark,ROUND(AVG(avgmark2),2) avgmark1 FROM `base_department` a    JOIN `qm_dep_teacher` b   JOIN  (SELECT b.term_no,b.teacher_no,ROUND(AVG(total),2) avgmark2  FROM qm_stu_pj a,base_teach_task b   WHERE a.task_no=b.task_no AND b.term_no=''{0}''   GROUP BY b.teacher_no) tb2   WHERE b.dep_no=a.dep_no AND b.term_no=''{0}'' AND tb2.teacher_no=b.teacher_no  GROUP BY a.dep_name  ORDER BY a.`dep_sort`";
		String[] params = new String[] {term_no};
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "");
		return result;
	}
	
	public ExecResult getTermnoservice () {
		// TODO Auto-generated method stub
		String sql = "SELECT term_no,term_name FROM base_term ORDER BY term_no DESC ";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql,null, "");
		return result;
	}
	
	
	
	
	public ExecResult getTeacherlistendetailsservice (String dep_name,String mark,String term_no) {
		JSONResponse jr = new JSONResponse();
		ExecResult result=null;
		String sqlselect="SELECT job_no FROM `qm_base_job`";
		ExecResult resultselect = jr.getSelectResult(sqlselect, null, "");
		if(resultselect.getData().size()==0){
		String[] params = new String[] {mark,dep_name,term_no};
		String sql = "SELECT a.task_no,a.teacher_no,e.teacher_name tkjs,b.course_name,f.teacher_name rkjs,a.total,a.jxjy,a.`skpj` FROM  `base_teach_task` b  JOIN   (SELECT tb1.teacher_no,b.dep_no FROM  base_department a   LEFT JOIN `qm_dep_teacher` b ON b.dep_no=a.dep_no AND b.term_no=''{2}''   LEFT JOIN   (SELECT b.teacher_no,ROUND(AVG(total),2) avgmark   FROM qm_master_listen a ,`base_teach_task` b   WHERE  a.task_no=b.task_no AND b.term_no=''{2}''      GROUP BY b.teacher_no) tb1  ON tb1.teacher_no=b.teacher_no   WHERE avgmark=''{0}''  AND a.dep_name=''{1}'') tb2    JOIN `qm_master_listen` a LEFT JOIN `base_teacher` f   ON f.teacher_no=tb2.teacher_no     LEFT JOIN `base_teacher` e  ON e.teacher_no=a.teacher_no  WHERE tb2.teacher_no=b.teacher_no AND b.task_no=a.task_no  AND a.task_no=b.task_no AND b.term_no=''{2}''   ORDER BY CONVERT( f.`teacher_name` USING gbk ) COLLATE gbk_chinese_ci ASC";
		result = jr.getSelectResult(sql,params, "");
		}else{
			String[] params = new String[] {mark,dep_name,term_no};
			String sql = "SELECT a.task_no,a.teacher_no,e.teacher_name tkjs,b.course_name,f.teacher_name rkjs,a.total,a.jxjy,a.`skpj` FROM  `base_teach_task` b   JOIN    (SELECT tb1.teacher_no,b.dep_no FROM  base_department a   LEFT JOIN `qm_dep_teacher` b ON b.dep_no=a.dep_no AND b.term_no=''{2}''    LEFT JOIN    ( SELECT tb0.teacher_no,ROUND(AVG(total),2) avgmark FROM     (SELECT a.teacher_no master_no, b.teacher_no,total FROM qm_master_listen a ,`base_teach_task` b    WHERE  a.task_no=b.task_no AND b.term_no=''{2}''  ) tb0 ,`qm_dep_teacher` a  ,`qm_base_job` b   WHERE  a.teacher_no  = tb0.master_no AND a.term_no = ''{2}'' AND b.job_kh='1' AND b.job_no=a.job_no GROUP BY tb0.teacher_no) tb1  ON tb1.teacher_no=b.teacher_no    WHERE avgmark=''{0}''  AND a.dep_name=''{1}'') tb2    JOIN `qm_master_listen` a  LEFT JOIN `base_teacher` f   ON f.teacher_no=tb2.teacher_no      LEFT JOIN `base_teacher` e  ON e.teacher_no=a.teacher_no  LEFT JOIN `qm_dep_teacher` g ON g.teacher_no=e.`teacher_no`  LEFT JOIN `qm_base_job` h ON h.job_no = g.job_no WHERE tb2.teacher_no=b.teacher_no AND b.task_no=a.task_no  AND a.task_no=b.task_no AND b.term_no=''{2}'' AND h.job_kh='1'  AND g.term_no=''{2}''   ORDER BY CONVERT( f.`teacher_name` USING gbk ) COLLATE gbk_chinese_ci ASC";
			result = jr.getSelectResult(sql,params, "");
		}
		return result;
	}
	
	
	public ExecResult getStudentpxdetailsservice (String dep_name,String mark,String term_no) {
		// TODO Auto-generated method stub
		String sql = " SELECT f.teacher_name,a.course_name,e.class_name,ROUND(AVG(total),2) avgmark1 FROM(SELECT tb1.teacher_no FROM   (SELECT b.teacher_no,ROUND(AVG(total),2) avgmark2  FROM qm_stu_pj a,base_teach_task b   WHERE a.task_no=b.task_no AND b.term_no=''{2}''  GROUP BY b.teacher_no) tb1,`qm_dep_teacher` a,`base_department` b WHERE  tb1.teacher_no=a.teacher_no  AND a.dep_no=b.dep_no AND avgmark2=''{0}''  AND b.dep_name=''{1}''  GROUP BY tb1.teacher_no) tb2  LEFT JOIN `base_teach_task` a ON a.teacher_no=tb2.teacher_no LEFT JOIN `qm_stu_pj`b ON b.task_no=a.task_no LEFT JOIN `qm_dep_teacher` c ON c.teacher_no=tb2.teacher_no AND c.term_no=''{2}'' LEFT JOIN `base_teacher`f ON f.teacher_no=c.teacher_no LEFT JOIN `base_classes` e ON e.class_no=a.class_no WHERE a.term_no=''{2}''  GROUP BY a.class_no ORDER BY CONVERT( f.teacher_name USING gbk ) COLLATE gbk_chinese_ci ASC";
		String[] params = new String[] {mark,dep_name,term_no};
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql,params, "");
		return result;
	}
}
