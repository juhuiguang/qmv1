package com.service.base.bean;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class CharacterUtilBean {
	// 关键字
	private String keyword;
	// 关键字对应的查询
	private String selectsql;
	// 查询sql参数
	private JSONObject sqlparams;
	// sql查询结果
	private JSONArray sqlresult;
	private String resultType;
    private JSONObject resultFields;
    private String link;
	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public JSONObject getResultFields() {
		return resultFields;
	}

	public void setResultFields(JSONObject resultFields) {
		this.resultFields = resultFields;
	}

	public String getResultType() {
		return resultType;
	}

	public void setResultType(String resultType) {
		this.resultType = resultType;
	}

	// SQL查询返回值组成文本的类型
	private JSONArray resultText;
	// 查询是否成功的标志
	private int result;
	// 查询信息
	private String message;
	// 子查询返回信息
	//标题
	private String title;
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	private String detailkeyword;

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getDetailkeyword() {
		return detailkeyword;
	}

	public void setDetailkeyword(String detailkeyword) {
		this.detailkeyword = detailkeyword;
	}

	public int getResult() {
		return result;
	}

	public void setResult(int result) {
		this.result = result;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getSelectsql() {
		return selectsql;
	}

	public void setSelectsql(String selectsql) {
		this.selectsql = selectsql;
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

	public JSONArray getResultText() {
		return resultText;
	}

	public void setResultText(JSONArray resultText) {
		this.resultText = resultText;
	}
    
	public CharacterUtilBean(String keyword, String selectsql, JSONObject sqlparams, JSONArray sqlresult,
			String resultType, JSONArray resultText, int result, String message, String detailkeyword) {
		super();
		this.keyword = keyword;
		this.selectsql = selectsql;
		this.sqlparams = sqlparams;
		this.sqlresult = sqlresult;
		this.resultType = resultType;
		this.resultText = resultText;
		this.result = result;
		this.message = message;
		this.detailkeyword = detailkeyword;
	}

	public CharacterUtilBean() {
		sqlresult = new JSONArray();
		resultText = new JSONArray();
		sqlparams = new JSONObject();
		result = 0;
		message = "";
		detailkeyword="";
		title="";
		link="";
	}

	@Override
	public String toString() {
		return "keyword=" + keyword + ", selectsql=" + selectsql + ", sqlparams=" + sqlparams
				+ ", sqlresult=" + sqlresult + ", resultType=" + resultType + ",  resultText="
				+ resultText + ", result=" + result + ", message=" + message + ", detailkeyword=" + detailkeyword + "]";
	}

}
