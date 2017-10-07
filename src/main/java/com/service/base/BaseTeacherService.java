package com.service.base;

import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;
import com.service.base.bean.BaseTeacherEntity;

/**
 * 
 * © 2015 niitSoft
 * 
 * @Title: BaseTeacherService.java
 * @Description: 教职工维护服务
 * @author LiKun
 * @date 2015年8月18日
 * @version V1.0
 *
 */
public class BaseTeacherService {

	// private static Logger logger =
	// Logger.getLogger(BaseTeacherService.class);

	/**
	 * 添加与编辑教职工(根据is_edit判断添加、编辑状态)
	 * 
	 * @param isEdit
	 *            添加false 编辑true
	 * @param baseTeacherEntity
	 *            教师Entity
	 * @return
	 */
	public ExecResult addOrEditBaseTeacherService(boolean isEdit, BaseTeacherEntity baseTeacherEntity,String teacher_type) {
		StringBuilder errorMeg = new StringBuilder();
		ExecResult result = new ExecResult();
		result.setResult(true);
		result.setMessage(errorMeg.toString());
		if (isEdit) {
			// 编辑状态
			result = updateBaseTeacher(baseTeacherEntity, teacher_type );
		} else {
			// 添加状态
			result = addBaseTeacher(baseTeacherEntity, teacher_type);
		}
		return result;
	}

	/**
	 * 根据所属部门获取教职工列表
	 * 
	 * @param dep_no
	 *            部门ID(缺省为all)
	 * @param pageLength
	 *            数量
	 * @param pageNumber
	 *            页码
	 * @return
	 */
	public ExecResult getBaseTeacherListService(String dep_no, int pageLength, int pageNumber) {

		int start = pageNumber - 1;
		int length = pageLength;
		if (TypeUtils.isEmpty(dep_no) || dep_no.equals("all")) {
			String sql = "SELECT teacher.* , department.dep_name FROM base_teacher AS teacher LEFT JOIN base_department department ON teacher.`dep_no` = department.`dep_no`  where teacher.teacher_status=1=1 ";
			if (length > 0) {
				sql += " limit " + (start * length) + "," + length;
			}
			JSONResponse jr = new JSONResponse();
			ExecResult result = jr.getSelectResult(sql, null, "");
			return result;
		} else {
			String sql = "SELECT teacher.* , department.dep_name FROM base_teacher AS teacher LEFT JOIN base_department department ON teacher.`dep_no` = department.`dep_no` where teacher.dep_no=''{0}'' AND teacher.teacher_status=1 ";
			if (length > 0) {
				sql += " limit " + (start * length) + "," + length;
			}
			String[] params = new String[] { dep_no };
			JSONResponse jr = new JSONResponse();
			ExecResult result = jr.getSelectResult(sql, params, "");
			return result;
		}
	}

	/**
	 * 根据部门ID获取教职工列表总数
	 * 
	 * @param dep_no
	 *            部门ID(缺省all)
	 * @return
	 */
	public ExecResult getBaseTeacherListCountService(String dep_no) {
		if (TypeUtils.isEmpty(dep_no) || dep_no.equals("all")) {
			String sql = "SELECT COUNT(1) totalrows FROM base_teacher AS teacher LEFT JOIN base_department department ON teacher.`dep_no` = department.`dep_no` where teacher.teacher_status=1 ";
			JSONResponse jr = new JSONResponse();
			ExecResult result = jr.getSelectResult(sql, null, "");
			return result;
		} else {
			String sql = "SELECT COUNT(1) totalrows FROM base_teacher AS teacher LEFT JOIN base_department department ON teacher.`dep_no` = department.`dep_no` where teacher.dep_no=''{0}'' AND teacher.teacher_status=1 ";
			String[] params = new String[] { dep_no };
			JSONResponse jr = new JSONResponse();
			ExecResult result = jr.getSelectResult(sql, params, "");
			return result;
		}
	}

