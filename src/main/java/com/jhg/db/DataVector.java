package com.jhg.db;

import java.util.List;

public class DataVector {
	private int length=0;
	private String tableName="table";
	private List<DataRow> rows;
	
	public DataVector(String tablename){
		this.tableName=tablename;
	}
	
	public List<DataRow> getRows() {
		return rows;
	}

	public void setRows(List<DataRow> rows) {
		this.rows = rows;
		if(rows!=null&&rows.size()>0){
			this.length=rows.size();
		}
	}

	public int getLength() {
		return length;
	}

	public void setLength(int length) {
		this.length = length;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
}
