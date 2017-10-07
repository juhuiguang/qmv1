package com.jhg.common;

import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Map;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.jeecgframework.poi.word.WordExportUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 
 * 
 * © 2015 niitSoft
 * 
 * @Title: QMWordUtil.java
 * @Description: Word处理类
 * @author LiKun
 * @date 2015年8月26日
 * @version V1.0
 *
 */
public class QMWordUtil {

	private static final Logger logger = LoggerFactory.getLogger(QMWordUtil.class);

	/**
	 * 演示word导出无列表
	 */
	public static void DemoWordExport() {
		Map<String, Object> map = new HashMap<String, Object>();
		// map.put("department", "Jeecg");
		// map.put("person", "JueYue");
		// map.put("time", format.format(new Date()));
		// map.put("me", "JueYue");
		// map.put("date", "2015-01-03");
		map.put("reportweek", "十");
		map.put("reporttime", "9月6日到9月8日");
		map.put("department", "质量监控与评估处");
		map.put("report_stuattendance", "本周全校学生出勤率为" + "18%");
		map.put("report_stustudy", "测试导出： 正常。");
		map.put("report_teateach",
				"测试导出：1、	文理学院高崚嶒老师批改学生作业高度认真、负责，即使作业量十分大时，他依然保持给每位学生的作业都有批注，并详尽记录每一次学生作业的完成质量，以便将作业中出现的问题在下一次课堂教学上进行纠正");
		map.put("report_teachmanage", "测试导出：正常。");
		map.put("report_teachsecurity",
				"测试导出：1、	教一408教室的投影图面偏移严重，需要重新调试；2、	教一J1304教室没有窗帘，师生无法看清投影仪投出的画面，且当天气炎热时该教室通风、隔热效果差，酷热难耐，影响上课。");
		map.put("report_other", "测试导出：暂无");
		try {
			XWPFDocument doc = WordExportUtil.exportWord07("d:/QmReport.docx", map);
			FileOutputStream fos = new FileOutputStream("d:/第" + map.get("reportweek") + "周《校督学巡查记录表》.docx");
			doc.write(fos);
			fos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
