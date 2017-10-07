package com.service.base;

import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.base.bean.BaseTeacherEntity;

public class BaseTeacherAction extends Action {

	private BaseTeacherService service = new BaseTeacherService();

	/**
	 * 添加教工信息
	 */
	public void addBaseTeacher() {

	}

	/**
	 * 删除教工信息
	 */
	public void delBaseTeacher() {

	}

	/**
	 * 更新教工信息
	 */
	public void updateBaseTeacher() {

	}

	/**
	 * 添加与编辑教职工(根据is_edit判断添加、编辑状态)
	 */
	public void addOrEditBaseTeacher() {
		BaseTeacherEntity baseTeacherEntity = new BaseTeacherEntity();
		baseTeacherEntity.setTeacher_no(request.getParameter("teacher_no"));
		baseTeacherEntity.setTeacher_name(request.getParameter("teacher_name"));
		baseTeacherEntity.setDep_no(request.getParameter("dep_no"));
		baseTeacherEntity.setTeacher_status("1");// 缺省开启
		baseTeacherEntity.setTeacher_title(request.getParameter("teacher_title"));
		String teacher_type = request.getParameter("teacher_type");
		boolean isEdit = Boolean.valueOf(request.getParameter("is_edit"));
		ExecResult result = service.addOrEditBaseTeacherService(isEdit, baseTeacherEntity,teacher_type);
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获取教职工信息
	 */
	public void getBaseTeacherList() {
		String pageindex = request.getParameter("pageindex");
		String pageLength = request.getParameter("pageLength");
		String temppage = request.getParameter("temppage");
		String dep_no = request.getParameter("dep_no");
		String result = "";
		com.alibaba.fastjson.JSONObject jo = new com.alibaba.fastjson.JSONObject();
		ExecResult r1 = (service.getBaseTeacherListService(dep_no, Integer.parseInt(pageLength),
				Integer.parseInt(pageindex)));
		if (Integer.parseInt(temppage) == 1) {
			ExecResult r2 = (service.getBaseTeacherListCountService(dep_no));
			jo.put("total", r2.getData().getJSONObject(0).getString("totalrows"));
		}
		jo.put("rows", r1.getData());
		result = jo.toJSONString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 根据所属部门模糊查询(教工号、姓名)
	 */
	public void searchBaseTeacherList() {
		String pageindex = request.getParameter("pageindex");
		String pageLength = request.getParameter("pageLength");
		String temppage = request.getParameter("temppage");
		String dep_no = request.getParameter("dep_no");
		String search_like_data = request.getParameter("search_like_data");
		String temp_serach_teacher_type = request.getParameter("temp_serach_teacher_type");
		StringBuilder searchSql = new StringBuilder();
		if(search_like_data.equals("")){
			searchSql.append(" AND teacher.teacher_type LIKE " + "'%" + temp_serach_teacher_type + "%' ORDER BY  convert(teacher.teacher_type USING gbk) COLLATE gbk_chinese_ci DESC,teacher.teacher_no");
		}else{
			if(temp_serach_teacher_type.equals("全部"))
			searchSql.append(" AND teacher.teacher_name LIKE " + "'%" + search_like_data + "%' ORDER BY  convert(teacher.teacher_type USING gbk) COLLATE gbk_chinese_ci DESC,teacher.teacher_no");
			else
			searchSql.append(" AND teacher.teacher_name LIKE " + "'%" + search_like_data + "%' AND teacher.teacher_type LIKE '%"+temp_serach_teacher_type+"%' ORDER BY teacher.teacher_no" );
		}
		String result = "";
		System.out.println("模糊查询SQL：" + searchSql.toString());
		com.alibaba.fastjson.JSONObject jo = new com.alibaba.fastjson.JSONObject();
		ExecResult r1 = (service.getBaseTeacherSearchListService(dep_no, Integer.parseInt(pageLength),
				Integer.parseInt(pageindex), searchSql.toString()));
		if (Integer.parseInt(temppage) == 1) {
			ExecResult r2 = (service.getBaseTeacherSearchListCountService(dep_no, searchSql.toString()));
			jo.put("total", r2.getData().getJSONObject(0).getString("totalrows"));
		}
		jo.put("rows", r1.getData());
		result = jo.toJSONString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 改变教师状态
	 */
	public void updateBaseTeacherStatus() {
		String teacher_no = request.getParameter("teacher_no");
		String teacher_status = request.getParameter("teacher_status");
		if (teacher_status.equals("1")) {
			teacher_status = "0";
		} else if (teacher_status.equals("0")) {
			teacher_status = "1";
		}
		ExecResult result = service.updateBaseTeacherStatusService(teacher_no, teacher_status);
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 根据学年学期和部门获取班级信息
	 */
	public void queryBaseTeacherList() {
		String pageindex = request.getParameter("pageindex");
		String pageLength = request.getParameter("pageLength");
		String temppage = request.getParameter("temppage");
		String term_no = request.getParameter("term_no");// 学年学期
		String dep_no = request.getParameter("dep_no"); // 部门
		String serach_teacher_name = request.getParameter("serach_teacher_name"); // 搜索班级名称
		System.out.println("教师搜索的名称为：" + serach_teacher_name);
		String result = "";
		com.alibaba.fastjson.JSONObject jo = new com.alibaba.fastjson.JSONObject();
		ExecResult r1 = (service.queryBaseTeacherListService(term_no, dep_no, serach_teacher_name,
				Integer.parseInt(pageLength), Integer.parseInt(pageindex)));
		if (Integer.parseInt(temppage) == 1) {
			ExecResult r2 = (service.queryBaseTeacherListCountService(term_no, dep_no, serach_teacher_name));
			jo.put("total", r2.getData().getJSONObject(0).getString("totalrows"));
		}
		jo.put("rows", r1.getData());
		result = jo.toJSONString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
