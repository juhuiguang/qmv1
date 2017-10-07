package com.service.base;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;
import com.service.base.bean.ImportFileCourseEntityFinal;
import com.service.base.bean.ImportFileLgStuEntityFinal;

import sun.management.counter.Variability;


public class BaseCourseWHService {

	public Object getCourseData(String depno, String termno, String pagenum, String times) {
		// TODO Auto-generated method stub
		String sql = "";
		int ys = (Integer.valueOf(pagenum))*(Integer.valueOf(times));
		ExecResult result = null;
		if (depno.equals("all")) {
			sql = "SELECT a.*,b.teacher_name,c.class_name FROM base_teach_task a LEFT JOIN base_teacher b ON b.teacher_no=a.teacher_no LEFT JOIN base_classes c ON c.class_no=a.class_no WHERE a.term_no='"+termno+ "' GROUP BY a.course_no,a.teacher_no,a.class_no ORDER BY a.course_no LIMIT "+ys+","+pagenum+"";
		} else {
			sql = "SELECT a.*,b.teacher_name,c.class_name FROM base_teach_task a LEFT JOIN base_teacher b ON b.teacher_no=a.teacher_no LEFT JOIN base_classes c ON c.class_no=a.class_no WHERE a.term_no='"+termno+"' AND a.dep_no='"+depno+"' GROUP BY a.course_no,a.teacher_no,a.class_no ORDER BY a.course_no LIMIT "+ys+","+pagenum+"";
		}   
		JSONResponse jr = new JSONResponse();
		result = jr.getSelectResult(sql, null, "base_teach_task");
		return result;
	}

	public Object getLogicClassData(String taskno, String termno, String lgtimes, String lgpagenum) {
		// TODO Auto-generated method stub
		int ys = (Integer.valueOf(lgpagenum))*(Integer.valueOf(lgtimes));
		String sql = "SELECT a.*,b.stu_name,b.stu_status,c.term_name,d.course_name FROM base_class_logic a LEFT JOIN base_student b ON b.stu_no=a.student_no LEFT JOIN base_term c ON c.term_no=a.term_no LEFT JOIN base_teach_task d ON d.course_no=a.course_no WHERE a.task_no='"+taskno+ "' AND a.term_no='"+termno+ "' AND (stu_name<>NULL OR stu_name<>'') AND (stu_status<>NULL OR stu_status<>'') LIMIT "+ys+","+lgpagenum+"";
		String sqltotal = "SELECT COUNT(DISTINCT (a.student_no)) AS total FROM base_class_logic a LEFT JOIN base_student b ON b.stu_no=a.student_no LEFT JOIN base_term c ON c.term_no=a.term_no LEFT JOIN base_teach_task d ON d.course_no=a.course_no WHERE a.task_no='"+taskno+"' AND a.term_no='"+termno+"' AND (stu_name<>NULL OR stu_name<>'') AND (stu_status<>NULL OR stu_status<>'')";
		JSONObject jo = new JSONObject();                    
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_class_logic");
		ExecResult result2 = jr.getSelectResult(sqltotal, null, "base_class_logic");
		jo.put("lgdata", result);
		jo.put("lgtotal", result2);
		return jo;
	}   

	public Object delLogicClassData(String taskno, String stuno, String termno) {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM base_class_logic WHERE student_no='" + stuno+ "' AND term_no='" + termno + "' AND task_no='" + taskno + "'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(sql, null, "", "");
		return result;
	}

