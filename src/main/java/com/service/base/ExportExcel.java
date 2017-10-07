package com.service.base;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.jeecgframework.poi.cache.ExcelCache;
import org.jeecgframework.poi.excel.ExcelExportUtil;
import org.jeecgframework.poi.excel.entity.TemplateExportParams;
import org.jeecgframework.poi.word.WordExportUtil;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;


public class ExportExcel {
	String separator = File.separator;
	
	public XWPFDocument exportOneWord(String export_id,String []params){
		//查询出导出ID的相关信息
	    ExecResult r2 = getExportInfo(export_id,params);
		//设定模板路径以及sql语句
	    JSONResponse jo = new JSONResponse();
	    String path = r2.getData().getJSONObject(0).getString("template_path");
		String Tsql = r2.getData().getJSONObject(0).getString("export_sql");
		ExecResult r3 = jo.getSelectResult(Tsql, params, null);
		if(r3.getData().size()>0){
			XWPFDocument workbook = null;
			Map<String, Object> secondMap = new HashMap<>();
			secondMap = getOneMap(r3);
				try {
					workbook = WordExportUtil.exportWord07(path, secondMap);
				} catch (Exception e) {
					e.printStackTrace();
				}
            return workbook;
           
		}
		return null;
	}
	
	
	public XWPFDocument exportWord(String export_id,String []params){
		//查询出导出ID的相关信息
	    ExecResult r2 = getExportInfo(export_id,params);
		//设定模板路径以及sql语句
	    JSONResponse jo = new JSONResponse();
	    String path = r2.getData().getJSONObject(0).getString("template_path");
		String Tsql = r2.getData().getJSONObject(0).getString("export_sql");
		
		ExecResult r3 = jo.getSelectResult(Tsql, params, null);
		if(r3.getData().size()>0){
			XWPFDocument workbook = null;
			Map<String, Object> map = new HashMap<>();
			map=getListMap(r3);
			try {
				workbook = WordExportUtil.exportWord07(path,map);
			} catch (Exception e1) {
				e1.printStackTrace();
			}
            return workbook;
           
		}
		return null;
	}
	
	public XWPFDocument exportMoreWord(String export_id,String []params,String []params2){
		//查询出导出ID的相关信息
	    ExecResult r2 = getExportInfo(export_id,params);
		//设定模板路径以及sql语句
	    JSONResponse jo = new JSONResponse();
	    String path = r2.getData().getJSONObject(0).getString("template_path");
		String Tsql1 = r2.getData().getJSONObject(0).getString("export_sql");
		String Tsql2 = r2.getData().getJSONObject(0).getString("export_sql");
		ExecResult r3 = jo.getSelectResult(Tsql1, params, null);
		ExecResult r4 = jo.getSelectResult(Tsql2, params, null);
		if(r3.getData().size()>0){
			XWPFDocument workbook = new XWPFDocument();
			Map<String, Object> map = new HashMap<>();
		    map = getListMap(r3);
		    Set<String> set1 =  r3.getData().getJSONObject(0).keySet();
	        for (String string : set1) {
				map.put(string, r4.getData().getJSONObject(0).getString(string));
			}	
			try {
				workbook = WordExportUtil.exportWord07(path, map);
			} catch (Exception e) {
				e.printStackTrace();
			}
            return workbook;
           
		}
		return null;
	}
	
	public   Workbook exportOneExcel(String export_id,String []params){
		//查询出导出ID的相关信息
	    ExecResult r2 = getExportInfo(export_id,params);
		//设定模板路径以及sql语句
	    JSONResponse jo = new JSONResponse();
	    String path = r2.getData().getJSONObject(0).getString("template_path");
		String Tsql = r2.getData().getJSONObject(0).getString("export_sql");
		ExecResult r3 = jo.getSelectResult(Tsql, params, null);
		TemplateExportParams templateParams = new TemplateExportParams(path);
		if(r3.getData().size()>0){
			Workbook workbook = null;
			Map<String, Object> secondMap = new HashMap<>();
			secondMap = getOneMap(r3);
	        workbook = ExcelExportUtil.exportExcel(templateParams, secondMap);
	        return workbook;
		}
		return null;
	}
	
	public   Workbook exportExcel(String export_id,String []params){
		//查询出导出ID的相关信息
	    ExecResult r2 = getExportInfo(export_id,params);
		//设定模板路径以及sql语句
	    JSONResponse jo = new JSONResponse();
	    String path = r2.getData().getJSONObject(0).getString("template_path");
		String Tsql = r2.getData().getJSONObject(0).getString("export_sql");
		for (int i = 0; i < params.length; i++) {
			System.out.println(params[i]);
		}
		System.out.println(Tsql);
		ExecResult r3 = jo.getSelectResult(Tsql, params, null);
		System.out.println("r3"+r3.getData());
		TemplateExportParams templateParams = new TemplateExportParams(path);
		if(r3.getData().size()>0){
			Workbook workbook = null;
			Map<String, Object> map = new HashMap<>();
			map = getListMap(r3);
	        try {
				workbook = ExcelExportUtil.exportExcel(templateParams, map);
			} catch (Exception e) {
				/*e.printStackTrace();*/
			    	/*Map<String, Object> secondMap = new HashMap<>();
			    	secondMap = getOneMap(r3);
			    	System.out.println(secondMap);
	                workbook = ExcelExportUtil.exportExcel(templateParams, secondMap);*/
			}
	        return workbook;
		}
		return null;
	}
	
