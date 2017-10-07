package com.service.base;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.student.MassService;

public class BaseFeedBackAction extends Action {
	private static Logger logger = Logger.getLogger(BaseFeedBackAction.class);
	private BaseFeedBackService service = new BaseFeedBackService();

	public void addStudentFeedBacks() {
		String stu_no = request.getParameter("stu_no");
		// 1、教师教学情况(选择反馈的课程)
		String task_id = request.getParameter("task_id");
		String teach_case = request.getParameter("teach_case");
		String teach_case_text = request.getParameter("teach_case_text");
		// 2、教学条件
		String teach_conditions_type = request.getParameter("teach_conditions_type");
		String teach_conditions_text = request.getParameter("teach_conditions_text");
		// 3、学风
		String stu_learningStyle = request.getParameter("stu_learningStyle");
		// 4、其他
		String stu_other = request.getParameter("stu_other");
		// 5、措施及建议
		String stu_advice = request.getParameter("stu_advice");
		// 6、备注
		String stu_remarks = request.getParameter("stu_remarks");
		ExecResult result = service.addFeedBackService(stu_no, task_id,teach_case,teach_case_text,teach_conditions_type, teach_conditions_text,
				stu_learningStyle, stu_other, stu_advice, stu_remarks);
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	
	public void getStudentFeedBacksByDepNoLists() {
		String dep_no = request.getParameter("dep_no");
		String term_no = request.getParameter("term_no");
		ExecResult r1 = (service.queryStudentFeedBackByDepNoListService(dep_no,term_no));
		try {
			response.getWriter().write(r1.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

	public void getStudentFeedBacksList() {
		String stu_no = request.getParameter("stu_no");
		Object r1 = (service.queryStudentFeedBackListService(stu_no));
		try {
			response.getWriter().write(r1.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void getStudentCoursesList() {
		String term_no = request.getParameter("term_no");
		String stu_no = request.getParameter("stu_no");
		String class_no = request.getParameter("class_no");
		ExecResult r1 = service.queryStudentClassByIdListService(term_no,stu_no,class_no);
		try {
			response.getWriter().write(r1.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void savetable() {
		String feedback_content = request.getParameter("feedback_content");
		String resp_content = request.getParameter("resp_content");
		String account_no = request.getParameter("account_no");
		String feedback_no = request.getParameter("feedback_no");
		Map<String,String>param=new HashMap();
		param.put("feedback_content", feedback_content);
		param.put("resp_content", resp_content);
		param.put("account_no", account_no);
		param.put("feedback_no", feedback_no);
		System.out.println(param.put("account_no", account_no));
		BaseFeedBackService service=new BaseFeedBackService();
		String result=(service.savetable(param)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getQmReportsByTeacherNoLists() {
		String teacher_no = request.getParameter("teacher_no");
		ExecResult r1 = (service.queryQmReportsByTeacherNoListService(teacher_no));
		try {
			response.getWriter().write(r1.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 导出信息员反馈意见汇总表
	 */
	public void exportTeachAggregation(){
		
	}
}
