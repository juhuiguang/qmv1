package com.service.app;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.HttpParams;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
public class ClientDemo {
	
	public static void main(String [] args){
		//String url="http://127.0.0.1:8080/QualityMonitor2/do?invoke=AppAction@userFeedBack";
		String url="http://127.0.0.1:8080/QualityMonitor2/do?invoke=AppAction@getOwnListenInfo";
		//String url="http://210.28.101.76/QualityMonitor2/getTeacherCheckInfo";   
		HttpPost httpRequest = new HttpPost(url);   
	 
		List <NameValuePair> params = new ArrayList <NameValuePair>(); 
		//params.add(new BasicNameValuePair("currentWeek", "5")); 
		params.add(new BasicNameValuePair("teacher_no", "1996100158")); 
		params.add(new BasicNameValuePair("term_no", "20141"));  
		//params.add(new BasicNameValuePair("qq", "1109089240"));  
		//params.add(new BasicNameValuePair("email", "fefefefe")); 
		//params.add(new BasicNameValuePair("userdname", "胡光勇"));
		//params.add(new BasicNameValuePair("oldPass", "111111"));  
		//params.add(new BasicNameValuePair("newPass", "123456"));
		//params.add(new BasicNameValuePair("paginal", "1"));  
		//params.add(new BasicNameValuePair("term_no", "20150"));  
		//params.add(new BasicNameValuePair("task_no", "41166"));  
	  
        try {
        	 httpRequest.setEntity(new UrlEncodedFormEntity(params, HTTP.UTF_8)); 
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 
        HttpResponse httpResponse = null;
		try {
			httpResponse = new DefaultHttpClient().execute(httpRequest);
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
        if(httpResponse.getStatusLine().getStatusCode() == 200)  
        { 
          /*读返回数据*/
          String strResult = null;
		try {
			strResult = EntityUtils.toString(httpResponse.getEntity(),HTTP.UTF_8);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
          System.out.println("result:"+strResult);
        } else{
        	System.out.println("result:error");
        }
		
	}
	

}