	public Object SearchlgClassStuData(String taskno, String termno) {
		// TODO Auto-generated method stub
		String sql = "SELECT DISTINCT a.stu_no,a.stu_name,b.class_no,c.class_name FROM base_student a LEFT JOIN base_term_student b ON a.stu_no=b.stu_no LEFT JOIN base_classes c ON b.class_no=c.class_no WHERE a.stu_no NOT IN (SELECT student_no FROM base_class_logic WHERE term_no='"+ termno+ "' AND task_no='"+ taskno+ "') AND a.stu_status='1' AND c.class_isover='0'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_student");
		return result;
	}

	public Object AddlgClassStuData(String taskno, String stuno, String termno,
			String logicno, String logicname, String courseno) {
		// TODO Auto-generated method stub
		String sqlS = "SELECT * FROM base_class_logic WHERE term_no='" + termno+ "' AND task_no='" + taskno + "' AND student_no='" + stuno+ "'";
		JSONResponse jre = new JSONResponse();
		ExecResult resultS = jre.getSelectResult(sqlS, null, "");
		if (resultS.getData().size() == 0) {
			String sql = "INSERT INTO base_class_logic (term_no,student_no,task_no,logic_no,logic_name,course_no) VALUES ('"+termno+"','"+stuno+"','"+taskno+"','"+logicno+"','"+logicname+"','"+courseno+"')";
			JSONResponse jr = new JSONResponse();
			ExecResult result = jr.getExecResult(sql, null, "新学生添加成功！","很抱歉，该学生添加失败！");
			return result;
		} else {
			return resultS;
		}
	}

	public Object delClassData(String taskno, String termno) {
		// TODO Auto-generated method stub
		JSONResponse jr = new JSONResponse();
		String sqldelSche = "";
		String sqldelTask = "";
		ExecResult result = null;
		String sqlSelSche = "SELECT * FROM base_task_sche WHERE task_no='"+ taskno + "'";
		ExecResult resultS = jr.getSelectResult(sqlSelSche, null, "");
		
		String sqlSelTask = "SELECT * FROM base_teach_task WHERE task_no='"+ taskno + "' AND term_no='" + termno + "'";
		ExecResult resultS2 = jr.getSelectResult(sqlSelTask, null, "");
		if (resultS.getData().size() > 0) {
			sqldelSche = "DELETE FROM base_task_sche WHERE task_no='" + taskno+ "'";
			result = jr.getExecResult(sqldelSche, null, "删除该课程节次数据成功！","删除该课程节次数据失败！");
		} else if(resultS2.getData().size() < 1){
			return new ExecResult(false, "没有找到该课程对应的节次数据 及课程数据！"); 
		}
		if (resultS2.getData().size() == 1) {
			sqldelTask = "DELETE FROM base_teach_task WHERE task_no='" + taskno+ "' AND term_no='" + termno + "'";
			result = jr.getExecResult(sqldelTask, null, "删除该课程数据成功！","删除该课程数据失败！");
		} else {
			return new ExecResult(false, "没有找到该课程数据！");
		} 
		return result;  

	}

	public Object getCourseTaskInfroData(String taskno, String termno) {
		// TODO Auto-generated method stub
		String sql = "SELECT a.*,b.sche_no,b.sche_set,b.sche_addr,c.teacher_name,c.teacher_status,e.class_name FROM base_teach_task a LEFT JOIN base_task_sche b ON a.task_no=b.task_no LEFT JOIN base_teacher c ON a.teacher_no=c.teacher_no LEFT JOIN base_classes e ON e.class_no=a.class_no WHERE a.task_no='"
				+ taskno + "' AND a.term_no='" + termno + "'";
		JSONResponse jre = new JSONResponse();
		ExecResult result = jre.getSelectResult(sql, null, "");
		return result;
	}

	public Object delCourseTaskSche(String taskno, String scheno) {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM base_task_sche WHERE sche_no='" + scheno
				+ "' AND task_no='" + taskno + "'";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(sql, null, "删除该课程节次数据成功！",
				"删除该课程节次数据失败！");
		return result;
	}

	public Object getTeasClassesAllData() {
		// TODO Auto-generated method stub
		JSONResponse jr = new JSONResponse();
		String sqlTeas = "SELECT teacher_no,teacher_name FROM base_teacher WHERE teacher_status='1'";
		JSONArray teas = jr.getSelectResult(sqlTeas, null, "base_teacher")
				.getData();

		String sqlClasses = "SELECT class_no,class_name FROM base_classes WHERE class_isover='0'";
		JSONArray classes = jr
				.getSelectResult(sqlClasses, null, "base_classes").getData();

		JSONObject item = new JSONObject();
		item.put("teas", teas);
		item.put("classes", classes);
		JSONArray getresult = new JSONArray();
		getresult.add(item);

		ExecResult rep = new ExecResult();
		rep.setResult(true);
		rep.setMessage("");
		rep.setData(getresult);
		return rep;
	}

	public Object UpdCourseInfroData(String taskno, String termno,
			String teano, String classno, String coursename, String coursetype,
			String courseweek, JSONObject courseInfo) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentdateString = sdf.format(new Date());
		ExecResult result = null;
		String flag = "1"; 
		String updsql = "UPDATE base_teach_task SET course_name='" + coursename+ "',teacher_no='" + teano + "',course_type='" + coursetype+ "',course_week='"+courseweek+"',class_no='" + classno + "',data_time='"+ currentdateString + "' WHERE task_no='" + taskno+ "' AND term_no='" + termno + "'";

		if (courseInfo.keySet().size() != 0) {
			Set<String> set = courseInfo.keySet();
			Iterator<String> iterator = set.iterator();
			List<String> sqlList = new ArrayList<String>();
			while (iterator.hasNext()) {
				String sche_no = iterator.next();
				/*
				 * System.out.println(courseInfo.getString(sche_no).split("-o-")[0]);
				 * System.out.println(courseInfo.getString(sche_no).split("-o-")[1]);
				 */
				String sche_set = "";
				String sche_addr = "";
				String sche_info[] = courseInfo.getString(sche_no).split("-o-");
				sche_set = sche_info[0];
				if (sche_info.length > 1) {
					sche_addr = sche_info[1];
				}
				// 修改
				/*
				 * String sqlString ="UPDATE base_task_sche SET sche_set='"+courseInfo.getString(sche_no).split("-o-")[0]+"',sche_addr='"+courseInfo.getString(sche_no).split("-o-")[1]+"' WHERE sche_no='"+sche_no +"' AND task_no='"+taskno+"'";
				 */
				// 添加
				String sqlString = "";

				if(sche_addr.equals("undefined")){
					flag = "2";
					continue;    
				} else if(sche_addr == "") {
					sqlString = "INSERT INTO base_task_sche (task_no,sche_set,data_time) VALUES('"+taskno+"','"+sche_set+"','"+currentdateString+"')";
				} else { 
					sqlString = "INSERT INTO base_task_sche (task_no,sche_set,sche_addr,data_time) VALUES('"+taskno+"','"+sche_set+"','"+sche_addr+"','"+currentdateString+"')";
				}

				sqlList.add(sqlString);
			}
			JSONResponse jr = new JSONResponse();
			ExecResult task_rep = jr.getExecResult(updsql, null, "", "");
			if (task_rep.getResult() > 0) {
				if(!(jr.getExecResult(sqlList, "", "").getResult() > 0) && flag != "2") {  
					result = new ExecResult(true, "新增节次信息添加失败！");
				} else {
					result = new ExecResult(true, "新增节次信息添加成功！");
				}
			} else {
				result = new ExecResult(false, "课程相关信息修改失败！");
			}
		} else {
			JSONResponse jr = new JSONResponse();
			ExecResult task_rep = jr.getExecResult(updsql, null, "", "");
			if (task_rep.getResult() > 0) {
				result = new ExecResult(true, "课程相关信息修改成功！");
			} else {
				result = new ExecResult(false, "课程相关信息修改失败！");
			}
		}
		return result;
	}

	public Object getSearchCourseData(String depno, String termno,
			String searchval, String pagenum, String times) {
		// TODO Auto-generated method stub
		String sql = "";
		int ys = (Integer.valueOf(pagenum))*(Integer.valueOf(times)); 
		ExecResult result = null;
		if (depno.equals("all")) {
			sql = "SELECT a.*,b.teacher_name,c.class_name FROM base_teach_task a LEFT JOIN base_teacher b ON b.teacher_no=a.teacher_no LEFT JOIN base_classes c ON c.class_no=a.class_no WHERE a.term_no='"+ termno+ "' AND (a.course_name LIKE '%"+ searchval+ "%' OR a.course_type LIKE '%"+ searchval+ "%' OR a.teacher_no LIKE '%"+ searchval+ "%' OR b.teacher_name LIKE '%"+ searchval+ "%' OR c.class_name LIKE '%"+ searchval+ "%') ORDER BY a.course_no  LIMIT "+ys+","+pagenum+"";
		} else {
			sql = "SELECT a.*,b.teacher_name,c.class_name FROM base_teach_task a LEFT JOIN base_teacher b ON b.teacher_no=a.teacher_no LEFT JOIN base_classes c ON c.class_no=a.class_no WHERE a.term_no='"+ termno+ "' AND a.dep_no='"+ depno+ "' AND (a.course_name LIKE '%"+ searchval+ "%' OR a.course_type LIKE '%"+ searchval+ "%' OR a.teacher_no LIKE '%"+ searchval+ "%' OR b.teacher_name LIKE '%"+ searchval+ "%' OR c.class_name LIKE '%"+ searchval+ "%') ORDER BY a.course_no  LIMIT "+ys+","+pagenum+"";
		}
		JSONResponse jr = new JSONResponse();
		result = jr.getSelectResult(sql, null, "base_teach_task");
		return result;
	}

	public Object InsCourseInforData(String termno, String courseno,
			String coursename, String courseteano, String coursetype,
			String courseattr, String courseweek, String courseccount,
			String coursescount, JSONObject courseclassno,
			JSONObject coursescheInfor, String coursedep) {
		// TODO Auto-generated method stub
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentdateString = sdf.format(new Date());
	//	ExecResult result = new ExecResult(true,"插入成功");
		ExecResult result = new ExecResult(true,""); 
		JSONResponse jr = new JSONResponse();
		
		if(courseclassno.toString().equals("{}") && coursetype.equals("任选课")) {
			System.out.println("ddd"+courseclassno);           
			
			String selSql = "SELECT * FROM base_teach_task WHERE course_no='"+courseno+"' AND term_no='"+termno+"' AND teacher_no='"+courseteano+"' AND class_no IS NULL";
			ExecResult result3 = jr.getSelectResult(selSql, null, "base_teach_task");
			
			if (result3.getData().size() == 0) {
				String insertSql = "INSERT INTO base_teach_task (term_no,course_no,course_name,teacher_no,course_type,course_attr,course_week,course_ccount,course_scount,class_no,dep_no,data_time) VALUES('"+termno+"','"+courseno+"','"+coursename+"','"+courseteano+"','"+coursetype+"','"+courseattr+"','"+courseweek+"','"+courseccount+"','"+coursescount+"','','"+coursedep+"','"+currentdateString+"')";
				ExecResult course = jr.getExecInsertId(insertSql, null, "", "");
				if (course.getResult() > 0) {
					String task_no = course.getMessage();
					if(coursescheInfor==null){
						result = new ExecResult(true, "没有从表数据");
					} else {
						Set<String> set2 = coursescheInfor.keySet();
						Iterator<String> iterator2 = set2.iterator();
						List<String> sqlList = new ArrayList<String>();
						while (iterator2.hasNext()) {
							String scheno = iterator2.next();
							String sche_set = "";
							String sche_addr = "";
							
							String sche_info[] = coursescheInfor.getString(scheno).split("-o-");
							if(sche_info.length > 1) {
								sche_addr = sche_info[1];
							}
							String insScheSql = "";
							if(sche_addr.equals("undefined")){
							//	flag = "2";
								continue;    
							} else if(sche_addr == null || sche_addr == "") {
								insScheSql = "INSERT INTO base_task_sche (task_no,sche_set,data_time) VALUES('"+task_no+"','"+sche_set+"','"+currentdateString+"')";				
							} else {
								insScheSql = "INSERT INTO base_task_sche (task_no,sche_set,sche_addr,data_time) VALUES('"+task_no+"','"+sche_set+"','"+sche_addr+"','"+currentdateString+"')";
							}
							sqlList.add(insScheSql);
						}           
						if (sqlList.size() > 0) { 
							if (!(jr.getExecResult(sqlList, "", "").getResult() > 0)) {
								result = new ExecResult(false, "插入从表失败");

							}
						}
					}
				} else {
					result = new ExecResult(false, "插入主表失败");
				}
			} else {  
				return result3 = new ExecResult(false,"本学期此教师在该班的课程已存在，不能重复添加！");
			}
			return result;
		} else if(!(courseclassno.toString().equals("{}"))) {
			System.err.println("uuuuuuuuuuuuu"); 
			int index = 0;
			Set<String> set = courseclassno.keySet();
			Iterator<String> iterator = set.iterator();
			while (iterator.hasNext()) {
				ExecResult result3 = new ExecResult(true,"");
				index++;
				
				String class_no = iterator.next();
				System.err.println("mmmmm"+class_no); 
				System.err.println("iiiiiiiiiiiiiii"+courseclassno.getString(class_no));    
				if(courseclassno.getString(class_no) ==null && coursetype.equals("任选课")) {                                   
					/*String selSql = "SELECT * FROM base_teach_task WHERE course_no='"+courseno+"' AND term_no='"+termno+"' AND teacher_no='"+courseteano+"' AND class_no IS NULL";
					result3 = jr.getSelectResult(selSql, null, "base_teach_task");*/
					continue;  
				}else if(courseclassno.getString(class_no) == null && !(coursetype.equals("任选课"))) {
					continue;             
					 
				} else { 
					String selSql = "SELECT * FROM base_teach_task WHERE course_no='"+courseno+"' AND term_no='"+termno+"' AND teacher_no='"+courseteano+"' AND class_no='"+courseclassno.getString(class_no)+"'";
					result3 = jr.getSelectResult(selSql, null, "base_teach_task");
				}

				if (result3.getData().size() == 0) {
					String insertSql = "";
					if(courseclassno.getString(class_no) == null) {
						insertSql = "INSERT INTO base_teach_task (term_no,course_no,course_name,teacher_no,course_type,course_attr,course_week,course_ccount,course_scount,class_no,dep_no,data_time) VALUES('"+termno+"','"+courseno+"','"+coursename+"','"+courseteano+"','"+coursetype+"','"+courseattr+"','"+courseweek+"','"+courseccount+"','"+coursescount+"','','"+coursedep+"','"+currentdateString+"')";
					} else {
						insertSql = "INSERT INTO base_teach_task (term_no,course_no,course_name,teacher_no,course_type,course_attr,course_week,course_ccount,course_scount,class_no,dep_no,data_time) VALUES('"+termno+"','"+courseno+"','"+coursename+"','"+courseteano+"','"+coursetype+"','"+courseattr+"','"+courseweek+"','"+courseccount+"','"+coursescount+"','"+courseclassno.getString(class_no)+"','"+coursedep+"','"+currentdateString+"')";
					}
					 
					ExecResult course = jr.getExecInsertId(insertSql, null, "", "");
					if (course.getResult() > 0) {
						String task_no = course.getMessage();
						
						if(coursescheInfor==null){
							if(coursetype.equals("实训课")){
								String insSXSql = "INSERT INTO base_task_sche (task_no,sche_set,data_time) VALUES('"+task_no+"','K99','"+currentdateString+"')";	
								if(jr.getExecInsertId(insSXSql, null, "", "").getResult() > 0){
									return result = new ExecResult(true , "实训课信息插入成功");
								}
								return result = new ExecResult(false , "实训课信息插入失败");
							}else{
								result = new ExecResult(true, "没有从表数据");
							}
						}else{
							Set<String> set2 = coursescheInfor.keySet();
							Iterator<String> iterator2 = set2.iterator();
							List<String> sqlList = new ArrayList<String>();
							while (iterator2.hasNext()) {
								String scheno = iterator2.next();
								String sche_set = "";
								String sche_addr = "";
								
								String sche_info[] = coursescheInfor.getString(scheno).split("-o-");
								sche_set = coursetype.equals("实训课") ? "K99" : sche_info[0];
								if(sche_info.length > 1) {
									sche_addr = sche_info[1];
								}
								String insScheSql = "";
								System.out.println("eeeeeeeeeeeee"+sche_addr);   
								if(sche_addr.equals("undefined")){
									
								//	flag = "2"; 
									continue;    
								}else if(sche_addr == null || sche_addr == "") {
									insScheSql = "INSERT INTO base_task_sche (task_no,sche_set,data_time) VALUES('"+task_no+"','"+sche_set+"','"+currentdateString+"')";				
								} else {
									insScheSql = "INSERT INTO base_task_sche (task_no,sche_set,sche_addr,data_time) VALUES('"+task_no+"','"+sche_set+"','"+sche_addr+"','"+currentdateString+"')";
								}
								sqlList.add(insScheSql);
							}           
							if (sqlList.size() > 0) {
								if (!(jr.getExecResult(sqlList, "", "").getResult() > 0)) {
									result = new ExecResult(false, "插入从表" + index + "失败");
									break;
								}
							}
						}
					} else {
						result = new ExecResult(false, "插入主表" + index + "失败");
						break;
					}
				} else {  
					return result3 = new ExecResult(false,"本学期此教师在该班的课程已存在，不能重复添加！");
				}
					
			}
		}
		return result;
		
	}
	
	
	
    JSONResponse jsonResponse = new JSONResponse();
    //部门map
    Map<String, String> dep_map = new HashMap<>();
 	//班级map
    Map<String, String> class_map = new HashMap<>();
    //教师map
    Map<String, String> tea_map = new HashMap<>();
    //数字map
    Map<String, String> num_map = new HashMap<>();
    //节次map
    Map<String, String> JC_map = new HashMap<>();
	public String importExcelt(List<ImportFileCourseEntityFinal> list,String term_no) {
		num_map.put("一", "1");
		num_map.put("二", "2");
		num_map.put("三", "3");
		num_map.put("四", "4");
		num_map.put("五", "5");
		num_map.put("六", "6");
		num_map.put("七", "7");
		JC_map.put("1-2","1");
		JC_map.put("3-4","2");
		JC_map.put("5-6","3");
		JC_map.put("7-8","4");
		JC_map.put("9-10","5");
		String result  =""; 
		//取部门信息
	    getDepInfo();
	    //取班级信息
	    getClassInfo();
	    //取教师信息
	    getTeacherInfo();
	  
	    for (int i = 0; i < list.size(); i++) {
	    	ImportFileCourseEntityFinal tempCourseEntity = list.get(i);
	    	String courseInfo[] =  JXcourse(tempCourseEntity.getCourse_no());
	    	String teacherInfo[] =  JXcourse(tempCourseEntity.getTeacher());
	    	String classInfo[] = tempCourseEntity.getCourse_class().split(" ");
	    	//如果部门不存在
	    	String task_no="";
	    	String dep_name ="";
	    	String dep_no = "";
	    	String course_type="";
	    	String teacher_no =""; 
	    	String course_sche="K";
	    	String course_attr=tempCourseEntity.getCourse_type2();
	    	String course_week = tempCourseEntity.getWeek();
	    	String course_addr = tempCourseEntity.getCourse_place();
	    	boolean flag = false;
	    	if (!(tempCourseEntity.getCourse_class().equals("null") || tempCourseEntity.getCourse_class().equals(""))) {
	    		for (int j = 0; j < classInfo.length; j++) {
		    		/*System.out.println(classInfo[j]);*/
		    		if(!isInsert(classInfo[j], class_map)){
		    			result +="第"+(i+1)+"条记录班级不存在，无法添加</br>";
		    			flag = true;
		    			break;
		    		}
				}
			}
	    	
	    	//只要存在一个班级不存在，就停止此次循环
	    	if(flag){
	    		continue;
	    	}
	    	if (!isInsert(tempCourseEntity.getDep_name(),dep_map)) {
	    		result +="第"+(i+1)+"条记录部门错误，无法添加</br>";
	    		continue;
			}else{
				dep_name = tempCourseEntity.getDep_name();
				dep_no = dep_map.get(dep_name);
				teacher_no = teacherInfo[0];
			}
	    	//如果tea_map中不存在这个教师,则插入
	    	if(!isInsert(teacherInfo[0], tea_map)){
	    	     	String sql = "INSERT INTO `base_teacher` (teacher_no,teacher_name,dep_no,teacher_status) VALUES('"+teacherInfo[0]+"','"+teacherInfo[1]+"','"+dep_no+"','1')";
	    	        ExecResult e2 = jsonResponse.getExecResult(sql, null, null, null);
	    	        if(e2.getResult() == 0){
	    	        	result +="第"+(i+1)+"条记录新教师添加失败，无法添加</br>";
	    	        	continue;
	    	        }
	    	}
	    	if("任选课".equals(tempCourseEntity.getCourse_type1()) && (tempCourseEntity.getCourse_class().equals("null") || tempCourseEntity.getCourse_class().equals(""))){
	    		course_type="任选课";
	    		course_sche+=JXJC(tempCourseEntity.getSection());
	    	}else if("实训课".equals(tempCourseEntity.getCourse_type1())){
	    		course_type="实训课";
	    		course_sche+="99";
	    	}else {
	    		course_type="讲授课";
	    		course_sche+=JXJC(tempCourseEntity.getSection());
			}
	    	//一切准备就绪，插入课程
	    	if (tempCourseEntity.getCourse_class().equals("null") || tempCourseEntity.getCourse_class().equals("")) {
	    		String InsertCourse = "INSERT INTO `base_teach_task` (term_no,course_no,course_name,teacher_no,course_type,course_attr,course_week,course_ccount,course_scount,class_no,dep_no) VALUES ('"+term_no+"','"+courseInfo[0]+"','"+courseInfo[1]+"','"+teacherInfo[0]+"','"+course_type+"','"+course_attr+"','"+course_week+"','"+tempCourseEntity.getClass_hour()+"','"+tempCourseEntity.getCourse_account()+"','','"+dep_no+"')";
	    		ExecResult e3 = jsonResponse.getExecInsertId(InsertCourse, null, null, null);
	    		if(e3.getResult()==0){
	    			result +="第"+(i+1)+"条记录课程表插入错误，无法添加</br>";
	    			continue;
	    		}else {
	    			task_no = e3.getMessage();
	    			String InsertSche = "INSERT INTO `base_task_sche` (task_no,sche_set,sche_addr) VALUES ('"+task_no+"','"+course_sche+"','"+course_addr+"')";
	    			ExecResult e4 = jsonResponse.getExecInsertId(InsertSche, null, null, null);
	    			if(e4.getResult()==0){
	    				result +="第"+(i+1)+"条记录课信息表插入错误，无法添加</br>";
	    				continue;
	    			}
	    		}
			}else {
				for (int j = 0; j < classInfo.length; j++) {
					String class_no = class_map.get(classInfo[j]);
					String InsertCourse = "INSERT INTO `base_teach_task` (term_no,course_no,course_name,teacher_no,course_type,course_attr,course_week,course_ccount,course_scount,class_no,dep_no) VALUES ('"+term_no+"','"+courseInfo[0]+"','"+courseInfo[1]+"','"+teacherInfo[0]+"','"+course_type+"','"+course_attr+"','"+course_week+"','"+tempCourseEntity.getClass_hour()+"','"+tempCourseEntity.getCourse_account()+"','"+class_no+"','"+dep_no+"')";
		    		ExecResult e3 = jsonResponse.getExecInsertId(InsertCourse, null, null, null);
		    		if(e3.getResult()==0){
		    			result +="第"+(i+1)+"条记录课程表插入错误，无法添加</br>";
		    			continue;
		    		}else {
		    			task_no = e3.getMessage();
		    			String InsertSche = "INSERT INTO `base_task_sche` (task_no,sche_set,sche_addr) VALUES ('"+task_no+"','"+course_sche+"','"+course_addr+"')";
		    			ExecResult e4 = jsonResponse.getExecInsertId(InsertSche, null, null, null);
		    			if(e4.getResult()==0){
		    				result +="第"+(i+1)+"条记录课信息表插入错误，无法添加</br>";
		    				continue;
		    			}
		    		}
				}
			}
	    }
		return result;
	}
	
	//获得部门信息
	public void getDepInfo(){
		String sql = "SELECT dep_no ,dep_name FROM `base_department`";
		ExecResult e1 = jsonResponse.getSelectResult(sql, null, null);
		JSONArray ja = e1.getData();
		for (int i = 0; i <ja.size() ; i++) {
			dep_map.put(ja.getJSONObject(i).getString("dep_name"), ja.getJSONObject(i).getString("dep_no"));
		}
	}
	//MAP的比对
	public boolean isInsert(String temp,Map<String, String> tempmap){
		if (tempmap.containsKey(temp)) {
			return true;
		}else{
			return false;
		}
	}
	//获得班级信息
		public void getClassInfo(){
			String sql = "SELECT class_no,class_name FROM `base_classes` ";
			ExecResult e1 = jsonResponse.getSelectResult(sql, null, null);
			JSONArray ja = e1.getData();
			for (int i = 0; i <ja.size() ; i++) {
				class_map.put(ja.getJSONObject(i).getString("class_name"), ja.getJSONObject(i).getString("class_no"));
			}
		}
	//获得教师信息
		public void getTeacherInfo(){
			String sql = "SELECT teacher_no,teacher_name FROM `base_teacher`";
			ExecResult e1 = jsonResponse.getSelectResult(sql, null, null);
			JSONArray ja = e1.getData();
			for (int i = 0; i <ja.size() ; i++) {
				tea_map.put(ja.getJSONObject(i).getString("teacher_no"), ja.getJSONObject(i).getString("teacher_name"));
			}
		}
	//解析字段方法
	public String[] JXcourse(String course){
		course = course.substring(1,course.length());
		String courseT[] = course.split("]");
		return courseT;
	}
	//班级记录解析
	public String[] JXClassCourse(String JXclass){
		return null;
	}
	//解析节次
	public String  JXJC(String jc){
		String result = "";
		String course_Sche[] = jc.split("\\[");
		String temp1 = num_map.get(course_Sche[0]);
		String temp2 = "";
		if (Integer.parseInt(course_Sche[1].substring(0,1))>8) {
			temp2 =JC_map.get(course_Sche[1].substring(0, 4));
		}else{
			temp2 =JC_map.get(course_Sche[1].substring(0, 3));
		}
		if (temp2==null || temp2=="") {
			System.out.println(course_Sche[1].substring(0, 3));
		}
		result = temp1;
		result += temp2;
		return result;
	}
	public boolean ifinsert(String class_no,List<String> list,Map<String, List<String>> map){
		int n=0;
		boolean flag = false;
		if(map.containsKey(class_no)){
			List<String> temp = new ArrayList<>();
			temp = map.get(class_no);
			for(int i=0;i<temp.size();i++){
				if(temp.get(i).equals(list.get(i))){
					n++;
				}
			}
		}
		if(n==3){
			flag = true;
		}
		return flag;
	}

	public String importLgStuExcelt(List<ImportFileLgStuEntityFinal> fileLgstuEnts, String term_no,String task_no,String course_no) {
		String result = "";
		String sql="SELECT * FROM `base_class_logic`  GROUP BY logic_no";
		JSONResponse jo = new JSONResponse();
		ExecResult r1 = jo.getSelectResult(sql, null, null);
		Map<String, List<String>> map =new HashMap<>();
		for(int i=0;i<r1.getData().size();i++){
			JSONObject jObject = r1.getData().getJSONObject(i);
			List<String>list = new ArrayList<>();
			list.add(jObject.getString("term_no"));
			list.add(jObject.getString("task_no"));
			list.add(jObject.getString("student_no"));
			map.put(jObject.getString("logic_no"), list);
		}
		for (int i = 0; i < fileLgstuEnts.size(); i++) {
			ImportFileLgStuEntityFinal importFileLgStuEntityFinal = new ImportFileLgStuEntityFinal();
			importFileLgStuEntityFinal = fileLgstuEnts.get(i);
		    List<String> list = new ArrayList<>();
		    list.add(term_no);
		    list.add(task_no);
		    list.add(importFileLgStuEntityFinal.getStudent_no());
		    String logic_no = importFileLgStuEntityFinal.getLogic_no();
		    if (ifinsert(logic_no, list, map)) {
		    	result +="第"+(i+1)+"条记录重复，无法添加</br>";
			}else{
				String insertLogic = "INSERT INTO `base_class_logic` VALUES(''{0}'',''{1}'',''{2}'',''{3}'',''{4}'',''{5}'')";
				String params[] = {term_no,importFileLgStuEntityFinal.getStudent_no(),task_no,importFileLgStuEntityFinal.getLogic_no(),importFileLgStuEntityFinal.getLogic_name(),course_no};
				ExecResult r3 = jo.getExecResult(insertLogic, params);
				if (r3.getResult()==0) {
					result +="第"+(i+1)+"条记录插入失败</br>";
				}
			}
		}
		return result;
	}


}
