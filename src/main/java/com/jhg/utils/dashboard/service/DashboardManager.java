package com.jhg.utils.dashboard.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;
import java.util.Set;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.googlecode.asyn4j.core.callback.AsynCallBack;
import com.googlecode.asyn4j.core.handler.CacheAsynWorkHandler;
import com.googlecode.asyn4j.core.handler.DefaultErrorAsynWorkHandler;
import com.googlecode.asyn4j.core.handler.FileAsynServiceHandler;
import com.googlecode.asyn4j.service.AsynService;
import com.googlecode.asyn4j.service.AsynServiceImpl;
import com.jhg.utils.HttpRequest;
import com.jhg.utils.PropertyConfig;
import com.jhg.utils.dashboard.bean.DashboardGroup;
import com.jhg.utils.dashboard.bean.DashboardItem;

public class DashboardManager {
	private static  Logger logger = Logger.getLogger(DashboardManager.class); 
	private static AsynService asynService = null;
	
	/**
	 * 异步调用机制初始化，在系统刚启动时初始化systemstart。
	 */
	public static void initAnyscDownloader() {
		asynService = AsynServiceImpl.getService(300, 3000L, 100, 100, 1000);
		// 异步工作缓冲处理器
		asynService.setWorkQueueFullHandler(new CacheAsynWorkHandler(100));
		// 服务启动和关闭处理器
		asynService.setServiceHandler(new FileAsynServiceHandler());
		// 异步工作执行异常处理器
		asynService.setErrorAsynWorkHandler(new DefaultErrorAsynWorkHandler());
		// 启动服务
		asynService.init();
	}
	
	/**
	 * 给异步调用队列中加入任务
	 * @param group 看板组
	 * @param callback 回调方法GroupGetDataCallback
	 * @return
	 */
	public static boolean addTask(DashboardGroup group,AsynCallBack callback) {
		 asynService.addWork(SqlAsynExec.class ,  "getSqlResult" ,  new  Object[] { group }, callback);
		return true;
	}
	
	private static JSONArray config=new JSONArray();
	
	public static void init(String path) throws FileNotFoundException{
		String fullFileName = path;
        File file = new File(fullFileName);
        Scanner scanner = null;
        StringBuilder buffer = new StringBuilder();
        try {
            scanner = new Scanner(file, "utf-8");
            while (scanner.hasNextLine()) {
                buffer.append(scanner.nextLine());
            }
 
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block  
 
        } finally {
            if (scanner != null) {
                scanner.close();
            }
        }
         
        System.out.println(buffer.toString());

		config=JSONArray.parseArray(buffer.toString());
	}
	
