package com.service.base;

import java.io.IOException;
import java.util.List;
import com.jhg.common.QMExcelUtil;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.base.bean.ImportFileCourseEntity2;

public class BaseCourseAction extends Action {
	private BaseCourseService courseService = new BaseCourseService();

	public void getAddTeacher() {
		String result = "";
		BaseCourseService service = new BaseCourseService();
		result = (service.getAddTeacher()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 添加
	 */
	public void addBaseCourse() {

	}

	/**
	 * 删除
	 */
	public void delBaseCourse() {

	}

	/**
	 * 更新
	 */
	public void updateBaseCourse() {

	}

	/**
	 * 获取课程信息
	 */
	public void getBaseCourseList() {

		String pageindex = request.getParameter("pageindex");
		String pageLength = request.getParameter("pageLength");
		String temppage = request.getParameter("temppage");
		String course_type = request.getParameter("course_type");
		String term_no = request.getParameter("term_no");
		String dep_no = request.getParameter("dep_no"); // 部门
		String search_info = request.getParameter("search_info");
		if (TypeUtils.isEmpty(search_info)) {
			search_info = "";
		}
		String searchSql = " AND teacher_task.course_name LIKE " + "'%" + search_info + "%'"
				+ " or classes.class_name LIKE " + "'%" + search_info + "%'" + " or teacher.teacher_name LIKE " + "'%"
				+ search_info + "%'" + " or teacher_task.teacher_no LIKE " + "'%" + search_info + "%'";
		String result = "";
		com.alibaba.fastjson.JSONObject jo = new com.alibaba.fastjson.JSONObject();
		courseService = new BaseCourseService();
		ExecResult r1 = (courseService.getBaseCourseListService(Integer.parseInt(pageLength),
				Integer.parseInt(pageindex), searchSql, term_no, dep_no));
		if (Integer.parseInt(temppage) == 1) {
			ExecResult r2 = (courseService.getBaseCourseListServiceCount(searchSql, term_no, dep_no));
			jo.put("total", r2.getData().getJSONObject(0).getString("totalrows"));
			System.out.println("获取课程的长度为：" + r2.getData().getJSONObject(0).getString("totalrows"));
		}
		jo.put("rows", r1.getData());
		result = jo.toJSONString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void getBaseSearchInf() {
		String result = "";
		String search_info = request.getParameter("search_info");
		String term_no = request.getParameter("term_no");
		String dep_no = request.getParameter("dep_no");
		BaseCourseService service = new BaseCourseService();
		result = (service.getBaseSearchInf(search_info, term_no, dep_no)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void removeInf() {
		String result = "";
		String sche_no = request.getParameter("sche_no");
		String task_no = request.getParameter("task_no");
		BaseCourseService service = new BaseCourseService();
		result = (service.removeInf(sche_no,task_no)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void changeInf() {
		String result = "";
		String task_no = request.getParameter("task_no");
		String sche_no = request.getParameter("sche_no");
		String term_no = request.getParameter("term_no");
		String course_name = request.getParameter("course_name");
		String class_name = request.getParameter("class_name");
		String teacher_no = request.getParameter("teacher_no");
		String sche_set = request.getParameter("sche_set");
		String sche_addr = request.getParameter("sche_addr");

		BaseCourseService service = new BaseCourseService();
		result = (service.changeInf(task_no, sche_no, term_no, course_name, class_name, teacher_no, sche_set,
				sche_addr)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	/**
	 * 导入课程Excel
	 */
	public void importExcelBaseCourses() {
		String term_no = request.getParameter("term_no");
		String courseFilePath = request.getParameter("course_file_path");
		System.out.println("导入学生的学年学期为：" + term_no + ",导入课程文件地址为：" + courseFilePath);
		ExecResult result = new ExecResult();
		result.setResult(false);
		result.setMessage("导入异常,需重新导入。");
		// 0判断文件是否存在
		if (TypeUtils.isEmpty(courseFilePath)) {
			result.setMessage("导入异常，导入的excel表不存在，请重新导入");
		}else{
			// 1解析导入课程为List
			List<ImportFileCourseEntity2> fileCourseEntity2s = QMExcelUtil.parseImportExcelFileToList(courseFilePath,
					ImportFileCourseEntity2.class);
			if (fileCourseEntity2s != null && fileCourseEntity2s.size() > 0) {
				System.out.println("共解析导入课程数据为：" + fileCourseEntity2s.size());
				for (ImportFileCourseEntity2 importFileCourseEntity2 : fileCourseEntity2s) {
					System.out.println("导入课程数据为：" + importFileCourseEntity2.toString());
				}
				result = courseService.processImportBaseCourseService(term_no, fileCourseEntity2s);
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
