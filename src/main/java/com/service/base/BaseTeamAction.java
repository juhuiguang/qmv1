package com.service.base;

import java.io.IOException;

import com.jhg.common.QMUtils;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.base.bean.BaseTermObject;

public class BaseTeamAction extends Action {

	private BaseTeamService service = new BaseTeamService();
	/**
	 * 获取学年学期列表
	 */
	public void getBaseTermList() {
		String pageindex = request.getParameter("pageindex");
		String pageLength = request.getParameter("pageLength");
		String temppage = request.getParameter("temppage");
		String result = "";
		com.alibaba.fastjson.JSONObject jo = new com.alibaba.fastjson.JSONObject();
		ExecResult r1 = (service.getBaseTermListService(Integer.parseInt(pageLength), Integer.parseInt(pageindex)));
		if (Integer.parseInt(temppage) == 1) {
			ExecResult r2 = (service.getBaseTermListServiceCount());
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
	 * 获取当前添加的学年学期
	 */
	public void getAddMaxBaseTeamNew() {
		ExecResult result = service.getCurrentBaseTeamService();
		System.out.println("获取当前添加的学年学期为：" + result.getData().toJSONString());
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 添加学年学期
	 */
	public void addBaseTermNew() {
		// 1.获取添加的学年学期编号
		String term_no = request.getParameter("term_no");
		String stuFilePath = request.getParameter("student_file_path");
		String courseFilePath = request.getParameter("course_file_path");
		// 2.添加学年学期基础数据
		BaseTermObject baseTermObject = new BaseTermObject();
		baseTermObject.setTerm_no(term_no);
		baseTermObject.setTerm_name(request.getParameter("term_name"));
		baseTermObject.setTerm_print_name(request.getParameter("term_print_name"));
		baseTermObject.setTerm_startdate(QMUtils.formatDateLine(request.getParameter("term_startdate")));
		baseTermObject.setTerm_enddate(QMUtils.formatDateLine(request.getParameter("term_enddate")));
		baseTermObject.setTerm_status("0");
		baseTermObject.setTerm_student("0");
		baseTermObject.setTerm_class("0");
		baseTermObject.setTerm_course("0");
		baseTermObject.setTerm_pj("0");
		baseTermObject.setTerm_kh("0");
		ExecResult result = service.addBaseTeamService(QMUtils.beanToMap(baseTermObject));
		// 3.判断是否上传文件
		if (!TypeUtils.isEmpty(stuFilePath)) {
			// 学生文件不为空
			// processImportBaseStudent(stuFilePath, term_no);
		}
		if (!TypeUtils.isEmpty(courseFilePath)) {
			// 课程文件不为空
			// processImportBaseCourse(courseFilePath, term_no);
		}
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 更新学年学期状态
	 */
	public void updataBaseTermStatus() {
		String term_no = request.getParameter("term_no");
		String term_status = request.getParameter("term_status");
		if (term_status.equals("1")) {
			term_status = "0";
		} else if (term_status.equals("0")) {
			term_status = "1";
		}
		ExecResult result = service.changeBaseTermStatusService(term_no, term_status);
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 更新学生评教，督导听课学年考核状态
	 */
	public void changestatus() {
		String result = "";
		String term_no = request.getParameter("term_no");
		String status = request.getParameter("status");
		result = (service.changeStatusService(term_no, status)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

}
