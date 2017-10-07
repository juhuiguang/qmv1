package com.service.student;

import java.awt.List;
import java.util.LinkedList;
import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

//与后台之间的交汇
public class MassService {	

	public ExecResult postdata_bz(Map<String,String> param){
		
		String sql0;
		sql0= " DELETE FROM qm_xnxq_rule_version   WHERE `term_no`="+param.get("term_no") +"  AND `rule_type`='judge' ";
		
		String sql1="insert into qm_xnxq_rule_version (term_no,rule_type,rule_version) values "
				+ "(";
			sql1+="'"+param.get("term_no")+"',";
		sql1+="'judge',";
		sql1+="'"+param.get("rule_version")+"')";
		LinkedList<String> sql = new LinkedList<String>();
		sql.add(sql0);
		sql.add(sql1);
		JSONResponse response=new JSONResponse();
		ExecResult result= response.getExecResult(sql,"设置成功!","设置失败!");
		return result;
		
}
	
	public ExecResult postdata_bz_(Map<String,String> param){
		
		String sql0;
		sql0= " DELETE FROM qm_xnxq_rule_version   WHERE `term_no`="+param.get("term_no") +"  AND `rule_type`='"+param.get("rule_type")+ "'";
		
		String sql1="insert into qm_xnxq_rule_version (term_no,rule_type,rule_version) values "
				+ "(";
			sql1+="'"+param.get("term_no")+"',";
			sql1+="'"+param.get("rule_type")+"',";
		sql1+="'"+param.get("rule_version")+"')";
		LinkedList<String> sql = new LinkedList<String>();
		sql.add(sql0);
		sql.add(sql1);
		JSONResponse response=new JSONResponse();
		ExecResult result= response.getExecResult(sql,"设置成功!","设置失败!");
		return result;
		
}


	
	public ExecResult postdata_xbz(Map<String,String> param){
		String s=param.get("numble");
		if(Integer.parseInt(s)==10 )
		{
			String sql1="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql1+="'"+param.get("rule_version_title")+"',";
			sql1+="'"+param.get("rule_version_flag")+"',";
			sql1+=param.get("rule_version")+",";
			sql1+="'"+param.get("rule_content_one")+"',";
			sql1+="'"+param.get("rule_goal_one")+"',";
			sql1+="'"+param.get("rule_title_one")+"',";
			sql1+="'"+param.get("rule_status")+"',";
			sql1+="'"+param.get("rule_table")+"',";
			sql1+="'"+param.get("rule_field_one")+"')";
			
			String sql2="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql2+="'"+param.get("rule_version_title")+"',";
			sql2+="'"+param.get("rule_version_flag")+"',";
			sql2+="'"+param.get("rule_version")+"',";
			sql2+="'"+param.get("rule_content_two")+"',";
			sql2+="'"+param.get("rule_goal_two")+"',";
			sql2+="'"+param.get("rule_title_two")+"',";
			sql2+="'"+param.get("rule_status")+"',";
			sql2+="'"+param.get("rule_table")+"',";
			sql2+="'"+param.get("rule_field_two")+"')";
			
			String sql3="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql3+="'"+param.get("rule_version_title")+"',";
			sql3+="'"+param.get("rule_version_flag")+"',";
			sql3+="'"+param.get("rule_version")+"',";
			sql3+="'"+param.get("rule_content_three")+"',";
			sql3+="'"+param.get("rule_goal_three")+"',";
			sql3+="'"+param.get("rule_title_three")+"',";
			sql3+="'"+param.get("rule_status")+"',";
			sql3+="'"+param.get("rule_table")+"',";
			sql3+="'"+param.get("rule_field_three")+"')";
			
			String sql4="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql4+="'"+param.get("rule_version_title")+"',";
			sql4+="'"+param.get("rule_version_flag")+"',";
			sql4+="'"+param.get("rule_version")+"',";
			sql4+="'"+param.get("rule_content_four")+"',";
			sql4+="'"+param.get("rule_goal_four")+"',";
			sql4+="'"+param.get("rule_title_four")+"',";
			sql4+="'"+param.get("rule_status")+"',";
			sql4+="'"+param.get("rule_table")+"',";
			sql4+="'"+param.get("rule_field_four")+"')";
			
			String sql5="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql5+="'"+param.get("rule_version_title")+"',";
			sql5+="'"+param.get("rule_version_flag")+"',";
			sql5+=param.get("rule_version")+",";
			sql5+="'"+param.get("rule_content_five")+"',";
			sql5+=param.get("rule_goal_five")+",";
			sql5+="'"+param.get("rule_title_five")+"',";
			sql5+=param.get("rule_status")+",";
			sql5+="'"+param.get("rule_table")+"',";
			sql5+="'"+param.get("rule_field_five")+"')";
			
			String sql6="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql6+="'"+param.get("rule_version_title")+"',";
			sql6+="'"+param.get("rule_version_flag")+"',";
			sql6+=param.get("rule_version")+",";
			sql6+="'"+param.get("rule_content_six")+"',";
			sql6+=param.get("rule_goal_six")+",";
			sql6+="'"+param.get("rule_title_six")+"',";
			sql6+=param.get("rule_status")+",";
			sql6+="'"+param.get("rule_table")+"',";
			sql6+="'"+param.get("rule_field_six")+"')";
			
			String sql7="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql7+="'"+param.get("rule_version_title")+"',";
			sql7+="'"+param.get("rule_version_flag")+"',";
			sql7+=param.get("rule_version")+",";
			sql7+="'"+param.get("rule_content_seven")+"',";
			sql7+=param.get("rule_goal_seven")+",";
			sql7+="'"+param.get("rule_title_seven")+"',";
			sql7+=param.get("rule_status")+",";
			sql7+="'"+param.get("rule_table")+"',";
			sql7+="'"+param.get("rule_field_seven")+"')";
			
			String sql8="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql8+="'"+param.get("rule_version_title")+"',";
			sql8+="'"+param.get("rule_version_flag")+"',";
			sql8+=param.get("rule_version")+",";
			sql8+="'"+param.get("rule_content_eight")+"',";
			sql8+=param.get("rule_goal_eight")+",";
			sql8+="'"+param.get("rule_title_eight")+"',";
			sql8+=param.get("rule_status")+",";
			sql8+="'"+param.get("rule_table")+"',";
			sql8+="'"+param.get("rule_field_eight")+"')";
			
			String sql9="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql9+="'"+param.get("rule_version_title")+"',";
			sql9+="'"+param.get("rule_version_flag")+"',";
			sql9+=param.get("rule_version")+",";
			sql9+="'"+param.get("rule_content_nine")+"',";
			sql9+=param.get("rule_goal_nine")+",";
			sql9+="'"+param.get("rule_title_nine")+"',";
			sql9+=param.get("rule_status")+",";
			sql9+="'"+param.get("rule_table")+"',";
			sql9+="'"+param.get("rule_field_nine")+"')";
			
			String sql10="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql10+="'"+param.get("rule_version_title")+"',";
			sql10+="'"+param.get("rule_version_flag")+"',";
			sql10+=param.get("rule_version")+",";
			sql10+="'"+param.get("rule_content_ten")+"',";
			sql10+=param.get("rule_goal_ten")+",";
			sql10+="'"+param.get("rule_title_ten")+"',";
			sql10+=param.get("rule_status")+",";
			sql10+="'"+param.get("rule_table")+"',";
			sql10+="'"+param.get("rule_field_ten")+"')";
			
			LinkedList<String> sql = new LinkedList<String>();
			sql.add(sql1);
			sql.add(sql2);
			sql.add(sql3);
			sql.add(sql4);
			sql.add(sql5);
			sql.add(sql6);
			sql.add(sql7);
			sql.add(sql8);
			sql.add(sql9);
			sql.add(sql10);
			JSONResponse response=new JSONResponse();
			ExecResult result= response.getExecResult(sql,"新标准加入成功！","新标准加入失败");
			return result;
		}
		else if(Integer.parseInt(s)==9)
		{
			String sql1="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql1+="'"+param.get("rule_version_title")+"',";
			sql1+="'"+param.get("rule_version_flag")+"',";
			sql1+=param.get("rule_version")+",";
			sql1+="'"+param.get("rule_content_one")+"',";
			sql1+="'"+param.get("rule_goal_one")+"',";
			sql1+="'"+param.get("rule_title_one")+"',";
			sql1+="'"+param.get("rule_status")+"',";
			sql1+="'"+param.get("rule_table")+"',";
			sql1+="'"+param.get("rule_field_one")+"')";
			
			String sql2="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql2+="'"+param.get("rule_version_title")+"',";
			sql2+="'"+param.get("rule_version_flag")+"',";
			sql2+="'"+param.get("rule_version")+"',";
			sql2+="'"+param.get("rule_content_two")+"',";
			sql2+="'"+param.get("rule_goal_two")+"',";
			sql2+="'"+param.get("rule_title_two")+"',";
			sql2+="'"+param.get("rule_status")+"',";
			sql2+="'"+param.get("rule_table")+"',";
			sql2+="'"+param.get("rule_field_two")+"')";
			
			String sql3="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql3+="'"+param.get("rule_version_title")+"',";
			sql3+="'"+param.get("rule_version_flag")+"',";
			sql3+="'"+param.get("rule_version")+"',";
			sql3+="'"+param.get("rule_content_three")+"',";
			sql3+="'"+param.get("rule_goal_three")+"',";
			sql3+="'"+param.get("rule_title_three")+"',";
			sql3+="'"+param.get("rule_status")+"',";
			sql3+="'"+param.get("rule_table")+"',";
			sql3+="'"+param.get("rule_field_three")+"')";
			
			String sql4="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql4+="'"+param.get("rule_version_title")+"',";
			sql4+="'"+param.get("rule_version_flag")+"',";
			sql4+="'"+param.get("rule_version")+"',";
			sql4+="'"+param.get("rule_content_four")+"',";
			sql4+="'"+param.get("rule_goal_four")+"',";
			sql4+="'"+param.get("rule_title_four")+"',";
			sql4+="'"+param.get("rule_status")+"',";
			sql4+="'"+param.get("rule_table")+"',";
			sql4+="'"+param.get("rule_field_four")+"')";
			
			String sql5="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql5+="'"+param.get("rule_version_title")+"',";
			sql5+="'"+param.get("rule_version_flag")+"',";
			sql5+=param.get("rule_version")+",";
			sql5+="'"+param.get("rule_content_five")+"',";
			sql5+=param.get("rule_goal_five")+",";
			sql5+="'"+param.get("rule_title_five")+"',";
			sql5+=param.get("rule_status")+",";
			sql5+="'"+param.get("rule_table")+"',";
			sql5+="'"+param.get("rule_field_five")+"')";
			
			String sql6="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql6+="'"+param.get("rule_version_title")+"',";
			sql6+="'"+param.get("rule_version_flag")+"',";
			sql6+=param.get("rule_version")+",";
			sql6+="'"+param.get("rule_content_six")+"',";
			sql6+=param.get("rule_goal_six")+",";
			sql6+="'"+param.get("rule_title_six")+"',";
			sql6+=param.get("rule_status")+",";
			sql6+="'"+param.get("rule_table")+"',";
			sql6+="'"+param.get("rule_field_six")+"')";
			
			String sql7="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql7+="'"+param.get("rule_version_title")+"',";
			sql7+="'"+param.get("rule_version_flag")+"',";
			sql7+=param.get("rule_version")+",";
			sql7+="'"+param.get("rule_content_seven")+"',";
			sql7+=param.get("rule_goal_seven")+",";
			sql7+="'"+param.get("rule_title_seven")+"',";
			sql7+=param.get("rule_status")+",";
			sql7+="'"+param.get("rule_table")+"',";
			sql7+="'"+param.get("rule_field_seven")+"')";
			
			String sql8="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql8+="'"+param.get("rule_version_title")+"',";
			sql8+="'"+param.get("rule_version_flag")+"',";
			sql8+=param.get("rule_version")+",";
			sql8+="'"+param.get("rule_content_eight")+"',";
			sql8+=param.get("rule_goal_eight")+",";
			sql8+="'"+param.get("rule_title_eight")+"',";
			sql8+=param.get("rule_status")+",";
			sql8+="'"+param.get("rule_table")+"',";
			sql8+="'"+param.get("rule_field_eight")+"')";
			
			String sql9="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql9+="'"+param.get("rule_version_title")+"',";
			sql9+="'"+param.get("rule_version_flag")+"',";
			sql9+=param.get("rule_version")+",";
			sql9+="'"+param.get("rule_content_nine")+"',";
			sql9+=param.get("rule_goal_nine")+",";
			sql9+="'"+param.get("rule_title_nine")+"',";
			sql9+=param.get("rule_status")+",";
			sql9+="'"+param.get("rule_table")+"',";
			sql9+="'"+param.get("rule_field_nine")+"')";
			
			
	
			
			
			LinkedList<String> sql = new LinkedList<String>();
			sql.add(sql1);
			sql.add(sql2);
			sql.add(sql3);
			sql.add(sql4);
			sql.add(sql5);
			sql.add(sql6);
			sql.add(sql7);
			sql.add(sql8);
			sql.add(sql9);
			JSONResponse response=new JSONResponse();
			ExecResult result= response.getExecResult(sql,"新标准加入成功！","新标准加入失败");
			return result;
		}
		else if(Integer.parseInt(s)==8 )
		{
			String sql1="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql1+="'"+param.get("rule_version_title")+"',";
			sql1+="'"+param.get("rule_version_flag")+"',";
			sql1+=param.get("rule_version")+",";
			sql1+="'"+param.get("rule_content_one")+"',";
			sql1+="'"+param.get("rule_goal_one")+"',";
			sql1+="'"+param.get("rule_title_one")+"',";
			sql1+="'"+param.get("rule_status")+"',";
			sql1+="'"+param.get("rule_table")+"',";
			sql1+="'"+param.get("rule_field_one")+"')";
			
			String sql2="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql2+="'"+param.get("rule_version_title")+"',";
			sql2+="'"+param.get("rule_version_flag")+"',";
			sql2+="'"+param.get("rule_version")+"',";
			sql2+="'"+param.get("rule_content_two")+"',";
			sql2+="'"+param.get("rule_goal_two")+"',";
			sql2+="'"+param.get("rule_title_two")+"',";
			sql2+="'"+param.get("rule_status")+"',";
			sql2+="'"+param.get("rule_table")+"',";
			sql2+="'"+param.get("rule_field_two")+"')";
			
			String sql3="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql3+="'"+param.get("rule_version_title")+"',";
			sql3+="'"+param.get("rule_version_flag")+"',";
			sql3+="'"+param.get("rule_version")+"',";
			sql3+="'"+param.get("rule_content_three")+"',";
			sql3+="'"+param.get("rule_goal_three")+"',";
			sql3+="'"+param.get("rule_title_three")+"',";
			sql3+="'"+param.get("rule_status")+"',";
			sql3+="'"+param.get("rule_table")+"',";
			sql3+="'"+param.get("rule_field_three")+"')";
			
			String sql4="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql4+="'"+param.get("rule_version_title")+"',";
			sql4+="'"+param.get("rule_version_flag")+"',";
			sql4+="'"+param.get("rule_version")+"',";
			sql4+="'"+param.get("rule_content_four")+"',";
			sql4+="'"+param.get("rule_goal_four")+"',";
			sql4+="'"+param.get("rule_title_four")+"',";
			sql4+="'"+param.get("rule_status")+"',";
			sql4+="'"+param.get("rule_table")+"',";
			sql4+="'"+param.get("rule_field_four")+"')";
			
			String sql5="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql5+="'"+param.get("rule_version_title")+"',";
			sql5+="'"+param.get("rule_version_flag")+"',";
			sql5+=param.get("rule_version")+",";
			sql5+="'"+param.get("rule_content_five")+"',";
			sql5+=param.get("rule_goal_five")+",";
			sql5+="'"+param.get("rule_title_five")+"',";
			sql5+=param.get("rule_status")+",";
			sql5+="'"+param.get("rule_table")+"',";
			sql5+="'"+param.get("rule_field_five")+"')";
			
			String sql6="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql6+="'"+param.get("rule_version_title")+"',";
			sql6+="'"+param.get("rule_version_flag")+"',";
			sql6+=param.get("rule_version")+",";
			sql6+="'"+param.get("rule_content_six")+"',";
			sql6+=param.get("rule_goal_six")+",";
			sql6+="'"+param.get("rule_title_six")+"',";
			sql6+=param.get("rule_status")+",";
			sql6+="'"+param.get("rule_table")+"',";
			sql6+="'"+param.get("rule_field_six")+"')";
			
			String sql7="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql7+="'"+param.get("rule_version_title")+"',";
			sql7+="'"+param.get("rule_version_flag")+"',";
			sql7+=param.get("rule_version")+",";
			sql7+="'"+param.get("rule_content_seven")+"',";
			sql7+=param.get("rule_goal_seven")+",";
			sql7+="'"+param.get("rule_title_seven")+"',";
			sql7+=param.get("rule_status")+",";
			sql7+="'"+param.get("rule_table")+"',";
			sql7+="'"+param.get("rule_field_seven")+"')";
			
			String sql8="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql8+="'"+param.get("rule_version_title")+"',";
			sql8+="'"+param.get("rule_version_flag")+"',";
			sql8+=param.get("rule_version")+",";
			sql8+="'"+param.get("rule_content_eight")+"',";
			sql8+=param.get("rule_goal_eight")+",";
			sql8+="'"+param.get("rule_title_eight")+"',";
			sql8+=param.get("rule_status")+",";
			sql8+="'"+param.get("rule_table")+"',";
			sql8+="'"+param.get("rule_field_eight")+"')";
			
			LinkedList<String> sql = new LinkedList<String>();
			sql.add(sql1);
			sql.add(sql2);
			sql.add(sql3);
			sql.add(sql4);
			sql.add(sql5);
			sql.add(sql6);
			sql.add(sql7);
			sql.add(sql8);
			JSONResponse response=new JSONResponse();
			ExecResult result= response.getExecResult(sql,"新标准加入成功！","新标准加入失败");
			return result;
		}
		else if(Integer.parseInt(s)==7 )
		{
			String sql1="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql1+="'"+param.get("rule_version_title")+"',";
			sql1+="'"+param.get("rule_version_flag")+"',";
			sql1+=param.get("rule_version")+",";
			sql1+="'"+param.get("rule_content_one")+"',";
			sql1+="'"+param.get("rule_goal_one")+"',";
			sql1+="'"+param.get("rule_title_one")+"',";
			sql1+="'"+param.get("rule_status")+"',";
			sql1+="'"+param.get("rule_table")+"',";
			sql1+="'"+param.get("rule_field_one")+"')";
			
			String sql2="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql2+="'"+param.get("rule_version_title")+"',";
			sql2+="'"+param.get("rule_version_flag")+"',";
			sql2+="'"+param.get("rule_version")+"',";
			sql2+="'"+param.get("rule_content_two")+"',";
			sql2+="'"+param.get("rule_goal_two")+"',";
			sql2+="'"+param.get("rule_title_two")+"',";
			sql2+="'"+param.get("rule_status")+"',";
			sql2+="'"+param.get("rule_table")+"',";
			sql2+="'"+param.get("rule_field_two")+"')";
			
			String sql3="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql3+="'"+param.get("rule_version_title")+"',";
			sql3+="'"+param.get("rule_version_flag")+"',";
			sql3+="'"+param.get("rule_version")+"',";
			sql3+="'"+param.get("rule_content_three")+"',";
			sql3+="'"+param.get("rule_goal_three")+"',";
			sql3+="'"+param.get("rule_title_three")+"',";
			sql3+="'"+param.get("rule_status")+"',";
			sql3+="'"+param.get("rule_table")+"',";
			sql3+="'"+param.get("rule_field_three")+"')";
			
			String sql4="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql4+="'"+param.get("rule_version_title")+"',";
			sql4+="'"+param.get("rule_version_flag")+"',";
			sql4+="'"+param.get("rule_version")+"',";
			sql4+="'"+param.get("rule_content_four")+"',";
			sql4+="'"+param.get("rule_goal_four")+"',";
			sql4+="'"+param.get("rule_title_four")+"',";
			sql4+="'"+param.get("rule_status")+"',";
			sql4+="'"+param.get("rule_table")+"',";
			sql4+="'"+param.get("rule_field_four")+"')";
			
			String sql5="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql5+="'"+param.get("rule_version_title")+"',";
			sql5+="'"+param.get("rule_version_flag")+"',";
			sql5+=param.get("rule_version")+",";
			sql5+="'"+param.get("rule_content_five")+"',";
			sql5+=param.get("rule_goal_five")+",";
			sql5+="'"+param.get("rule_title_five")+"',";
			sql5+=param.get("rule_status")+",";
			sql5+="'"+param.get("rule_table")+"',";
			sql5+="'"+param.get("rule_field_five")+"')";
			
			String sql6="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql6+="'"+param.get("rule_version_title")+"',";
			sql6+="'"+param.get("rule_version_flag")+"',";
			sql6+=param.get("rule_version")+",";
			sql6+="'"+param.get("rule_content_six")+"',";
			sql6+=param.get("rule_goal_six")+",";
			sql6+="'"+param.get("rule_title_six")+"',";
			sql6+=param.get("rule_status")+",";
			sql6+="'"+param.get("rule_table")+"',";
			sql6+="'"+param.get("rule_field_six")+"')";
			
			String sql7="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql7+="'"+param.get("rule_version_title")+"',";
			sql7+="'"+param.get("rule_version_flag")+"',";
			sql7+=param.get("rule_version")+",";
			sql7+="'"+param.get("rule_content_seven")+"',";
			sql7+=param.get("rule_goal_seven")+",";
			sql7+="'"+param.get("rule_title_seven")+"',";
			sql7+=param.get("rule_status")+",";
			sql7+="'"+param.get("rule_table")+"',";
			sql7+="'"+param.get("rule_field_seven")+"')";
			
	

			LinkedList<String> sql = new LinkedList<String>();
			sql.add(sql1);
			sql.add(sql2);
			sql.add(sql3);
			sql.add(sql4);
			sql.add(sql5);
			sql.add(sql6);
			sql.add(sql7);
			JSONResponse response=new JSONResponse();
			ExecResult result= response.getExecResult(sql,"新标准加入成功！","新标准加入失败");
			return result;
		}
		else if(Integer.parseInt(s)==6)
		{
			String sql1="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql1+="'"+param.get("rule_version_title")+"',";
			sql1+="'"+param.get("rule_version_flag")+"',";
			sql1+=param.get("rule_version")+",";
			sql1+="'"+param.get("rule_content_one")+"',";
			sql1+="'"+param.get("rule_goal_one")+"',";
			sql1+="'"+param.get("rule_title_one")+"',";
			sql1+="'"+param.get("rule_status")+"',";
			sql1+="'"+param.get("rule_table")+"',";
			sql1+="'"+param.get("rule_field_one")+"')";
			
			String sql2="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql2+="'"+param.get("rule_version_title")+"',";
			sql2+="'"+param.get("rule_version_flag")+"',";
			sql2+="'"+param.get("rule_version")+"',";
			sql2+="'"+param.get("rule_content_two")+"',";
			sql2+="'"+param.get("rule_goal_two")+"',";
			sql2+="'"+param.get("rule_title_two")+"',";
			sql2+="'"+param.get("rule_status")+"',";
			sql2+="'"+param.get("rule_table")+"',";
			sql2+="'"+param.get("rule_field_two")+"')";
			
			String sql3="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql3+="'"+param.get("rule_version_title")+"',";
			sql3+="'"+param.get("rule_version_flag")+"',";
			sql3+="'"+param.get("rule_version")+"',";
			sql3+="'"+param.get("rule_content_three")+"',";
			sql3+="'"+param.get("rule_goal_three")+"',";
			sql3+="'"+param.get("rule_title_three")+"',";
			sql3+="'"+param.get("rule_status")+"',";
			sql3+="'"+param.get("rule_table")+"',";
			sql3+="'"+param.get("rule_field_three")+"')";
			
			String sql4="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql4+="'"+param.get("rule_version_title")+"',";
			sql4+="'"+param.get("rule_version_flag")+"',";
			sql4+="'"+param.get("rule_version")+"',";
			sql4+="'"+param.get("rule_content_four")+"',";
			sql4+="'"+param.get("rule_goal_four")+"',";
			sql4+="'"+param.get("rule_title_four")+"',";
			sql4+="'"+param.get("rule_status")+"',";
			sql4+="'"+param.get("rule_table")+"',";
			sql4+="'"+param.get("rule_field_four")+"')";
			
			String sql5="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql5+="'"+param.get("rule_version_title")+"',";
			sql5+="'"+param.get("rule_version_flag")+"',";
			sql5+=param.get("rule_version")+",";
			sql5+="'"+param.get("rule_content_five")+"',";
			sql5+=param.get("rule_goal_five")+",";
			sql5+="'"+param.get("rule_title_five")+"',";
			sql5+=param.get("rule_status")+",";
			sql5+="'"+param.get("rule_table")+"',";
			sql5+="'"+param.get("rule_field_five")+"')";
			
			String sql6="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql6+="'"+param.get("rule_version_title")+"',";
			sql6+="'"+param.get("rule_version_flag")+"',";
			sql6+=param.get("rule_version")+",";
			sql6+="'"+param.get("rule_content_six")+"',";
			sql6+=param.get("rule_goal_six")+",";
			sql6+="'"+param.get("rule_title_six")+"',";
			sql6+=param.get("rule_status")+",";
			sql6+="'"+param.get("rule_table")+"',";
			sql6+="'"+param.get("rule_field_six")+"')";
			LinkedList<String> sql = new LinkedList<String>();
			sql.add(sql1);
			sql.add(sql2);
			sql.add(sql3);
			sql.add(sql4);
			sql.add(sql5);
			sql.add(sql6);
			JSONResponse response=new JSONResponse();
			ExecResult result= response.getExecResult(sql,"新标准加入成功！","新标准加入失败");
			return result;
		}
		else
		{
			String sql1="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql1+="'"+param.get("rule_version_title")+"',";
			sql1+="'"+param.get("rule_version_flag")+"',";
			sql1+=param.get("rule_version")+",";
			sql1+="'"+param.get("rule_content_one")+"',";
			sql1+="'"+param.get("rule_goal_one")+"',";
			sql1+="'"+param.get("rule_title_one")+"',";
			sql1+="'"+param.get("rule_status")+"',";
			sql1+="'"+param.get("rule_table")+"',";
			sql1+="'"+param.get("rule_field_one")+"')";
			
			String sql2="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql2+="'"+param.get("rule_version_title")+"',";
			sql2+="'"+param.get("rule_version_flag")+"',";
			sql2+="'"+param.get("rule_version")+"',";
			sql2+="'"+param.get("rule_content_two")+"',";
			sql2+="'"+param.get("rule_goal_two")+"',";
			sql2+="'"+param.get("rule_title_two")+"',";
			sql2+="'"+param.get("rule_status")+"',";
			sql2+="'"+param.get("rule_table")+"',";
			sql2+="'"+param.get("rule_field_two")+"')";
			
			String sql3="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql3+="'"+param.get("rule_version_title")+"',";
			sql3+="'"+param.get("rule_version_flag")+"',";
			sql3+="'"+param.get("rule_version")+"',";
			sql3+="'"+param.get("rule_content_three")+"',";
			sql3+="'"+param.get("rule_goal_three")+"',";
			sql3+="'"+param.get("rule_title_three")+"',";
			sql3+="'"+param.get("rule_status")+"',";
			sql3+="'"+param.get("rule_table")+"',";
			sql3+="'"+param.get("rule_field_three")+"')";
			
			String sql4="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql4+="'"+param.get("rule_version_title")+"',";
			sql4+="'"+param.get("rule_version_flag")+"',";
			sql4+="'"+param.get("rule_version")+"',";
			sql4+="'"+param.get("rule_content_four")+"',";
			sql4+="'"+param.get("rule_goal_four")+"',";
			sql4+="'"+param.get("rule_title_four")+"',";
			sql4+="'"+param.get("rule_status")+"',";
			sql4+="'"+param.get("rule_table")+"',";
			sql4+="'"+param.get("rule_field_four")+"')";
			
			String sql5="insert into qm_rule (rule_version_title,rule_version_flag,rule_version,rule_content,rule_goal,rule_title,rule_status,rule_table,rule_field) values "
					+ "(";
				sql5+="'"+param.get("rule_version_title")+"',";
			sql5+="'"+param.get("rule_version_flag")+"',";
			sql5+=param.get("rule_version")+",";
			sql5+="'"+param.get("rule_content_five")+"',";
			sql5+=param.get("rule_goal_five")+",";
			sql5+="'"+param.get("rule_title_five")+"',";
			sql5+=param.get("rule_status")+",";
			sql5+="'"+param.get("rule_table")+"',";
			sql5+="'"+param.get("rule_field_five")+"')";
			
	
			LinkedList<String> sql = new LinkedList<String>();
			sql.add(sql1);
			sql.add(sql2);
			sql.add(sql3);
			sql.add(sql4);
			sql.add(sql5);
			JSONResponse response=new JSONResponse();
			ExecResult result= response.getExecResult(sql,"新标准加入成功！","新标准加入失败");
			return result;
		}
	
}
	