	public   Workbook exportMoreExcel(String export_id,String []params,String more){
		System.out.println("params.length"+params.length);
		//查询出导出ID的相关信息
	    ExecResult r2 = getExportInfo(export_id,params);
		//设定模板路径以及sql语句
	    JSONResponse jo = new JSONResponse();
	    int moreint = Integer.parseInt(more);
	    String path = r2.getData().getJSONObject(0).getString("template_path");
	    List<String> Tsql = new ArrayList<>();
	    System.out.println("more"+moreint);
	    for (int i = 0; i < moreint; i++) {
	    	System.out.println("i"+i);
	    	if (i==0) {
	    		if (r2.getData().getJSONObject(0).getString("export_sql")!=null || r2.getData().getJSONObject(0).getString("export_sql")!="") {
	    			Tsql.add(r2.getData().getJSONObject(0).getString("export_sql"));
	    		}
			}else{
				if (r2.getData().getJSONObject(0).getString("export_sqlmore"+i)!=null || r2.getData().getJSONObject(0).getString("export_sqlmore"+i)!="") {
	    			System.out.println(r2.getData().getJSONObject(0).getString("export_sqlmore"+i));
					Tsql.add(r2.getData().getJSONObject(0).getString("export_sqlmore"+i));
	    		}
			}
		}
		System.out.println("Tsql"+Tsql.size());
	    List<ExecResult> resultList = new ArrayList<>();
	    for (int i = 0; i < Tsql.size(); i++) {
			try {
				if (params.length==1) {
					resultList.add(jo.getSelectResult(Tsql.get(i), params, null));
				}else{
					System.out.println("第"+i+"次 "+params[i].split(","));
					resultList.add(jo.getSelectResult(Tsql.get(i), params[i].split(","), null));
				}
			} catch (Exception e) {
				System.err.println("执行sql时出错");
				e.printStackTrace();
			}
		}
	    Map<Integer,Map<String,Object>> result = new HashMap<>();
		TemplateExportParams templateParams = new TemplateExportParams(path,true);
		Workbook workbook = null;
		for (int i = 0; i < resultList.size(); i++) {
			ExecResult temp = resultList.get(i);
			Map<String,List<Map<String, Object>>> map = new HashMap<>();
			/*if(temp.getData().size()>0){*/
				@SuppressWarnings("rawtypes")
				Map<String, Object> map2 = new HashMap();
				map2 = getListMap(temp);
				result.put(i, map2);
			/*}*/
		}
		workbook=ExcelCache.getWorkbook(templateParams.getTemplateUrl(), templateParams.getSheetNum(),
				templateParams.isScanAllsheet());
		for (int i = 0, le = templateParams.isScanAllsheet() ? workbook.getNumberOfSheets()
                : templateParams.getSheetNum().length; i < le; i++) {
			System.out.println(le);
			System.out.println(result.get(i));
                if (templateParams.getSheetName() != null && templateParams.getSheetName().length > i
                    && StringUtils.isNotEmpty(templateParams.getSheetName()[i])) {
                	workbook.setSheetName(i, templateParams.getSheetName()[i]);
                }
            }
		workbook = ExcelExportUtil.exportExcel(result, templateParams);
		return workbook;
	}
	
	
	public ExecResult getExportInfo(String export_id,String []params){
		String sql = "SELECT * FROM qm_ecporttable WHERE export_id = '"+export_id+"'";
		JSONResponse jo = new JSONResponse();
		ExecResult r2 = null;
		r2 = jo.getSelectResult(sql, null, null);
		return r2;
	}
	public Map<String, Object> getOneMap(ExecResult r3){
		  Map<String, Object> secondMap = new HashMap<>();
	    	Set<String> set1 =  r3.getData().getJSONObject(0).keySet();
          for (String string : set1) {
				secondMap.put(string, r3.getData().getJSONObject(0).getString(string));
			}	
          return secondMap;
	}
	public Map<String, Object> getListMap(ExecResult r3){
		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> list = new ArrayList<>();
		for(int i = 0 ; i<r3.getData().size();i++){
			Map<String, Object> testmap = new HashMap<String,Object>();
			Set<String> set =  r3.getData().getJSONObject(0).keySet();
			for (String string : set) {
				testmap.put(string,r3.getData().getJSONObject(i).getString(string));
			}
			list.add(testmap);
		}
		map.put("testmap", list);
        return map;
	}
	
		

}