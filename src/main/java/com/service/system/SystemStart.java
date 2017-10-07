package com.service.system;

import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.utils.dashboard.service.DashboardManager;

public class SystemStart extends HttpServlet {
	private static  Logger logger = Logger.getLogger("SystemStart");
	
	private static JSONObject SystemObject=new JSONObject();
	
	private static Map<String,JSONObject> OnlineUser=new HashMap<String,JSONObject>();
	
	public static JSONObject getSys(){
		String currentWeek=refreshCurrentweek();
		if(SystemObject.containsKey("currentweek")){
			SystemObject.remove("currentweek");
		}
		SystemObject.put("currentweek", currentWeek);
		return SystemObject;
	}
	static SystemService service=new SystemService();
	public static void refreshSystemObject(){
		SystemObject=new JSONObject();
		ExecResult er=service.getCurrentTerm();
		if(er.getResult()==0){
			logger.error("获取当前学年失败。");
			return;
		}
		SystemObject=er.getData().getJSONObject(0);
		
		logger.info("正在获取部门数据...");
		er=service.getDep();
		if(er.getResult()==0){
			logger.error("获取部门数据失败。");
			return;
		}
		SystemObject.put("departments", er.getData());
		
		logger.info("初始化变量成功："+SystemObject.toJSONString());
	}
	public void init()  throws ServletException
    {
		logger.info("欢迎使用QM系统，系统正在启动...");
		logger.info("正在获取当前学年...");
		ExecResult er=service.getCurrentTerm();
		if(er.getResult()==0){
			logger.error("获取当前学年失败。");
			return;
		}
		SystemObject=er.getData().getJSONObject(0);
		
		logger.info("正在获取部门数据...");
		er=service.getDep();
		if(er.getResult()==0){
			logger.error("获取部门数据失败。");
			return;
		}
		SystemObject.put("departments", er.getData());
		
		logger.info("初始化变量成功："+SystemObject.toJSONString());
		//初始化异步任务，看板数据
		try {
			DashboardManager.init(getServletContext().getRealPath("/")+"/buslogic.json");
			DashboardManager.initAnyscDownloader();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
	
	public static String refreshCurrentweek(){
		ExecResult er=service.refreshCurrentWeek();
		if(er.getResult()>0){
			JSONObject week=er.getData().getJSONObject(0);
			return week.getString("currentweek");
		}else{
			return "";
		}
	}
	
	public static JSONObject getUser(String loginname){
		if(OnlineUser.containsKey(loginname)){
			JSONObject user=OnlineUser.get(loginname);
			return user;
		}else{
			JSONObject currentuser=service.getUser(loginname);
			if(currentuser!=null){
				OnlineUser.put(loginname, currentuser);
			}
			return currentuser;
		}
	}
	
	public static void resetUser(String loginname){
		if(OnlineUser.containsKey(loginname)){
			OnlineUser.remove(loginname);
		}
		OnlineUser.put(loginname, getUser(loginname));
		return;
	}

	public static void main(String [] args){
		Map temp=new HashMap();
		temp.put("13006","13006");
		temp.put("3006","3006");
		System.out.println(temp.get("3006"));
	}
}