	public ExecResult postdata_xkh(Map<String,String> param){
		String s=param.get("numble");
		if(Integer.parseInt(s)==5)
		{
			String sql1="insert into qm_judge_rule (rule_version,rule_title,rule_item_title,rule_item_content,rule_table,rule_item_field,rule_item_formula,rule_status) values "
					+ "(";
				sql1+="'"+param.get("rule_version")+"',";
			sql1+="'"+param.get("rule_title")+"',";
			sql1+=param.get("rule_item_title_one")+",";
			sql1+="'"+param.get("rule_item_content_one")+"',";
			sql1+="'"+param.get("rule_table")+"',";
			sql1+="'"+param.get("rule_item_field_one")+"',";
			sql1+="'"+param.get("rule_item_formula_one")+"',";
			sql1+="'"+param.get("rule_status")+"')";
			
			String sql2="insert into qm_judge_rule (rule_version,rule_title,rule_item_title,rule_item_content,rule_table,rule_item_field,rule_item_formula,rule_status) values "
					+ "(";
				sql2+="'"+param.get("rule_version")+"',";
			sql2+="'"+param.get("rule_title")+"',";
			sql2+=param.get("rule_item_title_two")+",";
			sql2+="'"+param.get("rule_item_content_two")+"',";
			sql2+="'"+param.get("rule_table")+"',";
			sql2+="'"+param.get("rule_item_field_two")+"',";
			sql2+="'"+param.get("rule_item_formula_two")+"',";
			sql2+="'"+param.get("rule_status")+"')";
			
			String sql3="insert into qm_judge_rule (rule_version,rule_title,rule_item_title,rule_item_content,rule_table,rule_item_field,rule_item_formula,rule_status) values "
					+ "(";
				sql3+="'"+param.get("rule_version")+"',";
			sql3+="'"+param.get("rule_title")+"',";
			sql3+=param.get("rule_item_title_three")+",";
			sql3+="'"+param.get("rule_item_content_three")+"',";
			sql3+="'"+param.get("rule_table")+"',";
			sql3+="'"+param.get("rule_item_field_three")+"',";
			sql3+="'"+param.get("rule_item_formula_three")+"',";
			sql3+="'"+param.get("rule_status")+"')";
			
			String sql4="insert into qm_judge_rule (rule_version,rule_title,rule_item_title,rule_item_content,rule_table,rule_item_field,rule_item_formula,rule_status) values "
					+ "(";
				sql4+="'"+param.get("rule_version")+"',";
			sql4+="'"+param.get("rule_title")+"',";
			sql4+=param.get("rule_item_title_four")+",";
			sql4+="'"+param.get("rule_item_content_four")+"',";
			sql4+="'"+param.get("rule_table")+"',";
			sql4+="'"+param.get("rule_item_field_four")+"',";
			sql4+="'"+param.get("rule_item_formula_four")+"',";
			sql4+="'"+param.get("rule_status")+"')";
			
			String sql5="insert into qm_judge_rule (rule_version,rule_title,rule_item_title,rule_item_content,rule_table,rule_item_field,rule_item_formula,rule_status) values "
					+ "(";
				sql5+="'"+param.get("rule_version")+"',";
			sql5+="'"+param.get("rule_title")+"',";
			sql5+=param.get("rule_item_title_five")+",";
			sql5+="'"+param.get("rule_item_content_five")+"',";
			sql5+="'"+param.get("rule_table")+"',";
			sql5+="'"+param.get("rule_item_field_five")+"',";
			sql5+="'"+param.get("rule_item_formula_five")+"',";
			sql5+="'"+param.get("rule_status")+"')";
			
			LinkedList<String> sql = new LinkedList<String>();
			sql.add(sql1);
			sql.add(sql2);
			sql.add(sql3);
			sql.add(sql4);
			sql.add(sql5);
			JSONResponse response=new JSONResponse();
			ExecResult result= response.getExecResult(sql,"新标准加入成功！","新标准加入失败");
			return result;
		}
		else if(Integer.parseInt(s)==4)
		{
			String sql1="insert into qm_judge_rule (rule_version,rule_title,rule_item_title,rule_item_content,rule_table,rule_item_field,rule_item_formula,rule_status) values "
					+ "(";
				sql1+="'"+param.get("rule_version")+"',";
			sql1+="'"+param.get("rule_title")+"',";
			sql1+=param.get("rule_item_title_one")+",";
			sql1+="'"+param.get("rule_item_content_one")+"',";
			sql1+="'"+param.get("rule_table")+"',";
			sql1+="'"+param.get("rule_item_field_one")+"',";
			sql1+="'"+param.get("rule_item_formula_one")+"',";
			sql1+="'"+param.get("rule_status")+"')";
			
			String sql2="insert into qm_judge_rule (rule_version,rule_title,rule_item_title,rule_item_content,rule_table,rule_item_field,rule_item_formula,rule_status) values "
					+ "(";
				sql2+="'"+param.get("rule_version")+"',";
			sql2+="'"+param.get("rule_title")+"',";
			sql2+=param.get("rule_item_title_two")+",";
			sql2+="'"+param.get("rule_item_content_two")+"',";
			sql2+="'"+param.get("rule_table")+"',";
			sql2+="'"+param.get("rule_item_field_two")+"',";
			sql2+="'"+param.get("rule_item_formula_two")+"',";
			sql2+="'"+param.get("rule_status")+"')";
			
			String sql3="insert into qm_judge_rule (rule_version,rule_title,rule_item_title,rule_item_content,rule_table,rule_item_field,rule_item_formula,rule_status) values "
					+ "(";
				sql3+="'"+param.get("rule_version")+"',";
			sql3+="'"+param.get("rule_title")+"',";
			sql3+=param.get("rule_item_title_three")+",";
			sql3+="'"+param.get("rule_item_content_three")+"',";
			sql3+="'"+param.get("rule_table")+"',";
			sql3+="'"+param.get("rule_item_field_three")+"',";
			sql3+="'"+param.get("rule_item_formula_three")+"',";
			sql3+="'"+param.get("rule_status")+"')";
			
			String sql4="insert into qm_judge_rule (rule_version,rule_title,rule_item_title,rule_item_content,rule_table,rule_item_field,rule_item_formula,rule_status) values "
					+ "(";
				sql4+="'"+param.get("rule_version")+"',";
			sql4+="'"+param.get("rule_title")+"',";
			sql4+=param.get("rule_item_title_four")+",";
			sql4+="'"+param.get("rule_item_content_four")+"',";
			sql4+="'"+param.get("rule_table")+"',";
			sql4+="'"+param.get("rule_item_field_four")+"',";
			sql4+="'"+param.get("rule_item_formula_four")+"',";
			sql4+="'"+param.get("rule_status")+"')";
			
			LinkedList<String> sql = new LinkedList<String>();
			sql.add(sql1);
			sql.add(sql2);
			sql.add(sql3);
			sql.add(sql4);
			JSONResponse response=new JSONResponse();
			ExecResult result= response.getExecResult(sql,"新标准加入成功！","新标准加入失败");
			return result;
		}
		else if(Integer.parseInt(s)==3 )
		{
			String sql1="insert into qm_judge_rule (rule_version,rule_title,rule_item_title,rule_item_content,rule_table,rule_item_field,rule_item_formula,rule_status) values "
					+ "(";
				sql1+="'"+param.get("rule_version")+"',";
			sql1+="'"+param.get("rule_title")+"',";
			sql1+=param.get("rule_item_title_one")+",";
			sql1+="'"+param.get("rule_item_content_one")+"',";
			sql1+="'"+param.get("rule_table")+"',";
			sql1+="'"+param.get("rule_item_field_one")+"',";
			sql1+="'"+param.get("rule_item_formula_one")+"',";
			sql1+="'"+param.get("rule_status")+"')";
			
			String sql2="insert into qm_judge_rule (rule_version,rule_title,rule_item_title,rule_item_content,rule_table,rule_item_field,rule_item_formula,rule_status) values "
					+ "(";
				sql2+="'"+param.get("rule_version")+"',";
			sql2+="'"+param.get("rule_title")+"',";
			sql2+=param.get("rule_item_title_two")+",";
			sql2+="'"+param.get("rule_item_content_two")+"',";
			sql2+="'"+param.get("rule_table")+"',";
			sql2+="'"+param.get("rule_item_field_two")+"',";
			sql2+="'"+param.get("rule_item_formula_two")+"',";
			sql2+="'"+param.get("rule_status")+"')";
			
			String sql3="insert into qm_judge_rule (rule_version,rule_title,rule_item_title,rule_item_content,rule_table,rule_item_field,rule_item_formula,rule_status) values "
					+ "(";
				sql3+="'"+param.get("rule_version")+"',";
			sql3+="'"+param.get("rule_title")+"',";
			sql3+=param.get("rule_item_title_three")+",";
			sql3+="'"+param.get("rule_item_content_three")+"',";
			sql3+="'"+param.get("rule_table")+"',";
			sql3+="'"+param.get("rule_item_field_three")+"',";
			sql3+="'"+param.get("rule_item_formula_three")+"',";
			sql3+="'"+param.get("rule_status")+"')";
			
			LinkedList<String> sql = new LinkedList<String>();
			sql.add(sql1);
			sql.add(sql2);
			sql.add(sql3);
			JSONResponse response=new JSONResponse();
			ExecResult result= response.getExecResult(sql,"新标准加入成功！","新标准加入失败");
			return result;
		}
		else 
		{
			String sql1="insert into qm_judge_rule (rule_version,rule_title,rule_item_title,rule_item_content,rule_table,rule_item_field,rule_item_formula,rule_status) values "
					+ "(";
				sql1+="'"+param.get("rule_version")+"',";
			sql1+="'"+param.get("rule_title")+"',";
			sql1+=param.get("rule_item_title_one")+",";
			sql1+="'"+param.get("rule_item_content_one")+"',";
			sql1+="'"+param.get("rule_table")+"',";
			sql1+="'"+param.get("rule_item_field_one")+"',";
			sql1+="'"+param.get("rule_item_formula_one")+"',";
			sql1+="'"+param.get("rule_status")+"')";
			
			String sql2="insert into qm_judge_rule (rule_version,rule_title,rule_item_title,rule_item_content,rule_table,rule_item_field,rule_item_formula,rule_status) values "
					+ "(";
				sql2+="'"+param.get("rule_version")+"',";
			sql2+="'"+param.get("rule_title")+"',";
			sql2+=param.get("rule_item_title_two")+",";
			sql2+="'"+param.get("rule_item_content_two")+"',";
			sql2+="'"+param.get("rule_table")+"',";
			sql2+="'"+param.get("rule_item_field_two")+"',";
			sql2+="'"+param.get("rule_item_formula_two")+"',";
			sql2+="'"+param.get("rule_status")+"')";
			LinkedList<String> sql = new LinkedList<String>();
			sql.add(sql1);
			sql.add(sql2);
			JSONResponse response=new JSONResponse();
			ExecResult result= response.getExecResult(sql,"新标准加入成功！","新标准加入失败！");
			return result;
		}
}
	public ExecResult postdata_xnkh(Map<String,String> param)
	{
		String sql0;
		sql0= "DELETE FROM qm_judge_config   WHERE `year_no`="+param.get("year_no");
		String sql1="insert into qm_judge_config (year_no,judge_type,judge_youxiu,judge_lianghao,judge_set) values "
				+ "(";
			sql1+=param.get("year_no")+",";
		sql1+="'"+param.get("judge_type_score")+"',";
		sql1+=param.get("judge_youxiu_fz")+",";
		sql1+=param.get("judge_lianghao_fz")+",";
		sql1+=param.get("judge_set_score")+")";
		
		String sql2="insert into qm_judge_config (year_no,judge_type,judge_youxiu,judge_lianghao,judge_set) values "
				+ "(";
			sql2+=param.get("year_no")+",";
		sql2+="'"+param.get("judge_type_percent")+"',";
		sql2+=param.get("judge_youxiu_bfb")+",";
		sql2+=param.get("judge_lianghao_bfb")+",";
		sql2+=param.get("judge_set_percent")+")";
		LinkedList<String> sql = new LinkedList<String>();
		sql.add(sql0);
		sql.add(sql1);
		sql.add(sql2);
		JSONResponse response=new JSONResponse();
		ExecResult result= response.getExecResult(sql,"学年考核新标准加入成功！","学年考核新标准加入失败！");
		return result;
	}
	
