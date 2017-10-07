package com.service.student;

import java.awt.List;
import java.util.LinkedList;
import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

//与后台之间的交汇
public class Student_survey_Service {
	public ExecResult getStuTable(String tableflag){//函数方法
		String sql="SELECT  *,COUNT(a.`stu_no`) total FROM qm_stu_survey a  WHERE a.`term_no`='"+tableflag+"' AND a.`survey_name`='专业课程设置满意度调查' GROUP BY a.`survey_result` UNION SELECT  *,COUNT(a.`stu_no`) total FROM qm_stu_survey a  WHERE a.`term_no`='"+tableflag+"' AND a.`survey_name`='本专业课程教学满意度调查' GROUP BY a.`survey_result`";//调取数据
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"qm_stu_survey");
		return result;//返回
	}
	
	public ExecResult judgedata(String stu_no,String term_no){//函数方法
		String sql="SELECT * FROM qm_stu_survey a WHERE a.`term_no`='"+term_no+"' AND a.`stu_no`='"+stu_no+"'";//调取数据
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"qm_stu_survey");
		return result;//返回
	}
	
	public ExecResult postListen(Map<String,String> param){
		String sql1="insert into qm_stu_survey (term_no,survey_name,stu_no,survey_result) values "
				+ "(";
			sql1+=param.get("term_no")+",";
		sql1+="'"+param.get("survey_name_one")+"',";//得到学号
		sql1+=param.get("stu_no")+",";//得到年份
		sql1+="'"+param.get("result_one")+"')";//得到数据的名字
		
		String sql2="insert into qm_stu_survey (term_no,survey_name,stu_no,survey_result) values "
				+ "(";
			sql2+=param.get("term_no")+",";
		sql2+="'"+param.get("survey_name_two")+"',";//得到学号
		sql2+=param.get("stu_no")+",";//得到年份
		sql2+="'"+param.get("result_two")+"')";//得到数据的名字			
		LinkedList<String> sql = new LinkedList<String>();//用list数组同时传入两个数据
		sql.add(sql1);
		sql.add(sql2);
		JSONResponse response=new JSONResponse();
		ExecResult result= response.getExecResult(sql, "","");
		return result;
	
	
}
}




