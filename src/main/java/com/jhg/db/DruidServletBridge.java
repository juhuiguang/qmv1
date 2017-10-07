package com.jhg.db;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.alibaba.druid.pool.DruidDataSource;
import com.jhg.common.RequestUtils;
import com.jhg.common.TypeUtils;
import com.jhg.mvc.Dispatch;
public class DruidServletBridge extends Dispatch {
	
	private static final long serialVersionUID = 1445994328471051152L;
	private DruidDataSource  data=null;
	public static Logger logger = Logger.getLogger("dbpool");
	/**
	 * 系统初始化方�?
	 */
	public void init() throws ServletException {
		logger.info("======================开始创建数据库连接池=====================");
        try {
        	System.setProperty("jsse.enableSNIExtension", "false");
        	System.setProperty("https.protocols", "SSLv3,SSLv2Hello");
			data=   DbPoolConnection.getInstance().getDataSource();
			//读取�?有关注�?�信�?
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public DruidServletBridge() {
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (!TypeUtils.isEmpty(RequestUtils.String(request, "invoke"))) {
			super.doPost(request, response);
		} 
	}

	public void destroy() {
		logger.info("=================数据库连接池注销==================");
		super.destroy();
	}
}
