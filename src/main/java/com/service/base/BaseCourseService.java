package com.service.base;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.common.QMUtils;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.db.JSONDataResult;
import com.jhg.response.JSONResponse;
import com.service.base.bean.BaseErrorMsg;
import com.service.base.bean.BaseLogEntity;
import com.service.base.bean.BaseTaskSche;
import com.service.base.bean.BaseTeachTask;
import com.service.base.bean.ImportFileCourseEntity2;

/**
 * 课程维护 © 2015 niitSoft 名称：BaseCourseService.java 描述：
 *
 * @author LiKun
 * @version v1.0 @date：2015年7月25日
 */
public class BaseCourseService {

	BaseClassService classService = new BaseClassService();
	CommonService commonService = new CommonService();
	private BaseLogService logService = new BaseLogService();

	public ExecResult getAddTeacher() {
		// TODO Auto-generated method stub
		String sql = "SELECT teacher_no , teacher_name FROM base_teacher WHERE teacher_status=1";
		
		String sql_="SELECT class_no , class_name FROM base_classes WHERE NOT class_isover = '1'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = new ExecResult();
		JSONArray jsonArray = new JSONArray();
		JSONObject jObjectTea = new JSONObject(); 
		JSONObject jsonObjectClass = new JSONObject();
		jObjectTea.put("teacher", jr.getSelectResult(sql, null, "").getData());
		jsonObjectClass.put("classInf", jr.getSelectResult(sql_, null, "").getData());
		jsonArray.add(jObjectTea);
		jsonArray.add(jsonObjectClass);
		result.setData(jsonArray);
		result.setResult(true);
		return result;
	}

	private static Logger logger = Logger.getLogger(BaseCourseService.class);

	/**
	 * 获取课程信息
	 * 
	 * @param class_no
	 *            课程代码(为空查询全部)
	 * @return ExecResult 集
	 */
	public ExecResult getBaseCourseTable() {
		String sql = "SELECT teacher_task.* , teacher.teacher_name ,classes.class_name,task_sche.sche_addr,task_sche.sche_set FROM base_teach_task AS teacher_task LEFT JOIN base_teacher teacher ON teacher_task.`teacher_no` = teacher.`teacher_no` LEFT JOIN base_classes classes ON teacher_task.`class_no` = classes.`class_no` LEFT JOIN base_task_sche task_sche ON teacher_task.`task_no` = task_sche.`task_no` where 1=1  ";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_teach_task");
		return result;
	}

