package com.service.teacher;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;
import com.service.system.SystemStart;
import com.service.teacher.bean.ScheObject;
import com.service.teacher.bean.TaskClassObject;
import com.service.teacher.bean.TaskObject;
import com.sys.LoginServer;

public class ListenService {
	private static Logger logger = Logger.getLogger(LoginServer.class);
	
	public ExecResult getTeachers(String teachername){
		String sql="select teacher_name as title,teacher_no as description,dep_no as dep_no from base_teacher where exists(select 1 from base_teach_task where base_teacher.teacher_no=base_teach_task.teacher_no and base_teach_task.term_no='"+
					SystemStart.getSys().getString("term_no")
				+"') and teacher_status=1 order by teacher_name";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"base_teacher");
		return result;
	}
	
	public JSONArray getTasks(String type,String keywords,String dep_no){
/*		String sql="SELECT  b.task_no,e.dep_name,b.`teacher_no`,b.`course_name`,c.`teacher_name`,b.`course_type`,b.`class_no`,d.`class_name`,a.`sche_set`,a.`sche_addr` "+
				"FROM base_task_sche a,base_teach_task b,base_teacher c,base_classes d,base_department e "+
				"WHERE a.`task_no`=b.`task_no` AND b.`teacher_no`=c.`teacher_no` AND b.`class_no`=d.`class_no` and c.dep_no=e.dep_no "+
				"AND b.`term_no`='"+SystemStart.getSys().getString("term_no")+"' ";*/
				//"AND (SUBSTRING(sche_set,2,1)='2' OR SUBSTRING(sche_set,2,1)='0') "+
				//"ORDER BY c.teacher_name,b.course_name ";
		String sql = "SELECT a.task_no,a.teacher_no,a.course_name,a.course_no,a.course_type,a.class_no,b.teacher_name,c.sche_set,c.sche_addr,d.dep_name,e.class_name FROM base_teach_task a LEFT JOIN base_teacher b ON a.teacher_no=b.teacher_no LEFT JOIN base_task_sche c ON c.task_no=a.task_no LEFT JOIN base_department d ON b.dep_no=d.dep_no LEFT JOIN base_classes e ON e.class_no=a.class_no WHERE  a.term_no='"+SystemStart.getSys().getString("term_no")+"' ";
		if(type.equals("teacher")){    
			sql+=" AND b.teacher_name ='"+keywords+"'";
		}else if(type.equals("week")){
			sql+=" AND (SUBSTRING(sche_set,2,1)='"+keywords+"' OR SUBSTRING(sche_set,2,1)='0') ";
		}else{
			sql+=" AND a.teacher_no = '"+keywords+"'";
		}   
/*		if(!dep_no.equalsIgnoreCase("ALL")){      
			sql+=" AND c.dep_no = '"+dep_no+"'";
		}*/                                  
//		sql+=" GROUP BY a.course_no ORDER BY b.teacher_name,a.course_name ";   
		sql+=" ORDER BY b.teacher_name,a.course_name ";       
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, null,"tb_tasks");
		if(result.getResult()>0){
			return result.getData();
		}else{
			return new JSONArray();
		}
	}
	
	
	public List<TaskObject> genTaskObject(JSONArray tasks){
		List<TaskObject> result=new ArrayList<TaskObject>();
		if(tasks.size()==0) return result;
		//第一次循环，构建教师-课程 列表tasks
		for(int i=0;i<tasks.size();i++){
			TaskObject task=new TaskObject();
			JSONObject item=tasks.getJSONObject(i);
			task.setCourse_name(item.getString("course_name"));
			task.setCourse_no(item.getString("course_no"));
			task.setCourse_type(item.getString("course_type"));
			task.setTeacher_no(item.getString("teacher_no"));
			task.setTeacher_name(item.getString("teacher_name"));
			task.setDep_no(item.getString("dep_no"));
			task.setDep_name(item.getString("dep_name"));
			boolean isExists=false;
			for(int j=0;j<result.size();j++){
				TaskObject to=result.get(j);
				if(to.getTeacher_no().equals(task.getTeacher_no()) && to.getCourse_name().equals(task.getCourse_name())){
					isExists=true;
					break;
				}else{
					continue;
				}
			}
			if(!isExists){
				result.add(task);
			}
			
		}
		
		//第二次循环，为教师-课程列表中添加班级。
		for(int i=0;i<tasks.size();i++){
			JSONObject item=tasks.getJSONObject(i);
			TaskClassObject classta=new TaskClassObject();
			classta.setClass_name(item.getString("class_name"));
			classta.setClass_no(item.getString("class_no"));
			classta.setTask_no(item.getString("task_no"));
			String teacher_no=item.getString("teacher_no");
			String course_name=item.getString("course_name");
			setClass(teacher_no,course_name,classta,result);
		}
		
		//第三次循环，为教师-课程列表中添加班级。
		for(int i=0;i<tasks.size();i++){
			JSONObject item=tasks.getJSONObject(i);
			ScheObject scheta=new ScheObject();
			scheta.setSche_addr(item.getString("sche_addr"));
			scheta.setTask_no(item.getString("task_no"));
			//解析节次
			String kk=item.getString("sche_set");
			scheta.setSche_set(kk);
			String teacher_no=item.getString("teacher_no");
			String course_name=item.getString("course_name");
			String class_no=item.getString("class_no");
			setSche(teacher_no,course_name,class_no,scheta,result);
		}
		return result;
		
	}
	
	private void setClass(String teacher_no,String course_name,TaskClassObject classta,List<TaskObject> tasks){
		for(int i=0;i<tasks.size();i++){
			TaskObject to=tasks.get(i);
			//找到对应的教师-课程
			if(to.getCourse_name().equals(course_name)&&to.getTeacher_no().equals(teacher_no)){
				List<TaskClassObject>classes=to.getClasses();
				if(classes==null)classes=new ArrayList<TaskClassObject>();
				//如果已经存在班级列表数据
				if(classes.size()>0){
					boolean isexists=false;
					for(int j=0;j<classes.size();j++){
						TaskClassObject classobj=classes.get(j);
						//如果已经存在当前这个班级
						if(classobj.getClass_no().equals(classta.getClass_no())){
							isexists=true;
							break;
						}
					}
					//如果不存在这个班级
					if(!isexists){
						classes.add(classta);
					}
				}else{
					classes.add(classta);
				}
				to.setClasses(classes);
				break;
			}else{
				continue;
			}
		}
	}
	
	private void setSche(String teacher_no,String course_name,String class_no,ScheObject scheta,List<TaskObject> tasks){
		for(int i=0;i<tasks.size();i++){
			TaskObject to=tasks.get(i);
			//找到对应的教师-课程
			if(to.getCourse_name().equals(course_name)&&to.getTeacher_no().equals(teacher_no)){
				List<TaskClassObject>classes=to.getClasses();
				for(int j=0;j<classes.size();j++){
					TaskClassObject co=classes.get(j);
					//如果是对应的班级
					if(co.getClass_no().equals(class_no)){
						List<ScheObject> sos=co.getSches();
						if(sos==null)sos=new ArrayList<ScheObject>();
						if(sos.size()>0){
							boolean isexists=false;
							for(int k=0;k<sos.size();k++){
								ScheObject so=sos.get(k);
								if(so.getSche_set().equals(scheta.getSche_set())){
									isexists=true;
									break;
								}
							}
							if(!isexists){
								sos.add(scheta);
							}
						}else{
							sos.add(scheta);
						}
						co.setSches(sos);
						break;
					}else{
						continue;
					}
				}
				break;
			}else{
				continue;
			}
		}
	}
	
	public ExecResult getMarkTeacher(String teacher){
		String term_no=SystemStart.getSys().getString("term_no");
		String sql="SELECT a.teacher_no,b.`teacher_name` FROM qm_master_mark a,base_teacher b "+
							"WHERE a.term_no=''{0}'' AND b.`teacher_no`=a.teacher_no and a.master_teacher_no=''{1}''";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql, new String[]{term_no,teacher},"tb_tasks");
		return result;
	}
	
	public ExecResult getMasterPlan(String week,String master_no){
		String currentterm=SystemStart.getSys().getString("term_no");
		String sql="SELECT b.`task_no`,a.`plan_time`,a.`plan_week`,b.`course_name`,b.`course_type`,c.`teacher_name`,d.`class_name`,b.`course_attr` FROM qm_master_listen_plan a ,base_teach_task b ,base_teacher c,base_classes d "+
							"WHERE a.`task_no`=b.`task_no` AND b.`teacher_no`=c.`teacher_no` AND b.`class_no`=d.`class_no` "+
							"AND a.`term_no`='"+currentterm+"' AND a.`teacher_no`='"+master_no+"' AND a.`plan_week`='"+week+"' ";
		
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql,null,"tb_plan");
		return result;
	}

	public ExecResult judgeSupLisBut() {
		// TODO Auto-generated method stub
		String sql = "SELECT term_tk FROM base_term WHERE term_no='"+SystemStart.getSys().getString("term_no")+"'";
		JSONResponse jr=new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_term");
		return result; 
	}

	public Object getSinglCourseFileData(String termno, String courseno,
			String teano) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM qm_teacher_course_file WHERE term_no='"+termno+"' AND course_no='"+courseno+"' AND teacher_no='"+teano+"'";
		JSONResponse jr=new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_term");
		return result; 
	}
	
}
