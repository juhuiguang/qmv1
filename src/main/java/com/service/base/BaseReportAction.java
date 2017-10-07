package com.service.base;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.jeecgframework.poi.word.WordExportUtil;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.jhg.common.DateUtils;
import com.jhg.common.QMWordUtil;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;
import com.service.base.bean.QmPatrolReportEntity;
import com.service.master.MasterJudgeChartService;
import com.service.master.MasterViewJudgeService;

import jxl.write.WritableWorkbook;

public class BaseReportAction extends Action {
	private static final String CONTENT_TYPE = "application/msword";
	String separator = File.separator;
	private BaseReportService service = new BaseReportService();

	public void getReportInf() {
		String result = "";
		String term_no = request.getParameter("term_no");
		String teacher_no = request.getParameter("teacher_no");
		String dep_no = request.getParameter("dep_no");
		result = (service.getReportInf(term_no, teacher_no, dep_no)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void getTermInf() {
		String result = "";
		result = (service.getTermInf()).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void postReportInf() {
		String term_no = request.getParameter("term_no");
		String teacher_no = request.getParameter("teacher_no");
		String dep_no = request.getParameter("dep_no");
		String report_publish = request.getParameter("report_publish");
		String report_week = request.getParameter("report_week");
		String report_date = request.getParameter("report_date");
		String report_stuattendance = request.getParameter("report_stuattendance");
		String report_stustudy = request.getParameter("report_stustudy");
		String report_teateach = request.getParameter("report_teateach");
		String report_teachmanage = request.getParameter("report_teachmanage");
		String report_teachsecurity = request.getParameter("report_teachsecurity");
		String report_other = request.getParameter("report_other");
		String id = request.getParameter("id");
		String result = "";
		result = (service.postReportInf(term_no, teacher_no, dep_no, report_publish, report_week, report_date,
				report_stuattendance, report_stustudy, report_teateach, report_teachmanage, report_teachsecurity,
				report_other, id)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void deleteReportInf() {

		String id = request.getParameter("id");
		String result = "";
		result = (service.deleteReportInf(id)).toString();
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 导出巡查报告
	 */
	public void exportReport() {
		String report_no = request.getParameter("report_no");
		System.out.println("获取导出巡查报告的ID为：" + report_no);
		// 根据巡查报告ID获取报告数据
		ExecResult result = service.getPatrolReportInfById(report_no);
		if (result != null) {
			JSONArray aJsonArray = result.getData();
			List<QmPatrolReportEntity> mList = JSON.parseArray(aJsonArray.toJSONString(), QmPatrolReportEntity.class);
			if (mList != null && mList.size() > 0) {
				System.out.println("获取需要导出的报告内容周次为：" + mList.get(0).getReport_week());
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("reportweek", mList.get(0).getReport_week());
				int monthone = Integer.parseInt(mList.get(0).getReport_date().substring(0, 2));
				int dayone = Integer.parseInt(mList.get(0).getReport_date().substring(2, 4));
				int monthtwo = Integer.parseInt(mList.get(0).getReport_date().substring(5, 7));
				int daytwo = Integer.parseInt(mList.get(0).getReport_date().substring(7, 9));
				String date = monthone + "月" + dayone + "日~" + monthtwo + "月" + daytwo + "日";
				map.put("reporttime", date);
				map.put("department", "质量监控与评估处");
				map.put("report_stuattendance", mList.get(0).getReport_stuattendance());
				map.put("report_stustudy", mList.get(0).getReport_stustudy());
				map.put("report_teateach", mList.get(0).getReport_teateach());
				map.put("report_teachmanage", mList.get(0).getReport_teachmanage());
				map.put("report_teachsecurity", mList.get(0).getReport_teachsecurity());
				map.put("report_other", mList.get(0).getReport_other());
				String codedFileName = "临时文件.docx";
				try {
					if (isIE(request)) {
						codedFileName = java.net.URLEncoder.encode(codedFileName, "UTF8");
					} else {
						codedFileName = new String(codedFileName.getBytes("UTF-8"), "ISO-8859-1");
					}
					response.setHeader("content-disposition", "attachment;filename=" + codedFileName);
					String rootFilePath = request.getSession().getServletContext().getRealPath("/") + separator
							+ "template" + separator + "qmreport.docx";
					XWPFDocument document = WordExportUtil.exportWord07(rootFilePath, map);
					ServletOutputStream out = response.getOutputStream();
					document.write(out);
					out.flush();
				} catch (Exception e) {
					// TODO: handle exception
				}

			}
		}

	}

	public boolean isIE(HttpServletRequest request) {
		return (request.getHeader("USER-AGENT").toLowerCase().indexOf("msie") > 0
				|| request.getHeader("USER-AGENT").toLowerCase().indexOf("rv:11.0") > 0) ? true : false;
	}

	public void saveFile() {
		String realFilePath = "";
		String dataFilePath = "";
		String separator = File.separator;
		String rootFilePath = request.getSession().getServletContext().getRealPath("/") + separator + "exportfile"
				+ separator;
		// //文件存放的目录
		File tempDirPath = new File(rootFilePath);
		if (!tempDirPath.exists()) {
			tempDirPath.mkdirs();
		}
		// 设置文件保存至每天的路径目录
		dataFilePath = DateUtils.getCurrentDate();// DateUtil.dateToString(new
													// Date(),
		// DateUtil.FORMAT_FOUR);//yyyyMMdd日期格式的文件夹名
		realFilePath = rootFilePath + separator + dataFilePath;
		File dateStrFolder = new File(realFilePath);
		if (!dateStrFolder.exists() && !dateStrFolder.isDirectory()) {// 如果该日期目录不存在
			dateStrFolder.mkdir();
		}
		System.out.println("下载地址为：" + realFilePath);
	}

	private void download(String path) {
		System.out.println("下载地址为：" + path);
		try {
			// path是指欲下载的文件的路径。
			File file = new File(path);
			// 取得文件名。
			String filename = file.getName();
			// 以流的形式下载文件。
			InputStream fis = new BufferedInputStream(new FileInputStream(path));
			byte[] buffer = new byte[fis.available()];
			fis.read(buffer);
			fis.close();
			// 清空response
			response.reset();
			// 设置response的Header
			response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes("UTF-8")));
			response.addHeader("Content-Length", "" + file.length());
			OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
			response.setContentType("application/vnd.ms-word;charset=utf-8");
			toClient.write(buffer);
			toClient.flush();
			toClient.close();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}
}
