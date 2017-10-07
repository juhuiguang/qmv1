package com.jhg.response;

import com.jhg.utils.PropertyConfig;


public class ResponseFactory {
	public static IResponse CreateResponse(){
		String responseType=new PropertyConfig("sysConfig.properties").getValue("responseType");
		if(responseType.equals("xml")){
			return new XmlResponse();
		}else if(responseType.equals("json")){
			return new JSONResponse();
		}else{
			return new XmlResponse();
		}
	}
}
