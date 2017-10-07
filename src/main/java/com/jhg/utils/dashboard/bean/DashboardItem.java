package com.jhg.utils.dashboard.bean;

import com.alibaba.fastjson.JSONObject;

public class DashboardItem {
	private String textkey;
	private String shorttext;
	private String template;
	private String errorText;
	private String shorttextvalue;
	private String textvalue;
	private String role;
	private String detailkeyword;
	public DashboardItem(JSONObject item){
		this.textkey=item.getString("textkey");
		this.shorttext=item.getString("shorttext");
		this.template=item.getString("template");
		this.errorText=item.getString("errorText");
		this.shorttextvalue=item.getString("shorttextvalue");
		this.textvalue=item.getString("textvalue");
		this.role=item.getString("role");
		if(!(item.getJSONObject("detailConfig")==null)){
			this.detailkeyword=(item.getJSONObject("detailConfig").getString("keyword")==null)?"":item.getJSONObject("detailConfig").getString("keyword");
			System.out.println("detailkeyword"+detailkeyword);
		}else{
			this.detailkeyword="";
		}
		//初始化detail
	}
	
	public DashboardItem() {
		this.textkey="";
		this.shorttext="";
		this.template="";
		this.errorText="";
		this.shorttextvalue="";
		this.textvalue="";
		this.role="";
		this.detailkeyword="";
	}

	public String getTextkey() {
		return textkey;
	}
	public void setTextkey(String textkey) {
		this.textkey = textkey;
	}
	public String getShorttext() {
		return shorttext;
	}
	public void setShorttext(String shorttext) {
		this.shorttext = shorttext;
	}
	public String getTemplate() {
		return template;
	}
	public void setTemplate(String template) {
		this.template = template;
	}
	public String getErrorText() {
		return errorText;
	}
	public void setErrorText(String errorText) {
		this.errorText = errorText;
	}
	public String getShorttextvalue() {
		return shorttextvalue;
	}
	public void setShorttextvalue(String shorttextvalue) {
		this.shorttextvalue = shorttextvalue;
	}
	public String getTextvalue() {
		return textvalue;
	}
	public void setTextvalue(String textvalue) {
		this.textvalue = textvalue;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getDetailkeyword() {
		return detailkeyword;
	}
	public void setDetailkeyword(String detailkeyword) {
		this.detailkeyword = detailkeyword;
	}
	
	
}
