package com.service.teacher;

import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class TeaUploadCoursePlanService {

	public Object getTeaLisInfor(String termno, String teano) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM base_teach_task WHERE term_no='"+termno+"' AND teacher_no='"+teano+"' GROUP BY course_no";
		JSONResponse js = new JSONResponse();
		ExecResult result = js.getSelectResult(sql, null,"base_teach_task");
		return result;
	}

	public Object getSinglCourseAllFileData(String termno, String courseno, String teano) {
		// TODO Auto-generated method stub
		JSONObject jo = new JSONObject();
		String sql_other = "SELECT a.*,b.teacher_name,'授课计划' as filetype FROM qm_teacher_course_file a LEFT JOIN base_teacher b ON b.teacher_no=a.teacher_no WHERE  a.term_no='"+termno+"' AND a.course_no='"+courseno+"' AND a.teacher_no<>'"+teano+"'" +
				" union " +
				"SELECT a.*,b.teacher_name,'课程标准' as filetype FROM qm_teacher_course_file2 a LEFT JOIN base_teacher b ON b.teacher_no=a.teacher_no WHERE  a.term_no='"+termno+"' AND a.course_no='"+courseno+"' AND a.teacher_no<>'"+teano+"'";
		String sql_oneself = "SELECT *,'授课计划' as filetype FROM qm_teacher_course_file WHERE term_no='"+termno+"' AND course_no='"+courseno+"' AND teacher_no='"+teano+"'" +
				" union " +
				"SELECT *,'课程标准' as filetype FROM qm_teacher_course_file2 WHERE term_no='"+termno+"' AND course_no='"+courseno+"' AND teacher_no='"+teano+"'";
		JSONResponse js = new JSONResponse();
		ExecResult other = js.getSelectResult(sql_other, null,"qm_teacher_course_file");
		ExecResult oneself = js.getSelectResult(sql_oneself, null,"qm_teacher_course_file");
		jo.put("other", other);
		jo.put("oneself", oneself);
		return jo;
	}

	public Object DelSinglCourseFileData(String termno, String courseno,
			String teano, String fileno) {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM qm_teacher_course_file  WHERE file_id='"+fileno+"' AND course_no='"+courseno+"' AND teacher_no='"+teano+"' AND term_no='"+termno+"'";
		JSONResponse js = new JSONResponse();
		ExecResult result = js.getExecResult(sql, null, "", ""); 
		return result;
	}

	public Object DelSinglCourseFileData2(String termno, String courseno,
										 String teano, String fileno) {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM qm_teacher_course_file2  WHERE file_id='"+fileno+"' AND course_no='"+courseno+"' AND teacher_no='"+teano+"' AND term_no='"+termno+"'";
		JSONResponse js = new JSONResponse();
		ExecResult result = js.getExecResult(sql, null, "", "");
		return result;
	}

	public Object AddThisCoursePlanInfor(String termno, String courseno,
			String teano, String fileno, String fileurl, String filename) {
		JSONResponse js = new JSONResponse();
		ExecResult result = new ExecResult(true,"");

		String sqlSelect = "SELECT * FROM qm_teacher_course_file WHERE file_name='"+filename+"' AND course_no='"+courseno+"' AND file_url='"+fileurl+"' AND term_no='"+termno+"' AND teacher_no='"+teano+"'";
		ExecResult select = js.getSelectResult(sqlSelect, null, "qm_teacher_course_file");
		if(select.getResult() > 0) {
			
		} else {
			String sql = "INSERT INTO qm_teacher_course_file(term_no,file_name,course_no,teacher_no,file_url) VALUES('"+termno+"','"+filename+"','"+courseno+"','"+teano+"','"+fileurl+"')";
			result = js.getExecInsertId(sql, null, "本课程文件复制失败！", "本课程文件复制成功！");
		}
		// TODO Auto-generated method stub
		return result;
	}

	public Object AddThisCoursePlanInfor2(String termno, String courseno,
										 String teano, String fileno, String fileurl, String filename) {
		JSONResponse js = new JSONResponse();
		ExecResult result = new ExecResult(true,"");

		String sqlSelect = "SELECT * FROM qm_teacher_course_file2 WHERE file_name='"+filename+"' AND course_no='"+courseno+"' AND file_url='"+fileurl+"' AND term_no='"+termno+"' AND teacher_no='"+teano+"'";
		ExecResult select = js.getSelectResult(sqlSelect, null, "qm_teacher_course_file");
		if(select.getResult() > 0) {

		} else {
			String sql = "INSERT INTO qm_teacher_course_file2(term_no,file_name,course_no,teacher_no,file_url) VALUES('"+termno+"','"+filename+"','"+courseno+"','"+teano+"','"+fileurl+"')";
			result = js.getExecInsertId(sql, null, "本课程文件复制失败！", "本课程文件复制成功！");
		}
		// TODO Auto-generated method stub
		return result;
	}

	public Object insertFile(String term_no, String file_name,String teacher_no, String course_no,String url) {
		JSONResponse js = new JSONResponse();
		String sqlS = "SELECT * FROM `qm_teacher_course_file`  WHERE term_no ='"+term_no+"' AND file_name='"+file_name+"' AND course_no = '"+course_no+"' AND teacher_no = '"+teacher_no+"'";
		ExecResult resultS = js.getSelectResult(sqlS, null, ""); 
		if (resultS.getData().size()>0) {
			ExecResult resultT = new ExecResult(false,"文件重复，无法上传");
			return resultT;
		}
		String sql = "INSERT INTO `qm_teacher_course_file` (term_no,file_name,course_no,teacher_no,file_url)  VALUES('"+term_no+"','"+file_name+"','"+course_no+"','"+teacher_no+"','"+url+"')";
		ExecResult result = js.getExecResult(sql, null, "上传失败", "上传成功"); 
		return result;
	}

	public Object insertFile2(String term_no, String file_name,String teacher_no, String course_no,String url) {
		JSONResponse js = new JSONResponse();
		String sqlS = "SELECT * FROM `qm_teacher_course_file2`  WHERE term_no ='"+term_no+"' AND file_name='"+file_name+"' AND course_no = '"+course_no+"' AND teacher_no = '"+teacher_no+"'";
		ExecResult resultS = js.getSelectResult(sqlS, null, "");
		if (resultS.getData().size()>0) {
			ExecResult resultT = new ExecResult(false,"文件重复，无法上传");
			return resultT;
		}
		String sql = "INSERT INTO `qm_teacher_course_file2` (term_no,file_name,course_no,teacher_no,file_url)  VALUES('"+term_no+"','"+file_name+"','"+course_no+"','"+teacher_no+"','"+url+"')";
		ExecResult result = js.getExecResult(sql, null, "上传失败", "上传成功");
		return result;
	}

}