	public ExecResult loadchange(Map<String,String> param){
		String sql0;
		sql0= "UPDATE qm_rule a SET rule_status= '0' WHERE a.`rule_version_flag`="+"'"+param.get("rule_version_flag")+"'"  ;
		String s=param.get("rule_status");
		if(Integer.parseInt(s)==0 )
		{
			String sql1;
			sql1= " UPDATE qm_rule a SET rule_status= '1' WHERE a.`rule_version_flag`="+"'"+param.get("rule_version_flag")+"'"+ "AND a.`rule_version`="+param.get("rule_version");
			LinkedList<String> sql = new LinkedList<String>();
			sql.add(sql0);
			sql.add(sql1);
			JSONResponse response=new JSONResponse();
			ExecResult result= response.getExecResult(sql,"班级评学标准设置cgeng","班级评学标准设置失败");
			return result;
		}
		else
		{
			JSONResponse response=new JSONResponse();
			ExecResult result= response.getExecResult(sql0,null,"班级评学标准设置cgeng","班级评学标准设置失败");
			return result;
		}
			
}
	
	public ExecResult loadchangekh(Map<String,String> param){
		String sql0;
		sql0= "UPDATE qm_judge_rule a SET rule_status= '0' WHERE a.`rule_title`="+"'"+param.get("rule_title")+"'"  ;
		String s=param.get("rule_status");
		if(Integer.parseInt(s)==0 )
		{
			String sql1;
			sql1= " UPDATE qm_judge_rule a SET rule_status= '1' WHERE a.`rule_title`="+"'"+param.get("rule_title")+"'"+ "AND a.`rule_version`="+param.get("rule_version");
			LinkedList<String> sql = new LinkedList<String>();
			sql.add(sql0);
			sql.add(sql1);
			JSONResponse response=new JSONResponse();
			ExecResult result= response.getExecResult(sql,"","");
			return result;
		}
		else
		{
			JSONResponse response=new JSONResponse();
			ExecResult result= response.getExecResult(sql0,null,"","");
			return result;
		}
			
}
	
