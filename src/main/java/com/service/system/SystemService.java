package com.service.system;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;
import com.jhg.utils.Azdg;
import com.service.system.bean.MenuObject;
import com.sys.LoginServer;

public class SystemService {
	private static Logger logger = Logger.getLogger("SystemService");

	/**
	 * 获得当前学期
	 * 
	 * @return
	 */
	public ExecResult getCurrentTerm() {
		String sql = "SELECT *,floor((TO_DAYS(NOW())-TO_DAYS(term_startdate)) /7)+1 currentweek FROM base_term WHERE term_status=1";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_term");
		return result;
	}
	
	public ExecResult refreshCurrentWeek(){
		String sql = "SELECT floor((TO_DAYS(NOW())-TO_DAYS(term_startdate)) /7)+1 currentweek FROM base_term WHERE term_status=1";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_term");
		return result;
	}

	/**
	 * 检查姓名、学号、教工号是否已经被注册
	 * 
	 * @param name
	 *            姓名
	 * @param no
	 *            教工号学号
	 * @param type
	 *            用户类型：学生，教师
	 * @return
	 */
	private boolean checkIsUser(String no, String type) {
		String sql = "select * from tb_user where user_loginname=''{0}'' and user_type=''{1}''";
		String[] params = new String[] { no, type };

		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "tb_user");
		if (result.getResult() == 0) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 检查姓名、学号、教工号是否存在
	 * 
	 * @param no
	 *            教工号学号
	 * @return
	 */
	private boolean checkIsUser(String no) {
		String sql = "select * from tb_user where user_loginname=''{0}''";
		String[] params = new String[] { no };
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "tb_user");
		if (result.getResult() == 0) {
			return false;
		} else {
			return true;
		}
	}

	private boolean checkUserInfo(String name, String no, String type) {
		String sql = "";
		if (!type.equals("学生")) {
			sql = "select * from base_teacher where teacher_no=''{0}'' and teacher_name=''{1}''";
		} else {
			sql = "select * from base_student where stu_no=''{0}'' and stu_name=''{1}''";
		}
		String[] params = new String[] { no, name };
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "tb_base_user");
		if (result.getData().size() > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	
	/**
	 * 创建登录用户，并根据角色名称自动绑定角色
	 * @param name 用户姓名
	 * @param no 教工号或学号
	 * @param pwd 登录密码，默认 123456
	 * @param type 角色名称，如果是非学生类用户，会自动创建为教师用户。
	 * @return
	 */
	public ExecResult createUser(String name, String no, String pwd, String type) {
		String usertype="学生";
		if(!type.equals("学生")){
			usertype="教师";
		}
		if (!this.checkIsUser(no, usertype)) {
			logger.error("用户信息已经注册，不可以重复注册");
			return new JSONResponse().getError("用户【" + no + "】，在系统中已经注册，请输入密码登录。");
		} else if (!this.checkUserInfo(name, no, usertype)) {
			logger.error("用户信息输入错误，系统中不存在该用户。");
			return new JSONResponse().getError("用户【" + no + "】，在系统中未登记，请检查信息是否输入正确。");
		} else {
			String sql = "insert into tb_user('user_loginname','user_name','user_type','user_pwd') values(''{0}'',''{1}'',''{2}'',''{3}'')";
			String[] params = new String[] { no, name, usertype, new Azdg().encrypt(pwd) };
			JSONResponse jr = new JSONResponse();
			ExecResult result = jr.getExecInsertId(sql, params, "", "");
			if (result.getResult() == 0) {
				logger.error("创建用户出错，请稍后重试。");
				return new JSONResponse().getError("用户【" + no + "】，创建失败。");
			} else {
				String userid = result.getMessage();
				if(type.equals("学生")){
					return genRoleData(userid,type);
				}else{
					//自动生成教师账户
					 ExecResult er=genRoleData(userid,usertype);
					 //自动生成其他角色
					 if(!type.equals("教师")){
						 return genRoleData(userid,type);
					 }
					 return er;
				}
			}
		}
	}
	
	/**
	 * 生成用户角色
	 * @param user_id 用户ID 用户id
	 * @param role_name 角色名称
	 * @return
	 */
	public ExecResult genRoleData(String user_id,String role_name){
		JSONResponse jr = new JSONResponse();
		String rolesql = "insert into tb_role_user(user_id,role_id) select ''{0}'',role_id from tb_role where role_name=''{1}''";
		String[] roleparams = new String[] { user_id, role_name };
		ExecResult er=jr.getExecResult(rolesql, roleparams, "用户创建成功", "用户创建失败");
		return er;
	}
	
	/**
	 * 删除用户角色
	 * @param user_id 用户ID
	 * @param role_name 角色名称
	 * @return
	 */
	public ExecResult removeRoleUser(String user_id,String role_name){
		JSONResponse jr = new JSONResponse();
		String rolesql = "delete from  tb_role_user where user_id={0} and role_id=(select role_id from tb_role where role_name=''{1}'')";
		String[] roleparams = new String[] { user_id, role_name };
		ExecResult er=jr.getExecResult(rolesql, roleparams, "用户创建成功", "用户创建失败");
		return er;
	}
	public JSONArray getUserRoles(String userid){
		String sql="SELECT a.* FROM tb_role a,tb_role_user c WHERE a.`role_id`=c.`role_id` AND c.user_id="+userid;
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "");
		return result.getData();
	}
	public JSONObject getUser(String loginname) {
		JSONObject user = new JSONObject();
	
		LoginServer ser = new LoginServer();
		JSONObject ujson = ser.getUserData(loginname);
		if (!TypeUtils.isEmpty(ujson)&&ujson.getInteger("result")>0&&ujson.getJSONArray("data").size()>0) {
			JSONArray users=ujson.getJSONArray("data");
			JSONObject usermap=new JSONObject();
			if(users!=null&&users.size()>0){
				for(int i=0;i<users.size();i++){
					JSONObject um=users.getJSONObject(i);
					if(um.getString("user_loginname").equals(loginname)){
						usermap=users.getJSONObject(i);
						break;
					}
				}
			}

			user.put("userid", TypeUtils.getString(usermap.get("USER_ID".toLowerCase())));
			user.put("loginname", TypeUtils.getString(usermap.get("USER_LOGINNAME".toLowerCase())));
			user.put("username", TypeUtils.getString(usermap.get("USER_NAME".toLowerCase())));
			user.put("usertype", TypeUtils.getString(usermap.get("USER_TYPE".toLowerCase())));
			user.put("userpurview", TypeUtils.getString(usermap.get("USER_PURVIEW".toLowerCase())));
			user.put("roles", getUserRoles(TypeUtils.getString(usermap.get("USER_ID".toLowerCase()))));
			// 获取学生或教师信息
			user.put("userinfo", getTorSInfo(user.getString("loginname"), user.getString("usertype")));
			// 获取权限菜单
			user.put("menu", getMenuByUser(user.getString("userid"), "0", user.getString("userpurview")));
			//获取业务逻辑菜单
			user.put("logicMenu", getLogicMenuByUser(user.getString("userid"), "0", user.getString("userpurview")));
			
			if (!user.getString("usertype").equals("学生")) {
//				if (!user.getString("userpurview").equalsIgnoreCase("ALL")) {
//					user.remove("userpurview");
//					JSONObject uinfo = user.getJSONObject("userinfo");
//					user.put("userpurview", uinfo.get("dep_no"));
//				}
			} else {

			}
			
			return user;
		} else {
			logger.error("获取用户信息失败：用户登录名" + loginname);
			return null;
		}

	}

	public JSONObject getTorSInfo(String no, String type) {
		String sql = "";
		if (!type.equals("学生")) {
			sql = "SELECT * FROM base_teacher a,base_department b WHERE a.dep_no=b.dep_no AND a.teacher_no=''{0}''";
		} else {
			String curterm = SystemStart.getSys().getString("term_no");
			sql = "SELECT a.*,b.`class_no`,c.`class_name`,c.`dep_no`,d.`dep_name` FROM base_student a,base_term_student b,base_classes c,base_department d "
					+ "WHERE a.`stu_no`=b.`stu_no` AND b.`class_no`=c.`class_no` AND d.`dep_no`=c.`dep_no` AND a.`stu_no`=''{0}'' AND b.`term_no`='"
					+ curterm + "'";
		}
		String[] params = new String[] { no };
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "tb_base_user");
		if (result.getResult() == 0) {
			logger.error("获取身份详情出错：身份编号>" + no + ",身份类型>" + type);
			return new JSONObject();
		} else {
			return result.getData().getJSONObject(0);
		}
	}

	public JSONArray getMenuByUser(String userid, String pid, String purview) {
		MenuObject[] menus = MenuObject.getMenu(userid, pid, purview);
		if (menus == null)
			return new JSONArray();
		else
			return JSONArray.parseArray(JSONArray.toJSONString(menus));
	}
	
	public JSONArray getLogicMenuByUser(String userid, String pid, String purview) {
		MenuObject[] menus = MenuObject.getLogicMenu(userid, pid, purview);
		if (menus == null)
			return new JSONArray();
		else
			return JSONArray.parseArray(JSONArray.toJSONString(menus));
	}

	public ExecResult getDep() {
		String sql = "select dep_no,dep_name,dep_type from base_department  order by dep_sort";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "base_department");
		return result;
	}

	/**
	 * 检测旧密码是否匹配
	 * 
	 * @param oldPass
	 * @return 是 true 否false
	 */
	private boolean checkOldPass(String loginName, String oldPass) {
		String sql = "select * from tb_user where user_loginname=''{0}'' and user_pwd=''{1}''";
		String[] params = new String[] { loginName, new Azdg().encrypt(oldPass) };
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, params, "tb_user");
		if (result.getResult() == 0) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 修改密码
	 * 
	 * @param loginName
	 *            用户名
	 * @param newPass
	 *            新密码
	 * @return
	 */
	private ExecResult updateUserPass(String loginName, String newPass) {
		StringBuilder sqlStr = new StringBuilder();
		sqlStr.append("UPDATE tb_user SET user_pwd= ");
		sqlStr.append("'" + newPass + "'");
		sqlStr.append(" WHERE user_loginname= ");
		sqlStr.append("'" + loginName + "'");
		JSONResponse response = new JSONResponse();
		ExecResult result = response.getExecResult(sqlStr.toString(), null, "修改密码成功.", "修改密码失败！");
		return result;
	}

	/**
	 * 修改个人密码
	 * 
	 * @param loginName
	 * @param oldPass
	 * @param newPass
	 * @return
	 */
	public ExecResult changeUserPass( String userName ,String loginName, String oldPass, String newPass) {
		// 检测登录账号是否存在
		if (!checkIsUser(loginName)) {
			return new JSONResponse().getError("用户【" + userName + "】，在系统中未登记，请检查信息是否输入正确。");
		} else {
			logger.info("检测账号存在");
		}
		// 检测旧密码是否匹配
		if (!checkOldPass(loginName, oldPass)) {
			return new JSONResponse().getError("用户【" + userName + "】，旧密码输入错误，请检查信息是否输入正确。");
		} else {
			logger.info("检测旧密码匹配成功");
		}
		// 更新新密码
		return updateUserPass(loginName, new Azdg().encrypt(newPass));

	}

	public Object savaUserFeedBack(String userno, String area, String qq, String email) {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO tb_feedback (username,content,qq,email) VALUES("+"'"+userno+"'"+","+"'"+area+"'"+","+"'"+qq+"'"+","+"'"+email+"'"+")";
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecInsertId(sql, null, "", "");
		return result;
	}

}
