package com.jhg.db;

public class DataItem {
	private String field;
	private String value;
	
	public DataItem(String f,String v){
		this.field=f;
		this.value=v;
	}
	public DataItem(){
		
	}
	
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
}