	public ExecResult loadchangexnkh(Map<String,String> param){
		    String sql0;
		    sql0= "UPDATE qm_judge_config a SET a.judge_set= '0'  WHERE a.`year_no`="+param.get("year_no");
			String sql1;
			sql1= "UPDATE qm_judge_config a SET a.judge_set= '1'  WHERE a.`year_no`="+param.get("year_no")+" AND a.`judge_type`="+"'"+param.get("judge_type")+"'";
			LinkedList<String> sql = new LinkedList<String>();
			sql.add(sql0);
			sql.add(sql1);
			JSONResponse response=new JSONResponse();
			ExecResult result= response.getExecResult(sql,"","");
			return result;
		
}
	
	
	public ExecResult loadversion(String rule_version ){
		String sql="SELECT a.`rule_version`,a.`rule_version_flag` FROM qm_rule a  WHERE  a.`rule_version_flag`=''{0}'' GROUP BY a.`rule_version`  ORDER BY a.`rule_version` DESC  ";
		String [] params=new String[] {rule_version };
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult loadversionkh(String rule_title ){
		String sql="SELECT * FROM qm_judge_rule a  WHERE a.`rule_title`=''{0}'' GROUP BY a.`rule_version`  ORDER BY a.`rule_version` DESC   ";
		String [] params=new String[] {rule_title };
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult load_listen(String rule_version_flag,String rule_version){
		String sql="SELECT *FROM qm_rule a  WHERE a.`rule_version_flag`=''{0}'' AND a.`rule_version`=''{1}''";
		String [] params=new String[] {rule_version_flag,rule_version};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult load_listenkh(String rule_title,String rule_version){
		String sql="SELECT *FROM qm_judge_rule a  WHERE a.`rule_title`=''{0}'' AND a.`rule_version`=''{1}''";
		String [] params=new String[] {rule_title,rule_version};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult load_all(){
		String sql="SELECT a.`rule_version_title`,a.`rule_version_flag`,a.`rule_table` FROM qm_rule a  GROUP BY a.`rule_version_flag`";
		String [] params=new String[] {};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult loadkh(){
		String sql="SELECT*FROM qm_judge_rule GROUP BY rule_title";
		String [] params=new String[] {};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult loadxnkh(){
		String sql="SELECT*FROM qm_judge_config GROUP BY year_no ORDER BY year_no DESC";
		String [] params=new String[] {};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult load_bb(String rule_version_flag){
		String sql="SELECT a.`rule_version_title`,a.`rule_version`,a.`rule_status`,a.`rule_version_flag` FROM qm_rule a  WHERE a.`rule_version_flag`=''{0}'' GROUP BY a.`rule_version`";
		String [] params=new String[] {rule_version_flag};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult load_kh(String rule_title){
		String sql="SELECT *FROM qm_judge_rule a  WHERE a.`rule_title`=''{0}'' GROUP BY a.`rule_version`";
		String [] params=new String[] {rule_title};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult loadxnkhxq(String year_no){
		String sql="SELECT *FROM qm_judge_config a  WHERE a.`year_no`=''{0}''";
		String [] params=new String[] {year_no};
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, params,"base_teach_task");
		return result;
	}
	
	public ExecResult loadversionuse(String rule_type){
		String sql="SELECT * FROM  qm_xnxq_rule_version a WHERE a.`rule_type` = '"+rule_type+"' ORDER BY a.`term_no` DESC ";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"qm_xnxq_rule_version");
		return result;
	}

}




