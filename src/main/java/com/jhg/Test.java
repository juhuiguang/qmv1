package com.jhg;

import java.util.List;
import java.util.Map;

import com.jhg.db.DAO;
import com.jhg.utils.Azdg;

public class Test {
	public static void main(String [] args){
		String sql="select distinct user_pwd from tb_user where user_pwd not like 'I%' and user_type='学生'";
		DAO dao=new DAO();
		List<Map<String, Object>> l=dao.getDataSet(sql);
		Azdg a=new Azdg();
		for(int i=0;i<l.size();i++){
			Map<String,Object> item=l.get(i);
			String oldpwd=item.get("USER_PWD").toString();
			
			String pwd=a.encrypt(oldpwd);
			String update="update tb_user set user_pwd='"+pwd+"' where user_pwd='"+oldpwd+"'";
			System.out.println(update);
			dao.execCommand(update);
		}
	}
}
