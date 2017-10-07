package com.jhg.utils;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.jhg.response.JSONResponse;
import com.mysql.fabric.xmlrpc.base.Params;
import com.service.base.bean.CharacterUtilBean;

public class Characterindexutil extends Action{
	/*public static void main(String[] args) {
		Characterindexutil characterindexutil = new Characterindexutil();
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("start_date","2015-01-01");
		jsonObject.put("end_date","2016-01-01");
		jsonObject.put("term_no","20150");
		jsonObject.put("yjz","8");
		jsonObject.put("class_no","2015140140");
		jsonObject.put("week","7");
		jsonObject.put("term_start_time","20150908");
		jsonObject.put("dep_no","2240");
<<<<<<< .mine
		jsonObject.put("login_no","1996100158");
		System.out.println(characterindexutil.getKeys("teacher,teacher,teacher,student",jsonObject));
		System.out.println(characterindexutil.characterindex("teacher_listen",jsonObject.toJSONString(),"teach1er"));
	    System.out.println(characterindexutil.getKeys("teacher"));
	}*/
	String basepath=new PropertyConfig("sysConfig.properties").getValue("rootpath");
	private  String data = HttpRequest.httpRequest(basepath+"/buslogic.json",null);
	private JSONArray ja =  JSONArray.parseArray(data);
	
	JSONResponse jo = new JSONResponse();
	