	/**
	 * 根据所属部门搜索获取教职工列表
	 * 
	 * @param dep_no
	 *            部门ID(缺省为all)
	 * @param pageLength
	 *            数量
	 * @param pageNumber
	 *            页码
	 * @param searchSql
	 *            模糊查询SQL
	 * @return
	 */
	public ExecResult getBaseTeacherSearchListService(String dep_no, int pageLength, int pageNumber, String searchSql) {

		int start = pageNumber - 1;
		int length = pageLength;
		if (TypeUtils.isEmpty(dep_no) || dep_no.equals("all")) {
			StringBuilder sql = new StringBuilder();
			sql.append(
					"SELECT teacher.* , department.dep_name FROM base_teacher AS teacher LEFT JOIN base_department department ON teacher.`dep_no` = department.`dep_no` where teacher.teacher_status =1 ");
			sql.append(searchSql);
			if (length > 0) {
				sql.append(" limit " + (start * length) + "," + length);
			}
			JSONResponse jr = new JSONResponse();
			System.out.println("根据所属部门搜索获取教职工列表SQL1：" + sql.toString());
			ExecResult result = jr.getSelectResult(sql.toString(), null, "");
			return result;
		} else {
			StringBuilder sql = new StringBuilder();
			sql.append(
					"SELECT teacher.* , department.dep_name FROM base_teacher AS teacher LEFT JOIN base_department department ON teacher.`dep_no` = department.`dep_no`  where teacher.dep_no="
							+ "'" + dep_no + "' AND teacher.teacher_status=1  ");
			sql.append(searchSql);
			if (length > 0) {
				sql.append(" limit " + (start * length) + "," + length);
			}
			// String[] params = new String[] { dep_no };
			JSONResponse jr = new JSONResponse();
			System.out.println("根据所属部门搜索获取教职工列表SQL2：" + sql.toString());
			ExecResult result = jr.getSelectResult(sql.toString(), null, "");
			return result;
		}
	}

	/**
	 * 根据部门ID搜索获取教职工列表总数
	 * 
	 * @param dep_no
	 *            部门ID(缺省all)
	 * @param searchSql
	 *            模糊查询sql
	 * @return
	 */
	public ExecResult getBaseTeacherSearchListCountService(String dep_no, String searchSql) {
		if (TypeUtils.isEmpty(dep_no) || dep_no.equals("all")) {
			StringBuilder sql = new StringBuilder();
			sql.append(
					"SELECT COUNT(1) totalrows FROM base_teacher AS teacher LEFT JOIN base_department department ON teacher.`dep_no` = department.`dep_no` where teacher.teacher_status=1 =1 ");
			sql.append(searchSql);
			JSONResponse jr = new JSONResponse();
			System.out.println("根据部门ID搜索获取教职工列表总数SQL1：" + sql.toString());
			ExecResult result = jr.getSelectResult(sql.toString(), null, "");
			return result;
		} else {
			StringBuilder sql = new StringBuilder();
			sql.append(
					"SELECT COUNT(1) totalrows FROM base_teacher AS teacher LEFT JOIN base_department department ON teacher.`dep_no` = department.`dep_no` where teacher.dep_no= "
							+ "'" + dep_no + "' AND teacher.teacher_status=1 ");
			sql.append(searchSql);
			// String[] params = new String[] { dep_no };
			JSONResponse jr = new JSONResponse();
			System.out.println("根据部门ID搜索获取教职工列表总数SQL2：" + sql.toString());
			ExecResult result = jr.getSelectResult(sql.toString(), null, "");
			return result;
		}
	}

	/**
	 * 更新教师状态
	 * 
	 * @param teacher_no
	 *            教工号
	 * @param teacher_status
	 *            教工状态
	 * @return
	 */
	public ExecResult updateBaseTeacherStatusService(String teacher_no, String teacher_status) {
		StringBuilder sqlStr = new StringBuilder();
		sqlStr.append("UPDATE base_teacher SET teacher_status= ");
		sqlStr.append("'" + teacher_status + "'");
		sqlStr.append(" WHERE teacher_no= ");
		sqlStr.append("'" + teacher_no + "'");
		JSONResponse response = new JSONResponse();
		ExecResult result = response.getExecResult(sqlStr.toString(), null, "状态改变成功", "状态改变失败");
		return result;
	}

	/**
	 * 添加教师
	 * 
	 * @param baseTeacherEntity
	 *            教师实体类
	 * @return
	 */
	public ExecResult addBaseTeacher(BaseTeacherEntity baseTeacherEntity,String teacher_type) {
		StringBuilder errorMeg = new StringBuilder();
		ExecResult result = new ExecResult();
		result.setResult(true);
		result.setMessage(errorMeg.toString());
		if (checkIsBaseTeacher(baseTeacherEntity.getTeacher_no())) {
			result.setResult(false);
			errorMeg.append("教工号【" + baseTeacherEntity.getTeacher_no() + "】已经存在，不可以重复添加");
			result.setMessage(errorMeg.toString());
		} else {
			String sql = "insert into base_teacher" + "(teacher_no,teacher_name,dep_no,teacher_status,teacher_title,data_time,teacher_type) values (";
			sql += "'" + baseTeacherEntity.getTeacher_no() + "',";
			sql += "'" + baseTeacherEntity.getTeacher_name() + "',";
			sql += "'" + baseTeacherEntity.getDep_no() + "',";
			sql += "'" + baseTeacherEntity.getTeacher_status()  + "',";
			sql += "'" + baseTeacherEntity.getTeacher_title() + "',";
			sql += "default,";
			sql += "'" + teacher_type + "')";
			System.out.println(baseTeacherEntity.getTeacher_title());
			JSONResponse response = new JSONResponse();
			result = response.getExecResult(sql, null, "添加" + "【" + baseTeacherEntity.getTeacher_name() + "】成功",
					"添加" + "【" + baseTeacherEntity.getTeacher_name() + "】失败");
		}
		return result;
	}

