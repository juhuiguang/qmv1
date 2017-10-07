package com.service.base;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.print.attribute.ResolutionSyntax;

import org.apache.log4j.Logger;
import org.springframework.web.bind.ServletRequestBindingException;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.common.ErrorCodeUtils;
import com.jhg.common.QMExcelUtil;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.db.JSONDataResult;
import com.jhg.response.JSONResponse;
import com.service.base.bean.BaseErrorMsg;
import com.service.base.bean.BaseErrorStuEntity;
import com.service.base.bean.BaseLogEntity;
import com.service.base.bean.BaseMajor;
import com.service.base.bean.BaseStudentEntity;
import com.service.base.bean.ImportFileStudentEntity;
import com.service.teacher.Tea_check_class_situationAction;

/**
 * 
 * © 2015 niitSoft
 * 
 * @Title: BaseStudentService.java
 * @Description: 处理学生相关业务
 * @author LiKun
 * @date 2015年8月18日
 * @version V1.0
 *
 */
public class BaseStudentService {

	private static Logger logger = Logger.getLogger(BaseStudentService.class);
	private BaseLogService logService = new BaseLogService();

	/**
	 * 添加学生(单个)
	 * 
	 * 1.添加学生base_student 2.添加学生base_term_student
	 * 3.差异新增班级：判断学生当前学生的班级是否存在不存在就添加base_classes
	 * 4.差异新增专业：判断当前学生的专业是否存在不存在添加base_major
	 * 
	 * @param
	 * @return ExecResult 集
	 */
	public ExecResult addBaseStudent(String term_no, ImportFileStudentEntity importFileStudentEntity) {
		ExecResult result = null;
		JSONResponse response = new JSONResponse();
		StringBuilder sql = new StringBuilder();
		// 1.添加到base_student
		sql.append("insert into base_student" + "(stu_no,stu_name,stu_major_init,stu_year,stu_status) values (");
		sql.append("'" + importFileStudentEntity.getStu_no() + "',");
		sql.append("'" + importFileStudentEntity.getStu_name() + "',");
		sql.append("'" + importFileStudentEntity.getStu_majorNo() + "',");
		sql.append("'" + importFileStudentEntity.getStu_year() + "',");
		sql.append("'" + '1' + "')");
		result = response.getExecResult(sql.toString(), null,
				"添加" + "【" + importFileStudentEntity.getStu_name() + "】成功",
				"添加" + "【" + importFileStudentEntity.getStu_name() + "】失败");
		// 2.添加base_term_student
		if (result.getResult() == 1) {
			StringBuilder sql2 = new StringBuilder();
			sql2.append("INSERT INTO base_term_student ( term_no , stu_no , major_no ,class_no ) VALUES( ");
			sql2.append("'" + term_no.trim() + "', ");
			sql2.append("'" + importFileStudentEntity.getStu_no() + "', ");
			sql2.append("'" + importFileStudentEntity.getStu_majorNo() + "', ");
			sql2.append("'" + importFileStudentEntity.getStu_classNo() + "') ");
			result = response.getExecResult(sql2.toString(), null);
			if (result.getResult() == 1) {
				// 3.差异新增班级：判断学生当前学生的班级是否存在不存在就添加base_classes
				// 4.差异新增专业：判断当前学生的专业是否存在不存在添加base_major
				sql.delete(0, sql.length());
				BaseTeamService teamService = new BaseTeamService();
				// 4-1.查询专业差异新增
				ExecResult execResult = teamService.queryBaseMajor();
				List<BaseMajor> majors = JSON.parseArray(execResult.getData().toJSONString(), BaseMajor.class);
				if (majors != null && majors.size() > 0) {
					// 4-2.判断插入的专业是否存在，不存在插入
					int temp = 0;//
					for (BaseMajor baseMajor : majors) {
						if (baseMajor.getMajor_no() == importFileStudentEntity.getStu_majorNo()) {
							temp = 1;
							break;
						}
					}
					if (temp == 0) {
						// 4-3.没有这个专业，插入
						teamService.insertBaseMajor(importFileStudentEntity.getStu_majorNo(),
								importFileStudentEntity.getStu_major());
					}
				}

			}
		}
		return result;
	}

	/**
	 * 添加学生(多个) 1.添加学生base_student 2.添加学生base_term_student
	 * 3.差异新增班级：判断学生当前学生的班级是否存在不存在就添加base_classes
	 * 4.差异新增专业：判断当前学生的专业是否存在不存在添加base_major
	 * 
	 * @param list
	 * @return
	 */
	public ExecResult addBaseStudentService(String term_no, List<BaseStudentEntity> list) {
		LinkedList<String> sqlList = new LinkedList<String>();
		for (BaseStudentEntity baseStudentEntity : list) {
			StringBuilder builder = new StringBuilder();
			builder.append("insert into base_student"
					+ "(stu_no,stu_name,stu_birthday,stu_phone,stu_major_init,stu_year,stu_status) values ( ");
			builder.append("'" + baseStudentEntity.getStu_no() + "', ");
			builder.append("'" + baseStudentEntity.getStu_name() + "', ");
			builder.append("'" + baseStudentEntity.getStu_birthday() + "', ");
			builder.append("'" + baseStudentEntity.getStu_phone() + "', ");
			builder.append("'" + baseStudentEntity.getStu_major_init() + "', ");
			builder.append("'" + baseStudentEntity.getStu_year() + "', ");
			builder.append("'" + baseStudentEntity.getStu_status() + "')");
			sqlList.add(builder.toString());
		}
		JSONResponse response = new JSONResponse();
		ExecResult result = response.getExecResult(sqlList, "添加学生成功", "添加学生失败");
		return result;
	}

