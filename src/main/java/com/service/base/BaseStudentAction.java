package com.service.base;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.jhg.common.QMExcelUtil;
import com.jhg.common.TypeUtils;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.base.bean.BaseStudentEntity;
import com.service.base.bean.ImportFileStudentEntity;

public class BaseStudentAction extends Action {

	private BaseStudentService studentService = new BaseStudentService();
	private BaseTeamService teamService = new BaseTeamService();

	/**
	 * 批量添加
	 */
	public void addBaseStudent() {
		String term_no = "";
		List<BaseStudentEntity> list = new ArrayList<BaseStudentEntity>();
		ExecResult result = studentService.addBaseStudentService(term_no, list);
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 批量删除
	 */
	public void delBaseStudent() {
		List<BaseStudentEntity> list = new ArrayList<BaseStudentEntity>();
		ExecResult result = studentService.delBaseStudentService(list);
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

    /**
     * 删除单个学生
     */
    public void deleteBaseStudent() {
        String stu_no = request.getParameter("stu_no");
        ExecResult result = studentService.deleteBaseStudentService(stu_no);
        try {
            response.getWriter().write(result.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

	/**
	 * 更新
	 */
	public void updateBaseStudent() {
		BaseStudentEntity studentObject = new BaseStudentEntity();
		String term_no = request.getParameter("term_no");
		String temp_term_no = request.getParameter("temp_term_no");
		studentObject.setStu_no(request.getParameter("stu_no"));
		studentObject.setStu_name(request.getParameter("stu_name"));
		studentObject.setStu_birthday(request.getParameter("stu_birthday").replace("-", ""));
		studentObject.setStu_phone(request.getParameter("stu_phone"));
		studentObject.setStu_major_init(request.getParameter("major_no"));
		studentObject.setStu_year(request.getParameter("stu_year"));
		studentObject.setClass_no(request.getParameter("class_no"));
		ExecResult result = studentService.updateBaseStudentService(studentObject,term_no,temp_term_no);
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 更新学生状态
	 */
	public void updateBaseStudentStatus() {
		String stu_no = request.getParameter("stu_no");
		String stu_status = request.getParameter("stu_status");
		if (stu_status.equals("1")) {
			stu_status = "0";
		} else if (stu_status.equals("0")) {
			stu_status = "1";
		}
		ExecResult result = studentService.updateBaseStudentStatusService(stu_no, stu_status);
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获取学生列表
	 */
	public void getBaseStudentList() {
		String pageindex = request.getParameter("pageindex");
		String pageLength = request.getParameter("pageLength");
		String temppage = request.getParameter("temppage");
		String year = request.getParameter("year");
		String dep_no = request.getParameter("temp_dep_no");
		String result = "";
		com.alibaba.fastjson.JSONObject jo = new com.alibaba.fastjson.JSONObject();
		BaseStudentService service = new BaseStudentService();
		ExecResult r1 = (service.queryBaseStudentListService(Integer.parseInt(pageLength), Integer.parseInt(pageindex),
				year, dep_no));
		if (Integer.parseInt(temppage) == 1) {
			ExecResult r2 = (service.querygetBaseStuListCountService(year, dep_no));
			jo.put("total", r2.getData().getJSONObject(0).getString("totalrows"));
		}
		jo.put("rows", r1.getData());
		result = jo.toJSONString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获取学年信息
	 */

	public void getTermYear() {
		String result = "";
		BaseStudentService service = new BaseStudentService();
		result = (service.getTermYear()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void getStuYear() {
		String result = "";
		BaseStudentService service = new BaseStudentService();
		result = (service.getStuYear()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 模糊查询(学号、学生姓名、入学年份)
	 */
	public void searchBaseStudentList() {
		String pageindex = request.getParameter("pageindex");
		String pageLength = request.getParameter("pageLength");
		String temppage = request.getParameter("temppage");
		String year = request.getParameter("year");
		String dep_no = request.getParameter("dep_no");
		String search_like_data = request.getParameter("search_like_data");
		com.alibaba.fastjson.JSONObject jo = new com.alibaba.fastjson.JSONObject();
		BaseStudentService service = new BaseStudentService();
		ExecResult r1 = (service.searchBaseStudentListService(Integer.parseInt(pageLength), Integer.parseInt(pageindex),
				year, dep_no, search_like_data));
		if (Integer.parseInt(temppage) == 1) {
			ExecResult r2 = (service.searchBaseStudentListCountService(year, dep_no, search_like_data));
			jo.put("total", r2.getData().getJSONObject(0).getString("totalrows"));
		}
		jo.put("rows", r1.getData());
		String result = jo.toJSONString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 模糊查询(学号或学生姓名)
	 */
	public void searchBaseStudentListByNameOrNum() {
		String pageindex = request.getParameter("pageindex");
		String pageLength = request.getParameter("pagelength");

		System.out.println("pageindex"+pageindex);
		System.out.println("pageLength"+pageLength);
		String temppage = request.getParameter("temppage");
		String search_like_data = request.getParameter("search_like_data");
		com.alibaba.fastjson.JSONObject jo = new com.alibaba.fastjson.JSONObject();
		BaseStudentService service = new BaseStudentService();
		ExecResult r1 = (service.searchBaseStudentListByNameOrNumService(Integer.parseInt(pageLength), Integer.parseInt(pageindex), search_like_data));
		if (Integer.parseInt(temppage) == 1) {
			ExecResult r2 = (service.searchBaseStudentListByNameOrNumCountService(search_like_data));
			jo.put("total", r2.getData().getJSONObject(0).getString("totalrows"));
		}
		jo.put("rows", r1.getData());
		String result = jo.toJSONString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 导入学生Excel
	 */
	public void importExcelBaseStudents() {
		String term_no = request.getParameter("term_no");
		String stuFilePath = request.getParameter("student_file_path");
		ExecResult result = new ExecResult();
		result.setResult(false);
		result.setMessage("导入异常,需重新导入。");
		// 0判断文件是否存在
		if (TypeUtils.isEmpty(stuFilePath)) {
			result.setMessage("导入异常，上传的excel表失败，请重新导入");
		}else{
			// 1解析导入学生为List
			List<ImportFileStudentEntity> fileStudentEnts = QMExcelUtil.parseImportExcelFileToList(stuFilePath,
					ImportFileStudentEntity.class);
			if (fileStudentEnts != null && fileStudentEnts.size() > 0) {
				result = studentService.importExcel(term_no ,fileStudentEnts);
			} else {
				result.setMessage("导入异常，Excel表内容可能为空，请重新导入");
			}
			//
			if (TypeUtils.isEmpty(result.getMessage())) {
				result.setMessage("0");
			}
		}
		
		try {
			response.getWriter().write(result.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	/**
	 * 拉取导航的信息
	 */
	public void loadNavigationInfo() {
		String term_no = request.getParameter("term_no");
		String result="";
		if(term_no==null||term_no==""){
			result = new ExecResult(false,"学期传入错误").toString();
		}else{
			BaseStudentService service = new BaseStudentService();
			result = service.loadNavigationInfoService(term_no).toString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 拉取部门信息
	 */
	public void getdepartmentInfo() {
		String result="";
			BaseStudentService service = new BaseStudentService();
			result = service.getdepartmentInfoService().toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 根据学年和部门获得表格班级信息
	 */
	public void getTableInfo() {
		String class_year = request.getParameter("class_year");
		String dep_no = request.getParameter("dep_no");
		String pageindex = request.getParameter("pageindex");
		String pagelength = request.getParameter("pagelength");
		String stu_name = request.getParameter("stu_name");
		String totaltemp = request.getParameter("totaltemp");
		String class_no = request.getParameter("class_no");
		String term_no = request.getParameter("term_no");
		String result="";
		if (class_year==null||dep_no==null) {
			ExecResult r = new ExecResult(false,"学年或部门信息错误");
			result = r.toString();
		}else{
			JSONObject jObject = new JSONObject();
			BaseStudentService service = new BaseStudentService();
			ExecResult r1 = service.getTableInfo(class_year,dep_no,Integer.parseInt(pageindex),Integer.parseInt(pagelength),stu_name,term_no,class_no);
			ExecResult r2 = new ExecResult();
			if ("1".equals(totaltemp)) {
				r2 = service.getTableInfoCount(class_year,dep_no, stu_name,term_no,class_no);
				if (r2.getData().size()>0) {
					jObject.put("total", r2.getData().getJSONObject(0).get("total"));
				}
			}
			
			jObject.put("info", r1);
			result = jObject.toJSONString();
		}
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	 
	/**
	 * 复制班级数据
	 */
	public void copyDataInfo() {
		String class_year = request.getParameter("class_year");
		String dep_no = request.getParameter("dep_no");
		String class_no = request.getParameter("class_no");
		String term_no = request.getParameter("term_no");
		String r = "";
		if (class_year==null||dep_no==null) {
			 r = new ExecResult(false,"学年或部门信息错误").toString();
		}else{
			BaseStudentService service = new BaseStudentService();
			 r = service.copyData(class_year,dep_no,term_no,class_no).toString();
		}
		try {
			response.getWriter().write(r);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	 
	
	 public void insertNewStudent(){
		 String tempPhone = request.getParameter("tempPhone");
		 String class_name = request.getParameter("class_name");
		 String stu_no = request.getParameter("stu_no");
		 String stu_name = request.getParameter("stu_name");
		 String stu_birthday = request.getParameter("stu_birthday");
		 String major_name = request.getParameter("major_name");
		 String stu_year = request.getParameter("stu_year");
		 String stu_status = request.getParameter("stu_status");
		 String term_no = request.getParameter("term_no");
         ExecResult class_no = new  BaseClassService().getclassNoByclassName(class_name);
         ExecResult major_no_ = new mymajorService().getmajorNoBymajorName(major_name) ;
         JSONObject class_noObject = new JSONObject((Map<String, Object>) class_no.getData().get(0));
         JSONObject major_no_Object = new JSONObject((Map<String, Object>) major_no_.getData().get(0));
         String classNo = class_noObject.getString("class_no");
         String majorNo = major_no_Object.getString("major_no");
		 String result = "";
		 result = new BaseStudentService().insertNewStudent(tempPhone,classNo , stu_no, stu_name, stu_birthday,majorNo, stu_year, stu_status,term_no).toString();


		 try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	 }
	 
	 public void getBaseClass(){
		 String class_year = request.getParameter("class_year");
		 String dep_no = request.getParameter("dep_no");
		 String result = "";
		 result = new BaseStudentService().getBaseClass(class_year, dep_no).toString();
		 try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	 }

	public void getAllClass(){
		String result = "";
		result = new BaseStudentService().getAllClass().toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	 
	 public void getclassInfo(){
		 String term[] = request.getParameter("temp").split(",");
		 String dep_no = request.getParameter("dep_no");
		 String result = "";
		 if(term.length==0){
			 result = new ExecResult(false,"学期编号传入错误").toString();
		 }else{
			 BaseStudentService baseStudentService = new BaseStudentService();
			 result = baseStudentService.getClassInfo(term, dep_no).toString();
		 }
		 try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	 }

}