	//根据角色传回key
/*<<<<<<< .mine
	public  void getKeys(){
		String role = request.getParameter("role");
		String paramsT = request.getParameter("jsonParams");
		JSONObject jsonParams =  JSONObject.parseObject(paramsT);
=======*/
	public void getKeys(){
		System.out.println("长度"+ja.size());
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
		}/*else{
			System.out.println("不是班主任");
		}*/
		//直接从角色查询对应的sql就开始执行查询，拼接成一个大的json返回
		JSONArray resultJson = new JSONArray();
		for (int i = 0; i < ja.size(); i++) {
			if (ja.getJSONObject(i).containsKey("resultText")) {
				JSONArray jsonArray =   ja.getJSONObject(i).getJSONArray("resultText");
				if (ja.getJSONObject(i).getString("keyword").equals("master_listen")) {
					System.out.println(jsonArray.size());
				}
				/*for (int j = 0; j < jsonArray.size(); j++) {*/
					String roles[] = jsonArray.getJSONObject(0).getString("role").split(",");
					int t=0;
					for (int k = 0; k < roles.length; k++) {
						for (int k2 = 0; k2 < rolesT.length; k2++) {
							if (rolesT[k2].equals(roles[k])) {
								CharacterUtilBean CB = new CharacterUtilBean();
								/*jsonObject.put("keyword", ja.getJSONObject(i).get("keyword"));
								jArray.add(jsonObject);*/
								String keyword = (String) ja.getJSONObject(i).get("keyword");
								JSONObject jObject = getParams(keyword);
								String []keys = jObject.getString("keys").split(",");
								String values = jObject.getString("values");
								jObject = changeValue(CB,keys,values,jObject,jsonParams);
								if (CB.getMessage().equals("")) {
									CB = characterindex(jObject,role,ja.getJSONObject(i));
									CB.setTitle(ja.getJSONObject(i).getString("title"));
									CB.setLink(ja.getJSONObject(i).getString("link"));
									if (!CB.getDetailkeyword().equals("")) {
										String detailKeyWordT = CB.getDetailkeyword();
										String [] detailKeyWordS=  detailKeyWordT.split(",");
										for (int T = 0; T < detailKeyWordS.length; T++) {
											String detailKeyWord = detailKeyWordS[T];
											for (int l = 0; l < ja.size(); l++) {
												if (ja.getJSONObject(l).getString("keyword").equals(detailKeyWord)) {
													CharacterUtilBean CB1 = new CharacterUtilBean();
													String keywordDetail = ja.getJSONObject(l).getString("keyword");
													JSONObject jsonObject = getParams(keywordDetail);
													String []keysDetail = jsonObject.getString("keys").split(",");
													String valuesDetail = jsonObject.getString("values");
													jsonObject = changeValue(CB1,keysDetail,valuesDetail,jsonObject,jsonParams);
													CB1 = characterindex(jsonObject,"",ja.getJSONObject(l));
													resultJson.add(CB1);
												}
											}
										}
										//CharacterUtilBean CB1 = characterindex( params, role, jsonObject)
									}
								}
								//若找到一个匹配的角色，则执行此查询，然后停止两重for循环停止,继续下一个配置的解析
								resultJson.add(CB);
								t=1;
								break;
							}
						}
						if (t==1) {
							break;
						}
					}
				/*}*/
				
			}
		}
		try {
			response.getWriter().write(resultJson.toJSONString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//数组去重
	public String[] duplicateRemoval(String []roles){
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
	//修改参数
	public JSONObject changeValue(CharacterUtilBean CB,String []keys,String values,JSONObject jObject,JSONObject jsonParams){
		for (int i = 0; i < keys.length; i++) {
			String keyT = keys[i];
			System.out.println("参数0"+keyT);
			String keyTemp = jsonParams.getString(keyT); 
			System.out.println("参数1"+keyTemp);
			if (keyTemp==null) {
				CB.setResult(0);
				CB.setMessage("参数获取失败，查询失败");
				break;
			} 
			values =  values.replace(keyT, keyTemp);
			jObject.put("values", values);
			
		}
		return jObject;
	}
	public JSONObject getParams(String keyword){
		JSONObject jObject = new JSONObject();
		for (int i = 0; i < ja.size(); i++) {
			if (keyword.equals(ja.getJSONObject(i).getString("keyword"))) {
				jObject = ja.getJSONObject(i).getJSONObject("sqlparams");
			}
		}
		return jObject;
	}
	
	public  ExecResult getIsTeacher(String teacher_no){
		String sql="SELECT* FROM`base_classes`  WHERE teacher_no= '"+teacher_no+"' AND class_isover=0";
		ExecResult result = jo.getSelectResult(sql, null, null);
		return result;
	}
	
	//传入关键字，sql对应参数,sql的多个sql的参数用|分割,单个sql的多个参数用$分割
	//解析sql拿到查询结果的方法
	public  CharacterUtilBean characterindex(JSONObject params,String role,JSONObject jsonObject){
		CharacterUtilBean CB = new CharacterUtilBean();
		/*String keywords = request.getParameter("keyword");
		String  paramsT = request.getParameter("paprams");
		String  role = request.getParameter("role");*/
		if (role==null) {
		       CB.setResult(0);
		       CB.setMessage("角色参数传递错误，查询失败");
		}else {
			CB.setKeyword(jsonObject.getString("keyword"));
			CB.setSqlparams(params);
					//查询sql
					String selectsql = jsonObject.getString("selectsql");
					CB.setSelectsql(selectsql);
					//返回的结果文本
					JSONObject resultFields = new JSONObject();
					try {
						 resultFields = JSONObject.parseObject(jsonObject.getString("resultFields"));
					} catch (Exception e) {
						CB.setMessage("resultFields解析出错，请检查配置文件。");
					}
					CB.setResultFields(resultFields);
					String resultType = jsonObject.getString("resultType");
					JSONArray resultText = new JSONArray();
					try {
						resultText = JSONArray.parseArray(jsonObject.getString("resultText"));
				       //定义查询的返回结果变量
					   ExecResult r2 = new ExecResult();
					   String key = params.getString("keys");
					   String value = params.getString("values");
					   String keys[] = key.split(",");
					   String values[] = value.split(",");
					   if (keys.length==values.length) {
						   for (int j = 0; j < values.length; j++) {
							   selectsql = selectsql.replace("$("+keys[j]+")",values[j]);
						   }
						   long start = System.currentTimeMillis();
						 //这里是你要执行的程序块。。。。
						   r2 = jo.getSelectResult(selectsql, null, null);
						 long end = System.currentTimeMillis();
						 long T=start-end;
						 System.out.println("该sql执行耗时"+T);
						   CB.setSqlresult(r2.getData());
						   CB.setResultType(resultType);
						   if (jsonObject.getString("keyword").equals("master_listen")) {
							   System.out.println("进入master_listen啦");
								System.out.println("解析文本"+resultText);
							}
						   //判断是否解析文本
						   if (!resultType.equals("detail")) {
							   //检测是否有匹配的角色
							   int t=0;
							   JSONArray returnJsonArray = new JSONArray();
							   //解析文本
							   for (int j = 0; j < resultText.size(); j++) {
								   System.out.println("进入1次");
								   JSONObject jObject = resultText.getJSONObject(j);
								   //判断此角色是否有权限查看此文本
								   String [] roles = jObject.getString("role").split(",");
								   for (int k = 0; k < roles.length; k++) {
									   JSONObject returnjson = new JSONObject();
									   if(role.contains(roles[k])){
										   if (!(t==1)) {
											   t++;
										   }
										 //结果json
										   String template = jObject.getString("template");
										   String errorText = jObject.getString("errorText");
										   String shorttext = jObject.getString("shorttextvalue");
										   String shorttextT = jObject.getString("shorttext");
										   returnjson.put("textkey",jObject.getString("textkey"));
										   returnjson.put("template",template);
										   returnjson.put("errorText",errorText);
										   
										   returnjson.put("role",roles);
										   if (r2.getResult()==0) {
											   returnjson.put("textvalue",errorText);
											   returnjson.put("shorttextvalue","");
											   returnjson.put("shorttext","");
											   CB.setMessage("sql查询失败");
											   CB.setResult(0);
										   }else{
											   Set<String> set = r2.getData().getJSONObject(0).keySet();
											   Iterator<String> iterator = set.iterator();
											   while (iterator.hasNext()) {
												   String iteratorT = iterator.next();
												   if (template.contains("$("+iteratorT+")")) {
													  template = template.replace("$("+iteratorT+")", r2.getData().getJSONObject(0).getString(iteratorT));
												   }
												   if (shorttext.contains("$("+iteratorT+")")) {
													   shorttext = shorttext.replace("$("+iteratorT+")", r2.getData().getJSONObject(0).getString(iteratorT));
													   }
												   if (shorttextT.contains("$("+iteratorT+")")) {
													   shorttextT = shorttextT.replace("$("+iteratorT+")", r2.getData().getJSONObject(0).getString(iteratorT));
													  }
											   }
											   returnjson.put("textvalue",template);
											   returnjson.put("shorttextvalue", shorttext);
											   returnjson.put("shorttext",shorttextT);
											   if (jObject.containsKey("detailConfig")) {
												  String detailKeyword = jObject.getJSONObject("detailConfig").getString("keyword");
												  int m=0;
												  if (jsonObject.getString("keyword").equals("master_listen")) {
													  System.out.println(m);
													  System.out.println(t);
													  m++;
														System.out.println("解析文本detailKeyword"+detailKeyword);
													}
												  returnjson.put("detailkeyword", detailKeyword);
												  if (!CB.getDetailkeyword().equals("")) {
													String tempDetailKeyword = CB.getDetailkeyword()+","+detailKeyword;
													CB.setDetailkeyword(tempDetailKeyword);
												  }else{
													  CB.setDetailkeyword(detailKeyword);
												  }
											   }
										   }
										   returnJsonArray.add(returnjson);
									   }
									   if (t==1) {
										   break; 
									   }
									  }
								   if (t==0) {
									   CB.setMessage("暂无匹配角色文本，无返回结果");
								   }else{
								   	   CB.setMessage("查询成功");
								   }
								   CB.setResult(1);
								   if (jsonObject.getString("keyword").equals("master_listen")) {
										System.out.println("解析文本resulttext"+returnJsonArray);
									}
								   CB.setResultText(returnJsonArray);
								   }
								   
						   }else{
							   CB.setResult(1);
							   CB.setMessage("查询成功"); 
						   }
					   }else{
						   CB.setMessage("参数的键值不对应，无法查询");
					   }
					   
					} catch (Exception e) {
						e.printStackTrace();
						CB.setMessage("resultText解析出错，请检查配置文件。");
					}
				
		}
	
		//如果参数keywords匹配不JSON中的keyword，则for循环没有return，则返回失败结果
		if (CB.getMessage().equals("")) {
			CB.setResult(0);
			CB.setMessage("没有匹配的关键字，无法查询");
		}
		/*try {
			response.getWriter().write(CB.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}*/
		return CB;
		
	}
	
	

	//读取json文件方法
	public String ReadFile(String Path) {
        BufferedReader reader = null;
        String laststr = "";
        try {
            FileInputStream fileInputStream = new FileInputStream(Path);
            InputStreamReader inputStreamReader = new InputStreamReader(
                    fileInputStream, "utf-8");
            reader = new BufferedReader(inputStreamReader);
            String tempString = null;
            while ((tempString = reader.readLine()) != null) {
                laststr += tempString;
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return laststr;
    }
	
	
   //绘制结果方法
   public  String paintResult(JSONObject jo,String datatemplate){
	   Set<String> SetParams = jo.keySet();
		Iterator<String> iterator = SetParams.iterator();
		while (iterator.hasNext()) {
			String temp = iterator.next();
			datatemplate = datatemplate.replace("$$("+temp+")",jo.getString(temp));
		}
		return datatemplate;
   }
   
   
   /** 
   * 判断是否是json结构 
   */ 
   public static boolean isJson(String value) { 
   try { 
	    JSONArray.parse(value); 
   } catch (JSONException e) { 
	   return false; 
   } 
   	return true; 
   } 
}
