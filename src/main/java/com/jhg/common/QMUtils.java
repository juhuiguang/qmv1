package com.jhg.common;

import java.beans.PropertyDescriptor;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.PropertyUtilsBean;
import org.apache.poi.ss.usermodel.Workbook;
import org.jeecgframework.poi.excel.ExcelExportUtil;
import org.jeecgframework.poi.excel.entity.TemplateExportParams;

/**
 * 
 * © 2015 niitSoft
 * 
 * @Title: Utils.java
 * @Description: 常用处理类
 * @author LiKun
 * @date 2015年8月8日
 * @version V1.0
 *
 */
public class QMUtils {

	// private static final Logger logger =
	// LoggerFactory.getLogger(Utils.class);

	/**
	 * bean类转换map
	 * 
	 * @param obj
	 * @return
	 */
	public static Map<String, String> beanToMap(Object obj) {
		Map<String, String> params = new HashMap<String, String>(0);
		try {
			PropertyUtilsBean propertyUtilsBean = new PropertyUtilsBean();
			PropertyDescriptor[] descriptors = propertyUtilsBean.getPropertyDescriptors(obj);
			for (int i = 0; i < descriptors.length; i++) {
				String name = descriptors[i].getName();
				if (!"class".equals(name)) {
					params.put(name, (String) propertyUtilsBean.getNestedProperty(obj, name));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return params;
	}

	/**
	 * 转换时间
	 * 
	 * @param str
	 *            时间不带横线
	 * @return
	 */
	public static String formatDateNoLine(String str) {
		if (TypeUtils.isEmpty(str)) {
			return "";
		}
		return DateUtils.format(str, "yyyymmdd", "yyyy-mm-dd");
	}

	/**
	 * 转换时间
	 * 
	 * @param str
	 *            时间带横线
	 * @return
	 */
	public static String formatDateLine(String str) {
		if (TypeUtils.isEmpty(str)) {
			return "";
		}
		return DateUtils.format(str, "yyyy-mm-dd", "yyyymmdd");
	}

	/**
	 * 模板生成Excel导出到磁盘
	 * 
	 * @param templateFilePath
	 *            模板文件路径
	 * @param map
	 *            数据封装map
	 * @param outputFilePath
	 *            输出文件路径
	 * @throws IOException
	 *             抛出异常
	 * 
	 */
	public static void exportTemplateToDisc(String templateFilePath, Map<String, Object> map, String outputFilePath)
			throws IOException {
		TemplateExportParams params = new TemplateExportParams(templateFilePath);
		Workbook workbook = ExcelExportUtil.exportExcel(params, map);
		FileOutputStream fos = new FileOutputStream(outputFilePath);
		workbook.write(fos);
		fos.close();
	}

	public static void exportTemplateToOutPutStream(HttpServletRequest request, HttpServletResponse response,
			String fileName, String templateFilePath, Map<String, Object> map) throws Exception {
		response.setCharacterEncoding("UTF-8");
		// 设置响应头
		response.setContentType("application/vnd.ms-excel;charset=UTF-8");
		// 执行文件写入
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xls");
		// 获取输出流
		OutputStream outputStream = response.getOutputStream();
		TemplateExportParams params = new TemplateExportParams(templateFilePath);
		Workbook workbook = ExcelExportUtil.exportExcel(params, map);
		// 写入Excel
		workbook.write(outputStream);
		// 关闭Excel工作薄对象
		workbook.close();
		// 关闭流
		outputStream.flush();
		outputStream.close();
		outputStream = null;
	}

	/**
	 * 获取上一学年学期
	 * 
	 * @param term_no
	 *            当前学年学期
	 * @return
	 */
	public static String updateTermNo(String term_no) {
		String temp = term_no;
		if (term_no.length() > 5) {
			temp = term_no;
			return temp;
		} else {
			String year = term_no.substring(0, 4);
			String status = term_no.substring(4, 5);
			if (status.equals("1")) {
				temp = year;
			} else {
				temp = String.valueOf(Integer.valueOf(year) - 1);
			}

			if (status.equals("0")) {
				temp += 1;
			} else {
				temp += 0;
			}
			return temp;
		}

	}

	/**
	 * 解析课程代号
	 * 
	 * @param course
	 * @return
	 */
	public static String parseCourseNo(String course) {
		// [114242179]程序设计基础
		if (TypeUtils.isEmpty(course)) {
			return "";
		}
		String temp = course.substring(0, course.lastIndexOf("]"));
		return temp.substring(1);
	}

	/**
	 * 解析课程名称
	 * 
	 * @param course
	 * @return
	 */
	public static String parseCourseName(String course) {
		// [114242179]程序设计基础
		if (TypeUtils.isEmpty(course)) {
			return "";
		}
		String temp = course.substring(course.lastIndexOf("]") + 1);
		return temp;
	}

	/**
	 * 解析人数
	 * 
	 * @param total
	 * @return
	 */
	public static String parseCoursePeopTotal(String total) {
		// 99/100
		if (TypeUtils.isEmpty(total)) {
			return "";
		}
		String temp = total.substring(0, total.indexOf("/"));
		return temp;
	}

	public static void main(String[] args) {

	}

}
