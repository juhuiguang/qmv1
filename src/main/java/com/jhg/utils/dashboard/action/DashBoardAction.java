package com.jhg.utils.dashboard.action;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.jhg.response.JSONResponse;
import com.jhg.utils.dashboard.bean.DashboardGroup;
import com.jhg.utils.dashboard.service.DashboardManager;

public class DashBoardAction extends Action {
	public void getKeys(){
		String role=request.getParameter("roles");
		JSONObject jsonParams=new JSONObject();
		jsonParams.put("start_date",request.getParameter("start_date"));
		jsonParams.put("end_date",request.getParameter("end_date"));
		jsonParams.put("term_no",request.getParameter("term_no"));
		jsonParams.put("yjz",request.getParameter("yjz"));
		jsonParams.put("class_no",request.getParameter("class_no"));
		jsonParams.put("week",request.getParameter("week"));
		jsonParams.put("term_start_time",request.getParameter("term_start_time"));
		jsonParams.put("dep_no",request.getParameter("dep_no"));
		jsonParams.put("login_no",request.getParameter("login_no"));
		//String role = request.getParameter("role");
		String rolesT[] = role.split(",");
		rolesT=duplicateRemoval(rolesT);
		ExecResult isTeacher = getIsTeacher(jsonParams.getString("login_no"));
		if (isTeacher.getData().size()>0) {
			jsonParams.put("class_no", isTeacher.getData().getJSONObject(0).getString("class_no"));
			String [] temp = new String[rolesT.length+1];
			for (int i = 0; i < rolesT.length; i++) {
				temp[i]=rolesT[i];
			}
			temp[rolesT.length]="bzr";
			rolesT=temp;
		}
		JSONArray resultJson = new JSONArray();
		DashboardManager dm=new DashboardManager();
		List<DashboardGroup> groups=dm.getGroups(jsonParams, role);
		try {
			response.getWriter().write(JSONArray.toJSONString(groups));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//数组去重
		private String[] duplicateRemoval(String []roles){
			 List<String> list = new LinkedList<String>();  
		        for(int i = 0; i < roles.length; i++) {  
		            if(!list.contains(roles[i])) {  
		                list.add(roles[i]);  
		            }  
		        }  
		  
		        String[] rowsTemp = list.toArray(new String[list.size()]);  
		        if(rowsTemp!=null && rowsTemp.length > 0) {  
		            for(int i=0; i<rowsTemp.length; i++) {  
		                System.out.println(rowsTemp[i]);  
		            }  
		        } 
		        return rowsTemp;
		}
		
		private  ExecResult getIsTeacher(String teacher_no){
			JSONResponse jo=new JSONResponse();
			String sql="SELECT* FROM`base_classes`  WHERE teacher_no= '"+teacher_no+"' AND class_isover=0";
			ExecResult result = jo.getSelectResult(sql, null, null);
			return result;
		}
}
