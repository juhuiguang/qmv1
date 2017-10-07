package com.jhg.db;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
/**
 * 结果集解析类
 * @author 橘
 *
 */
public class DataResult {
	private String json="";
	private boolean isselect=true;
	private JSONObject result=null;
	/**
	 * 初始化请求结果集
	 * @param json 获得到的请求结果。
	 */
	public DataResult(String json){
		this.json=json;
		if(json.indexOf("com.common.db.ExecResult")>=0){
			isselect=false;
		}
		try{
			result=JSONObject.parseObject(json);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		
	}
	
	/**
	 * 获得结果集长度
	 * @return 返回结果集记录长度
	 */
	public int getLength(){
		if(!this.isselect) return 0;
		if(result!=null&&result.containsKey("length")){
			return Integer.parseInt(result.getString("length"));
		}
		else{
			return 0;
		}
	}
	
	/**
	 * 获取结果集指定行
	 * @param rownumber 行号索引，0开始。
	 * @return 返回对应行的JSONArray对象。
	 * @throws Exception 索引越界与解析出错抛出异常。
	 */
	public JSONArray getRow(int rownumber) throws Exception{
		if(this.getLength()>0){
			JSONArray rows=result.getJSONArray("rows");
			if(rownumber<0 || rownumber>=rows.size()){
				throw new Exception("索引越界");
			}else{
				JSONObject row=rows.getJSONObject(rownumber);
				if(row.containsKey("items")){
					return row.getJSONArray("items");
				}else{
					throw new Exception("结果集解析错误，缺少items元素");
				}
			}
		}
		return null;
	}
	
	/**
	 * 获得指定行列值
	 * @param rownumber 行号
	 * @param field 字段名称
	 * @return 返回对应行列值
	 * @throws Exception 解析错误异常
	 */
	public String getValue(int rownumber,String field) throws Exception{
		JSONArray row=this.getRow(rownumber);
		if(row!=null){
			String value="";
			boolean flag=false;
			for(int i=0;i<row.size();i++){
				JSONObject jo=row.getJSONObject(i);
				if(jo.containsKey("field")){
					if(jo.getString("field").toUpperCase().equals(field.toUpperCase())){
						value=jo.getString("value");
						flag=true;
						break;
					}
				}else{
					continue;
				}
			}
			if(!flag){
				throw new Exception("结果集中未找到对应的字段:"+field);
			}else{
				return value;
			}
		}else{
			throw new Exception("没有找到指定的行数据");
		}
	}
	
	public String getExecValue() throws Exception{
		if(isselect){
			throw new Exception("该JSON是查询返回结果集，不是执行结果。");
		}else{
			if(result.containsKey("com.common.db.ExecResult")){
				JSONObject jo=result.getJSONObject("com.common.db.ExecResult");
				return jo.getString("flag");
			}else{
				throw new Exception("获取执行结果错误");
			}
		}
	}
	
	public static void main(String [] args){
		
	}
	
	

}
