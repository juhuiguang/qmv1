package com.service.base;

import java.io.IOException;

import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

public class mymajorAction extends Action {
	
		public void getbase_major(){
		String result="";
		mymajorService service=new mymajorService();
		result=(service.dbgetbase_major()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
		public void insetdb_add(){
		String major_no= request.getParameter("reqmajorno");
		String major_na= request.getParameter("reqmajorna");
		String result="";
		if(major_no==null||major_na==null){
			ExecResult rs=new ExecResult(false,"获取失败");
			result=rs.toString();
		}else{
			mymajorService service=new mymajorService();
			result=(service.insertmajor(major_no,major_na)).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
		public void searchmajor(){
			String result="";
			mymajorService service=new mymajorService();
			result=(service.dbsearch_major()).toString();
			try {
				response.getWriter().write(result);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		public void loaddelete(){
			String result="";
			String major_no= request.getParameter("major_no");
			String major_na= request.getParameter("major_na");
			mymajorService service=new mymajorService();
			result=(service.deleteMajor(major_no,major_na)).toString();
			try {
				response.getWriter().write(result);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
}