	/**
	 * 查询当前课程task_no
	 * @param term_no 学年学期
	 * @param course_no 课程号
	 * @param teacher_no 教工号
	 * @param class_no 班级号
	 * @return
	 */
	public ExecResult getBaseCourseByCourseNo(String term_no , String course_no , String teacher_no , String class_no) {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM base_teach_task WHERE term_no=");
		sql.append("'" + term_no + "'");
		sql.append("AND course_no=");
		sql.append("'" + course_no + "'");
		sql.append("AND teacher_no=");
		sql.append("'" + teacher_no + "'");
		sql.append("AND class_no=");
		sql.append("'" + class_no + "'");
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql.toString(), null, "base_teach_task");
		return result;
	}

	public ExecResult getBaseCourseListService(int pageLength, int pageNumber, String searchSql, String term_no,
			String dep_no) {
		int start = pageNumber - 1;
		int length = pageLength;
		String sql = "SELECT teacher_task.* , teacher.teacher_name ,classes.class_name,task_sche.sche_no, task_sche.sche_addr,task_sche.sche_set ,term.term_name FROM base_teach_task AS teacher_task LEFT JOIN base_teacher teacher ON teacher_task.`teacher_no` = teacher.`teacher_no` LEFT JOIN base_classes classes ON teacher_task.`class_no` = classes.`class_no`  left JOIN base_task_sche task_sche ON teacher_task.`task_no` = task_sche.`task_no` left join base_term term on term.term_no = teacher_task.term_no where 1=1  ";
		if (!TypeUtils.isEmpty(term_no)) {
			sql = "SELECT teacher_task.* , teacher.teacher_name ,classes.class_name,task_sche.sche_no, task_sche.sche_addr,task_sche.sche_set ,term.term_name FROM base_teach_task AS teacher_task LEFT JOIN base_teacher teacher ON teacher_task.`teacher_no` = teacher.`teacher_no` LEFT JOIN base_classes classes ON teacher_task.`class_no` = classes.`class_no`  left JOIN base_task_sche task_sche ON teacher_task.`task_no` = task_sche.`task_no` left join base_term term on term.term_no = teacher_task.term_no where   ";
			sql += "teacher_task.term_no= ";
			sql += "'" + term_no + "'";
		}
		if (!dep_no.equals("all")) {
			sql = "SELECT teacher_task.* , teacher.teacher_name ,classes.class_name,task_sche.sche_no, task_sche.sche_addr,task_sche.sche_set ,term.term_name FROM base_teach_task AS teacher_task LEFT JOIN base_teacher teacher ON teacher_task.`teacher_no` = teacher.`teacher_no` LEFT JOIN base_classes classes ON teacher_task.`class_no` = classes.`class_no`  left JOIN base_task_sche task_sche ON teacher_task.`task_no` = task_sche.`task_no` left join base_term term on term.term_no = teacher_task.term_no where   ";
			sql += "teacher_task.dep_no = ";
			sql += "'" + dep_no + "'";
			sql += "AND teacher_task.term_no= ";
			sql += "'" + term_no + "'"; 
		}
		// sql += searchSql ; 
		if (length > 0) {
			sql += " ORDER BY teacher_task.course_no DESC limit " + (start * length) + "," + length;
		}
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "");
		return result;
	}

	public ExecResult getBaseCourseListServiceCount(String searchSql, String term_no, String dep_no) {
		String sql = "SELECT COUNT(1) totalrows FROM base_teach_task AS teacher_task LEFT JOIN base_teacher teacher ON teacher_task.`teacher_no` = teacher.`teacher_no` LEFT JOIN base_classes classes ON teacher_task.`class_no` = classes.`class_no` LEFT JOIN base_task_sche task_sche ON teacher_task.`task_no` = task_sche.`task_no` where 1=1  ";
		if (!TypeUtils.isEmpty(term_no)) {
			sql = "SELECT COUNT(1) totalrows FROM base_teach_task AS teacher_task LEFT JOIN base_teacher teacher ON teacher_task.`teacher_no` = teacher.`teacher_no` LEFT JOIN base_classes classes ON teacher_task.`class_no` = classes.`class_no` LEFT JOIN base_task_sche task_sche ON teacher_task.`task_no` = task_sche.`task_no` where ";
			sql += "teacher_task.term_no= ";
			sql += "'" + term_no + "'";
		}
		if (!dep_no.equals("all")) {
			sql = "SELECT COUNT(1) totalrows FROM base_teach_task AS teacher_task LEFT JOIN base_teacher teacher ON teacher_task.`teacher_no` = teacher.`teacher_no` LEFT JOIN base_classes classes ON teacher_task.`class_no` = classes.`class_no` LEFT JOIN base_task_sche task_sche ON teacher_task.`task_no` = task_sche.`task_no` where ";
			sql += "teacher_task.dep_no = ";
			sql += "'" + dep_no + "'";
			sql += "AND teacher_task.term_no= ";
			sql += "'" + term_no + "'";
		}
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "");
		return result;
	}

	public ExecResult getBaseSearchInf(String search_info, String term_no, String dep_no) {
		String sql = "SELECT teacher_task.* , teacher.teacher_name ,classes.class_name,task_sche.sche_no, task_sche.sche_addr,task_sche.sche_set ,term.term_name FROM base_teach_task AS teacher_task LEFT JOIN base_teacher teacher ON teacher_task.`teacher_no` = teacher.`teacher_no` LEFT JOIN base_classes classes ON teacher_task.`class_no` = classes.`class_no`  left JOIN base_task_sche task_sche ON teacher_task.`task_no` = task_sche.`task_no` left join base_term term on term.term_no = teacher_task.term_no where 1=1  ";
		if (!TypeUtils.isEmpty(term_no)) {
			sql = "SELECT teacher_task.* , teacher.teacher_name ,classes.class_name,task_sche.sche_no, task_sche.sche_addr,task_sche.sche_set ,term.term_name FROM base_teach_task AS teacher_task LEFT JOIN base_teacher teacher ON teacher_task.`teacher_no` = teacher.`teacher_no` LEFT JOIN base_classes classes ON teacher_task.`class_no` = classes.`class_no`  left JOIN base_task_sche task_sche ON teacher_task.`task_no` = task_sche.`task_no` left join base_term term on term.term_no = teacher_task.term_no WHERE  (teacher_task.course_name LIKE''%{0}%'' OR teacher.teacher_name LIKE''%{0}%'') ";
			sql += "AND teacher_task.term_no= ";
			sql += "'" + term_no + "' ORDER BY teacher_task.course_no";
		}
		if (!dep_no.equals("all")) {
			sql = "SELECT teacher_task.* , teacher.teacher_name ,classes.class_name,task_sche.sche_no, task_sche.sche_addr,task_sche.sche_set ,term.term_name FROM base_teach_task AS teacher_task LEFT JOIN base_teacher teacher ON teacher_task.`teacher_no` = teacher.`teacher_no` LEFT JOIN base_classes classes ON teacher_task.`class_no` = classes.`class_no`  left JOIN base_task_sche task_sche ON teacher_task.`task_no` = task_sche.`task_no` left join base_term term on term.term_no = teacher_task.term_no WHERE (teacher_task.course_name LIKE''%{0}%'' OR teacher.teacher_name LIKE''%{0}%'')   ";
			sql += "AND teacher_task.dep_no = ";
			sql += "'" + dep_no + "'";
			sql += " AND teacher_task.term_no= ";
			sql += "'" + term_no + "' ORDER BY teacher_task.course_no"; 
		}
		String[] params = new String[] { search_info, term_no, dep_no };
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "");
		return result;
	}

	public ExecResult changeInf(String task_no, String sche_no, String term_no, String course_name, String class_name,
			String teacher_no, String sche_set, String sche_addr) {
		JSONResponse jr = new JSONResponse();
		String class_no = "";
		String sql_select = "SELECT course_type  FROM base_teach_task  WHERE task_no='"+task_no+"'";
		ExecResult select_result = jr.getSelectResult(sql_select, null, "");
		if("".equals(class_name) || class_name == null){	
			//查一下是否为任选 
			if(select_result.getResult() > 0){ 
				 
				if(!"任选课".equals(select_result.getData().getJSONObject(0).getString("course_type"))){
					return new ExecResult(false,"");
				}
				
			}
		}else{
			String select_classNo = "SELECT class_no FROM base_classes WHERE class_name='"+class_name.trim()+"'";
			ExecResult select_class_no = jr.getSelectResult(select_classNo, null, "");
			if(select_class_no.getResult() > 0){
				class_no = select_class_no.getData().getJSONObject(0).getString("class_no");
			}else{
				return new ExecResult(false,"");
			}
		}
		if("实训课".equals(select_result.getData().getJSONObject(0).getString("course_type"))){
			sche_set = "K99";  
		} 
		if("".equals(class_no)){   
			System.out.println("123");
			class_name=""; 
		}

		String[] params = new String[] { task_no, sche_no, term_no, course_name, class_name, teacher_no, sche_set, 
				sche_addr,class_no }; 
		ExecResult result = new ExecResult();
    
		String sql = "UPDATE  base_teach_task SET term_no=''{2}'' , course_name=''{3}'' ,teacher_no=''{5}'' ,class_no=''{8}'' WHERE task_no=''{0}''";
		String sql_ = "";
		if(sche_no == null || "".equals(sche_no)){ 
			sql_ = "INSERT INTO base_task_sche('task_no' , 'sche_set' , 'sche_addr') VALUES(''{0}'',''{6}'',''{7}'')";
		}else{
			sql_ = "UPDATE base_task_sche SET sche_set=''{6}'' ,sche_addr=''{7}'' where sche_no=''{1}''";
		}
		jr.getExecResult(sql_, params, "", "");  
		result = jr.getExecResult(sql, params, "", ""); 
		result.setResult(true); 


		return result;
	}

	/**
	 * 
	 * @param baseTeachTask
	 * @return
	 */
	public ExecResult insertBaseTeachTaskInfo(BaseTeachTask baseTeachTask) {
		StringBuilder sql = new StringBuilder();
		sql.append(
				"INSERT INTO base_teach_task(term_no,course_no,course_name,teacher_no,course_type,course_attr,course_week,course_ccount,course_scount,class_no,dep_no)VALUES(");
		sql.append("'" + baseTeachTask.getTerm_no() + "',");
		sql.append("'" + baseTeachTask.getCourse_no() + "',");
		sql.append("'" + baseTeachTask.getCourse_name() + "',");
		sql.append("'" + baseTeachTask.getTeacher_no() + "',");
		sql.append("'" + baseTeachTask.getCourse_type() + "',");
		sql.append("'" + baseTeachTask.getCourse_attr() + "',");
		sql.append("'" + baseTeachTask.getCourse_week() + "',");
		sql.append("'" + baseTeachTask.getCourse_ccount() + "',");
		sql.append("'" + baseTeachTask.getCourse_scount() + "',");
		sql.append("'" + baseTeachTask.getClass_no() + "',");
		sql.append("'" + baseTeachTask.getDep_no() + "')");
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(sql.toString(), null, "", "");
		return result;
	}

	/**
	 * 
	 * @param baseTaskSche
	 * @return
	 */
	public ExecResult insertBaseTaskScheInfo(BaseTaskSche baseTaskSche) {
		StringBuilder sql = new StringBuilder();
		sql.append("INSERT INTO base_task_sche(task_no , sche_set , sche_addr )VALUES(");
		sql.append("'" + baseTaskSche.getTask_no() + "',");
		sql.append("'" + baseTaskSche.getSche_set() + "',");
		sql.append("'" + baseTaskSche.getSche_addr() + "')");
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(sql.toString(), null, "", "");
		return result;
	}

	/**
	 * 插入任选课
	 * 
	 * @param baseClassLogic
	 * @return
	 */
	// public ExecResult insertBaseClassLogicInfo(BaseClassLogic
	// baseClassLogic){
	// StringBuilder sql = new StringBuilder();
	// sql.append("INSERT INTO base_class_logic(term_no , student_no ,
	// task_no,logic_no,logic_name,course_no )VALUES(");
	// sql.append("'" + baseClassLogic.getTerm_no() + "',");
	// sql.append("'" + baseClassLogic.getStudent_no() + "',");
	// sql.append("'" + baseClassLogic.getTask_no() + "',");
	// sql.append("'" + baseClassLogic.getLogic_no() + "',");
	// sql.append("'" + baseClassLogic.getLogic_name() + "',");
	// sql.append("'" + baseClassLogic.getCourse_no() + "')");
	// JSONResponse jr=new JSONResponse();
	// ExecResult result=jr.getExecResult(sql.toString(), null, "", "");
	// return result;
	// }

	public ExecResult removeInf(String sche_no , String task_no) {
		String sql = "";
		boolean flag = true;
		if(sche_no == null || "".equals(sche_no)){ 
			 sql = "DELETE FROM base_teach_task WHERE task_no=''{1}''";  
			 flag = false;
		}else{
			 sql = "DELETE FROM base_task_sche WHERE sche_no=''{0}''";
		}
		String[] params = new String[] { sche_no  ,task_no};
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(sql, params, "", "");
		
		if(flag){
			String sql_select = "SELECT * FROM `base_task_sche` WHERE task_no='"+task_no+"'";
			ExecResult select_result = jr.getSelectResult(sql_select, null, "");
			if(!(select_result.getResult() > 0)){ 
				sql = "DELETE FROM base_teach_task WHERE task_no=''{1}''";
				jr.getExecResult(sql, params, "", "");
			}
		}
		
		return result;
	}

	public List<ImportFileCourseEntity2> parseFileCourseEntitys(String term_no,
			List<ImportFileCourseEntity2> entities) {
		LinkedList<ImportFileCourseEntity2> courseEntity2s = new LinkedList<>();
		for (ImportFileCourseEntity2 importFileCourseEntity2 : entities) {
			System.out.println("改造前的课程为：" + importFileCourseEntity2.toString());
			// 所属部门
			String dep_name = importFileCourseEntity2.getCourse_dep();
			importFileCourseEntity2.setDep_name(dep_name);
			if (!TypeUtils.isEmpty(dep_name)) {
				ExecResult execResult = commonService.queryDep(dep_name);
				if (execResult.getResult() == 1) {
					System.out.println("查询到该部门ID：" + dep_name);
					JSONArray array = execResult.getData();
					for (int j = 0; j < array.size(); j++) {
						JSONObject object = array.getJSONObject(j);
						String dep_no = object.getString("dep_no");
						System.out.println("查询到该部门信息No：" + dep_no);
						importFileCourseEntity2.setDep_no(dep_no);
					}
				}
			}
			// 课程号
			String course_no = QMUtils.parseCourseNo(importFileCourseEntity2.getCourse_idName());
			importFileCourseEntity2.setCourse_no(course_no);
			// 课程名称
			String course_name = QMUtils.parseCourseName(importFileCourseEntity2.getCourse_idName());
			importFileCourseEntity2.setCourse_name(course_name);
			// 教工号
			String teacher_no = QMUtils.parseCourseNo(importFileCourseEntity2.getCourse_teacher());
			importFileCourseEntity2.setTeacher_no(teacher_no);
			// 教师名称
			String teacher_name = QMUtils.parseCourseName(importFileCourseEntity2.getCourse_teacher());
			importFileCourseEntity2.setTeacher_name(teacher_name);
			//
			if (importFileCourseEntity2.getCourse_logic().equals("0")) {
				importFileCourseEntity2.setCourse_type1("讲授课");
			}
			// 多个班级
			if (!TypeUtils.isEmpty(importFileCourseEntity2.getClassNames())
					|| importFileCourseEntity2.getClassNames().equals("null")) {
				String[] classNames = importFileCourseEntity2.getClassNames().split(" ");
				System.out.println("班级数量为：" + classNames.length);
				for (int i = 0; i < classNames.length; i++) {
					System.out.println("班级为：" + classNames[i]);
					ImportFileCourseEntity2 im = new ImportFileCourseEntity2();
					im.setCourse_dep(importFileCourseEntity2.getCourse_dep());
					im.setDep_no(importFileCourseEntity2.getDep_no());
					im.setDep_name(importFileCourseEntity2.getDep_name());
					im.setCourse_idName(importFileCourseEntity2.getCourse_idName());
					im.setCourse_name(importFileCourseEntity2.getCourse_name());
					im.setCourse_no(importFileCourseEntity2.getCourse_no());
					im.setCourse_totalTime(importFileCourseEntity2.getCourse_totalTime());
					im.setCourse_teacher(importFileCourseEntity2.getCourse_teacher());
					im.setTeacher_no(importFileCourseEntity2.getTeacher_no());
					im.setTeacher_name(importFileCourseEntity2.getTeacher_name());
					im.setCourse_classTotalStu(importFileCourseEntity2.getCourse_classTotalStu());
					im.setCourse_classWeek(importFileCourseEntity2.getCourse_classWeek());
					im.setCourse_classScheSet(importFileCourseEntity2.getCourse_classScheSet());
					im.setCourse_scheAddr(importFileCourseEntity2.getCourse_scheAddr());
					im.setCourse_type1(importFileCourseEntity2.getCourse_type1());
					im.setCourse_type2(importFileCourseEntity2.getCourse_type2());
					im.setCourse_logic(importFileCourseEntity2.getCourse_logic());
					im.setClassNames(importFileCourseEntity2.getClassNames());
					im.setClass_name(classNames[i]);
					if (!TypeUtils.isEmpty(im.getClass_name())) {
						// 班级名称不为空，查询class_no
						ExecResult execResult = classService.queryBaseClassListService(term_no, im.getClass_name());
						if (execResult.getResult() == 1) {
							System.out.println("查询到该班级信息：" + im.getClass_name());
							JSONArray array = execResult.getData();
							for (int j = 0; j < array.size(); j++) {
								JSONObject object = array.getJSONObject(j);
								String class_no = object.getString("class_no");
								System.out.println("查询到该班级信息No：" + class_no);
								im.setClass_no(class_no);
							}
						} else {
							System.out.println("未查询到该班级信息：" + im.getClass_name());
							System.out.println("执行添加该班级：" + im.getClass_name());
						}

					}
					courseEntity2s.add(im);
				}
			} else {
				courseEntity2s.add(importFileCourseEntity2);
			}
		}
		return courseEntity2s;
	}

	/**
	 * 
	 * @param term_no
	 * @param entities
	 * @return
	 */
	public ExecResult processImportBaseCourseService(String term_no, List<ImportFileCourseEntity2> entities) {
		ExecResult result = new ExecResult();
		BaseLogEntity logEntity = new BaseLogEntity();
		logEntity.setBatch_type(2);// 缺省为课程导入
		logEntity.setBatch_status(0);// 缺省导入数据全部成功
		logEntity.setTotal(entities.size());// 导入总数量
		List<ImportFileCourseEntity2> sucessCourseEntities = new ArrayList<>();
		List<ImportFileCourseEntity2> errorCourseEntities = new ArrayList<>();
		List<BaseErrorMsg> errorMsgs = new ArrayList<>();
		StringBuilder errmsgStr = new StringBuilder();
		// 0.筛选课程正确与错误数据
		for (ImportFileCourseEntity2 importFileCourseEntity2 : entities) {
			System.out.println("筛选的课程为：" + importFileCourseEntity2.toString());
			StringBuilder errMsg = new StringBuilder();
			boolean isFlag = true;
			errMsg.append("课程[" + importFileCourseEntity2.getCourse_idName() + "]: ");
			// 1.承担单位不能为空
			if (TypeUtils.isEmpty(importFileCourseEntity2.getCourse_dep())
					|| importFileCourseEntity2.getCourse_dep().equals("null")) {
				isFlag = false;
				errMsg.append("A.承担单位不能为空");
			}
			// 2.课程内容不能为空
			if (TypeUtils.isEmpty(importFileCourseEntity2.getCourse_idName())
					|| importFileCourseEntity2.getCourse_idName().equals("null")) {
				isFlag = false;
				errMsg.append("B.课程内容不能为空");
			}
			// 3.教师不能为空
			if (TypeUtils.isEmpty(importFileCourseEntity2.getCourse_teacher())
					|| importFileCourseEntity2.getCourse_teacher().equals("null")) {
				isFlag = false;
				errMsg.append("D.教师内容不能为空");
			}
			// 3.班级不能为空(不是逻辑班级)
			if (TypeUtils.isEmpty(importFileCourseEntity2.getCourse_logic())
					|| importFileCourseEntity2.getCourse_logic().equals("null")) {
				isFlag = false;
				errMsg.append("L.必须设置是否逻辑班级");
			} else {
				if (importFileCourseEntity2.getCourse_logic().equals("0")) {
					if (TypeUtils.isEmpty(importFileCourseEntity2.getClassNames())
							|| importFileCourseEntity2.getClassNames().equals("null")) {
						isFlag = false;
						errMsg.append("F.班级内容不能为空");
					}
				}
			}
			// 4.周次不能为空
			if (TypeUtils.isEmpty(importFileCourseEntity2.getCourse_classWeek())
					|| importFileCourseEntity2.getCourse_classWeek().equals("null")) {
				isFlag = false;
				errMsg.append("G.周次内容不能为空");
			}
			// 5.节次不能为空
			if (TypeUtils.isEmpty(importFileCourseEntity2.getCourse_classScheSet())
					|| importFileCourseEntity2.getCourse_classScheSet().equals("null")) {
				isFlag = false;
				errMsg.append("H.节次内容不能为空");
			}
			if (isFlag) {
				sucessCourseEntities.add(importFileCourseEntity2);
			} else {
				errorCourseEntities.add(importFileCourseEntity2);
				System.out.println("导入课程内容错误信息为：" + errMsg.toString());
				errmsgStr.append(errMsg.toString());
				if (!TypeUtils.isEmpty(errMsg.toString())) {
					errmsgStr.append(",");
				}
			}
		}
		logEntity.setError_msg(errmsgStr.toString());
		System.out.println("导入课程总计为：" + entities.size());
		System.out.println("成功课程总计为：" + sucessCourseEntities.size());
		System.out.println("失败课程总计为：" + errorCourseEntities.size());
		// 1.成功数据
		if (sucessCourseEntities != null && sucessCourseEntities.size() > 0) {
			addSuccessCourses(term_no, sucessCourseEntities);
		}
		// 2. 失败数据插入
		BaseErrorMsg errorMsg = new BaseErrorMsg();
		errorMsg.setTotalnum(entities.size());
		errorMsg.setSuccessnum(sucessCourseEntities.size());
		errorMsg.setErrornum(errorCourseEntities.size());
		if (errorCourseEntities != null && errorCourseEntities.size() > 0) {
			logEntity.setError_total(errorCourseEntities.size());
			logEntity.setBatch_status(1);
			logEntity.setError_data(JSON.toJSONString(errorCourseEntities));
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
	 * 添加符合条件的课程
	 * 
	 * @param term_no
	 *            学年学期
	 * @param sucessCourseEntities
	 *            符合条件的课程集
	 */
	private void addSuccessCourses(String term_no, List<ImportFileCourseEntity2> sucessCourseEntities) {
		List<ImportFileCourseEntity2> list = parseFileCourseEntitys(term_no, sucessCourseEntities);
		if (list != null && list.size() > 0) {
			for (ImportFileCourseEntity2 iFileCourseEntity2 : list) {
				BaseTeachTask teachTask = new BaseTeachTask();
				teachTask.setTerm_no(term_no);
				teachTask.setCourse_no(iFileCourseEntity2.getCourse_no());
				teachTask.setCourse_name(iFileCourseEntity2.getCourse_name());
				teachTask.setTeacher_no(iFileCourseEntity2.getTeacher_no());
				teachTask.setCourse_type(iFileCourseEntity2.getCourse_type1());
				teachTask.setCourse_attr(iFileCourseEntity2.getCourse_type2());
				teachTask.setCourse_week(iFileCourseEntity2.getCourse_classWeek());
				teachTask.setCourse_ccount(iFileCourseEntity2.getCourse_totalTime());
				teachTask.setCourse_scount(iFileCourseEntity2.getCourse_classTotalStu());
				teachTask.setClass_no(iFileCourseEntity2.getClass_no());
				teachTask.setDep_no(iFileCourseEntity2.getDep_no());
				ExecResult execResult = insertBaseTeachTaskInfo(teachTask);
				if (execResult.getResult() == 1) {
					System.out.println("成功插入课程为：" + teachTask.getCourse_name());
					ExecResult resultCourse = getBaseCourseByCourseNo(term_no ,teachTask.getCourse_no() ,teachTask.getTeacher_no() , teachTask.getClass_no());
					if (resultCourse.getResult() == 1) {
						List<BaseTeachTask> baseTeachTasks = JSON.parseArray(resultCourse.getData().toJSONString(),
								BaseTeachTask.class);
						if (baseTeachTasks != null && baseTeachTasks.size() > 0) {
							System.out.println("查询刚插入的taskNo:" + baseTeachTasks.get(0).getTask_no());
							BaseTaskSche taskSche = new BaseTaskSche();
							taskSche.setTask_no(baseTeachTasks.get(0).getTask_no());// 教学任务编号
							taskSche.setSche_set(iFileCourseEntity2.getCourse_classScheSet());// 节次
							taskSche.setSche_addr(iFileCourseEntity2.getCourse_scheAddr()); //
							ExecResult execResultTaskSche = insertBaseTaskScheInfo(taskSche);
							if (execResultTaskSche.getResult() == 1) {
								System.out.println("插入task_sche: " + taskSche.getTask_no() + "成功");
							}
						}
					}
				}

			}
		}

	}
}
