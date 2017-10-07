package com.jhg.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.exception.excel.ExcelImportException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 
 * 
 * © 2015 niitSoft
 * 
 * @Title: ExcelUtil.java
 * @Description: ExcelUtil处理类
 * @author LiKun
 * @date 2015年8月26日
 * @version V1.0
 *
 */
public class QMExcelUtil {
	
	private static final Logger logger = LoggerFactory.getLogger(QMExcelUtil.class);

	
	/**
	 * 解析ExcelFile导入
	 * 
	 * @param filePath
	 *            文件路径
	 * @param pojoClass
	 *            实体类
	 * @return
	 */
	public static <T> List<T> parseImportExcelFileToList(String filePath, Class<?> pojoClass) {
		// 解析导入的新课程数据
		if (!TypeUtils.isEmpty(filePath)) {
			System.out.println("解析ExcelFile文件地址为:" + filePath);
			List<T> temp = ImportParseExcel(filePath, pojoClass);
			if (temp != null && temp.size() > 0) {
				return temp;
			} else {
				logger.info("parseImportExcelFileToList解析Excel文件数据为空/异常:" + pojoClass.getSimpleName());
				return null;
			}
		} else {
			logger.info("parseImportExcelFileToList解析Excel文件路径为空:" + pojoClass.getSimpleName());
			return null;
		}
	}
	
	
	/**
	 * 通用解析excel
	 * 
	 * @param filePath
	 *            文件路径
	 * @param pojoClass
	 *            类
	 * @return
	 */
	private static <T> List<T> ImportParseExcel(String filePath, Class<?> pojoClass) {

		List<T> ims = new ArrayList<>();
		try {
			File excelFile = new File(filePath);
			if (excelFile.exists()) {
				ImportParams params = new ImportParams();
				long start = new Date().getTime();
				ims = ExcelImportUtil.importExcel(new FileInputStream(excelFile), pojoClass, params);
				logger.info("导入花费时间为：" + (new Date().getTime() - start));
				logger.info("导入的数据长度为：" + ims.size());
				if (ims != null && ims.size() > 0) {
					// ReflectionToStringBuilder.toString(list.get(0))
					// JSONArray jsonArray =
					// JSON.parseArray(JSONArray.toJSONString(list, true));
					// result.setData(jsonArray);
					// logger.info("导入的数据第一行内容：" + ims.get(0).toString());
					return ims;
				} else {
					logger.warn("导入的数据不能为空！");
					return null;
				}
			} else {
				System.out.println("文件异常：系统找不到指定的路径。");
				// new JSONResponse().getError("文件异常：系统找不到指定的路径.")
				return null;
			}
		} catch (NullPointerException nullError) {
			logger.error("空指针异常：" + nullError.getMessage(), nullError);
			// new JSONResponse().getError("空指针异常：" + nullError.getMessage())
			return null;
		} catch (FileNotFoundException noFoundError) {
			logger.error("文件异常:" + noFoundError.getMessage(), noFoundError);
			// new JSONResponse().getError("文件异常:" + noFoundError.getMessage())
			return null;
		} catch (IOException ioError) {
			logger.error("IO异常：" + ioError.getMessage(), ioError);
			// new JSONResponse().getError("IO异常：" + ioError.getMessage())
			return null;
		} catch (ExcelImportException excelImportError) {
			logger.error("Excel表导入异常：" + excelImportError.getMessage(), excelImportError);
			// new JSONResponse().getError("Excel表导入异常：" +
			// excelImportError.getMessage())
			return null;
		} catch (Exception e) {
			logger.error("未知异常：" + e.getMessage(), e);
			// new JSONResponse().getError("未知异常：" + e.getMessage())
			return null;
		}

	}

}
