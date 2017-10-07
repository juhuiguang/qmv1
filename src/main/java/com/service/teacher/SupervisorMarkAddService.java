package com.service.teacher;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;
import com.service.system.SystemStart;

public class SupervisorMarkAddService {

	public Object getSupMarkAddDep(String supno, String depno) {
		// TODO Auto-generated method stub
/*		String sql = "SELECT tb1.teacher_no , tb1.teacher_name FROM(SELECT b.teacher_no,b.teacher_name FROM base_teach_task a LEFT JOIN base_teacher b ON b.teacher_no=a.teacher_no WHERE b.dep_no='"+depno+"' GROUP BY b.teacher_name ORDER BY CONVERT( b.teacher_name USING gbk ) COLLATE gbk_chinese_ci ASC) tb1 LEFT JOIN qm_master c ON c.teacher_no=tb1.teacher_no WHERE master_no IS NULL";
*/
		String sql ="SELECT tb1.teacher_no,tb1.teacher_name,d.teacher_no markteacher_no FROM(SELECT b.teacher_no,b.teacher_name FROM base_teach_task a LEFT JOIN base_teacher b ON b.teacher_no=a.teacher_no WHERE b.dep_no='"+depno+"' GROUP BY b.teacher_name ORDER BY CONVERT( b.teacher_name USING gbk ) COLLATE gbk_chinese_ci ASC) tb1 LEFT JOIN qm_master c ON c.teacher_no=tb1.teacher_no LEFT JOIN qm_master_mark d ON d.teacher_no=tb1.teacher_no WHERE master_no IS NULL";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master");
		return result;
	}
	
	/**
	 * 获取督学关注的教师
	 * @param supno
	 * @return
	 */
	public ExecResult getMyMarkedTeacher(String supno,String termno){
		String sql="SELECT a.teacher_no,b.teacher_name FROM qm_master_mark a,base_teacher b WHERE a.teacher_no=b.teacher_no AND a.term_no='"+termno+"' AND a.master_teacher_no='"+supno+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql,null, "base_teacher");
		return result;
	}
	
	/**
	 * 按部门获取所有未被关注的教师名单
	 * @param supno
	 * @param depno
	 * @return
	 */
	public ExecResult getTeachers(String supno,String depno,String termno){
		String sql="SELECT a.teacher_no,a.teacher_name,a.dep_no FROM base_teacher a WHERE EXISTS (SELECT 1 FROM base_teach_task b WHERE b.teacher_no=a.teacher_no AND b.term_no='"+termno+"') AND NOT EXISTS(SELECT 1 FROM qm_master_mark c WHERE c.teacher_no=a.teacher_no AND c.term_no='"+termno+"'  AND master_teacher_no='"+supno+"') AND a.dep_no='"+depno+"' AND a.teacher_status='1' ORDER BY CONVERT( a.teacher_name USING gbk ) COLLATE gbk_chinese_ci ASC";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_teacher");
		return result;
	}
	
	public ExecResult getSupMarkAdd(String supno, String teano, String termno) {
		// TODO Auto-generated method stub
		String sql ="SELECT teacher_no FROM qm_master_mark WHERE teacher_no='"+teano+"' and master_no='"+supno+"' and term_no='"+termno+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "qm_master");
		if(result.getResult() == 0) {
			//取系统当前时间
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String currentdateString=sdf.format(new Date());
			String sql2 ="INSERT INTO qm_master_mark(master_teacher_no,teacher_no,term_no,mark_time) VALUES("+"'"+supno+"'"+","+"'"+teano+"'"+","+"'"+termno+"'"+","+"'"+currentdateString+"'"+")";
			JSONResponse jre = new JSONResponse(); 
			/*ExecResult result2 = jre.getExecResult(sql2, null, "", ""); */   //这一句是原先写的！
			ExecResult result2 = jre.getExecResult(sql2, null, "该教师关注成功！", "关注该教师失败。");  
			return result2;
		} else {
			return new ExecResult(false,"您这学期已关注了这位老师。");
		}
	}
	
	public ExecResult delSupMark(String supno, String teano, String termno){
		String sql ="delete  FROM qm_master_mark WHERE teacher_no='"+teano+"' and master_teacher_no='"+supno+"' and term_no='"+termno+"'";
		JSONResponse jre = new JSONResponse(); 
		ExecResult result2 = jre.getExecResult(sql, null, "取消关注成功！", "取消关注失败。");  
		return result2;
	}

	public Object getAllTerm() {
		// TODO Auto-generated method stub
		String sql="SELECT term_no,term_name FROM base_term";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"");
		return result;
	}

	public Object getAllDeps() {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM base_department";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_department");
		return result;
	}
	

}
