package com.service.base;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.jeecgframework.poi.word.WordExportUtil;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.jhg.db.ExecResult;
import com.service.base.bean.QmPatrolReportEntity;

/**
 * Servlet implementation class DownLoadServlet
 */
@WebServlet("/DownLoadServlet")
public class DownLoadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String separator = File.separator;
	private BaseReportService service = new BaseReportService();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DownLoadServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		// 执行文件写入
		response.setHeader("Content-Disposition", "attachment;filename=" + "123.xls");
		// 获取输出流
		OutputStream outputStream = response.getOutputStream();

		// 根据巡查报告ID获取报告数据
		ExecResult result = service.getPatrolReportInfById("6");
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
				String rootFilePath = request.getSession().getServletContext().getRealPath("/") + separator + "template"
						+ separator + "qmreport.docx";
				try {
					XWPFDocument doc = WordExportUtil.exportWord07(rootFilePath, map);
					outputStream = new FileOutputStream(
							"d:/第" + map.get("reportweek") + "周《校督学巡查记录表》.docx");
					doc.write(outputStream);
					outputStream.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {

			}
		}
	}

}