	public List<DashboardGroup> getGroups(JSONObject params,String role){
		long start=System.currentTimeMillis();
		logger.info("begin get groups,current time is "+start);
		/*String role=request.getParameter("roles");*/
		String rolesT[] = role.split(",");
		List<DashboardGroup> groups=new ArrayList<DashboardGroup>();
		for(int i=0;i<config.size();i++){
			//筛选column
			if (!config.getJSONObject(i).getString("resultType").equals("detail")) {
				boolean  flag=false;
				for (int T= 0; T < config.getJSONObject(i).getJSONArray("resultText").size(); T++) {
					for (int j = 0; j < rolesT.length; j++) {
						System.out.println((config.getJSONObject(i)));
						System.out.println((config.getJSONObject(i).getJSONArray("resultText").getJSONObject(T).getString("role")));
						System.out.println((config.getJSONObject(i).getJSONArray("resultText").getJSONObject(T).getString("role").contains(rolesT[j])));
					    if(config.getJSONObject(i).getJSONArray("resultText").getJSONObject(T).getString("role").contains(rolesT[j])){
							if(config.getJSONObject(i).toString().contains(rolesT[j])){
								DashboardGroup g=new DashboardGroup(config.getJSONObject(i),params,rolesT);
								g.getsqlresult();
								//此处执行异步调用查询结果
								groups.add(g);
							}
							flag=true;
							break;
						}
					}
					if (flag) {
						break;
					}
				}
			}
			//筛选detail
			else {
				boolean ifinsertflag = false;
				//遍历group寻找是否存在detailkeyword为当前keyword的DashboardGroup
				for (int j = 0; j < groups.size(); j++) {
					DashboardGroup dbGroup = groups.get(j);
					if(dbGroup.getResultText()!=null){
						if (dbGroup.getResultText().size()>0) {
							for (int j2 = 0; j2 < dbGroup.getResultText().size(); j2++) {
								if (dbGroup.getResultText().get(j2).getDetailkeyword().equals(config.getJSONObject(i).getString("keyword"))) {
									DashboardGroup g=new DashboardGroup(config.getJSONObject(i),params,rolesT);
									g.getsqlresult();
									groups.add(g);
									ifinsertflag=true;
									break;
								}
							}
							if(ifinsertflag){
								break;
							}
						}
					}
				}
			}
		}
		
		//等待所有group获取数据完毕
		System.out.println(groups.size());
		for(int i=0;i<groups.size();i++){
			System.out.println(i);
			DashboardGroup g=groups.get(i);
			if(!g.isIscalc()){//如果没有执行完成，重新检测一遍。
				logger.error("group's sql is not complete."+JSON.toJSONString(g));
				i=-1;
				try {
					Thread.sleep(500);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				continue;
			}else{
				//如果已经执行完成且未进行item组装，进行item组装
				if(!g.getResultType().equals("detail")){
					for (int j = 0; j < g.getResultText().size(); j++) {
						DashboardItem DT =g.getResultText().get(j);
						if (g.getMessage().equals("sql查询为空或者查询错误")) {
							DT.setTextvalue(DT.getErrorText());
							DT.setShorttext("");
							DT.setShorttextvalue("");
							g.getResultText().set(j, DT);
						}else{
							String template = g.getResultText().get(j).getTemplate();
							String shorttext = g.getResultText().get(j).getShorttextvalue();
							String shorttextT = g.getResultText().get(j).getShorttext();
							JSONObject selResult0=g.getSqlresult().getJSONObject(0);
							Set<String> set = selResult0.keySet();
							   Iterator<String> iterator = set.iterator();
							   while (iterator.hasNext()) {
								   String iteratorT = iterator.next();
								   if (template.contains("$("+iteratorT+")")) {
									   template = template.replace("$("+iteratorT+")", selResult0.getString(iteratorT));
									   DT.setTextvalue(template);
								   }
								   if (shorttext.contains("$("+iteratorT+")")) {
									   shorttext = shorttext.replace("$("+iteratorT+")", selResult0.getString(iteratorT));
									   DT.setShorttextvalue(shorttext);
								   }
								   if (shorttextT.contains("$("+iteratorT+")")) {
									   shorttextT = shorttextT.replace("$("+iteratorT+")",selResult0.getString(iteratorT));
									   DT.setShorttext(shorttextT);
								   }
							   }
							   g.getResultText().set(j, DT);
						}
					}
					if(!g.isItemready()){
						g.initItems();
					}
				}
				//logger.error("group's sql is  complete."+g.getKeyword());
			}
		}
		long end=System.currentTimeMillis();
		logger.info("end get groups,current time is "+end+", total time is "+(end-start)+"ms");
		//返回所有group
		logger.info("groups all ready>>>"+JSON.toJSONString(groups));
		return groups;
	}
	
	public static void main(String [] args){
		DashboardManager.initAnyscDownloader();
		DashboardManager manager=new DashboardManager();
		JSONObject params=new JSONObject();
		params.put("start_date","2015-01-01");
		params.put("end_date","2016-01-01");
		params.put("term_no","20151");
		params.put("yjz","8");
		params.put("class_no","2015140140");
		params.put("week","7");
		params.put("term_start_time","20150908");
		params.put("dep_no","2240");
		params.put("login_no", "1996100158");
		manager.getGroups(params,"teacher");
	}
	
}
