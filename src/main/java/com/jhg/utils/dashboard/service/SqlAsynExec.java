package com.jhg.utils.dashboard.service;

import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;
import com.jhg.utils.dashboard.bean.DashboardGroup;

public class SqlAsynExec {
	private static  Logger logger = Logger.getLogger(SqlAsynExec.class); 
	//执行sql语句，获得执行结果
	public DashboardGroup getSqlResult(DashboardGroup group){
		String sql=group.getSelectsql();
		JSONObject params=group.getSqlparams();
		String newSql=sqlstatement(sql,params);
		//group.setSelectsql(newSql);
		JSONResponse jr=new JSONResponse();
		//logger.error("begin select>>>>"+group.getKeyword()+">>>>"+newSql);
		ExecResult er=jr.getSelectResult(newSql, null, "tb");
		//logger.error("end select>>>>"+group.getKeyword()+">>>>"+er.toString());
		group.setIscalc(true);
		//查询正确返回结果
		if(er.getResult()>0){
			group.setSqlresult(er.getData());
		}else{//如果查询出错
			group.setMessage("sql查询为空或者查询错误");
			//logger.error("sql select wrong!!!"+newSql);
		}
		return group;
	}
	
	private String sqlstatement(String sql,JSONObject params){
		//logger.info("sql>>>>"+sql);
		//logger.info("sql params>>>>"+params.toJSONString());
		for (Map.Entry<String, Object> entry : params.entrySet()) {
			String param="$("+entry.getKey()+")";
			//logger.info("param>>"+param+","+entry.getKey()+","+(String)entry.getValue());
			if(sql.indexOf(param)>=0){
				//logger.info("********************************************"+sql);
				sql=sql.replace(param,(String)entry.getValue());
				//logger.info("********************************************"+sql);
			}
        }
		//logger.info("newsql>>>>"+sql);
		return sql;
	}
}
