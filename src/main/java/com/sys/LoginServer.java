package com.sys;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.jhg.utils.Azdg;
import com.jhg.utils.HttpRequest;
import com.jhg.utils.PropertyConfig;
import org.apache.log4j.Logger;

import com.jhg.common.TypeUtils;
import com.jhg.db.DAO;
/**
 * 登录
 * @author Administrator
 *
 */
public class LoginServer {
	private static Logger logger = Logger.getLogger(LoginServer.class);
    /**
     * 获取用户信息
     * @param username
     * @return
     */
	public JSONObject getUserData(String username){
//		List<Map<String,Object>> list=null;
//    	try{
//    		String sql="SELECT USER_ID,USER_LOGINNAME,USER_PWD,USER_TYPE,USER_NAME,USER_PURVIEW FROM `tb_user` WHERE user_status='1' AND user_loginname='"+username+"'";
//    		list=DAO.getDao().getDataSet(sql);
//    	}catch(Exception e){
//    		logger.info("获取登陆用户信息失败"+e);
//    	}
//    	return list;

		JSONObject map = new JSONObject();
		map.put("loginname", username);
		System.out.println( map.toString());
		String token  = Azdg.getToken(new PropertyConfig("sysConfig.properties").getValue("ssokey"), map);
		Map<String, String> portMap = new HashMap<>();
		portMap.put("flag", new PropertyConfig("sysConfig.properties").getValue("flag"));
		portMap.put("config", map.toJSONString());
		portMap.put("token", token);
		portMap.put("loginname",username);
		String rep = HttpRequest.httpRequest(new PropertyConfig("sysConfig.properties").getValue("ssourl")+"/basicdata/user/getUsersByLoginname.interface", portMap);
		JSONObject jsonObject_ = (JSONObject) JSONObject.parse(rep);
		return jsonObject_;
	}
	/**
	 * 获取登陆菜单
	 * @param userid
	 * @return
	 */
	public List<Map<String,Object>> getMenuData(String userid,String userPurview){
		List<Map<String,Object>> list=null;
    	try{
    		String sql="SELECT A.* FROM (SELECT * FROM tb_menu WHERE menu_status='1') A ,(SELECT *FROM tb_role_menu WHERE role_id IN(SELECT role_id FROM tb_role_user WHERE user_id ='"+userid+"'))B WHERE A.menu_id=B.menu_id";
    		if("ALL".equals(userPurview)){
    			sql="SELECT * FROM tb_menu WHERE menu_status='1' ";
    		}
    		list=DAO.getDao().getDataSet(sql);
    	}catch(Exception e){
    		logger.info("获取登陆用户广告菜单失败"+e);
    		//list=new ArrayList
    	}
    	return list;
	}
	
	/**
	 * 返回菜单数据格式
	 * @param list
	 * @return
	 */
	public Map<String,List<Map<String,Object>>> getMenuData(List<Map<String,Object>> list){
		  Map<String,List<Map<String,Object>>> map=new HashMap<String,List<Map<String,Object>>>();
		  if(!TypeUtils.isEmpty(list)){
			  for(Map<String,Object> m:list){
                	String menu_id=TypeUtils.getString(m.get("MENU_ID"));
                	String menu_pid=TypeUtils.getString(m.get("MENU_PID"));//父节点
                	//父节点
                	if(map.containsKey(menu_pid)){
                		List<Map<String,Object>> l=map.get(menu_pid);
                		l.add(m);
                	}else{
                		List<Map<String,Object>> l=new ArrayList<Map<String,Object>>();
                		l.add(m);
                		map.put(menu_id, l);
                	}
			  }
		  }
		  return map;
	}
	
	
	
	
	
}
