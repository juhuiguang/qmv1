package com.service.app;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.jhg.utils.Azdg;
import com.service.system.SystemService;
import com.service.system.SystemStart;
import com.service.teacher.ListenService;
import com.service.teacher.bean.TaskObject;
import com.sys.LoginServer;

public class AppAction extends Action {
//	public void demo(){
////		String stu_no = request.getParameter("stu_no");
////		String stu_name = request.getParameter("stu_name");
////		
////		AppService service = new AppService();
////
////		try {
////			response.getWriter()
////					.write(JSONObject.toJSONString(service.demo(stu_no, stu_name )));
////		} catch (IOException e) {
////			// TODO Auto-generated catch block
////			e.printStackTrace();
////		}
//		String stu_no = request.getParameter("stu_no");
//		String class_no = request.getParameter("class_no");
//		
//		AppService service = new AppService();
//
//		try {
//			response.getWriter()
//					.write(JSONObject.toJSONString(service.demo2(stu_no,class_no )));
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
	/**
	 * 用户登录
	 * 
	 * @param loginname
	 * @param loginpwd
	 */
	public void Login() {
//		String loginname = request.getParameter("loginname");
//		String loginpwd = request.getParameter("loginpwd");
//
//		System.out.println(loginname);
//		System.out.println(loginpwd);
//		ExecResult er = null;
//		if (TypeUtils.isEmpty(loginname) || TypeUtils.isEmpty(loginpwd)) {
//			er = new ExecResult(true, "用户名或密码不正确！");
//			er.setErrorCode(1);
//			er.setErrormsg("用户名或密码不正确！");
//		} else {
//			LoginServer ser = new LoginServer();
//			List<Map<String, Object>> usrlist = null;
//			try {
//				usrlist = ser.getUserData(loginname);
//			} catch (Exception e) {
//				er = new ExecResult(false, "查询用户名错误");
//			}
//			if (!TypeUtils.isEmpty(usrlist)){
//				Map<String, Object> usermap = usrlist.get(0);
//				String pwd = TypeUtils.getString(usermap.get("USER_PWD"));
//				if (new Azdg().decrypt(pwd).equals(loginpwd)){
//					er = new ExecResult(true, "登录成功");
//					JSONObject user = null;
//					try {
//						user = SystemStart.getUser(TypeUtils.getString(usermap.get("USER_LOGINNAME")));
//						user.remove("menu");
//					} catch (Exception e) {
//						er = new ExecResult(false, "用户信息提取错误错误");
//					}
//					JSONArray result = new JSONArray();
//					result.add(user);
//					er.setData(result);
//				} else {
//
//					er = new ExecResult(true, "用户名或密码不正确！");
//					er.setErrorCode(1);
//					er.setErrormsg("用户名或密码不正确！");
//				}
//			} else {
//				er = new ExecResult(true, "您输入的用户名不存在！");
//				er.setErrorCode(1);
//				er.setErrormsg("您输入的用户名不存在！");
//			}
//		}
//
//		try {
//			response.getWriter().write(JSONObject.toJSONString(er));
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
	}

