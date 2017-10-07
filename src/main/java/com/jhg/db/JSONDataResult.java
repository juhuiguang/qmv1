package com.jhg.db;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.common.TypeUtils;
import com.service.base.bean.BaseErrorMsg;

public class JSONDataResult {
	public JSONArray getJSONResult(List<Map<String, Object>> result) {
		JSONArray ja = new JSONArray();
		if (result.size() > 0) {
			for (int i = 0; i < result.size(); i++) {
				JSONObject jo = new JSONObject();
				Map<String, Object> item = result.get(i);
				for (String key : item.keySet()) {
					String value = TypeUtils.getString(item.get(key));
					jo.put(key.toLowerCase(), value);
				}
				ja.add(jo);
			}
		}
		return ja;
	}

	public JSONArray getJSONResult1(List<BaseErrorMsg> result) {
		JSONArray ja = new JSONArray();
		if (result.size() > 0) {
			for (int i = 0; i < result.size(); i++) {
				JSONObject jo = new JSONObject();
				ja.add(JSON.toJSON(result.get(i)));
			}
		}
		return ja;
	}
}