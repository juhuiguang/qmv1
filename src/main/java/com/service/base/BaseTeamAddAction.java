package com.service.base;

import java.io.IOException;

import org.apache.log4j.Logger;

import com.jhg.common.QMUtils;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.base.bean.BaseTermObject;

public class BaseTeamAddAction extends Action {
	private static Logger logger = Logger.getLogger(BaseTeamAddAction.class);
	private ExecResult results = new ExecResult(false, "");
	private ExecResult resultBaseTerm = new ExecResult(false, "添加学年学期失败");
	private ExecResult resultBaseStu = new ExecResult(false, "添加学生失败");

	/**
	 * 新建学年学期
	 */
	public void importBaseTeamExcel() {

		//resultBaseStu = processBaseStu();
		
		resultBaseTerm = processBaseTerms();
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			logger.info("新建学年学期数据：" + "");
			response.getWriter().write("成功");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 处理添加学生
	 * 
	 * @return
	 */
//	public ExecResult processBaseStu() {
//		List<BaseStuObject> baseStuObjects = new ArrayList<>();
//		BaseStudentService baseStudentService = new BaseStudentService();
//		return baseStudentService.exportExcelStudents(baseStuObjects);
//	}

	/**
	 * 处理添加学年学期
	 * 
	 * @param baseTermObject
	 * @return
	 */
	public ExecResult processBaseTerms() {
		BaseTermObject baseTermObject = new BaseTermObject();
		baseTermObject.setTerm_no("20151");
		baseTermObject.setTerm_name("2015学年第一学期");
		baseTermObject.setTerm_print_name("2015学年第一学期");
		baseTermObject.setTerm_startdate(QMUtils.formatDateLine("2015-07-12"));
		baseTermObject.setTerm_enddate(QMUtils.formatDateLine("2015-08-12"));
		baseTermObject.setTerm_status("0");
		baseTermObject.setTerm_student("0");
		baseTermObject.setTerm_class("0");
		baseTermObject.setTerm_course("0");
		baseTermObject.setTerm_pj("0");
		baseTermObject.setTerm_kh("0");
		BaseTeamService baseTeamService = new BaseTeamService();
		return baseTeamService.addBaseTeam(QMUtils.beanToMap(baseTermObject));
	}

}