	/**
	 * 批量删除学生
	 * 
	 * @param list
	 *            学生list
	 * @return
	 */
	public ExecResult delBaseStudentService(List<BaseStudentEntity> list) {
		logger.info("批量删除学生业务Begin >>>>>>");
		LinkedList<String> sqlList = new LinkedList<String>();
		for (BaseStudentEntity baseStudentEntity : list) {
			StringBuilder builder = new StringBuilder();
			builder.append("DELETE FROM base_student WHERE stu_no= ");
			builder.append("'" + baseStudentEntity.getStu_no() + "'");
			sqlList.add(builder.toString());
		}
		JSONResponse response = new JSONResponse();
		ExecResult result = response.getExecResult(sqlList, "删除学生成功", "删除学生失败");
		logger.info("批量删除学生状态End >>>>>>" + result.getResult() + "," + result.getMessage());
		return result;
	}

    /**
     * 单个删除学生
     *
     * @param stu_no
     *
     * @return
     */
    public ExecResult deleteBaseStudentService(String stu_no) {
        JSONResponse jo = new JSONResponse();
        ExecResult result = new ExecResult();
            String sqlInsertbase="DELETE FROM `base_student` WHERE stu_no=''{0}''";
            String params1[] = {stu_no};
            ExecResult r2=jo.getExecResult(sqlInsertbase, params1, "删除学生成功", "删除学生失败");
            ExecResult r3 = null;
            String sqlInsertTerm="DELETE FROM `base_term_student` WHERE stu_no=''{0}''";
            String params2[] = {stu_no};
            r3=jo.getExecResult(sqlInsertTerm, params2, "删除学生成功", "删除学生失败");
            if (r3.getResult()==1) {
                result=new ExecResult(true,"删除学生成功");
            }else{
                result.setResult(false);
                result.setMessage("删除学生失败");
            }
        return result;
    }

