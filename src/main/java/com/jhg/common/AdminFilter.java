package com.jhg.common;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.jhg.db.DAO;
import com.jhg.utils.Azdg;
import com.jhg.utils.PropertyConfig;


public class AdminFilter implements Filter {
	private static  Logger logger = Logger.getLogger("登录拦截器");

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse rep = (HttpServletResponse) response;
		String path = req.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		
		
		HttpSession session=req.getSession(true);
		PropertyConfig pc=new PropertyConfig("sysConfig.properties");
		String loginpath=pc.getValue("loginpath");//登陆页面
		String requrl=req.getRequestURL().toString();
	    String requri=req.getServletPath().toString().trim();
		String ip = req.getHeader("x-forwarded-for");
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = req.getHeader("Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = req.getHeader("WL-Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		logger.info("客户端主机地址"+ip);
		logger.info("请求页面地址"+requrl);
		//登录页不进行过滤
		if(requrl.indexOf(loginpath)>=0){
			logger.info("是登录页面，不进行拦截");
			chain.doFilter(request, response);
			return;
		}
		if(requrl.indexOf("index_sso.jsp")>=0){
			logger.info("是单点登录页面，不进行拦截");
			chain.doFilter(request, response);
			return;
		}
		//不在配置文件制定目录的页面，也不进行过滤
		String filterpath=pc.getValue("filterPath");
		if(requrl.indexOf(filterpath)<0||requrl.indexOf("addCusinfo.jsp")>=0){
			logger.info("非拦截目录，不进行拦截");
			chain.doFilter(request, response);
			return;
		}
		Azdg az=new Azdg();
		String param=java.net.URLEncoder.encode(az.encrypt(requrl),"UTF-8");
		logger.info("加密后且encode后的url:"+param);
		loginpath+="?url="+param;
		logger.info("过滤器生成的登录地址"+basePath+loginpath);
		Object secret=session.getAttribute("secret");
		if(secret==null){
			if(requrl.indexOf("/mobile/")>0){
				logger.info("移动端未登录，跳转登录>>>>"+basePath+"/mobile/"+loginpath);
				rep.sendRedirect(basePath+"/mobile/"+loginpath);
			}else{
				logger.info("未登录，跳转登录>>>>"+basePath+loginpath);
				rep.sendRedirect(basePath+loginpath);
			}
			return;
		}else{
//			Long time=(Long)session.getAttribute("secret");
//			if((new Date().getTime()-time)>(1000*60*60)){
//				logger.info("登录超时，跳转登录界面>>>>"+basePath+loginpath);
//				rep.sendRedirect(basePath+loginpath);
//				return;
//			}
		}
		chain.doFilter(request, response);
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	
	public static String validateLogin(String user,String pwd){
		String sql="select admin_id,admin_usercode,admin_pwd,admin_special from tb_admin_user where admin_usercode='"+user+"'";
		DAO dao=new DAO();
		List<Map<String,Object>> result=dao.getDataSet(sql);
		if(result!=null&&result.size()>0){
			Map item=result.get(0);
			String cpwd=item.get("ADMIN_PWD").toString();
			pwd=new Azdg().encrypt(pwd);
			if(pwd.equals(cpwd)){
				if(item.get("ADMIN_SPECIAL").toString().equals("")){
					return item.get("ADMIN_ID").toString();
				}else{
					return item.get("ADMIN_ID").toString()+","+item.get("ADMIN_SPECIAL").toString();
				}
				
			}else{
				return "0";
			}
		}else{
			return "0";
		}
	}
}
