package com.service.base;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.sys.LoginServer;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;
import com.service.base.bean.BaseClassesEntity;
import com.service.base.bean.ImportFileClass;

/**
 * 
 * © 2015 niitSoft
 * 
 * @Title: BaseClassService.java
 * @Description: 班级维护
 * @author LiKun
 * @date 2015年8月18日
 * @version V1.0
 *
 */
public class BaseClassService {

	private static Logger logger = Logger.getLogger(BaseClassService.class);

	/**
	 * 根据学年学期和班级名称获取班级信息
	 *
	 * @param term_no
	 * @param class_name
	 * @return
	 */
	public ExecResult queryBaseClassListService(String term_no, String class_name) {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT	* FROM base_classes WHERE class_name = ");
		sql.append("'" + class_name + "' ");
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql.toString(), null, "");
		return result;
	}

	/**
	 * 根据学年学期和部门获取班级信息
	 *
	 * @param term_no    学年学期号
	 * @param dep_no     部门号(缺省为all)
	 * @param pageLength 数量
	 * @param pageNumber 页码
	 * @return
	 */
	public ExecResult queryBaseClassListService(String term_no, String dep_no, String serach_class_name, int pageLength,
												int pageNumber) {
		int start = pageNumber - 1;
		int length = pageLength;
		StringBuilder sql = new StringBuilder();
		sql.append(
				"SELECT DISTINCT a.class_no,a.class_name,a.class_stu_amount,a.dep_no,b.dep_name,a.major_no,c.major_name,a.teacher_no,d.teacher_name,a.stu_no,e.stu_name,a.class_isover FROM base_classes a");
		sql.append(" LEFT JOIN base_department b ON b.dep_no=a.dep_no ");
		sql.append(" LEFT JOIN base_major c ON c.major_no=a.major_no ");
		sql.append(" LEFT JOIN base_teacher d ON d.teacher_no=a.teacher_no ");
		sql.append(" LEFT JOIN base_student e ON e.stu_no=a.stu_no ");
		//sql.append(" LEFT JOIN base_term_student f ON f.class_no=a.class_no AND term_no = " + "'" + term_no + "'");
		sql.append("WHERE a.class_session_year = " + "'" + term_no.substring(0, 4) + "'");
		if (!dep_no.equals("all")) {
			sql.append(" AND b.dep_no = " + "'" + dep_no + "'");
		}
		if (!TypeUtils.isEmpty(serach_class_name)) {
			sql.append(" AND a.class_name LIKE " + "'%" + serach_class_name + "%'");
		}
		if (length > 0) {
			sql.append(" GROUP BY a.class_no  limit " + (start * length) + "," + length);
		}
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql.toString(), null, "");
		return result;

	}

	/**
	 * 根据学年学期和部门获取班级信息总数
	 *
	 * @param term_no 学年学期号
	 * @param dep_no  部门号(缺省为all)
	 * @return
	 */
	public ExecResult queryBaseClassListCountService(String term_no, String dep_no, String serach_class_name) {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT  COUNT(DISTINCT(classes.class_no)) totalrows  FROM base_classes classes");
		sql.append(" LEFT JOIN base_major major ON major.`major_no` = classes.`major_no` ");
		sql.append(" LEFT JOIN base_teacher teacher ON teacher.`teacher_no` = classes.`teacher_no` ");
		sql.append(" LEFT JOIN base_student student ON student.`stu_no` = classes.`stu_no` ");
		sql.append(" LEFT JOIN base_department department ON department.`dep_no` = classes.`dep_no` ");
		sql.append("WHERE classes.`class_session_year` LIKE " + "'" + term_no.substring(0, 4) + "%'");
		if (!dep_no.equals("all")) {
			sql.append(" AND department.dep_no = " + "'" + dep_no + "'");
		}
		if (!TypeUtils.isEmpty(serach_class_name)) {
			sql.append(" AND classes.`class_name` LIKE " + "'%" + serach_class_name + "%'");
		}
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql.toString(), null, "");
		return result;
	}

	/**
	 * 批量添加课程
	 *
	 * @param list 课程list
	 * @return
	 */
	public ExecResult addBaseClassService(List<BaseClassesEntity> list) {
		logger.info("批量添加课程业务Begin >>>>>>");
		LinkedList<String> sqlList = new LinkedList<String>();
		for (BaseClassesEntity baseStudentEntity : list) {
			StringBuilder builder = new StringBuilder();
			builder.append("insert into base_classes"
					+ "(class_no,class_name,major_no,teacher_no,stu_no,dep_no,class_stu_amount,class_isover) values ( ");
			builder.append("'" + baseStudentEntity.getClass_no() + "', ");
			builder.append("'" + baseStudentEntity.getClass_name() + "', ");
			builder.append("'" + baseStudentEntity.getMajor_no() + "', ");
			builder.append("'" + baseStudentEntity.getTeacher_no() + "', ");
			builder.append("'" + baseStudentEntity.getStu_no() + "', ");
			builder.append("'" + baseStudentEntity.getDep_no() + "', ");
			builder.append("'" + baseStudentEntity.getClass_stu_amount() + "', ");
			builder.append("'" + baseStudentEntity.getClass_isover() + "', ");
			sqlList.add(builder.toString());
		}
		JSONResponse response = new JSONResponse();
		ExecResult result = response.getExecResult(sqlList, "添加课程成功", "添加课程失败");
		logger.info("批量添加课程业务状态End >>>>>>" + result.getResult() + "," + result.getMessage());
		return result;
	}

	/**
	 * 批量删除课程
	 *
	 * @param list 课程list
	 * @return
	 */
	public ExecResult delBaseClassService(List<BaseClassesEntity> list) {
		logger.info("批量删除课程业务Begin >>>>>>");
		LinkedList<String> sqlList = new LinkedList<String>();
		for (BaseClassesEntity baseClassesEntity : list) {
			StringBuilder builder = new StringBuilder();
			builder.append("DELETE FROM base_classes WHERE class_no= ");
			builder.append("'" + baseClassesEntity.getClass_no() + "'");
			sqlList.add(builder.toString());
		}
		JSONResponse response = new JSONResponse();
		ExecResult result = response.getExecResult(sqlList, "删除课程成功", "删除课程失败");
		logger.info("批量删除课程状态End >>>>>>" + result.getResult() + "," + result.getMessage());
		return result;
	}

	/**
	 * 根据班级号更新班级信息
	 *
	 * @param baseClassesEntity 班级类
	 * @return
	 */
	public ExecResult updateBaseClassService(BaseClassesEntity baseClassesEntity, String teacher_noT, String stu_noT) {
		logger.info("根据班级号更新班级信息业务Begin >>>>>>");
		ExecResult result = null;

		if (baseClassesEntity == null) {
			result = new ExecResult(false, "");
			return result;
		}else{
			if (!"1".equals(baseClassesEntity.getClass_isover())) {
				baseClassesEntity.setClass_isover("0");
			}
			StringBuilder sqlStr = new StringBuilder();
			sqlStr.append("UPDATE base_classes SET class_name= ");
			sqlStr.append("'" + baseClassesEntity.getClass_name() + "'");
			sqlStr.append(" ,major_no= ");
			sqlStr.append("'" + baseClassesEntity.getMajor_no() + "'");
			sqlStr.append(" ,teacher_no= ");
			sqlStr.append("'" + baseClassesEntity.getTeacher_no() + "'");
			sqlStr.append(" ,stu_no= ");
			sqlStr.append("'" + baseClassesEntity.getStu_no() + "'");
			sqlStr.append(" ,dep_no= ");
			sqlStr.append("'" + baseClassesEntity.getDep_no() + "'");
			sqlStr.append(" ,class_stu_amount= ");
			sqlStr.append("'" + baseClassesEntity.getClass_stu_amount() + "'");
			sqlStr.append(" ,class_isover= ");
			sqlStr.append("'" + baseClassesEntity.getClass_isover() + "'");
			sqlStr.append(" WHERE class_no= ");
			sqlStr.append("'" + baseClassesEntity.getClass_no() + "'");
			JSONResponse response = new JSONResponse();
			ExecResult r1 = response.getExecResult(sqlStr.toString(), null, "", "");
			if (r1.getResult() == 1) {
				if (baseClassesEntity.getTeacher_no().equals(teacher_noT) && baseClassesEntity.getStu_no().equals(stu_noT)) {
					return r1;
				}
				LoginServer ser = new LoginServer();

				//班主任角色自动添加
				JSONObject bzr_teacher = ser.getUserData(baseClassesEntity.getTeacher_no());
				JSONArray ts = bzr_teacher.getJSONArray("data");
				if (ts.size() > 0) {
					JSONObject bzr = ts.getJSONObject(0);
					String userid = bzr.getString("user_id");
					String existssql = "SELECT '9','" + userid + "' FROM tb_role_user a WHERE a.`user_id`='" + userid + "' AND a.`role_id`='9'";
					ExecResult existssql_rst = response.getSelectResult(existssql, null, null);
					if (existssql_rst.getResult() > 0 && existssql_rst.getData().size() > 0) {
						//return new ExecResult(true, "修改成功");
					}else {
						String insertsql = "insert into tb_role_user (user_id,role_id) values('" + userid + "','9')";
						ExecResult insertsql_rst = response.getExecResult(insertsql, null, null, null);
						if (insertsql_rst.getResult() > 0) {
							//return new ExecResult(true, "修改成功");
						} else {
							return new ExecResult(true, "保存失败");
						}
					}
				} else {
					return new ExecResult(true, "未找到班主任信息");
				}

				//信息员角色自动添加
				JSONObject xxy_stu = ser.getUserData(baseClassesEntity.getStu_no());
				JSONArray xxya = xxy_stu.getJSONArray("data");
				if (xxya.size() > 0) {
					JSONObject xxy = xxya.getJSONObject(0);
					String userid = xxy.getString("user_id");
					String existssql = "SELECT '8','" + userid + "' FROM tb_role_user a WHERE a.`user_id`='" + userid + "' AND a.`role_id`='8'";
					ExecResult existssql_rst = response.getSelectResult(existssql, null, null);
					if (existssql_rst.getResult() > 0 && existssql_rst.getData().size() > 0) {
						return new ExecResult(true, "修改成功");
					} else {
						String insertsql = "insert into tb_role_user (user_id,role_id) values('" + userid + "','8')";
						ExecResult insertsql_rst = response.getExecResult(insertsql, null, null, null);
						if (insertsql_rst.getResult() > 0) {
							return new ExecResult(true, "修改成功");
						} else {
							return new ExecResult(true, "保存失败");
						}
					}
				} else {
					return new ExecResult(true, "未找到班主任信息");
				}
			} else {
				return new ExecResult(false, "保存失败");
			}
		}
	}

	/**
	 * 根据部门号获取班级数据列表
	 * 
	 * @param dep_no
	 *            部门号(缺省all)
	 * @param pageLength
	 *            数量
	 * @param pageNumber
	 *            页码
	 * @return
	 */
	public ExecResult queryBaseClassListService(String dep_no, int pageLength, int pageNumber) {
		int start = pageNumber - 1;
		int length = pageLength;
		if (TypeUtils.isEmpty(dep_no) || dep_no.equals("all")) {
			StringBuilder sql = new StringBuilder();
			sql.append(
					"SELECT classes.*, major.major_name ,teacher.teacher_name ,student.stu_name,department.dep_name FROM base_classes AS classes  LEFT JOIN base_major major ON classes.major_no = major.major_no LEFT JOIN base_teacher teacher ON classes.teacher_no = teacher.teacher_no LEFT JOIN base_student student ON classes.stu_no = student.stu_no LEFT JOIN base_department department ON classes.dep_no = department.dep_no WHERE 1=1 ");
			if (length > 0) {
				sql.append(" limit " + (start * length) + "," + length);
			}
			JSONResponse jr = new JSONResponse();
			ExecResult result = jr.getSelectResult(sql.toString(), null, "");
			return result;
		} else {
			StringBuilder sql = new StringBuilder();
			sql.append(
					"SELECT classes.*, major.major_name ,teacher.teacher_name ,student.stu_name,department.dep_name FROM base_classes AS classes  LEFT JOIN base_major major ON classes.major_no = major.major_no LEFT JOIN base_teacher teacher ON classes.teacher_no = teacher.teacher_no LEFT JOIN base_student student ON classes.stu_no = student.stu_no LEFT JOIN base_department department ON classes.dep_no = department.dep_no WHERE classes.dep_no="
							+ "'" + dep_no + "'");
			if (length > 0) {
				sql.append(" limit " + (start * length) + "," + length);
			}
			// String[] params = new String[] { dep_no };
			JSONResponse jr = new JSONResponse();
			ExecResult result = jr.getSelectResult(sql.toString(), null, "");
			return result;
		}

	}

	/**
	 * 根据部门号获取班级列表总数
	 * 
	 * @param dep_no
	 *            部门号(缺省all)
	 * @return
	 */
	public ExecResult queryBaseClassListCountService(String dep_no) {
		if (TypeUtils.isEmpty(dep_no) || dep_no.equals("all")) {
			StringBuilder sql = new StringBuilder();
			sql.append(
					"SELECT COUNT(1) totalrows FROM base_classes AS classes  LEFT JOIN base_major major ON classes.major_no = major.major_no LEFT JOIN base_teacher teacher ON classes.teacher_no = teacher.teacher_no LEFT JOIN base_student student ON classes.stu_no = student.stu_no LEFT JOIN base_department department ON classes.dep_no = department.dep_no WHERE 1=1 ");
			JSONResponse jr = new JSONResponse();
			ExecResult result = jr.getSelectResult(sql.toString(), null, "");
			return result;
		} else {
			StringBuilder sql = new StringBuilder();
			sql.append(
					"SELECT COUNT(1) totalrows FROM base_classes AS classes  LEFT JOIN base_major major ON classes.major_no = major.major_no LEFT JOIN base_teacher teacher ON classes.teacher_no = teacher.teacher_no LEFT JOIN base_student student ON classes.stu_no = student.stu_no LEFT JOIN base_department department ON classes.dep_no = department.dep_no WHERE  department.dep_no= "
							+ "'" + dep_no + "'");
			JSONResponse jr = new JSONResponse();
			// String[] params = new String[] { dep_no };
			ExecResult result = jr.getSelectResult(sql.toString(), null, "");
			return result;
		}

	}

	/**
	 * 根据部门号搜索班级数据列表
	 * 
	 * @param dep_no
	 *            部门号(缺省all)
	 * @param pageLength
	 *            数量
	 * @param pageNumber
	 *            页码
	 * @param searchSql
	 *            模糊查询SQL
	 * @return
	 */
	public ExecResult searchBaseClassListService(String dep_no, int pageLength, int pageNumber, String searchSql) {
		int start = pageNumber - 1;
		int length = pageLength;
		if (TypeUtils.isEmpty(dep_no) || dep_no.equals("all")) {
			StringBuilder sql = new StringBuilder();
			sql.append(
					" dent.stu_no LEFT JOIN base_department department ON classes.dep_no = department.dep_no WHERE 1=1 ");
			sql.append(searchSql);
			if (length > 0) {
				sql.append(" limit " + (start * length) + "," + length);
			}
			JSONResponse jr = new JSONResponse();
			ExecResult result = jr.getSelectResult(sql.toString(), null, "");
			return result;
		} else {
			StringBuilder sql = new StringBuilder();
			sql.append(
					"SELECT classes.*, major.major_name ,teacher.teacher_name ,student.stu_name,department.dep_name FROM base_classes AS classes  LEFT JOIN base_major major ON classes.major_no = major.major_no LEFT JOIN base_teacher teacher ON classes.teacher_no = teacher.teacher_no LEFT JOIN base_student student ON classes.stu_no = student.stu_no LEFT JOIN base_department department ON classes.dep_no = department.dep_no WHERE classes.dep_no= "
							+ "'" + dep_no + "'");
			sql.append(searchSql);
			if (length > 0) {
				sql.append(" limit " + (start * length) + "," + length);
			}
			// String[] params = new String[] { dep_no };
			JSONResponse jr = new JSONResponse();
			ExecResult result = jr.getSelectResult(sql.toString(), null, "");
			return result;
		}
	}

	/**
	 * 根据部门号搜索班级列表总数
	 * 
	 * @param dep_no
	 *            部门号(缺省all)
	 * @param searchSql
	 *            模糊查询SQL
	 * @return
	 */
	public ExecResult searchBaseClassListCountService(String dep_no, String searchSql) {
		if (TypeUtils.isEmpty(dep_no) || dep_no.equals("all")) {
			StringBuilder sql = new StringBuilder();
			sql.append(
					"SELECT COUNT(1) totalrows FROM base_classes AS classes  LEFT JOIN base_major major ON classes.major_no = major.major_no LEFT JOIN base_teacher teacher ON classes.teacher_no = teacher.teacher_no LEFT JOIN base_student student ON classes.stu_no = student.stu_no LEFT JOIN base_department department ON classes.dep_no = department.dep_no WHERE 1=1 ");
			sql.append(searchSql);
			JSONResponse jr = new JSONResponse();
			ExecResult result = jr.getSelectResult(sql.toString(), null, "");
			return result;
		} else {
			StringBuilder sql = new StringBuilder();
			sql.append(
					"SELECT COUNT(1) totalrows FROM base_classes AS classes  LEFT JOIN base_major major ON classes.major_no = major.major_no LEFT JOIN base_teacher teacher ON classes.teacher_no = teacher.teacher_no LEFT JOIN base_student student ON classes.stu_no = student.stu_no LEFT JOIN base_department department ON classes.dep_no = department.dep_no WHERE  department.dep_no= "
							+ "'" + dep_no + "'");
			sql.append(searchSql);
			JSONResponse jr = new JSONResponse();
			// String[] params = new String[] { dep_no };
			ExecResult result = jr.getSelectResult(sql.toString(), null, "");
			return result;
		}
	}

	public ExecResult getyearInf() {
		String sql = " SELECT DISTINCT LEFT(term_startdate,4)AS year_no FROM base_term ORDER BY term_no DESC";
		JSONResponse js = new JSONResponse();
		ExecResult result = js.getSelectResult(sql, null, "base_term");
		return result; 
	}

	public Object getTeaStu(String classno) {
		// TODO Auto-generated method stub
		String sqlT ="SELECT teacher_no,teacher_name FROM base_teacher WHERE teacher_status='1'";
		JSONResponse jr = new JSONResponse();
		JSONArray teatb = jr.getSelectResult(sqlT, null, "base_teacher").getData(); 
		
		String sqlS ="SELECT a.stu_no,b.stu_name FROM base_term_student a LEFT JOIN base_student b ON b.stu_no=a.stu_no WHERE a.class_no='"+classno+"'  GROUP BY a.stu_no";
		JSONArray stutb = jr.getSelectResult(sqlS, null, "base_term_student").getData();
		
		JSONObject item = new JSONObject();
		 item.put("teatb", teatb); 
		 item.put("stutb", stutb);
		 JSONArray getresult = new JSONArray();
		 getresult.add(item);
		 ExecResult rep = new ExecResult();
		 rep.setResult(true);
		 rep.setMessage("");
		 rep.setData(getresult);
		return rep;
	}
    
	public ExecResult gettermnyearoinformation() {
		String sql ="SELECT class_session_year year_no FROM `base_classes`  GROUP BY class_session_year ORDER BY class_session_year DESC";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "");
		return result;
	}
	
	  
		public ExecResult importExcel(String term_no ,List<ImportFileClass> fileStudentEnts) {
			JSONResponse jr = new JSONResponse();
			//定义返回的message
			String result = "";
			String sql ="SELECT class_no FROM  base_classes";
			ExecResult r1 =jr.getSelectResult(sql, null, null);
			Map<String, String> clas_map = new HashMap<>();
			for (int i = 0; i < r1.getData().size(); i++) {
				clas_map.put(r1.getData().getJSONObject(i).get("class_no").toString(),r1.getData().getJSONObject(i).get("class_no").toString());
			}
			for (int i = 0; i < fileStudentEnts.size(); i++) {
				ImportFileClass fileClass = new ImportFileClass();
				fileClass = fileStudentEnts.get(i);
				String class_no = fileClass.getClass_no();
				if(ifClass_no(class_no, clas_map)){
					result += "第"+ (i+1) +"条记录班级编号重复\r\n</br> ";
					continue;
				}else{
					String sqlinsert = "INSERT INTO base_classes (class_no,class_name,major_no,teacher_no,stu_no,dep_no,class_stu_amount,class_isover,data_time,class_session_year) VALUES(''{0}'',''{1}'',''{2}'',''{3}'',''{4}'',''{5}'',''{6}'',''{7}'',DEFAULT,''{8}'')";
					String params[] = {fileClass.getClass_no(),fileClass.getClass_name(),fileClass.getMajor_no(),fileClass.getTeacher_no(),fileClass.getStu_no(),fileClass.getDep_no(),fileClass.getClass_stu_amount(),fileClass.getClass_isover(),term_no};
					ExecResult result2 = jr.getExecResult(sqlinsert, params,"第"+(i+1)+"条班级数据添加成功\r\n</br>","第"+(i+1)+"条班级数据添加失败\r\n</br>");
					if(result2.getResult()==0){
						result +=result2.getMessage();
					}
				}
			}
			if(result==""){
				result ="数据导入成功";
			}
			ExecResult r3=new ExecResult(true,result);
			return r3;
		}
		
		public boolean  ifClass_no(String calss_no ,Map<String, String> map){
			boolean flag = false;
			if (map.containsKey(calss_no)) {
				flag = true;
			}
			return flag;
		}


	//根据班级名称获取班级代码
	public ExecResult getclassNoByclassName(String className) {
		String sql ="SELECT a.`class_no` FROM base_classes a WHERE a.`class_name`='"+className+"'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "");
		return result;
	}
}