	/**
	 * 考勤主界面
	 * 
	 * @param currentWeek
	 *            周次
	 * @param teacher_no
	 *            教工号
	 * @param term_no
	 *            学年学期
	 */
	public void checkInfo() {
		String currentWeek = request.getParameter("currentWeek");
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no");
		AppService service = new AppService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.checkInfo(currentWeek, teacher_no, term_no)));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 考勤从界面
	 * 
	 * @param check_main_no
	 *            考勤从表id
	 * @param class_no
	 *            班级编码
	 * @param term_no
	 *            学年学期
	 * @param course_type
	 *            课程类型
	 */
	public void StudentCheckInfo() {
		String check_main_no = request.getParameter("check_main_no");
		String class_no = request.getParameter("class_no");
		String term_no = request.getParameter("term_no");
		String course_type = request.getParameter("course_type");
		AppService service = new AppService();
		try {
			response.getWriter().write(
					JSONObject.toJSONString(service.StudentCheckInfo(check_main_no, class_no, term_no, course_type)));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 得到当前周、学期等信息
	 */
	public void currentInfo() {
		SystemService service = new SystemService();
		ExecResult result = null;
		try {
			result = service.getCurrentTerm();
		} catch (Exception e1) {
			result = new ExecResult(false, "提取数据异常");
			try {
				response.getWriter().write(JSONObject.toJSONString(result));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if (result.getResult() > 0) {
			result.setMessage("当前信息提取成功");
		} else {
			result = new ExecResult(true, "当前信息提取失败");
		}
		try {
			response.getWriter().write(JSONObject.toJSONString(result));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 得到院系表
	 */
	public void departmentInfo() {
		AppService service = new AppService();

		try {
			response.getWriter().write(JSONObject.toJSONString(service.departmentInfo()));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 得到当前听课标准
	 * 
	 * @param term_no
	 *            学年学期
	 */
	public void teacherListenStandard() {
		AppService service = new AppService();
		String term_no = request.getParameter("term_no");
		try {
			response.getWriter().write(JSONObject.toJSONString(service.teacherListenStandard(term_no)));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 关注的教师及课程
	 * 
	 * @param teacher_no
	 *            登陆人教工号
	 * @param term_no
	 *            学年学期
	 * @param paginal
	 *            页码(1,2,3......)
	 * @param amount
	 *            每页数量(如果为0 则不分页)
	 */
	public void getAttentionTea() {
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no");
		String paginalString = request.getParameter("paginal");
		String amountString = request.getParameter("amount");
		int paginal = -1;
		int amount = 0;
		if (paginalString != null) {
			paginal = Integer.parseInt(paginalString);
		}
		if (amountString != null) {
			amount = Integer.parseInt(amountString);
		}
		AppService service = new AppService();
		ListenService service_ = new ListenService();
		JSONArray tasks = null;
		ExecResult er = new ExecResult();
		try {
			tasks = service.getAttentionTea(teacher_no, term_no);
		} catch (Exception e1) {
			er = new ExecResult(false, "提取数据异常");
			try {
				response.getWriter().write(er.toString());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	
		if (tasks.size() > 0) {
			List<TaskObject> tos = null;
			try {
				tos = service_.genTaskObject(tasks);
			} catch (Exception e) {
				er = new ExecResult(false, "提取数据异常");
				try {
					response.getWriter().write(er.toString());
				} catch (IOException err) {
					// TODO Auto-generated catch block
					err.printStackTrace();
				}
			}

			if (amount > 0 && paginal >= 0) {
				List<TaskObject> result = new ArrayList<TaskObject>();
				int begin = (paginal - 1) * amount;
				int end = (paginal) * amount;
				int size = tos.size();
				if (begin >= size) {
					er = new ExecResult(false, "超过页数上限");
				} else {
					if (size < end) {
						end = size;
					}
					for (; begin < end; begin++) {
						result.add(tos.get(begin));
					}
					er.setResult(true);
					er.setMessage("提取该天次教学任务成功");
					er.setData(JSONArray.parseArray(JSONArray.toJSONString(result)));
				}
			} else {
				er.setResult(true);
				er.setMessage("提取该天次教学任务成功");
				er.setData(JSONArray.parseArray(JSONArray.toJSONString(tos)));
			}
		} else {
			er = new ExecResult(true, "没有我关注的教师");
		}

		try {
			response.getWriter().write(er.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 根据周几查询教学任务
	 * 
	 * @param weekDay
	 *            天次（1，2，3，4，5，6，7）
	 * @param dep_no
	 *            部门编号
	 * @param paginal
	 *            页码(1,2,3......)
	 * @param amount
	 *            每页数量(如果为0 则不分页)
	 */
	public void getTeaByWeek() {
		String dep_no = request.getParameter("dep_no");
		String weekDay = request.getParameter("weekDay");
		String paginalString = request.getParameter("paginal");
		String amountString = request.getParameter("amount");
		int paginal = -1;
		int amount = 0;
		if (paginalString != null) {
			paginal = Integer.parseInt(paginalString);
		}
		if (amountString != null) {
			amount = Integer.parseInt(amountString);
		}
		ListenService service = new ListenService();
		AppExecResult er = new AppExecResult();
		JSONArray tasks = null;
		try {
			tasks = service.getTasks("week", weekDay, dep_no);
		} catch (Exception e1) {
			er = new AppExecResult(false, "提取数据异常");
			try {
				response.getWriter().write(er.toString());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		List<TaskObject> tos = null;
		if (tasks.size() > 0) {
			
			try {
				tos = service.genTaskObject(tasks);
			} catch (Exception e) {
				er = new AppExecResult(false, "提取数据异常");
				try {
					response.getWriter().write(er.toString());
				} catch (IOException err) {
					// TODO Auto-generated catch block
					err.printStackTrace();
				}
			}

			//
			if (amount > 0 && paginal >= 0) {
				List<TaskObject> result = new ArrayList<TaskObject>();
				int begin = (paginal - 1) * amount;
				int end = (paginal) * amount;
				int size = tos.size();
				if (begin >= size) {
					er = new AppExecResult(false, "超过页数上限");
				} else {
					if (size < end) {
						end = size;
					}
					for (; begin < end; begin++) {
						result.add(tos.get(begin));
					}
					er.setResult(true);
					er.setMessage("提取该天次教学任务成功");
					er.setData(JSONArray.parseArray(JSONArray.toJSONString(result)));
				}
			} else {
				er.setResult(true);
				er.setMessage("提取该天次教学任务成功");
				er.setData(JSONArray.parseArray(JSONArray.toJSONString(tos)));
				
			}

		} else {
			er = new AppExecResult(true, "该天次教学任务为空");
		}
		er.setLength(tos.size());
		try {
			response.getWriter().write(er.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 根据教师查询教学任务
	 * 
	 * @param teacher_name
	 *            登陆人姓名
	 * @param dep_no
	 *            部门编号
	 * @param paginal
	 *            页码(1,2,3......)
	 * @param amount
	 *            每页数量(如果为0 则不分页)
	 */
	public void getTeaByTeacher() {
		String dep_no = request.getParameter("dep_no");
		String teacher_name = request.getParameter("teacher_name");
		String paginalString = request.getParameter("paginal");
		String amountString = request.getParameter("amount");
		int paginal = -1;
		int amount = 0;
		if (paginalString != null) {
			paginal = Integer.parseInt(paginalString);
		}
		if (amountString != null) {
			amount = Integer.parseInt(amountString);
		}

		ListenService service = new ListenService();
		AppExecResult er = new AppExecResult();
		JSONArray tasks = null;
		try {
			tasks = service.getTasks("teacher", teacher_name, dep_no);
		} catch (Exception e1) {
			er = new AppExecResult(false, "提取数据异常");
			try {
				response.getWriter().write(er.toString());
			} catch (IOException err) {
				// TODO Auto-generated catch block
				err.printStackTrace();
			}
		}
		List<TaskObject> tos = null;
		if (tasks.size() > 0) {
			
			try {
				tos = service.genTaskObject(tasks);
			} catch (Exception e) {
				er = new AppExecResult(false, "提取数据异常");
				try {
					response.getWriter().write(er.toString());
				} catch (IOException err) {
					// TODO Auto-generated catch block
					err.printStackTrace();
				}
			}
			if (amount > 0 && paginal >= 0) {
				List<TaskObject> result = new ArrayList<TaskObject>();
				int begin = (paginal - 1) * amount;
				int end = (paginal) * amount;
				int size = tos.size();
				if (begin >= size) {
					er = new AppExecResult(false, "超过页数上限");
				} else {
					if (size < end) {
						end = size;
					}
					for (; begin < end; begin++) {
						result.add(tos.get(begin));
					}
					er.setResult(true);
					er.setMessage("提取该天次教学任务成功");
					er.setData(JSONArray.parseArray(JSONArray.toJSONString(result)));
				}
			} else {
				er.setResult(true);
				er.setMessage("提取该天次教学任务成功");
				er.setData(JSONArray.parseArray(JSONArray.toJSONString(tos)));
			}
		} else {
			er = new AppExecResult(true, "该天次教学任务为空");
		}
		er.setLength(tos.size());
		try {
			response.getWriter().write(er.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 提取常用语
	 * 
	 * @param teacher_no
	 *            登陆人教工号
	 * @param key 
	 * 			提取标志   (comment评价 /   suggest建议   / "" 全部)
	 */
	public void getConfig() {
		String teacher_no = request.getParameter("teacher_no");
		String key = request.getParameter("key");
		key = (key==null)?"":key;
		AppService service = new AppService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.getConfig(teacher_no ,key)));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获得听课表内容
	 * 
	 * @param teacher_no
	 *            登陆人教工号
	 * @param task_no
	 *            教学任务编号
	 * @param listen_time
	 *            听课时间 YYYY-MM-DD
	 */
	public void getListenInfo() {
		String teacher_no = request.getParameter("teacher_no");
		String task_no = request.getParameter("task_no");
		String listen_time = request.getParameter("listen_time");
		AppService service = new AppService();

		try {
			response.getWriter()
					.write(JSONObject.toJSONString(service.getListenInfo(teacher_no, task_no, listen_time)));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 学生考勤状态提交（总表）
	 * 
	 * @param check_main_no
	 *            主表ID (提取接口已提供)
	 * @param check_kk
	 *            旷课人数
	 * @param check_cd
	 *            迟到人数
	 * @param check_zt
	 *            早退人数
	 * @param check_qj
	 *            请假人数
	 * @param check_count
	 *            班级总人数
	 * @param check_ration
	 *            出勤率 （到勤人数 + 请假人数）/总人数
	 * @param check_sx
	 *            实训节次（没有为空）
	 */
	public void postMainCheckInfo() {
		String check_main_no = request.getParameter("check_main_no");
		String check_kk = request.getParameter("check_kk");
		String check_cd = request.getParameter("check_cd");
		String check_zt = request.getParameter("check_zt");
		String check_qj = request.getParameter("check_qj");
		String check_count = request.getParameter("check_count");
		String check_ratio = request.getParameter("check_ratio");
		String check_sx = request.getParameter("check_sx");
		AppService service = new AppService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.postMainCheckInfo(check_main_no, check_kk,
					check_cd, check_zt, check_qj, check_count, check_ratio, check_sx)));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 学生考勤状态提交（从表）
	 * 
	 * @param check_main_no
	 *            主表ID (提取接口已提供)
	 * @param stu_no
	 *            学生学号
	 * @param check_status
	 *            学生考勤状态(迟到/旷课/早退/请假/到勤)
	 */
	public void postStuCheckInfo() {
		String check_main_no = request.getParameter("check_main_no");
		String stu_no = request.getParameter("stu_no");
		String check_status = request.getParameter("check_status");
		AppService service = new AppService();
		try {
			response.getWriter()
					.write(JSONObject.toJSONString(service.postStuCheckInfo(check_main_no, stu_no, check_status)));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 听课表保存
	 * 
	 * @param listen_no
	 *            听课表主键(没有置空)
	 * @param teacher_no
	 *            听课督导教工号
	 * @param task_no
	 *            听课课程编号
	 * @param jxjy
	 *            教学建议
	 * @param skpj
	 *            听课评价
	 * @param per
	 *            各项得分（**-**-**-** 用-相隔字符串）
	 */
	public void postListenInfo() {
		String listen_no = request.getParameter("listen_no");
		if (listen_no == null) {
			listen_no = "";
		}
		String teacher_no = request.getParameter("teacher_no");
		String task_no = request.getParameter("task_no");
		String jxjy = request.getParameter("jxjy");
		String skpj = request.getParameter("skpj"); 
		String per = request.getParameter("per"); 
		String listen_time = request.getParameter("listen_time");
		AppService service = new AppService();
		try { 
			response.getWriter().write(
					JSONObject.toJSONString(service.postListenInfo(listen_no, teacher_no, task_no, jxjy, skpj, per ,listen_time)));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 模糊查询教师/可标识出关注教师
	 * 
	 * @param keyWord
	 *            查询关键字
	 * @param dep_no
	 *            部门编号
	 * @param teacher_no 
	 * 			督导教工号
	 * @param term_no
	 * 			学年学期
	 */
	public void getTeacherName() {
		String keyWord = request.getParameter("keyWord");
		String dep_no = request.getParameter("dep_no");
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no");
		String flag = request.getParameter("flag"); 
		teacher_no = (teacher_no==null)?"":teacher_no;
		term_no = (term_no==null)?"":term_no;
		AppService service = new AppService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.getTeacherName(keyWord, dep_no , teacher_no ,term_no )));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 考勤从表切换周次
	 * 
	 * @param selectWeek
	 *            选中的周次
	 * @param sche_no
	 *            课次编号
	 * @param class_no 
	 *            班级编码
	 * @param course_type
	 *            课程类型
	 * @param term_no
	 *            学年学期
	 */
	public void studentCheckWeekInfo(){
		String selectWeek = request.getParameter("selectWeek");
		String sche_no = request.getParameter("sche_no");
		String class_no = request.getParameter("class_no");
		String course_type = request.getParameter("course_type");
		
		String term_no = request.getParameter("term_no");
		

		AppService service = new AppService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.studentCheckWeekInfo(selectWeek, sche_no ,class_no ,course_type ,term_no)));
		}catch (IOException e){
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 获取考勤记录
	 * @param teacher_no
	 *            登陆人教工号
	 * @param selectWeek 
	 * 				周次
	 * @param term_no
	 * 			学年学期
	 * 
	 */
	public void getCheckRecord(){
		String selectWeek = request.getParameter("selectWeek");
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no");
		selectWeek = (selectWeek==null)?"":selectWeek;
		AppService service = new AppService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.getCheckRecord(selectWeek,teacher_no,term_no)));
		}catch (IOException e){
			e.printStackTrace();
		}
	}
	
	/**
	 * 添加常用语
	 * @param teacher_no
	 *            督导教工号
	 * @param key 
	 * 			  comment添加评价    suggest建议
	 * @param content 
	 * 				内容
	 */
	public void setConfig(){
		String content = request.getParameter("content");
		String key = request.getParameter("key");
		String teacher_no = request.getParameter("teacher_no");
		AppService service = new AppService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.setConfig(content,key,teacher_no)));
		}catch (IOException e){
			e.printStackTrace();
		}
	}
	
	/**
	 * 删除常用语
	 * @param config_no 
	 * 			常用语主键
	 */
	public void removeConfig(){
		String config_no = request.getParameter("config_no");
		AppService service = new AppService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.removeConfig(config_no)));
		}catch (IOException e){
			e.printStackTrace();
		}
	}

	/**
	 * 提取关注教师
	 * @param teacher_no
	 * 			督导教工号
	 * @param term_no
	 */
	public void getMarkTeacher(){
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no");
		AppService service = new AppService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.getMarkTeacher(teacher_no , term_no)));
		}catch (IOException e){
			e.printStackTrace();
		}
	}
	/**
	 * 关注教师添加/取消
	 * @param master_teacher_no
	 * 			督导教工号
	 * @param teacher_no
	 * 			关注教师教工号
	 * @param term_no
	 * 			学年学期
	 */
	public void changeMarkStatus(){
		String master_teacher_no = request.getParameter("master_teacher_no");
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no");
		AppService service = new AppService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.changeMarkStatus(master_teacher_no , teacher_no , term_no)));
		}catch (IOException e){
			e.printStackTrace();
		}
	}
	
	/**
	 * 教师查看个人被听课记录
	 * @param teacher_no
	 * 			教师教工号
	 * @param term_no
	 * 			学年学期
	 */
	public void getOwnListenInfo(){
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no");
		AppService service = new AppService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.getOwnListenInfo(teacher_no , term_no)));
		}catch (IOException e){
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 督导查看个人听课情况
	 * @param teacher_no
	 * 			督导教工号
	 * @param term_no
	 * 			学年学期
	 * @param paginal
	 *            页码(1,2,3......)
	 * @param amount
	 *            每页数量(如果为0 则不分页)
	 */
	public void getMasterOwnListenInfo(){
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no"); 
		String paginalString = request.getParameter("paginal");
		String amountString = request.getParameter("amount"); 
		
		int paginal = -1;
		int amount = 0;
		if (paginalString != null) {
			paginal = Integer.parseInt(paginalString);
		}
		if (amountString != null) {
			amount = Integer.parseInt(amountString);
		}
		AppService service = new AppService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.getMasterOwnListenInfo(teacher_no , term_no ,paginal,amount)));
		}catch (IOException e){
			e.printStackTrace();
		}
	}
	
	/**
	 * 督导删除个人听课情况
	 * @param listen_no 听课记录主键
	 */
	public void removeMasterOwnListenInfo(){
	
		String listen_no = request.getParameter("listen_no");
	
		
		AppService service = new AppService();
		try {
			response.getWriter().write(JSONObject.toJSONString(service.removeMasterOwnListenInfo(listen_no)));
		}catch (IOException e){
			e.printStackTrace();
		}
	}
	/**
	 * 教师所有课程缺勤查询
	 * @param teacher_no 教工号
	 * @param term_no 学年学期
	 */
	public void getTeacherCheckInfo(){
		String teacher_no = request.getParameter("teacher_no");
		String term_no = request.getParameter("term_no"); 
		AppService service = new AppService();
		
		try {
			response.getWriter().write(JSONObject.toJSONString(service.getTeacherCheckInfo(teacher_no,term_no)));
		}catch (IOException e){
			e.printStackTrace();
		}
		
	}
	/**
	 * 修改密码
	 * @param loginname 登陆号
	 * @param userdname 登陆名称(用户登陆时候获得)
	 * @param oldPass 旧密码
	 * @param newPass 新密码
	 */
	public void changeUserPwd(){
		SystemService service=new SystemService();
		String userNanme = request.getParameter("userdname");
		String loginName = request.getParameter("loginname"); 
		String oldPass = request.getParameter("oldPass");
		String newPass = request.getParameter("newPass");
		
		ExecResult result=service.changeUserPass(userNanme ,loginName, oldPass, newPass);
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 意见反馈
	 * @param user 登陆账号
	 * @param area 内容
	 * @param qq 
	 * @param email 
	 */
	public void userFeedBack(){
		SystemService service=new SystemService();
		String userno = request.getParameter("user");
		String area = request.getParameter("area");
		String qq = request.getParameter("qq");
		String email = request.getParameter("email");
		String result = "";
	
		ExecResult rep = (ExecResult)service.savaUserFeedBack(userno,area,qq,email);
		if(rep.getResult() > 0){
			rep.setMessage("意见返回成功");
		}else{
			rep= new ExecResult(false , "意见返回失败");
		}
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 缺勤相信信息
	 * @param task_no

	 */
	public void getTeacherCheckDetail(){
		AppService service = new AppService();
		
		String task_no = request.getParameter("task_no");
		String result = "";
	
		ExecResult rep = (ExecResult)service.getTeacherCheckDetail(task_no);
		
		try {
			response.getWriter().write(rep.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 获得历史版本信息
	 * url:http://210.28.101.76/QualityMonitor2/version.json
	 */
	
	/*
	 * 取得所有教师信息
	 */
	public void getAllTeacher(){
		AppService service = new AppService();
		ExecResult rep = (ExecResult)service.getAllTeacher();
		
		try {
			response.getWriter().write(rep.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/*
	 * 取得部门老师信息
	 */
	public void getDepTeacher(){
		AppService service = new AppService();
		String dep_no = request.getParameter("dep_no");
		ExecResult rep = (ExecResult)service.getDepTeacher(dep_no);
		try {
			response.getWriter().write(rep.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 取得某个老师信息  根据教工号
	 */
	public void getTeacherByID(){
		AppService service = new AppService();
		String teacher_no = request.getParameter("teacher_no");
		ExecResult rep = (ExecResult)service.getTeacherByID(teacher_no);
		try {
			response.getWriter().write(rep.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 取得某个老师信息  根据教工号
	 */
	public void getTeacherByName(){
		AppService service = new AppService();
		String teacher_name = request.getParameter("teacher_name");
		ExecResult rep = (ExecResult)service.getTeacherByName(teacher_name);
		try {
			response.getWriter().write(rep.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/*
	 * 根据专业查询班级
	 */
	public void getClassByMajor(){
		AppService service = new AppService();
		String major_no = request.getParameter("major_no");
		ExecResult rep = (ExecResult)service.getClassByMajor(major_no);
		try {
			response.getWriter().write(rep.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/*
	 * 根据院系查询
	 */
	public void getClassByDep(){
		AppService service = new AppService();
		String dep_no = request.getParameter("dep_no");
		ExecResult rep = (ExecResult)service.getClassByDep(dep_no);
		try {
			response.getWriter().write(rep.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/*
	 * 根据班级名称查询班级
	 */
	public void getClassByName(){
		AppService service = new AppService();
		String class_name = request.getParameter("class_name");
		ExecResult rep = (ExecResult)service.getClassByName(class_name);
		try {
			response.getWriter().write(rep.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/*
	 * 根据年级查询班级
	 */
	public void getClassByGrade(){
		AppService service = new AppService();
		String grade = request.getParameter("grade");
		ExecResult rep = (ExecResult)service.getClassByGrade(grade);
		try {
			response.getWriter().write(rep.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/*
	 * 改变班级专业
	 */
	public void changeClassMajor(){
		AppService service = new AppService();
		String class_no = request.getParameter("class_no");
		String major_no = request.getParameter("major_no");
		ExecResult rep = (ExecResult)service.changeClassMajor(class_no,major_no);
		try {
			response.getWriter().write(rep.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 
	 */
	public void getClassByDepAndYear(){
		AppService service = new AppService();
		String dep_no = request.getParameter("dep_no");
		String year = request.getParameter("year");
		String limitYear = request.getParameter("limitYear");
		ExecResult rep = (ExecResult)service.getClassByDepAndYear(dep_no,year,limitYear);
		try {
			response.getWriter().write(rep.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 
	 */
	public void getClassByMajorAndYear(){
		AppService service = new AppService();
		String major_no = request.getParameter("major_no");
		String year = request.getParameter("year");
		ExecResult rep = (ExecResult)service.getClassByMajorAndYear(major_no,year);
		try {
			response.getWriter().write(rep.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
