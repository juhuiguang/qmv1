package com.service.app;

import com.jhg.db.ExecResult;

public class AppExecResult extends ExecResult {
	private int length;
	public AppExecResult(){
		
	}
	public AppExecResult(boolean result,String message){
		this.setResult(result);
		this.setMessage(message);
		if(!result){
			this.setErrormsg(message);
		}
	}
	public int getLength() {
		return length;
	}
	public void setLength(int length) {
		this.length = length;
	}
}
