package com.service.student;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class studentMessengerMaintainService {

	public Object getClassInfor(String stuno,String termno) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.*,b.stu_name,f.class_name,b.stu_year,b.stu_status,d.term_name,c.major_name FROM base_term_student a LEFT JOIN base_classes f ON f.class_no=a.class_no LEFT JOIN base_student b ON b.stu_no=a.stu_no LEFT JOIN base_term d ON d.term_no=a.term_no LEFT JOIN (SELECT DISTINCT major_no,major_name FROM base_major) c ON c.major_no=a.major_no WHERE a.class_no=(SELECT a.class_no FROM base_term_student a WHERE a.stu_no='"+stuno+"' AND a.term_no='"+termno+"') AND a.term_no='"+termno+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_term_student");
		return result;
	}

	public Object getAllTerm() {
		// TODO Auto-generated method stub
		String sql="SELECT term_no,term_name FROM base_term";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"");
		return result;
	}

	public Object DeleteStu(String stuno, String termno) {
		// TODO Auto-generated method stub
	//	String sql = "DELETE FROM base_term_student WHERE stu_no='"+stuno+"' AND term_no='"+termno+"'";
		String sql ="UPDATE base_term_student SET term_no='',major_no='',class_no='' WHERE  stu_no='"+stuno+"' AND term_no ='"+termno+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(sql, null,"删除成功！","删除失败");  
		return result;
	}

	public Object getMajorClass(String termno) {
		// TODO Auto-generated method stub
		String sqlm = "SELECT * FROM base_major";
		JSONResponse jr=new JSONResponse();
		JSONArray majortb = jr.getSelectResult(sqlm, null, "base_major").getData();
		
		String sqlc = "SELECT a.class_no,a.class_name,b.term_no FROM base_classes a LEFT JOIN base_term_student b ON b.class_no=a.class_no WHERE b.term_no='"+termno+"' GROUP BY a.class_no";
		JSONArray classtb = jr.getSelectResult(sqlc, null, "base_classes").getData();		
		
		JSONObject item = new JSONObject();
		item.put("majortb", majortb);
		item.put("classtb", classtb);
		JSONArray getresult = new JSONArray();
		getresult.add(item);
		ExecResult rep = new ExecResult();
		rep.setResult(true);
		rep.setMessage("");
		rep.setData(getresult);
		
		return rep; 
	}

	public Object StuUpdata(String termno, String stuno, String majorno,
			String classno) {
		// TODO Auto-generated method stub
		String sql ="UPDATE base_term_student SET major_no='"+majorno+"',class_no='"+classno+"' WHERE  stu_no='"+stuno+"' AND term_no ='"+termno+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(sql, null, "", "");
		return result;
	}

	public Object getStudent(String termno) {
		// TODO Auto-generated method stub
		String sqlm = "SELECT a.stu_no,b.stu_name FROM base_term_student a LEFT JOIN base_student b ON b.stu_no=a.stu_no WHERE (a.class_no IS NULL OR a.class_no='') AND (a.major_no IS NULL OR a.major_no='')";
		JSONResponse jr=new JSONResponse();
		ExecResult result = jr.getSelectResult(sqlm, null, "base_term_student");  
		return result;
	}

	public Object StuAdd(String termno, String stuno, String majorno,
			String classno) {
		// TODO Auto-generated method stub
		String sql = "UPDATE base_term_student SET term_no='"+termno+"',major_no='"+majorno+"',class_no='"+classno+"' WHERE  stu_no='"+stuno+"' AND term_no =''";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(sql, null, "新学生添加成功！", "添加新学生失败~"); 
		return result;
	}

	public Object getClasses(String teano) {
		// TODO Auto-generated method stub
		String sql = "SELECT class_no,class_name FROM base_classes WHERE teacher_no='"+teano+"'";
		JSONResponse jr=new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_classes");
		return result;
	}

	public Object TeaClassInfor(String classid, String termno) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.*,b.stu_name,f.class_name,b.stu_year,b.stu_status,d.term_name,c.major_name FROM base_term_student a LEFT JOIN base_classes f ON f.class_no=a.class_no LEFT JOIN base_student b ON b.stu_no=a.stu_no LEFT JOIN base_term d ON d.term_no=a.term_no LEFT JOIN (SELECT DISTINCT major_no,major_name FROM base_major) c ON c.major_no=a.major_no WHERE a.class_no='"+classid+"' AND a.term_no='"+termno+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_term_student");
		return result;
	}

}
