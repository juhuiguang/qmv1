package com.service.master;

import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

public class DepartmentmaintainService {
    public ExecResult gettableinformationService(){
    	String sql="SELECT * FROM `base_department` ";
		JSONResponse jr=new JSONResponse();
		ExecResult result=jr.getSelectResult(sql,null,"");
		return result;
    }
    
    
    public ExecResult insertService(String dep_no,String dep_name,String  dep_type, String dep_cddw_no,String  dep_sort,String dep_abbreviation){
    	String sql="SELECT dep_no,dep_name FROM `base_department` WHERE dep_no=''{0}'' OR dep_name=''{1}''";
    	String [] params=new String[]{dep_no,dep_name};
		JSONResponse jr=new JSONResponse();
		ExecResult result=null;
		ExecResult resultselect=jr.getSelectResult(sql,params,"");
		if(resultselect.getData().size()==0){
			String sqlinsert="INSERT INTO `base_department` (dep_no,dep_name,dep_type,dep_cddw_no,dep_sort,dep_abbreviation) VALUES (''{0}'',''{1}'',''{2}'',''{3}'',''{4}'',''{5}'')";
			JSONResponse response=new JSONResponse();
			String [] insert =new String[]{dep_no,dep_name,dep_type,dep_cddw_no,dep_sort,dep_abbreviation};
			result= response.getExecResult(sqlinsert, insert, "部门添加成功","部门添加失败");
		}
		else{
		result=new ExecResult(false,"已存在的部门名称或编号，无法添加");
		}
		return result;
    }
    
    
    
    public ExecResult updatadepService( String dep_no1,String dep_no,String dep_name,String  dep_type, String dep_cddw_no,String  dep_sort,String dep_abbreviation){
		ExecResult result=null;
		String sqlinsert="UPDATE `base_department` SET dep_no=''{0}'',dep_name=''{1}'',dep_type=''{2}'',dep_cddw_no=''{3}'',dep_sort=''{4}'',dep_abbreviation=''{6}'' WHERE dep_no=''{5}''";
		JSONResponse response=new JSONResponse();
		String [] insert =new String[]{dep_no,dep_name,dep_type,dep_cddw_no,dep_sort,dep_no1,dep_abbreviation};
		result= response.getExecResult(sqlinsert, insert, "部门修改成功","部门修改失败"); 
		return result;
    }
    
    
    public ExecResult deleteService(String dep_no){
 		ExecResult result=null;
 		String sqlinsert="DELETE FROM `base_department`  WHERE dep_no=''{0}''";
 		JSONResponse response=new JSONResponse();
 		String [] insert =new String[]{dep_no};
 		result= response.getExecResult(sqlinsert, insert, "删除成功","删除失败"); 
 		return result;
     }
}
