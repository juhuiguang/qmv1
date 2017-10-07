package com.service.base;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.jhg.common.QMExcelUtil;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.mysql.jdbc.Util;
import com.service.base.bean.BaseClassesEntity;
import com.service.base.bean.ImportFileClass;
import com.service.base.bean.ImportFileStudentEntity;

public class BaseClassAction extends Action {

	private BaseClassService service = new BaseClassService();

	/**
	 * 获取班级列表
	 */
	public void getBaseClassList() {
		String pageindex = request.getParameter("pageindex");
		String pageLength = request.getParameter("pageLength");
		String temppage = request.getParameter("temppage");
		String dep_no = request.getParameter("dep_no"); // 部门
		String term_no = request.getParameter("term_no");// 学年学期
		String result = "";
		com.alibaba.fastjson.JSONObject jo = new com.alibaba.fastjson.JSONObject();
		ExecResult r1 = (service.queryBaseClassListService(dep_no, Integer.parseInt(pageLength),
				Integer.parseInt(pageindex)));
		if (Integer.parseInt(temppage) == 1) {
			ExecResult r2 = (service.queryBaseClassListCountService(dep_no));
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
	 * 批量添加
	 */
	public void addBaseClasses() {
		List<BaseClassesEntity> list = new ArrayList<BaseClassesEntity>();
		ExecResult result = service.addBaseClassService(list);
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 批量删除
	 */
	public void delBaseClasses() {
		List<BaseClassesEntity> list = new ArrayList<BaseClassesEntity>();
		ExecResult result = service.delBaseClassService(list);
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 更新班级
	 */
	public void updateBaseClass() {
		BaseClassesEntity baseClassesEntity = new BaseClassesEntity();
		baseClassesEntity.setClass_no(request.getParameter("class_no"));
		baseClassesEntity.setClass_name(request.getParameter("class_name"));
		baseClassesEntity.setMajor_no(request.getParameter("major_no"));
		baseClassesEntity.setTeacher_no(request.getParameter("teacher_no"));
		baseClassesEntity.setStu_no(request.getParameter("stu_no"));
		baseClassesEntity.setDep_no(request.getParameter("dep_no"));
		baseClassesEntity.setClass_stu_amount(request.getParameter("class_stu_amount"));
		baseClassesEntity.setClass_isover(request.getParameter("class_isover"));
		String teacher_noT =request.getParameter("teacher_noT");
		String stu_noT =request.getParameter("stu_noT");
		System.out.println(baseClassesEntity); 
		ExecResult result=new ExecResult(false,"");
		if(teacher_noT==null || stu_noT==null){
			result.setMessage("参数传递错误");
		}else {
			result = service.updateBaseClassService(baseClassesEntity,teacher_noT,stu_noT);
		}
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 根据所属部门模糊查询(班级名称、专业、班主任)
	 * 
	 */
	public void searchBaseClassList() {
		String pageindex = request.getParameter("pageindex");
		String pageLength = request.getParameter("pageLength");
		String temppage = request.getParameter("temppage");
		String dep_no = request.getParameter("dep_no");
		String search_like_data = request.getParameter("search_like_data");
		String searchSql = " AND classes.class_name LIKE " + "'%" + search_like_data + "%'"
				+ " or major.major_name LIKE " + "'%" + search_like_data + "%'" + " or department.dep_name LIKE " + "'%"
				+ search_like_data + "%'";
		String result = "";
		com.alibaba.fastjson.JSONObject jo = new com.alibaba.fastjson.JSONObject();
		ExecResult r1 = (service.searchBaseClassListService(dep_no, Integer.parseInt(pageLength),
				Integer.parseInt(pageindex), searchSql));
		if (Integer.parseInt(temppage) == 1) {
			ExecResult r2 = (service.searchBaseClassListCountService(dep_no, searchSql));
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
	 * 根据学年学期和部门获取班级信息
	 */
	public void queryBaseClassList() {
		String pageindex = request.getParameter("pageindex");
		String pageLength = request.getParameter("pageLength");
		String temppage = request.getParameter("temppage");
		String term_no = request.getParameter("term_no");// 学年学期
		String dep_no = request.getParameter("dep_no"); // 部门
		String serach_class_name = request.getParameter("serach_class_name"); // 搜索班级名称
		String result = "";
		com.alibaba.fastjson.JSONObject jo = new com.alibaba.fastjson.JSONObject();
		ExecResult r1 = (service.queryBaseClassListService(term_no, dep_no, serach_class_name,
				Integer.parseInt(pageLength), Integer.parseInt(pageindex)));
		if (Integer.parseInt(temppage) == 1) {
			ExecResult r2 = (service.queryBaseClassListCountService(term_no, dep_no, serach_class_name));
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
	
	public void gettermnyearoinformation() {	
		String result = "";
		BaseClassService service = new BaseClassService();
		result = (service.gettermnyearoinformation()).toString();	
		System.out.println(result);
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void getTeaStu() {		
		String classno = request.getParameter("classno");
		String result=""; 
		if( classno == null) {
			ExecResult rs = new ExecResult(false,"学期号或班级号获取失败~");
			result = rs.toString();
		} else {
			BaseClassService service = new BaseClassService();
			result = (service.getTeaStu(classno)).toString();		
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	
	public void importExcelBaseStudents() {		
		String term_no = request.getParameter("term_no");
		String stuFilePath = request.getParameter("student_file_path");
		ExecResult result = new ExecResult();
		result.setResult(false);
		result.setMessage("导入异常,需重新导入。");
		// 0判断文件是否存在
		if (TypeUtils.isEmpty(stuFilePath)) {
			result.setMessage("导入异常，上传的excel表失败，请重新导入");
		}else{
			// 1解析导入学生为List
			List<ImportFileClass> fileStudentEnts = QMExcelUtil.parseImportExcelFileToList(stuFilePath,
					ImportFileClass.class);
			if (fileStudentEnts != null && fileStudentEnts.size() > 0) {
				BaseClassService baseClassService = new BaseClassService();
				result = baseClassService.importExcel(term_no ,fileStudentEnts);
			} else {
				result.setMessage("导入异常，Excel表内容可能为空，请重新导入");
			}
			//
			if (TypeUtils.isEmpty(result.getMessage())) {
				result.setMessage("0");
			}
		}
		
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}