	/**
	 * 更新教师
	 * 
	 * @param baseTeacherEntity
	 *            教师实体类
	 * @return
	 */
	public ExecResult updateBaseTeacher(BaseTeacherEntity baseTeacherEntity,String teacher_type) {
		StringBuilder sqlStr = new StringBuilder();
		sqlStr.append("UPDATE base_teacher SET teacher_name= ");
		sqlStr.append("'" + baseTeacherEntity.getTeacher_name() + "'");
		sqlStr.append(" ,dep_no= ");
		sqlStr.append("'" + baseTeacherEntity.getDep_no() + "'");
		sqlStr.append(" ,teacher_title= ");
		sqlStr.append("'" + baseTeacherEntity.getTeacher_title() + "'");
		sqlStr.append(" ,teacher_type= ");
		sqlStr.append("'" + teacher_type + "'");
		sqlStr.append(" WHERE teacher_no= ");
		sqlStr.append("'" + baseTeacherEntity.getTeacher_no() + "'");
		JSONResponse response = new JSONResponse();
		return response.getExecResult(sqlStr.toString(), null, "修改" + "【" + baseTeacherEntity.getTeacher_name() + "】成功",
				"修改	" + "【" + baseTeacherEntity.getTeacher_name() + "】失败");
	}

	/**
	 * 检测该教师是否存在
	 * 
	 * @param teacher_no
	 *            教师号
	 * @return 是 true 否 false
	 */
	private boolean checkIsBaseTeacher(String teacher_no) {
		String sql = "select * from base_teacher where teacher_no=''{0}''";
		String[] params = new String[] { teacher_no };
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "base_teacher");
		if (result.getResult() == 0) {
			return false;
		} else {
			return true;
		}

	}

	/**
	 * 根据学年学期和部门获取教师信息
	 * 
	 * @param term_no
	 *            学年学期号
	 * @param dep_no
	 *            部门号(缺省为all)
	 * @param pageLength
	 *            数量
	 * @param pageNumber
	 *            页码
	 * @return
	 */
	public ExecResult queryBaseTeacherListService(String term_no, String dep_no, String serach_class_name,
			int pageLength, int pageNumber) {
		int start = pageNumber - 1;
		int length = pageLength;
		StringBuilder sql = new StringBuilder();
		sql.append(
				"SELECT teacher.`teacher_no` , teacher.`teacher_name` ,teacher.`teacher_status` ,teacher.`teacher_title` ,teacher.teacher_type,teacher.`dep_no` , department.`dep_name` FROM base_teacher teacher ");
		sql.append(" LEFT JOIN base_department department ON department.`dep_no` = teacher.`dep_no`");
		if (!dep_no.equals("all")) {
			sql.append(" WHERE teacher.dep_no = " + "'" + dep_no + "'");
		}
		if (!TypeUtils.isEmpty(serach_class_name)) {
			sql.append(" AND  teacher.`teacher_name` LIKE " + "'" + serach_class_name + "%'");
		}
		sql.append(" ORDER BY  convert(teacher.teacher_type USING gbk) COLLATE gbk_chinese_ci DESC,teacher.teacher_no");
		
		if (length > 0) {
			sql.append(" limit " + (start * length) + "," + length);
		}
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql.toString(), null, "");
		return result;

	}

	/**
	 * 根据学年学期和部门获取教师信息总数
	 * 
	 * @param term_no
	 *            学年学期号
	 * @param dep_no
	 *            部门号(缺省为all)
	 * @return
	 */
	public ExecResult queryBaseTeacherListCountService(String term_no, String dep_no, String serach_class_name) {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT COUNT(*) totalrows FROM base_teacher teacher ");
		sql.append(" LEFT JOIN base_department department ON department.`dep_no` = teacher.`dep_no`");
		if (!dep_no.equals("all")) {
			sql.append(" WHERE teacher.dep_no = " + "'" + dep_no + "'");
		}
		if (!TypeUtils.isEmpty(serach_class_name)) {
			sql.append(" AND  teacher.`teacher_name` LIKE " + "'" + serach_class_name + "%'");
		}
		
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql.toString(), null, "");
		return result;
	}

}
