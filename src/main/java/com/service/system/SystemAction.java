package com.service.system;

import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

import org.apache.log4j.Logger;
public class SystemAction extends Action {
	private SystemService service=new SystemService();
	private static Logger logger = Logger.getLogger(SystemAction.class);
	public void createUser(){
		String no=request.getParameter("user_no");
		String type=request.getParameter("usertype");
		String name=request.getParameter("user_name");
		String pwd=request.getParameter("user_pwd");
		ExecResult result=service.createUser(name, no, pwd, type);
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 修改个人密码
	 */
	public void changeUserPass(){
		String userNanme = request.getParameter("userdname");
		String loginName = request.getParameter("loginname");
		String oldPass = request.getParameter("oldPass");
		String newPass = request.getParameter("newPass");
		logger.info("获取的修改个人密码数据为：" + userNanme+","+loginName + "," + oldPass + "," + newPass);
		ExecResult result=service.changeUserPass(userNanme ,loginName, oldPass, newPass);
		try {
			logger.info("" + result.getResult() + result.getMessage());
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void savaUserFeedBack(){
		String userno = request.getParameter("user");
		String area = request.getParameter("area");
		String qq = request.getParameter("qq");
		String email = request.getParameter("email");
		String result = "";
		if(area == null) {
			ExecResult er = new ExecResult(false,"用户反馈意见获取失败！");
			result = er.toString();
		} else {
			result=(service.savaUserFeedBack(userno,area,qq,email)).toString();
			try {
				response.getWriter().write(result.toString());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
