package com.jhg.utils.dashboard.bean;

import java.io.Console;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.utils.dashboard.service.DashboardManager;
import com.jhg.utils.dashboard.service.GroupGetDataCallback;

/**
 * 看板分组
 * @author al
 *
 */
public class DashboardGroup {
	private String keyword;
	private String title;
	private String selectsql;
	private String message;
	private String [] paramskey;
	private JSONObject sqlparams;
	private JSONArray sqlresult;
	private String resultType;
	private List<DashboardItem> resultText;
	private JSONObject resultFields;
	private boolean iscalc=false;
	private boolean itemready=false;
	

	public DashboardGroup(JSONObject group,JSONObject params,String [] roles){
		this.keyword=group.getString("keyword");
		this.title=group.getString("title");
		this.selectsql=group.getString("selectsql");
		this.message="";
		this.sqlparams=params;
		this.resultType=group.getString("resultType");
		this.resultFields=group.getJSONObject("resultFields");
		
		//初始化items
		if(group.containsKey("resultText")){
			this.resultText=new ArrayList<>(); 
			JSONArray rt=group.getJSONArray("resultText");
			System.out.println(rt);
			for(int i=0;i<rt.size();i++){
				String role = rt.getJSONObject(i).getString("role");
				for (int j = 0; j < roles.length; j++) {
					if (role.contains(roles[j])) {
						this.resultText.add(new DashboardItem(rt.getJSONObject(i)));
						break;
					}
				}
			}
		}
	}
	
	//查询结果
	public void getsqlresult(){
		//异步执行方法。
		DashboardManager.addTask(this, new GroupGetDataCallback());
	}
	
	/**
	 * 初始化items
	 */
	public void initItems(){
		this.itemready=true;
	}
	
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSelectsql() {
		return selectsql;
	}
	public void setSelectsql(String selectsql) {
		this.selectsql = selectsql;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String[] getParamskey() {
		return paramskey;
	}
	public void setParamskey(String[] paramskey) {
		this.paramskey = paramskey;
	}
	public JSONObject getSqlparams() {
		return sqlparams;
	}
	public void setSqlparams(JSONObject sqlparams) {
		this.sqlparams = sqlparams;
	}
	public JSONArray getSqlresult() {
		return sqlresult;
	}
	public void setSqlresult(JSONArray sqlresult) {
		this.sqlresult = sqlresult;
	}
	public String getResultType() {
		return resultType;
	}
	public void setResultType(String resultType) {
		this.resultType = resultType;
	}
	
	public JSONObject getResultFields() {
		return resultFields;
	}
	public void setResultFields(JSONObject resultFields) {
		this.resultFields = resultFields;
	}
	
	public boolean isIscalc() {
		return iscalc;
	}

	public void setIscalc(boolean iscalc) {
		this.iscalc = iscalc;
	}

	public boolean isItemready() {
		return itemready;
	}

	public void setItemready(boolean itemready) {
		this.itemready = itemready;
	}

	public List<DashboardItem> getResultText() {
		return resultText;
	}

	public void setResultText(List<DashboardItem> resultText) {
		this.resultText = resultText;
	}
	
	
}
