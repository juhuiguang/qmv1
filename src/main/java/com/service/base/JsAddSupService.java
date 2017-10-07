package com.service.base;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult; 
import com.jhg.response.JSONResponse;
import com.service.base.bean.BaseTeacherEntity;
import com.service.system.SystemService;
public class JsAddSupService {
	public ExecResult getAddTeacher (String dep_no) {
		// TODO Auto-generated method stub 
		String sql="";
		if(dep_no.equals("all")){
			 sql = "SELECT c.dep_name,a.teacher_name ,a.teacher_no ,d.user_id FROM base_teacher a LEFT JOIN qm_master b ON a.teacher_no=b.teacher_no AND a.teacher_status=1 LEFT JOIN base_department c ON c.dep_no=a.dep_no LEFT JOIN tb_user d ON d.user_loginname=a.teacher_no WHERE master_no IS NULL";
		}else{
			 sql = "SELECT c.dep_name,a.teacher_name ,a.teacher_no ,d.user_id FROM base_teacher a LEFT JOIN qm_master b ON a.teacher_no=b.teacher_no AND a.teacher_status=1 LEFT JOIN base_department c ON c.dep_no=a.dep_no LEFT JOIN tb_user d ON d.user_loginname=a.teacher_no WHERE master_no IS NULL and a.dep_no="+dep_no+"";
		}
		
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getSelectResult(sql, null, "");
		return result;
	}
	public ExecResult postSup (String teacher_no,String teacher_name,String type ,String id) {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO qm_master(master_type,teacher_no ,master_status) VALUES(''{2}'',''{0}'','1')";
		String [] params=new String[] {teacher_no,teacher_name,type,id}; 
		SystemService service=new SystemService();
		if(id.equals("")){ 
			service.createUser(teacher_name , teacher_no,"123456",type);
		}else{
			service.genRoleData(id,type); 
		}
		JSONResponse jr = new JSONResponse();
		ExecResult result = jr.getExecResult(sql, params, "", ""); 
		return result;
	}
}
