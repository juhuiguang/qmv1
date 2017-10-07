package com.sys;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.alibaba.fastjson.JSONObject;
import com.jhg.common.TypeUtils;
import com.jhg.mvc.Action;
import com.jhg.utils.Azdg;
import com.jhg.utils.HttpRequest;
import com.jhg.utils.PropertyConfig;
import com.service.system.SystemStart;

public class Login extends Action {
	public void Login(){
		HttpSession session=request.getSession();
		String loginname=request.getParameter("loginname");
		String loginpwd=request.getParameter("loginpwd");
		JSONObject result=new JSONObject();
		//这里改写登录验证逻辑
		if(!TypeUtils.isEmpty(loginname)&&!TypeUtils.isEmpty(loginpwd)){
			//登陆远程接口
			List<Map<String,Object>> usrlist = portLogin(loginname,loginpwd);
			System.out.println(usrlist);
			if(!TypeUtils.isEmpty(usrlist)){
				Map<String,Object> usermap=usrlist.get(0);
				String pwd=TypeUtils.getString(usermap.get("USER_PWD"));
				if(new Azdg().decrypt(pwd).equals(loginpwd)){
					session.setAttribute("secret",new java.util.Date().getTime());
					session.setAttribute("loginname", TypeUtils.getString(usermap.get("USER_LOGINNAME")));
					session.setAttribute("username", TypeUtils.getString(usermap.get("USER_NAME")));
					session.setAttribute("usertype", TypeUtils.getString(usermap.get("USER_TYPE")));
					session.setAttribute("userid", TypeUtils.getString(usermap.get("USER_ID")));
					session.setAttribute("userPurview", TypeUtils.getString(usermap.get("USER_PURVIEW")));
					result.put("flag",true);
					SystemStart.resetUser(TypeUtils.getString(usermap.get("USER_LOGINNAME")));
					result.put("user",SystemStart.getUser(TypeUtils.getString(usermap.get("USER_LOGINNAME"))));
				}else{
					session.setAttribute("secret",new java.util.Date().getTime());
					session.setAttribute("loginname", "");
					session.setAttribute("username", "");
					session.setAttribute("usertype", "");
					session.setAttribute("op_id","");
					session.setAttribute("userPurview","");
					session.setAttribute("cus_id","" );
					session.setAttribute("userid", "");
					result.put("flag",false);
				}
			}
			try {
				response.getWriter().write(result.toJSONString());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	public List<Map<String,Object>> portLogin(String loginname , String loginpwd){
		JSONObject map = new JSONObject();
		map.put("login_name", loginname);
		map.put("login_pwd", loginpwd);
		System.out.println( map.toString());
		String token  = Azdg.getToken(new PropertyConfig("sysConfig.properties").getValue("ssokey"), map);
		Map<String, String> portMap = new HashMap<>();
		portMap.put("flag", new PropertyConfig("sysConfig.properties").getValue("flag"));
		portMap.put("config", map.toJSONString());
		portMap.put("token", token);
		portMap.put("login_name",loginname);
		portMap.put("login_pwd",loginpwd);
		String rep = HttpRequest.httpRequest(new PropertyConfig("sysConfig.properties").getValue("ssourl")+"login.interface", portMap); 
		JSONObject jsonObject_ = (JSONObject) JSONObject.parse(rep);
		JSONObject jsonObject;
		List<Map<String, Object>> list = new ArrayList<>();
		System.out.println(jsonObject_);
		if(jsonObject_.getString("data") != null){
			jsonObject = (JSONObject) JSONObject.parse(jsonObject_.getString("data"));
			System.out.println(jsonObject);
			
			Map<String, Object> map2 = new HashMap<>();
			map2.put("USER_ID", jsonObject.getString("user_id"));
			map2.put("USER_LOGINNAME", jsonObject.getString("user_loginname"));
			map2.put("USER_NAME", jsonObject.getString("user_name"));
			map2.put("USER_TYPE", jsonObject.getString("user_type"));
			map2.put("USER_PURVIEW", jsonObject.getString("user_purview"));
			map2.put("USER_PWD", jsonObject.getString("user_pwd"));
			list.add(map2);
			System.out.println("ok");
		}
		return list;
	}
	/**
	 * 获取菜单
	 */
	public void getMenuData(){
		String userid=request.getParameter("userid");
		String userPurview=request.getParameter("userPurview");
		LoginServer ser=new LoginServer();
		List<Map<String,Object>> list=ser.getMenuData(userid, userPurview);
		Map<String,List<Map<String,Object>>>map=ser.getMenuData(list);
		String json =JSONObject.toJSONString(map);
		this.getWriter().write(json);
	}
	
	public static void main(String [] args){
		System.out.println(new Azdg().encrypt("123456"));
		System.out.println(new Azdg().decrypt("IBp+HC5NIk4hEQ1t"));
	}
	
}
