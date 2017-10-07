package com.service.base;

import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class CommonAction extends Action {

	private CommonService service = new CommonService();
	
	/**
	 * 查询部门信息
	 */
	public void queryBaseClass() {
		ExecResult result = service.getBaseDepartmentSelect();
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 查询部门信息
	 */
	public void queryBaseDep() {
		ExecResult result = service.getBaseDepartmentSelect();
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 查询专业信息
	 */
	public void queryBaseMajor(){
		ExecResult result = service.getBaseMajorSelect();
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}


	
}
