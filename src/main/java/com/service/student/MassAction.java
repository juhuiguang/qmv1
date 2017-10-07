package com.service.student;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class MassAction extends Action {
	public void postdata_xbz(){
		String numble=request.getParameter("numble");
		String rule_version_title=request.getParameter("rule_version_title");
		String rule_version_flag=request.getParameter("rule_version_flag");
		String rule_version=request.getParameter("rule_version");
		String rule_content_one=request.getParameter("rule_content_one");
		String rule_content_two=request.getParameter("rule_content_two");
		String rule_content_three=request.getParameter("rule_content_three");
		String rule_content_four=request.getParameter("rule_content_four");
		String rule_content_five=request.getParameter("rule_content_five");
		String rule_content_six=request.getParameter("rule_content_six");
		String rule_content_seven=request.getParameter("rule_content_seven");
		String rule_content_eight=request.getParameter("rule_content_eight");
		String rule_content_nine=request.getParameter("rule_content_nine");
		String rule_content_ten=request.getParameter("rule_content_ten");
		String rule_goal_one=request.getParameter("rule_goal_one");
		String rule_goal_two=request.getParameter("rule_goal_two");
		String rule_goal_three=request.getParameter("rule_goal_three");
		String rule_goal_four=request.getParameter("rule_goal_four");
		String rule_goal_five=request.getParameter("rule_goal_five");
		String rule_goal_six=request.getParameter("rule_goal_six");
		String rule_goal_seven=request.getParameter("rule_goal_seven");
		String rule_goal_eight=request.getParameter("rule_goal_eight");
		String rule_goal_nine=request.getParameter("rule_goal_nine");
		String rule_goal_ten=request.getParameter("rule_goal_ten");
		String rule_title_one=request.getParameter("rule_title_one");
		String rule_title_two=request.getParameter("rule_title_two");
		String rule_title_three=request.getParameter("rule_title_three");
		String rule_title_four=request.getParameter("rule_title_four");
		String rule_title_five=request.getParameter("rule_title_five");
		String rule_title_six=request.getParameter("rule_title_six");
		String rule_title_seven=request.getParameter("rule_title_seven");
		String rule_title_eight=request.getParameter("rule_title_eight");
		String rule_title_nine=request.getParameter("rule_title_nine");
		String rule_title_ten=request.getParameter("rule_title_ten");
		String rule_status=request.getParameter("rule_status");
		String rule_table=request.getParameter("rule_table");
		String rule_field_one=request.getParameter("rule_field_one");
		String rule_field_two=request.getParameter("rule_field_two");
		String rule_field_three=request.getParameter("rule_field_three");
		String rule_field_four=request.getParameter("rule_field_four");
		String rule_field_five=request.getParameter("rule_field_five");
		String rule_field_six=request.getParameter("rule_field_six");
		String rule_field_seven=request.getParameter("rule_field_seven");
		String rule_field_eight=request.getParameter("rule_field_eight");
		String rule_field_nine=request.getParameter("rule_field_nine");
		String rule_field_ten=request.getParameter("rule_field_ten");
		Map<String,String>param=new HashMap();
		param.put("numble", numble);
		param.put("rule_version_title", rule_version_title);
		param.put("rule_version_flag", rule_version_flag);
		param.put("rule_version", rule_version);
		param.put("rule_content_one",rule_content_one);
		param.put("rule_content_two", rule_content_two);
		param.put("rule_content_three", rule_content_three);
		param.put("rule_content_four", rule_content_four);
		param.put("rule_content_five", rule_content_five);
		param.put("rule_content_six", rule_content_six);
		param.put("rule_content_seven", rule_content_seven);
		param.put("rule_content_eight", rule_content_eight);
		param.put("rule_content_nine", rule_content_nine);
		param.put("rule_content_ten", rule_content_ten);
		param.put("rule_goal_one",  rule_goal_one);
		param.put("rule_goal_two", rule_goal_two);
		param.put("rule_goal_three", rule_goal_three);
		param.put("rule_goal_four", rule_goal_four);
		param.put("rule_goal_five", rule_goal_five);
		param.put("rule_goal_six", rule_goal_six);
		param.put("rule_goal_seven", rule_goal_seven);
		param.put("rule_goal_eight", rule_goal_eight);
		param.put("rule_goal_nine", rule_goal_nine);
		param.put("rule_goal_ten", rule_goal_ten);
		param.put("rule_title_one", rule_title_one);
		param.put("rule_title_two", rule_title_two);
		param.put("rule_title_three", rule_title_three);
		param.put("rule_title_four", rule_title_four);
		param.put("rule_title_five", rule_title_five);
		param.put("rule_title_six", rule_title_six);
		param.put("rule_title_seven", rule_title_seven);
		param.put("rule_title_eight", rule_title_eight);
		param.put("rule_title_nine", rule_title_nine);
		param.put("rule_title_ten", rule_title_ten);
		param.put("rule_status", rule_status);
		param.put("rule_table", rule_table);
		param.put("rule_field_one", rule_field_one);
		param.put("rule_field_two", rule_field_two);
		param.put("rule_field_three", rule_field_three);
		param.put("rule_field_four", rule_field_four);
		param.put("rule_field_five", rule_field_five);
		param.put("rule_field_six", rule_field_six);
		param.put("rule_field_seven", rule_field_seven);
		param.put("rule_field_eight", rule_field_eight);
		param.put("rule_field_nine", rule_field_nine);
		param.put("rule_field_ten", rule_field_ten);
		
		MassService service=new MassService();
		String result=(service.postdata_xbz(param)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void postdata_xkh(){
		String numble=request.getParameter("numble");
		String rule_status=request.getParameter("rule_status");
		String rule_table=request.getParameter("rule_table");
		String rule_title=request.getParameter("rule_title");
		String rule_version=request.getParameter("rule_version");
		
		String rule_title_one=request.getParameter("rule_title_one");
		String rule_title_two=request.getParameter("rule_title_two");
		String rule_title_three=request.getParameter("rule_title_three");
		String rule_title_four=request.getParameter("rule_title_four");
		String rule_title_five=request.getParameter("rule_title_five");
		
		String rule_item_title_one=request.getParameter("rule_item_title_one");
		String rule_item_title_two=request.getParameter("rule_item_title_two");
		String rule_item_title_three=request.getParameter("rule_item_title_three");
		String rule_item_title_four=request.getParameter("rule_item_title_four");
		String rule_item_title_five=request.getParameter("rule_item_title_five");
		
		String rule_item_formula_one=request.getParameter("rule_item_formula_one");
		String rule_item_formula_two=request.getParameter("rule_item_formula_two");
		String rule_item_formula_three=request.getParameter("rule_item_formula_three");
		String rule_item_formula_four=request.getParameter("rule_item_formula_four");
		String rule_item_formula_five=request.getParameter("rule_item_formula_five");
		
		String rule_item_content_one=request.getParameter("rule_item_content_one");
		String rule_item_content_two=request.getParameter("rule_item_content_two");
		String rule_item_content_three=request.getParameter("rule_item_content_three");
		String rule_item_content_four=request.getParameter("rule_item_content_four");
		String rule_item_content_five=request.getParameter("rule_item_content_five");
		

		Map<String,String>param=new HashMap();
		param.put("numble", numble);
		param.put("rule_title", rule_title);
		param.put("rule_version", rule_version);
		param.put("rule_status", rule_status);
		param.put("rule_table", rule_table);
		
		param.put("rule_title_one", rule_title_one);
		param.put("rule_title_two", rule_title_two);
		param.put("rule_title_three", rule_title_three);
		param.put("rule_title_four", rule_title_four);
		param.put("rule_title_five", rule_title_five);
		
		param.put("rule_item_title_one",rule_item_title_one);
		param.put("rule_item_title_two", rule_item_title_two);
		param.put("rule_item_title_three", rule_item_title_three);
		param.put("rule_item_title_four", rule_item_title_four);
		param.put("rule_item_title_five", rule_item_title_five);
		

		param.put("rule_item_formula_one",  rule_item_formula_one);
		param.put("rule_item_formula_two",rule_item_formula_two);
		param.put("rule_item_formula_three", rule_item_formula_three);
		param.put("rule_item_formula_four", rule_item_formula_four);
		param.put("rule_item_formula_five", rule_item_formula_five);
		
		param.put("rule_item_content_one", rule_item_content_one);
		param.put("rule_item_content_two", rule_item_content_two);
		param.put("rule_item_content_three", rule_item_content_three);
		param.put("rule_item_content_four", rule_item_content_four);
		param.put("rule_item_content_five",rule_item_content_five);
		
		MassService service=new MassService();
		String result=(service.postdata_xkh(param)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	
	public void loadversion() {
		String rule_version = request.getParameter("rule_version");
		String result = "";
		if(rule_version == null) {
			ExecResult rs = new ExecResult(false,"版本号获取失败！");
			result = rs.toString();
		} else {
			MassService service = new MassService();
			result = (service.loadversion(rule_version)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadversionkh() {
		String rule_title = request.getParameter("rule_title");
		String result = "";
		if(rule_title == null) {
			ExecResult rs = new ExecResult(false,"版本号获取失败！");
			result = rs.toString();
		} else {
			MassService service = new MassService();
			result = (service.loadversionkh(rule_title)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void load_listen() {
		String rule_version_flag = request.getParameter("rule_version_flag");
		String rule_version = request.getParameter("rule_version");
		String result = "";
		if(rule_version_flag == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			MassService service = new MassService();
			result = (service.load_listen(rule_version_flag,rule_version)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void load_listenkh() {
		String rule_title = request.getParameter("rule_title");
		String rule_version = request.getParameter("rule_version");
		String result = "";
		if(rule_title == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			MassService service = new MassService();
			result = (service.load_listenkh(rule_title,rule_version)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void load_all() {
		String result = "";
			MassService service = new MassService();
			result = (service.load_all()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadkh() {
		String result = "";
			MassService service = new MassService();
			result = (service.loadkh()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadxnkh() {
		String result = "";
			MassService service = new MassService();
			result = (service.loadxnkh()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadxnkhxq() {
		String year_no = request.getParameter("year_no");
		String result = "";
		if(year_no== null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			MassService service = new MassService();
			result = (service.loadxnkhxq(year_no)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void load_kh() {
		String rule_title = request.getParameter("rule_title");
		String result = "";
		if(rule_title== null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			MassService service = new MassService();
			result = (service.load_kh(rule_title)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void load_bb() {
		String rule_version_flag = request.getParameter("rule_version_flag");
		String result = "";
		if(rule_version_flag == null) {
			ExecResult rs = new ExecResult(false,"数据获取失败！");
			result = rs.toString();
		} else {
			MassService service = new MassService();
			result = (service.load_bb(rule_version_flag)).toString();

		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void postdata_bz() {
		String term_no = request.getParameter("term_no");
		String rule_type = request.getParameter("rule_type");
		String rule_version = request.getParameter("rule_version");
		Map<String,String>param=new HashMap();	
		param.put("term_no", term_no);
		param.put("rule_type", rule_type);
		param.put("rule_version", rule_version);
		MassService service=new MassService();
		String result=(service.postdata_bz(param)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void postdata_bz_() {
		String term_no = request.getParameter("term_no");
		String rule_type = request.getParameter("rule_type");
		String rule_version = request.getParameter("rule_version");
		Map<String,String>param=new HashMap();	
		param.put("term_no", term_no);
		param.put("rule_type", rule_type);
		param.put("rule_version", rule_version);
		MassService service=new MassService();
		String result=(service.postdata_bz_(param)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void postdata_xnkh() {
		String year_no = request.getParameter("year_no");
		String judge_type_score = request.getParameter("judge_type_score");
		String judge_type_percent = request.getParameter("judge_type_percent");
		String judge_youxiu_fz = request.getParameter("judge_youxiu_fz");
		String judge_youxiu_bfb = request.getParameter("judge_youxiu_bfb");
		String judge_lianghao_fz = request.getParameter("judge_lianghao_fz");
		String judge_lianghao_bfb = request.getParameter("judge_lianghao_bfb");
		String judge_set_score = request.getParameter("judge_set_score");
		String judge_set_percent = request.getParameter("judge_set_percent");
		Map<String,String>param=new HashMap();	
		param.put("year_no", year_no);
		param.put("judge_type_score", judge_type_score);
		param.put("judge_type_percent", judge_type_percent);
		param.put("judge_youxiu_fz", judge_youxiu_fz);
		param.put("judge_youxiu_bfb", judge_youxiu_bfb);
		param.put("judge_lianghao_fz", judge_lianghao_fz);
		param.put("judge_lianghao_bfb", judge_lianghao_bfb);
		param.put("judge_set_score", judge_set_score);
		param.put("judge_set_percent", judge_set_percent);
		System.out.println(param.put("judge_lianghao_bfb", judge_lianghao_bfb));
		
		MassService service=new MassService();
		String result=(service.postdata_xnkh(param)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadchange() {
		String rule_version_flag = request.getParameter("rule_version_flag");
		String rule_version = request.getParameter("rule_version");
		String rule_status = request.getParameter("rule_status");
		Map<String,String>param=new HashMap();	
		param.put("rule_version_flag", rule_version_flag);
		param.put("rule_version", rule_version);
		param.put("rule_status", rule_status);
		MassService service=new MassService();
		String result=(service.loadchange(param)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadchangexnkh() {
		String year_no = request.getParameter("year_no");
		String judge_type = request.getParameter("judge_type");
		String judge_set = request.getParameter("judge_set");
		Map<String,String>param=new HashMap();	
		param.put("year_no", year_no);
		param.put("judge_type", judge_type);
		param.put("judge_set", judge_set);
		MassService service=new MassService();
		String result=(service.loadchangexnkh(param)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadchangekh() {
		String rule_title = request.getParameter("rule_title");
		String rule_version = request.getParameter("rule_version");
		String rule_status = request.getParameter("rule_status");
		Map<String,String>param=new HashMap();	
		param.put("rule_title", rule_title);
		param.put("rule_version", rule_version);
		param.put("rule_status", rule_status);
		MassService service=new MassService();
		String result=(service.loadchangekh(param)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void loadversionuse() {
		String rule_type = request.getParameter("rule_type");
		MassService service=new MassService();
		String result=(service.loadversionuse(rule_type)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	
	
	
}
