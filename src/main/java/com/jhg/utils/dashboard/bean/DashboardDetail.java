package com.jhg.utils.dashboard.bean;

import com.alibaba.fastjson.JSONObject;

public class DashboardDetail {
	private String keyword;
	private JSONObject resultFields;
	private JSONObject sqlparams;
	private String selectsql;
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public JSONObject getResultFields() {
		return resultFields;
	}
	public void setResultFields(JSONObject resultFields) {
		this.resultFields = resultFields;
	}
	public JSONObject getSqlparams() {
		return sqlparams;
	}
	public void setSqlparams(JSONObject sqlparams) {
		this.sqlparams = sqlparams;
	}
	public String getSelectsql() {
		return selectsql;
	}
	public void setSelectsql(String selectsql) {
		this.selectsql = selectsql;
	}
}