	public ExecResult getTermYear() {
		String sql = "SELECT DISTINCT LEFT(term_no,4)AS year_no FROM base_term ORDER BY term_no DESC";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "");
		return result;
	}
	
	public ExecResult getStuYear() {
		String sql = "SELECT DISTINCT stu_year FROM base_student WHERE stu_year  IS NOT NULL AND stu_year !='' ORDER BY stu_year DESC ";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "");
		return result;
	}

	/**
	 * 根据学号更新学生信息
	 * 
	 * @param baseStudentEntity
	 *            学生
	 * @return
	 */
	public ExecResult updateBaseStudentService(BaseStudentEntity baseStudentEntity,String term_no,String temp_term_no) {
		ExecResult r1 = new ExecResult();
		StringBuilder sqlStr = new StringBuilder();
		sqlStr.append("UPDATE base_student SET stu_name= ");
		sqlStr.append("'" + baseStudentEntity.getStu_name() + "'");
		sqlStr.append(" ,stu_birthday= ");
		sqlStr.append("'" + baseStudentEntity.getStu_birthday() + "'");
		sqlStr.append(" ,stu_phone= ");
		sqlStr.append("'" + baseStudentEntity.getStu_phone() + "'");
		sqlStr.append(" ,stu_year= ");
		sqlStr.append("'" + baseStudentEntity.getStu_year() + "'");
		sqlStr.append(" WHERE stu_no= ");
		sqlStr.append("'" + baseStudentEntity.getStu_no() + "'");
		JSONResponse response = new JSONResponse();
		ExecResult r2= response.getExecResult(sqlStr.toString(), null, "修改" + "【" + baseStudentEntity.getStu_name() + "】成功",
				"修改	" + "【" + baseStudentEntity.getStu_name() + "】失败");
		if(r2.getResult()==0){
			r1 .setResult(false);
			r1.setMessage("修改基础信息失败");
		}else{
			System.out.println("开始修改");
			System.out.println(baseStudentEntity.getStu_major_init());
			System.out.println(baseStudentEntity.getClass_no());
			System.out.println(baseStudentEntity.getStu_no());
			String sql = "SELECT stu_no FROM `base_term_student` WHERE term_no = '"+temp_term_no+"' AND stu_no =''{1}''";
			String params[] = {term_no,baseStudentEntity.getStu_no()};
			ExecResult r3 = response.getSelectResult(sql, params, null);
			ExecResult r4 =new ExecResult();
			if(r3.getData().size()>0){
				String sql1="UPDATE `base_term_student` SET major_no=''{0}'' , class_no=''{1}'' WHERE stu_no=''{2}'' AND term_no='"+temp_term_no+"'";
				String params2[]={baseStudentEntity.getStu_major_init(),baseStudentEntity.getClass_no(),baseStudentEntity.getStu_no()};
				r4 = response.getExecResult(sql1, params2,"学期表修改成功","学期表修改出错");
			}else{
				String sql1="INSERT INTO `base_term_student` VALUES('"+temp_term_no+"',''{1}'',''{2}'',''{3}'')";
				String params2[]={term_no,baseStudentEntity.getStu_no(),baseStudentEntity.getStu_major_init(),baseStudentEntity.getStu_no()};
				r4 = response.getExecResult(sql1, params2,"学期表插入成功","学期表插入出错");
			}
			if(r4.getResult()==0){
				r1.setResult(false);
				r1.setMessage(r4.getMessage());
			}else{
				r1.setResult(true);
				r1.setMessage("修改成功");
			}
			
		}
		return r1;
	}

	/**
	 * 改变学生状态
	 * 
	 * @param stu_no
	 *            学号
	 * @param stu_status
	 *            学生状态
	 * @return
	 */
	public ExecResult updateBaseStudentStatusService(String stu_no, String stu_status) {
		StringBuilder sqlStr = new StringBuilder();
		sqlStr.append("UPDATE base_student SET stu_status= ");
		sqlStr.append("'" + stu_status + "'");
		sqlStr.append(" WHERE stu_no= ");
		sqlStr.append("'" + stu_no + "'");
		JSONResponse response = new JSONResponse();
		ExecResult result = response.getExecResult(sqlStr.toString(), null, "状态改变成功", "状态改变失败");
		return result;
	}

	/**
	 * 获取学生数据列表
	 * 
	 * @param pageLength
	 *            数量
	 * @param pageNumber
	 *            页码
	 * @return
	 */
	public ExecResult queryBaseStudentListService(int pageLength, int pageNumber, String year, String dep_no) {
		int start = pageNumber - 1;
		int length = pageLength;
		String sql = "";
		if (dep_no.equals("all")) {
			sql = "SELECT student.stu_no,student.`stu_phone`,student.`stu_birthday`,student.stu_name,termstu.class_no,classes.class_name,major.major_no,major.major_name,student.stu_year,student.stu_status FROM base_student student LEFT JOIN (SELECT stu_no,MAX(term_no) term_no FROM base_term_student  GROUP BY stu_no) maxterm ON maxterm.stu_no=student.stu_no LEFT JOIN base_term_student termstu ON termstu.term_no=maxterm.term_no AND termstu.stu_no=student.stu_no LEFT JOIN base_classes classes ON classes.class_no=termstu.class_no LEFT JOIN base_major major ON major.major_no=student.stu_major_init OR major.`major_no` = classes.`major_no` WHERE student.stu_year=''{0}'' ";
		} else {
			sql = "SELECT student.stu_no,student.`stu_phone`,student.`stu_birthday`,student.stu_name,termstu.class_no,classes.class_name,major.major_no,major.major_name,student.stu_year,student.stu_status FROM base_student student LEFT JOIN (SELECT stu_no,MAX(term_no) term_no FROM base_term_student  GROUP BY stu_no) maxterm ON maxterm.stu_no=student.stu_no LEFT JOIN base_term_student termstu ON termstu.term_no=maxterm.term_no AND termstu.stu_no=student.stu_no LEFT JOIN base_classes classes ON classes.class_no=termstu.class_no LEFT JOIN base_major major ON major.major_no=student.stu_major_init  OR major.`major_no` = classes.`major_no` WHERE student.stu_year=''{0}''  AND classes.dep_no=''{1}''";
		}
		if (length > 0) {
			sql += " limit " + (start * length) + "," + length;
		}
		String[] params = new String[] { year, dep_no };
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "");
		return result;
	}

	/**
	 * 获取学生列表总数
	 * 
	 * @return
	 */
	public ExecResult querygetBaseStuListCountService(String year, String dep_no) {
		String sql = "";
		if (dep_no.equals("all")) {
			sql = "SELECT COUNT(1) totalrows FROM base_student student LEFT JOIN (SELECT stu_no,MAX(term_no) term_no FROM base_term_student  GROUP BY stu_no) maxterm ON maxterm.stu_no=student.stu_no LEFT JOIN base_term_student termstu ON termstu.term_no=maxterm.term_no AND termstu.stu_no=student.stu_no LEFT JOIN base_classes classes ON classes.class_no=termstu.class_no LEFT JOIN base_major major ON major.major_no=classes.major_no WHERE student.stu_year=''{0}'' ";
		} else {
			sql = "SELECT COUNT(1) totalrows FROM base_student student LEFT JOIN (SELECT stu_no,MAX(term_no) term_no FROM base_term_student  GROUP BY stu_no) maxterm ON maxterm.stu_no=student.stu_no LEFT JOIN base_term_student termstu ON termstu.term_no=maxterm.term_no AND termstu.stu_no=student.stu_no LEFT JOIN base_classes classes ON classes.class_no=termstu.class_no LEFT JOIN base_major major ON major.major_no=classes.major_no WHERE student.stu_year=''{0}''  AND classes.dep_no=''{1}''";
		}
		String[] params = new String[] { year, dep_no };
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "");
		return result;
	}

	/**
	 * 搜索学生列表
	 * 
	 * @param pageLength
	 *            数量
	 * @param pageNumber
	 *            页码
	 * @param
	 *
	 * @return
	 */
	public ExecResult searchBaseStudentListService(int pageLength, int pageNumber, String year, String dep_no,
			String search_like_data) {
		int start = pageNumber - 1;
		int length = pageLength;
		String sql = "";
		if (dep_no.equals("all")) {
			sql = "SELECT student.stu_no,student.`stu_phone`,student.`stu_birthday`,student.stu_name,termstu.class_no,classes.class_name,termstu.major_no,major.major_name,student.stu_year,student.stu_status FROM base_student student LEFT JOIN (SELECT stu_no,MAX(term_no) term_no FROM base_term_student  GROUP BY stu_no) maxterm ON maxterm.stu_no=student.stu_no LEFT JOIN base_term_student termstu ON termstu.term_no=maxterm.term_no AND termstu.stu_no=student.stu_no LEFT JOIN base_classes classes ON classes.class_no=termstu.class_no LEFT JOIN base_major major ON major.major_no=classes.major_no WHERE student.stu_year=''{0}'' AND student.stu_name LIKE ''%{1}%''";
		} else {
			sql = "SELECT student.stu_no,student.`stu_phone`,student.`stu_birthday`,student.stu_name,termstu.class_no,classes.class_name,termstu.major_no,major.major_name,student.stu_year,student.stu_status FROM base_student student LEFT JOIN (SELECT stu_no,MAX(term_no) term_no FROM base_term_student  GROUP BY stu_no) maxterm ON maxterm.stu_no=student.stu_no LEFT JOIN base_term_student termstu ON termstu.term_no=maxterm.term_no AND termstu.stu_no=student.stu_no LEFT JOIN base_classes classes ON classes.class_no=termstu.class_no LEFT JOIN base_major major ON major.major_no=classes.major_no WHERE student.stu_year=''{0}'' AND student.stu_name LIKE ''%{1}%'' AND classes.dep_no=''{2}'' ";
		}
		if (length > 0) {
			sql += (" limit " + (start * length) + "," + length);
		}
		String[] params = new String[] { year, search_like_data, dep_no };
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "");
		return result;
	}

	/**
	 * 搜索学生列表总数
	 *
	 * @param
	 * @return
	 */
	public ExecResult searchBaseStudentListCountService(String year, String dep_no, String search_like_data) {
		String sql = "";
		if (dep_no.equals("all")) {
			sql = "SELECT COUNT(1) totalrows FROM base_student student LEFT JOIN (SELECT stu_no,MAX(term_no) term_no FROM base_term_student  GROUP BY stu_no) maxterm ON maxterm.stu_no=student.stu_no LEFT JOIN base_term_student termstu ON termstu.term_no=maxterm.term_no AND termstu.stu_no=student.stu_no LEFT JOIN base_classes classes ON classes.class_no=termstu.class_no LEFT JOIN base_major major ON major.major_no=classes.major_no WHERE student.stu_year=''{0}'' AND student.stu_name LIKE ''%{1}%''";
		} else {
			sql = "SELECT COUNT(1) totalrows FROM base_student student LEFT JOIN (SELECT stu_no,MAX(term_no) term_no FROM base_term_student  GROUP BY stu_no) maxterm ON maxterm.stu_no=student.stu_no LEFT JOIN base_term_student termstu ON termstu.term_no=maxterm.term_no AND termstu.stu_no=student.stu_no LEFT JOIN base_classes classes ON classes.class_no=termstu.class_no LEFT JOIN base_major major ON major.major_no=classes.major_no WHERE student.stu_year=''{0}'' AND student.stu_name LIKE ''%{1}%'' AND classes.dep_no=''{2}'' ";
		}
		String[] params = new String[] { year, search_like_data, dep_no };
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "");
		return result;
	}

	/**
	 * 根据姓名或者学号搜索学生列表
	 * @return
	 */
	public ExecResult searchBaseStudentListByNameOrNumService(int pageLength, int pageNumber, String search_like_data) {
		int start = pageNumber - 1;
		int length = pageLength;
		String sql = "SELECT distinct student.stu_no,student.`stu_phone`,student.`stu_birthday`,student.stu_name,termstu.class_no,classes.class_name,termstu.major_no,major.major_name,student.stu_year,student.stu_status FROM base_student student LEFT JOIN (SELECT stu_no,MAX(term_no) term_no FROM base_term_student  GROUP BY stu_no) maxterm ON maxterm.stu_no=student.stu_no LEFT JOIN base_term_student termstu ON termstu.term_no=maxterm.term_no AND termstu.stu_no=student.stu_no LEFT JOIN base_classes classes ON classes.class_no=termstu.class_no LEFT JOIN base_major major ON major.major_no=classes.major_no WHERE  student.stu_name LIKE ''%{0}%'' OR student.stu_no LIKE ''%{0}%''";
		if (length > 0) {
			sql += (" limit " + (start * length) + "," + length);
		}
		String[] params = new String[] {search_like_data};
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "");
		return result;
	}

	/**
	 * 列出模糊搜索学生列表总数

	 * @return
	 */
	public ExecResult searchBaseStudentListByNameOrNumCountService(String search_like_data) {
		String sql = "SELECT COUNT(1) totalrows FROM base_student student LEFT JOIN (SELECT stu_no,MAX(term_no) term_no FROM base_term_student  GROUP BY stu_no) maxterm ON maxterm.stu_no=student.stu_no LEFT JOIN base_term_student termstu ON termstu.term_no=maxterm.term_no AND termstu.stu_no=student.stu_no LEFT JOIN base_classes classes ON classes.class_no=termstu.class_no LEFT JOIN base_major major ON major.major_no=classes.major_no WHERE  student.stu_name LIKE ''%{0}%'' OR student.stu_no LIKE ''%{0}%''";

		String[] params = new String[] {search_like_data};
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "");
		return result;
	}

	/**
	 * 处理批量导入数据库
	 * 
	 * 业务描述： 1.判断校验数据是否符合规范 2.循环插入数据（后期批量插入）
	 * 
	 * @param
	 *
	 */
	public ExecResult importExcelStudents(String term_no, List<ImportFileStudentEntity> entities) {
		ExecResult execResult = new ExecResult();
		// 判断是否存在重复学号
		if (entities != null && entities.size() > 0) {
			// 循环校验数据
			for (ImportFileStudentEntity exportStuObject : entities) {
				execResult = checkStudentData(exportStuObject);
				if (execResult.getResult() == 0) {
					return execResult;
				} else {
					logger.info("批量循环校验数据通过");
				}
			}
			// 单个循环插入数据（后期批量插入）
			for (ImportFileStudentEntity exportStuObject : entities) {
				execResult = addBaseStudent(term_no, exportStuObject);
				if (execResult.getResult() == 0) {
					return execResult;
				} else {
					logger.info("批量插入数据通过");
				}
			}
			execResult.setResult(true);
			execResult.setMessage("批量添加学生成功");
			return execResult;
		} else {
			return new JSONResponse().getError("导入的文件数据可能为空");
		}
	}

	/**
	 * 检测该学生是否存在
	 * 
	 * @param stu_no
	 *            学号
	 * @return 是 true 否 false
	 */
	private boolean checkIsBaseStudent(String stu_no) {
		String sql = "select * from base_student where stu_no=''{0}''";
		String[] params = new String[] { stu_no };
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "base_student");
		if (result.getResult() == 0) {
			return false;
		} else {
			return true;
		}

	}

	/**
	 * 单个检测学生数据健壮性
	 * 
	 * @param baseStuObject
	 *            学生实体类
	 * @return
	 */
	public ExecResult checkStudentData(ImportFileStudentEntity baseStuObject) {
		StringBuilder errorMeg = new StringBuilder();
		ExecResult errResult = new ExecResult();
		errResult.setResult(true);
		errResult.setMessage(errorMeg.toString());
		// 检测学生学号
		if (TypeUtils.isEmpty(baseStuObject.getStu_no())) {
			errResult.setResult(false);
			errorMeg.append("学生【" + baseStuObject.getStu_name() + "】学号不能为空\n");
		}
		// 检测学生学号长度
		if (baseStuObject.getStu_no().length() > 10) {
			errResult.setResult(false);
			errorMeg.append("学生【" + baseStuObject.getStu_name() + "】学号异常\n");
		}
		// 检测学号重复添加
		if (checkIsBaseStudent(baseStuObject.getStu_no())) {
			errResult.setResult(false);
			errorMeg.append("学生【" + baseStuObject.getStu_name() + "】已经添加，不可以重复添加");
		}
		errResult.setMessage(errorMeg.toString());
		return errResult;
	}

	public ExecResult processImportBaseStudentService(String term_no, List<ImportFileStudentEntity> entities) {
		ExecResult result = new ExecResult();
		BaseLogEntity logEntity = new BaseLogEntity();
		logEntity.setBatch_type(1);// 缺省为新生导入
		logEntity.setBatch_status(0);// 缺省导入数据全部成功
		logEntity.setTotal(entities.size());// 导入总数量
		List<ImportFileStudentEntity> successStuEntities = new ArrayList<>();
		List<ImportFileStudentEntity> errorStuEntities = new ArrayList<>();
		List<BaseErrorMsg> errorMsgs = new ArrayList<>();
		StringBuilder errmsgStr = new StringBuilder();
		// 0.筛选学生正确与错误数据
		// 0.检测学生信息数据符合规范
		for (ImportFileStudentEntity importFileStudentEntity : entities) {
			System.out.println("导入内容为：" + importFileStudentEntity.toString());
			StringBuilder errMsg = new StringBuilder();
			boolean isFlag = true;
			errMsg.append("学生[" + importFileStudentEntity.getStu_name() + "(" + importFileStudentEntity.getStu_no()
					+ ")] : ");
			// 学号不能为空
			if (TypeUtils.isEmpty(importFileStudentEntity.getStu_no())
					|| importFileStudentEntity.getStu_no().equals("null")) {
				isFlag = false;
				errMsg.append("A.学号内容为空");
			} else {
				// 判断该学生是否存在
				if (checkIsBaseStudent(importFileStudentEntity.getStu_no())) {
					isFlag = false;
					errMsg.append("A.学号[" + importFileStudentEntity.getStu_no() + "]重复添加");
				}
			}
			//学生姓名不能为空
			if (TypeUtils.isEmpty(importFileStudentEntity.getStu_name())
					|| importFileStudentEntity.getStu_name().equals("null")) {
				isFlag = false;
				errMsg.append("B.学生姓名为空");
			}
			//所属院系不能为空
			if (TypeUtils.isEmpty(importFileStudentEntity.getStu_deartment())
					|| importFileStudentEntity.getStu_deartment().equals("null")) {
				isFlag = false;
				errMsg.append("C.所属院系为空");
			}
			// 判断专业代码不能为空
			if (TypeUtils.isEmpty(importFileStudentEntity.getStu_majorNo())
					|| importFileStudentEntity.getStu_majorNo().equals("null")) {
				isFlag = false;
				errMsg.append("E.专业代码为空");
			}
			// 判断班级代码不能为空
			if (TypeUtils.isEmpty(importFileStudentEntity.getStu_classNo())
					|| importFileStudentEntity.getStu_classNo().equals("null")) {
				isFlag = false;
				errMsg.append("F.班级代码为空");
			}
			if (isFlag) {
				successStuEntities.add(importFileStudentEntity);
			} else {
				errorStuEntities.add(importFileStudentEntity);
				System.out.println("导入内容错误信息为：" + errMsg.toString());
				errmsgStr.append(errMsg.toString());
				if (!TypeUtils.isEmpty(errMsg.toString())) {
					errmsgStr.append(",");
				}
			}

		}
		logEntity.setError_msg(errmsgStr.toString());
		System.out.println("导入总计为：" + entities.size());
		System.out.println("成功总计为：" + successStuEntities.size());
		System.out.println("失败总计为：" + errorStuEntities.size());
		// 0. 成功数据插入
		if (successStuEntities != null && successStuEntities.size() > 0) {
			for (ImportFileStudentEntity importFileStudentEntity : successStuEntities) {
				addBaseStudent(term_no, importFileStudentEntity);
			}
		}
		// 1. 失败数据插入
		BaseErrorMsg errorMsg = new BaseErrorMsg();
		errorMsg.setTotalnum(entities.size());
		errorMsg.setSuccessnum(successStuEntities.size());
		errorMsg.setErrornum(errorStuEntities.size());
		if (errorStuEntities != null && errorStuEntities.size() > 0) {
			logEntity.setError_total(errorStuEntities.size());
			logEntity.setBatch_status(1);
			logEntity.setError_data(JSON.toJSONString(errorStuEntities));
			ExecResult logExec = logService.addBaseLogService(logEntity);
			System.out.println("log批处理的ID为：" + logExec.getMessage());
			errorMsg.setBrach_id(logExec.getMessage());
		}
		errorMsgs.add(errorMsg);
		JSONDataResult jr = new JSONDataResult();
		JSONArray ja = jr.getJSONResult1(errorMsgs);
		result.setData(ja);
		result.setResult(false);
		return result;
	}

	/**
	 * 解析处理导入Excel学生
	 * 
	 * @return
	 */
	public ExecResult processImportBaseStudent(String stuFilePath, String term_no) {
		if (TypeUtils.isEmpty(stuFilePath)) {
			// 判断文件地址与学年学期号为空
			ExecResult result = new ExecResult();
			result.setResult(false);
			result.setErrorCode(1001);
			result.setMessage(ErrorCodeUtils.getCodeMsg(1001));
			return result;
		}
		if (TypeUtils.isEmpty(term_no)) {
			// 判断学年学期号为空
			ExecResult result = new ExecResult();
			result.setResult(false);
			result.setErrorCode(1002);
			result.setMessage(ErrorCodeUtils.getCodeMsg(1002));
			return result;
		}
		// 解析导入的学生数据
		List<ImportFileStudentEntity> fileStudentEnts = QMExcelUtil.parseImportExcelFileToList(stuFilePath,
				ImportFileStudentEntity.class);

		if (fileStudentEnts != null && fileStudentEnts.size() > 0) {
			BaseTeamService teamService = new BaseTeamService();
			// 1.查询专业差异新增
			ExecResult execResult = teamService.queryBaseMajor();
			if (execResult.getResult() == 1) {
				System.out.println("查询专业成功");
				List<BaseMajor> majors = JSON.parseArray(execResult.getData().toJSONString(), BaseMajor.class);
				if (majors != null && majors.size() > 0) {
					// System.out.println("查询专业数据为：" + majors.size() + "," +
					// majors.get(0).getMajor_name());
					for (ImportFileStudentEntity studentEntity : fileStudentEnts) {
						// 判断插入的专业是否存在，不存在插入
						int temp = 0;//
						for (BaseMajor baseMajor : majors) {
							if (baseMajor.getMajor_no() == studentEntity.getStu_majorNo()) {
								temp = 1;
								break;
							}
						}
						if (temp == 0) {
							// 没有这个专业，插入
							teamService.insertBaseMajor(studentEntity.getStu_majorNo(), studentEntity.getStu_major());
						}

					}
				}
				// 并插入学生数据
				// BaseStudentService baseStudentService = new
				// BaseStudentService();
				importExcelStudents(term_no, fileStudentEnts);
				teamService.addBaseTermStudentIFileService(fileStudentEnts, term_no);
			}

		}

		return null;

	}
   public ExecResult loadNavigationInfoService(String term_no){
	   String sql = "SELECT class_session_year term_no FROM `base_classes` WHERE  class_isover = '0' AND class_session_year<=''{0}'' GROUP BY class_session_year ORDER BY class_session_year DESC";
	   JSONResponse jr = new JSONResponse();
	   String params[]={term_no.substring(0,4)};
	   ExecResult r1 = jr.getSelectResult(sql, params, null);
	   return r1;
   }
   
   public ExecResult getdepartmentInfoService(){
	   String sql = "SELECT dep_no,dep_name FROM `base_department` WHERE dep_type='教学'";
	   JSONResponse jr = new JSONResponse();
	   ExecResult result = jr.getSelectResult(sql, null, null);
	   return result;
   }
	
   /**
	 * 单个检测学生数据健壮性
	 * 

	 *            学生实体类
	 * @return
	 */
	public ExecResult getTableInfo(String class_year,String dep_no,int pageindex,int pagelength,String stu_name,String term_no,String class_no) {
		int pagenumber = pageindex-1; 
		String sql = "";
		String []params =new String[5];
		if(stu_name =="" ||stu_name == null){
			  sql=" SELECT b.`stu_no`,a.stu_name,c.major_name,c.major_no,d.class_no,d.class_name,a.stu_birthday,a.stu_phone,a.stu_year,a.stu_status FROM (`base_term_student` b ,`base_classes` d,`base_student` a ) LEFT JOIN `base_major` c ON b.major_no = c.major_no WHERE b.term_no=''{0}''  AND d.class_session_year=''{1}'' AND d.dep_no=''{2}'' AND d.class_no=''{3}'' AND a.stu_no = b.stu_no AND b.class_no = d.class_no  GROUP BY  b.`stu_no`,a.stu_name,d.class_no ORDER BY b.stu_no ASC";
			  params[1]=class_year;
			  params[0]=term_no;
		      params[2]=dep_no;
			  params[3] = class_no;
		}else{
			 sql=" SELECT b.`stu_no`,a.stu_name,c.major_name,c.major_no,d.class_no,d.class_name,a.stu_birthday,a.stu_phone,a.stu_year,a.stu_status FROM (`base_term_student` b ,`base_classes` d,`base_student` a ) LEFT JOIN `base_major` c ON b.major_no = c.major_no WHERE b.term_no=''{0}''  AND d.class_session_year=''{1}'' AND d.dep_no=''{2}'' AND d.class_no=''{4}'' AND a.stu_no = b.stu_no AND b.class_no = d.class_no AND a.stu_name LIKE  ''%{3}%'' GROUP BY  b.`stu_no`,a.stu_name,d.class_no  ORDER BY b.stu_no ASC   ";
			 params[1]=class_year;
			 params[0]=term_no;
			 params[2]=dep_no;
		     params[3] =stu_name;
		     params[4] = class_no;
		}
		 if (pagelength > 0) {
			sql += " limit " + (pagenumber * pagelength) + "," + pagelength;
		}
		JSONResponse jo = new JSONResponse();
		ExecResult r = jo.getSelectResult(sql, params, null);
		if ("数据为空".equals(r.getMessage())) {
			r.setResult(false);
		}
		return r;
	}
	
	public ExecResult getTableInfoCount(String class_year,String dep_no,String stu_name,String term_no,String class_no) {
		String sql = "";
		String []params = new String[5];
		if(stu_name == "" ||stu_name==null){
			sql=" SELECT COUNT(*)total FROM (SELECT a.stu_name  FROM (`base_term_student` b ,`base_classes` d,`base_student` a ) LEFT JOIN `base_major` c ON b.major_no = c.major_no WHERE b.term_no=''{0}''  AND d.class_session_year=''{1}'' AND d.dep_no=''{2}'' AND d.class_no=''{3}'' AND a.stu_no = b.stu_no AND b.class_no = d.class_no   GROUP BY  b.`stu_no`,a.stu_name,d.class_no  )tb1";
			 params[1]=class_year;
			 params[0]=term_no;
			 params[2]=dep_no;
			 params[3] = class_no;
		}else{
			sql=" SELECT COUNT(*)total FROM ( SELECT a.stu_name FROM (`base_term_student` b ,`base_classes` d,`base_student` a ) LEFT JOIN `base_major` c ON b.major_no = c.major_no WHERE b.term_no=''{0}''  AND d.class_session_year=''{1}'' AND d.dep_no=''{2}'' AND d.class_no=''{4}'' AND a.stu_no = b.stu_no AND b.class_no = d.class_no   AND a.stu_name LIKE  ''%{3}%''   GROUP BY  b.`stu_no`,a.stu_name,d.class_no  )tb1";
			 params[1]=class_year;
			 params[0]=term_no;
			 params[2]=dep_no;
		     params[3] =stu_name;
		     params[4] = class_no;
		}
		JSONResponse jo = new JSONResponse();
		ExecResult r = jo.getSelectResult(sql, params, null);
		return r;
	}
	public ExecResult getDouble(String stu_no){
		JSONResponse jo = new JSONResponse();
		ExecResult result = new ExecResult();
		String sqlselect="SELECT stu_no FROM base_student WHERE stu_no = ''{0}''";
		String []params={stu_no};
		ExecResult r1 = jo.getSelectResult(sqlselect, params, null);
		return r1;
	}
	public ExecResult insertNewStudent(String tempPhone,String class_no,String stu_no,String stu_name,String stu_birthday,String major_no_,String stu_year,String stu_status,String term_no){
		
		JSONResponse jo = new JSONResponse();
		ExecResult result = new ExecResult();
		ExecResult r1 = getDouble(stu_no);
		if(r1.getData().size()>0){
			result = new ExecResult(false,"学号重复，无法添加");
		}else{
			String sqlInsertbase="INSERT INTO `base_student` VALUES(''{0}'',''{1}'',''{2}'',''{3}'',''{4}'',''{5}'',''{6}'')";
			String params1[] = {stu_no,stu_name,stu_birthday,tempPhone,major_no_,stu_year,stu_status};
			ExecResult r2=jo.getExecResult(sqlInsertbase, params1, "基础数据插入成功", "基础数据插入失败");
			ExecResult r3 = null;

			String sqlInsertTerm="INSERT INTO `base_term_student` VALUES(''{0}'',''{1}'',''{2}'',''{3}'')";
			String params2[] = {term_no,stu_no,major_no_,class_no};
			r3=jo.getExecResult(sqlInsertTerm, params2, "学期数据插入成功", "学期数据插入失败");
			if (r3.getResult()==1) {
				result=new ExecResult(true,"学生数据插入成功");
			}else{
				result.setResult(false);
				result.setMessage("基础数据插入失败");
			}
		}
		return result;
	}
	public ExecResult importExcel(String term_no,List<ImportFileStudentEntity> fileStudentEnts){
		JSONResponse jo = new JSONResponse();
		String result ="";
		String sql = "SELECT major_no,major_name FROM base_major";
		String sql2 = "SELECT class_no FROM base_classes";
		String sql3 = "SELECT stu_no FROM base_student";
		ExecResult r1 = jo.getSelectResult(sql, null, null);
		ExecResult r2 = jo.getSelectResult(sql2, null, null);
		ExecResult r3 = jo.getSelectResult(sql3, null, null);
		Map<String , String> majorMap = new HashMap<>();
		Map<String, String> class_no_map = new HashMap<>();
		Map<String, String> stu_no_map = new HashMap<>();
		for (int i = 0; i < r1.getData().size(); i++) {
			majorMap.put(r1.getData().getJSONObject(i).get("major_no").toString(),r1.getData().getJSONObject(i).get("major_no").toString());
		}
		for(int i = 0 ;i<r2.getData().size();i++){
			class_no_map.put(r2.getData().getJSONObject(i).get("class_no").toString(),r2.getData().getJSONObject(i).get("class_no").toString());
		}
		for(int i = 0 ;i<r3.getData().size();i++){
			stu_no_map.put(r3.getData().getJSONObject(i).get("stu_no").toString(),r3.getData().getJSONObject(i).get("stu_no").toString());
		}
		for(int i =0;i<fileStudentEnts.size();i++){
			//比对这组数组是否重复
			ImportFileStudentEntity importFileStudentEntity = new ImportFileStudentEntity();
			importFileStudentEntity=fileStudentEnts.get(i);
			if(ifclass_No(importFileStudentEntity.getStu_classNo(),class_no_map)) {
					result += "第"+ (i+1) +"条记录班级编号错误\r\n</br> ";
					continue;
			}
			if(ifstu_no(importFileStudentEntity.getStu_no(),stu_no_map)) {
				result += "第"+ (i+1) +"条记录学生编号重复\r\n</br>";
				continue;
		    }
			if(ifclass_No(importFileStudentEntity.getStu_classNo(),class_no_map)) {
				String sql4="INSERT INTO base_major (major_no,major_name) VALUES(''{0}'',''{1}'')";
				String params[] = {importFileStudentEntity.getStu_majorNo(),importFileStudentEntity.getStu_major()};
				ExecResult r4 = jo.getExecResult(sql4, params, "插入专业成功", "插入专业失败");
		    }
			String sqlInsertbase="INSERT INTO `base_student` (stu_no,stu_name,stu_birthday,stu_phone,stu_major_init,stu_year,stu_status) VALUES(''{0}'',''{1}'','''','''','''',''{2}'','1')";
			String params1[] = {importFileStudentEntity.getStu_no(),importFileStudentEntity.getStu_name(),importFileStudentEntity.getStu_year()};
			ExecResult r5=jo.getExecResult(sqlInsertbase, params1, ""+ i+1 +"条基础数据插入成功", ""+ i+1 +"基础数据插入失败");
			ExecResult r6 = null;
			if(r5.getResult()==1){
			String sqlInsertTerm="INSERT INTO `base_term_student` (term_no,stu_no,major_no,class_no) VALUES(''{0}'',''{1}'',''{2}'',''{3}'')";
			String params2[] = {term_no,importFileStudentEntity.getStu_no(),importFileStudentEntity.getStu_majorNo(),importFileStudentEntity.getStu_classNo()};
			r3=jo.getExecResult(sqlInsertTerm, params2, ""+ i+1 +"条学期数据插入成功", ""+ i+1 +"条学期数据插入失败");
			}
				if(r5.getResult()==0 && r6==null){
					result+="第"+ (i+1) +"基础数据插入失败\r\n</br>";
				}
				if(r6!=null){
					if(r5.getResult()==1 && r6.getResult()==0){
						result+="第"+ (i+1) +"基础数据、学期数据导入错误\r\n</br>";
					}
				}
		}
		ExecResult rn = new ExecResult();
		if(result==""){
			rn.setResult(true);
			rn.setMessage("导入成功");
		}else{
			rn.setResult(false);
			rn.setMessage(result);
		}
		return rn;
	}
	
	public boolean ifclass_No(String class_no,Map<String, String> map){
		boolean flag = true;
	    if(map.containsKey(class_no)){
	    	flag=false;
	    }
		return flag;
	}
	public boolean ifstu_no(String stu_no,Map<String, String> map){
		boolean flag = false;
		if(map.containsKey(stu_no)){
	    	flag=true;
	    }
		return flag;
	}
	public boolean ifInsertMajor_no(String major_no,Map<String, String> map){
		boolean flag = true;
		if(map.containsKey(major_no)){
	    	flag=false;
	    }
		return flag;
	}
	
	public  ExecResult getBaseClass(String class_year,String dep_no){
		String sql="SELECT class_no,class_name,major_no FROM `base_classes` WHERE class_session_year = ''{0}''";
		String params[] = {class_year};
		JSONResponse jo = new JSONResponse();
		ExecResult result = jo.getSelectResult(sql, params, null);
		return  result;
	}

	public  ExecResult getAllClass(){
		String sql="SELECT class_no,class_name,major_no FROM `base_classes` ";
		JSONResponse jo = new JSONResponse();
		ExecResult result = jo.getSelectResult(sql, null, null);
		return  result;
	}
	
	
	public ExecResult getClassInfo(String []term,String dep_no){
		JSONArray ja = new JSONArray();
		JSONResponse jo = new JSONResponse();
		for(int i =0;i<term.length;i++){
			String tempterm = term[i];
			String sql ="SELECT class_no,class_name FROM `base_classes` WHERE dep_no=''{1}'' AND  class_session_year = ''{0}'' AND class_isover ='0'";
			String params[] = {tempterm.substring(0, 4),dep_no};
			ExecResult r = jo.getSelectResult(sql, params, null);
			JSONArray temparray = r.getData();
			for(int m=0;m<temparray.size();m++){
				JSONObject jObject = new JSONObject();
				jObject.put("class_no", temparray.getJSONObject(m).get("class_no"));
				jObject.put("class_name", temparray.getJSONObject(m).get("class_name"));
				jObject.put("term_no", tempterm);
				ja.add(jObject);
			}
		}
		ExecResult result = new ExecResult(true,"成功返回对应班级");
		result.setData(ja);
		return result;
	}
	
	public ExecResult copyData(String class_year,String dep_no,String term_no,String class_no){
		JSONResponse jo = new JSONResponse();
		String sql = "INSERT INTO `base_term_student` (term_no,stu_no,major_no,class_no)   SELECT ''{0}'' AS term_no,a.stu_no,a.major_no,a.class_no FROM  `base_term_student` a LEFT JOIN  (SELECT MAX(term_no)  term_no FROM (SELECT term_no FROM  `base_term` WHERE term_no <''{0}'') tb1) tb2 ON tb2.term_no = a.`term_no` WHERE a.class_no=''{1}'' AND a.term_no = tb2.term_no";
		String params[] = {term_no,class_no};
		ExecResult result = jo.getExecResult(sql, params, "", "");
		return result;
	}

}
