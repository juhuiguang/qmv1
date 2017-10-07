package com.service.base;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.common.QMUtils;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.db.JSONDataResult;
import com.jhg.response.JSONResponse;
import com.service.base.bean.BaseTermStudentTentity;
import com.service.base.bean.ImportFileStudentEntity;
import com.service.system.SystemStart;

/**
 * 学年学期 © 2015 niitSoft 
 * 名称：BaseTeamService.java 描述：
 *
 * @author LiKun
 * @version v1.0 @date：2015年7月25日
 */
public class BaseTeamService {

	private static Logger logger = Logger.getLogger(BaseTeamService.class);

	/**
	 * 获取学年学期列表
	 * 
	 * @param pageLength
	 * @param pageNumber
	 * @return
	 */
	public ExecResult getBaseTermListService(int pageLength, int pageNumber) {
		int start = pageNumber - 1;
		int length = pageLength;
		String sql = "SELECT * FROM base_term u where 1=1 ";
		if (length > 0) {
			sql += " ORDER BY u.term_no DESC limit " + (start * length) + "," + length;
		}
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "");
		return result;
	}

	/**
	 * 根据当前最大的学年学期生成添加的学年学期
	 * 
	 * @return
	 */
	public ExecResult getCurrentBaseTeamService() {
		String sql = "select MAX(term_no) As term_no , MAX(term_name) As term_name from base_term";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_term");
		if (result.getResult() == 1) {
			JSONArray jsonArray = result.getData();
			JSONObject object = JSON.parseObject(jsonArray.getString(0));
			String term_no = object.getString("term_no");
			String term_name = object.getString("term_name");
			// System.out.println("缺省最大的学年学期:" + term_no + "," + term_name);
			String msg1 = term_no.substring(0, 4);
			String msg2 = term_no.substring(4, 5);
			if (msg2.equals("0")) {
				term_no = msg1 + 1;
				term_name = msg1 + "学年第二学期";
			} else if (msg2.equals("1")) {
				msg1 = (Integer.valueOf(msg1) + 1) + "";
				term_no = msg1 + "0";
				term_name = msg1 + "学年第一学期";
			}
			List<Map<String, Object>> mList = new ArrayList<>();
			Map<String, Object> map = new HashMap<>();
			map.put("term_no", term_no);
			map.put("term_name", term_name);
			mList.add(map);
			JSONDataResult jsonDataResult = new JSONDataResult();
			result.setData(jsonDataResult.getJSONResult(mList));
			// System.out.println("获取添加的学年学期:" + term_no + "," + term_name);
		}
		return result;
	}

	/**
	 * 添加学年学期
	 * 
	 * @param params
	 * 
	 * @return ExecResult 集
	 */
	public ExecResult addBaseTeamService(Map<String, String> params) {
		JSONResponse response = new JSONResponse();
		ExecResult result = new ExecResult();
		// 1.添加学年学期基础数据
		StringBuilder strSql = new StringBuilder();
		strSql.append("insert into base_term"
				+ "(term_no,term_name,term_print_name,term_startdate,term_enddate,term_status,term_student,term_class,term_course,term_pj,term_kh) values (");
		strSql.append("'" + params.get("term_no") + "',");
		strSql.append("'" + params.get("term_name") + "',");
		strSql.append("'" + params.get("term_print_name") + "',");
		strSql.append("'" + params.get("term_startdate") + "',");
		strSql.append("'" + params.get("term_enddate") + "',");
		strSql.append("'" + params.get("term_status") + "',");
		strSql.append("'" + params.get("term_student") + "',");
		strSql.append("'" + params.get("term_class") + "',");
		strSql.append("'" + params.get("term_course") + "',");
		strSql.append("'" + params.get("term_pj") + "',");
		strSql.append("'" + params.get("term_kh") + "')");
		String termno = params.get("term_no");
		String msg1 = termno.substring(0, 4);
		String msg2 = termno.substring(4, 5);
		if (msg2.equals("1")) {
			msg2 = "年第一学期";
		} else if (msg2.equals("2")) {
			msg2 = "年第二学期";
		}
		result = response.getExecResult(strSql.toString(), null, "添加" + "【" + msg1 + msg2 + "】成功",
				"添加" + "【" + msg1 + msg2 + "】失败");
		if (result.getResult() == 1) {
			// 2.复制上半年的学生
			copyTermStudent(termno);
		}
		return result;

	}

	/**
	 * 复制学年学期学生
	 * 
	 * @param term_no
	 *            学年学期号
	 * @return
	 */
	public ExecResult copyTermStudent(String term_no) {
		ExecResult result = null;
		StringBuilder str = new StringBuilder();
		JSONResponse jr = new JSONResponse();
		if (TypeUtils.isEmpty(term_no)) {
			return null;
		}
		int msg1 = Integer.valueOf(term_no.substring(0, 4));
		int msg2 = Integer.valueOf(term_no.substring(4, 5));
		System.out.println("复制学生的学年为：" + msg1 + "," + msg2);
		if (msg2 == 0) {
			// 1当term_no 为 0
			// 第一学年，处理毕业班数据
			// 2.根据添加的学年将班级设置已毕业状态
			result = updateClassesByClassIsOverService(String.valueOf(Integer.valueOf(msg1) - 3));
			if (result.getResult() == 1) {
				str.append("INSERT INTO base_term_student (SELECT ");
				str.append("'" + term_no + "',");
				str.append("term_stu.stu_no , term_stu.major_no , term_stu.class_no FROM base_term_student term_stu ");
				str.append("left join base_classes classes on classes.class_no = term_stu.class_no ");
				str.append("WHERE term_stu.term_no = ");
				str.append("'" + QMUtils.updateTermNo(term_no) + "'");
				str.append(" AND classes.class_isover=0 )");
				System.out.println("当前为第一学年学期处理毕业班后复制的数据SQL为：" + str.toString());
				//result = jr.getExecResult(str.toString(), null, "", "");
			}
		} else if (msg2 == 1) {
			// 第二学年，直接copy上半年数据
			str.append("INSERT INTO base_term_student (SELECT ");
			str.append("'" + term_no + "',");
			str.append("stu_no,major_no,class_no FROM base_term_student WHERE term_no=");
			str.append("'" + QMUtils.updateTermNo(term_no) + "')");
			System.out.println("当前为第二学期学年直接copy上一学期的数据SQL为：" + str.toString());
			//result = jr.getExecResult(str.toString(), null, "", "");
		} else {
			return null;
		}
		return result;
	}

	/**
	 * 根据年份查询相关设置毕业班
	 * 
	 * @param likeData
	 *            毕业班级学年
	 * @return
	 */
	public ExecResult updateClassesByClassIsOverService(String likeData) {
		JSONResponse response = new JSONResponse();
		ExecResult result = new ExecResult();
		StringBuilder sql = new StringBuilder();
		sql.append("update base_classes set class_isover = 1  where class_no LIKE ");
		sql.append("'" + likeData + "%'");
		System.out.println("根据添加的学年学期设备毕业班状态SQL为：" + sql.toString());
		result = response.getExecResult(sql.toString(), null, "设置毕业班成功", "设置毕业班失败");
		return result;
	}

	/**
	 * 改变学期状态
	 * 
	 * @param term_no
	 * @param term_status
	 * @return
	 */
	public ExecResult changeBaseTermStatusService(String term_no, String term_status) {
		StringBuilder sqlStr = new StringBuilder();
		JSONResponse response = new JSONResponse();
		String sql = "UPDATE base_term SET term_status= '0'";
		response.getExecResult(sql, null, "", "");
		sqlStr.append("UPDATE base_term SET term_status= ");
		sqlStr.append("'" + term_status + "'");
		sqlStr.append(" WHERE term_no= ");
		sqlStr.append("'" + term_no + "'");
		ExecResult result = response.getExecResult(sqlStr.toString(), null, "", "状态改变失败");
		if (result.getResult()==1) {
			System.out.println("进入初始化程序");
			SystemStart SS = new SystemStart();
			try {
				SS.init();
			} catch (ServletException e) {
				System.err.println("变量初始化失败");
				e.printStackTrace();
			}
		}
		return result;
	}

	/**
	 * 更新学生评教，督导听课学年考核状态
	 * 
	 * @param term_no
	 *            学年学期号
	 * @param status
	 *            相关状态名称
	 * @return
	 */
	public ExecResult changeStatusService(String term_no, String status) {
		String term_status = "term_" + status;
		String sql = "SELECT " + term_status + " FROM base_term WHERE term_no=''{1}''";
		String[] params = new String[] { term_status, term_no };
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "base_term_student");
		if (result.getResult() > 0) {
			String sql_ = "";
			if (result.getData().getJSONObject(0).getString(term_status).equals("1")) {
				sql_ = "UPDATE base_term SET " + term_status + "='0' WHERE term_no=''{1}''";
			} else {
				sql_ = "UPDATE base_term SET " + term_status + "='1' WHERE term_no=''{1}''";
			}
			jr.getExecResult(sql_, params, "", "");
		}
		return result;
	}

	/**
	 * 批量插入导入的文件到base_term_student
	 */
	public ExecResult addBaseTermStudentIFileService(List<ImportFileStudentEntity> list, String term_no) {
		logger.info("批量插入导入的文件到base_term_student业务Begin >>>>>>");
		LinkedList<String> sqlList = new LinkedList<String>();
		for (ImportFileStudentEntity importFileStudentEntity : list) {
			StringBuilder builder = new StringBuilder();
			builder.append("insert into base_term_student" + "(term_no,stu_no,major_no,class_no) values ( ");
			builder.append("'" + term_no + "', ");
			builder.append("'" + importFileStudentEntity.getStu_no() + "', ");
			builder.append("'" + importFileStudentEntity.getStu_majorNo() + "', ");
			builder.append("'" + importFileStudentEntity.getStu_classNo() + "')");
			System.out.println(builder.toString());
			sqlList.add(builder.toString());
		}
		JSONResponse response = new JSONResponse();
		ExecResult result = response.getExecResult(sqlList, "添加成功", "添加失败");
		logger.info("批量插入导入的文件到base_term_student业务状态End >>>>>>" + result.getResult() + "," + result.getMessage());
		return result;
	}

	/**
	 * 根据学年学期ID获取一学年所有学生
	 * 
	 * @param term_no
	 *            学年学期ID
	 * @return
	 */
	public ExecResult queryTermStudentByTermNo(String term_no) {
		String sql = "select * from base_term_student where term_no=''{0}''";
		String[] params = new String[] { term_no };
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "base_term_student");
		return result;
	}

	/**
	 * 根据学年学期ID插入学生
	 * 
	 * @param term_no
	 * @return
	 */
	public ExecResult insertTermStudent(String term_no) {
		ExecResult result;
		String sql = "select * from base_term_student where term_no=''{0}''";
		String[] params = new String[] { term_no };
		JSONResponse jr = new JSONResponse();
		result = jr.getSelectResult(sql, params, "base_term_student");
		if (result.getResult() == 1) {
			// 解析学生数据并改变学年学期后插入
			List<BaseTermStudentTentity> list = JSON.parseArray(result.getData().toJSONString(),
					BaseTermStudentTentity.class);
			if (list != null && list.size() > 0) {
				System.out.println("获取要复制插入的条数：" + list.size());
				for (int i = 0; i < list.size(); i++) {
					list.get(i).setTerm_no(term_no);
				}
				// 插入数据库
				result = addBaseTermService(list);

			} else {
				System.out.println("获取要复制插入的条数可能为空或异常。");
			}

		}
		return result;
	}

	/**
	 * 查询所有的专业
	 * 
	 * @return
	 */
	public ExecResult queryBaseMajor() {
		ExecResult result;
		String sql = "select * from base_major ";
		JSONResponse jr = new JSONResponse();
		result = jr.getSelectResult(sql, null, "base_major");
		return result;
	}

	/**
	 * 插入一个专业
	 * 
	 * @param major_no
	 *            专业代码
	 * @param major_name
	 *            专业名称
	 * @return
	 */
	public ExecResult insertBaseMajor(String major_no, String major_name) {
		StringBuilder str = new StringBuilder();
		str.append("INSERT INTO base_major (major_no , major_name) values(");
		str.append("'" + major_no + "',");
		str.append("'" + major_name + "')");
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(str.toString(), null, "", "");
		return result;
	}

	/**
	 * 检查学年学期是否已经被注册
	 * 
	 * @param term_no
	 * @return
	 */
	private boolean checkIsBaseTeam(String term_no) {
		String sql = "select * from base_term where term_no=''{0}''";
		String[] params = new String[] { term_no };
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "base_term");
		if (result.getResult() == 0) {
			return true;
		} else {
			return false;
		}

	}

	/**
	 * 添加学年学期
	 * 
	 * @param params
	 * 
	 * @return ExecResult 集
	 */
	public ExecResult addBaseTeam(Map<String, String> params) {
		if (!this.checkIsBaseTeam(params.get("term_no"))) {
			logger.error("学年学期已经添加，不可以重复添加");
			String msg1 = params.get("term_no").substring(0, 4) + "年";
			String msg2 = params.get("term_no").substring(4, 5);
			if (msg2.equals("1")) {
				msg2 = "第一学期";
			} else if (msg2.equals("2")) {
				msg2 = "第二学期";
			}
			return new JSONResponse().getError("【" + msg1 + msg2 + "】已经添加，不可以重复添加");
		} else {

			// 数据内容不能为空

			String sql = "insert into base_term"
					+ "(term_no,term_name,term_print_name,term_startdate,term_enddate,term_status,term_student,term_class,term_course,term_pj,term_kh) values (";
			sql += "'" + params.get("term_no") + "',";
			sql += "'" + params.get("term_name") + "',";
			sql += "'" + params.get("term_print_name") + "',";
			sql += "'" + params.get("term_startdate") + "',";
			sql += "'" + params.get("term_enddate") + "',";
			sql += "'" + params.get("term_status") + "',";
			sql += "'" + params.get("term_student") + "',";
			sql += "'" + params.get("term_class") + "',";
			sql += "'" + params.get("term_course") + "',";
			sql += "'" + params.get("term_pj") + "',";
			sql += "'" + params.get("term_kh") + "')";
			String msg1 = params.get("term_no").substring(0, 4) + "年";
			String msg2 = params.get("term_no").substring(4, 5);
			if (msg2.equals("1")) {
				msg2 = "第一学期";
			} else if (msg2.equals("2")) {
				msg2 = "第二学期";
			}
			JSONResponse response = new JSONResponse();
			ExecResult result = response.getExecResult(sql, null, "创建" + "【" + msg1 + msg2 + "】成功",
					"创建	" + "【" + msg1 + msg2 + "】失败");
			return result;
		}

	}

	/**
	 * 根据学年学期编号删除学年学期
	 * 
	 * @param term_no
	 *            学年学期编号
	 * @return ExecResult 集
	 */
	public ExecResult delBaseTeam(String term_no) {
		String sql = "DELETE FROM base_term WHERE term_no=''{0}''";
		String[] params = new String[] { term_no };
		JSONResponse response = new JSONResponse();
		ExecResult result = response.getExecResult(sql, params, "删除学年学期成功", "删除学年学期失败");
		return result;
	}

	/**
	 * 根据学年学期编号更新学年学期
	 * 
	 * @param params
	 * @return
	 */
	public ExecResult updateBaseTeams(Map<String, String> params) {
		// UPDATE base_term SET term_name='12345' WHERE term_no='20156'
		String term_no = params.get("term_no");
		String[] param = new String[] { term_no };
		String sql = "UPDATE base_term SET ";
		if (params != null && params.size() > 0) {

		}
		sql += " WHERE term_no=''{0}''";
		JSONResponse response = new JSONResponse();
		ExecResult result = response.getExecResult(sql, param, "更新学年学期成功", "更新学年学期失败");
		return result;
	}

	/**
	 * 获取学生学期
	 * 
	 * @param term_no
	 *            学年学期编号(为空查询全部)
	 * @return ExecResult 集
	 */
	public ExecResult getBaseTeamTable(String term_no) {
		String sql = "SELECT * FROM base_term WHERE term_no=''{0}''";
		if (TypeUtils.isEmpty(term_no)) {
			sql = "SELECT * FROM base_term";
		}
		String[] params = new String[] { term_no };
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "base_term");
		return result;
	}

	public ExecResult getBaseTermListServiceCount() {
		String sql = "SELECT COUNT(1) totalrows FROM base_term u where 1=1";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "");
		return result;

	}

	public ExecResult addBaseTermService(List<BaseTermStudentTentity> list) {
		logger.info("批量添加学年学期 Begin >>>>>>");
		LinkedList<String> sqlList = new LinkedList<String>();
		for (BaseTermStudentTentity baseStudentEntity : list) {
			StringBuilder builder = new StringBuilder();
			builder.append("insert into base_term_student" + "(term_no,stu_no,major_no,class_no) values ( ");
			builder.append("'" + baseStudentEntity.getTerm_no() + "', ");
			builder.append("'" + baseStudentEntity.getStu_no() + "', ");
			builder.append("'" + baseStudentEntity.getMajor_no() + "', ");
			builder.append("'" + baseStudentEntity.getClass_no() + "')");
			sqlList.add(builder.toString());
		}
		JSONResponse response = new JSONResponse();
		ExecResult result = response.getExecResult(sqlList, "添加成功", "添加失败");
		logger.info("批量添加学年学期业务状态End >>>>>>" + result.getResult() + "," + result.getMessage());
		return result;
	}

}