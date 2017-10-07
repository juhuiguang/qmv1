package com.service.base;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;

import com.jhg.common.DateUtils;
import com.jhg.mvc.Action;

public class UploadAction extends Action {
	String realFilePath = "";
	String dataFilePath = "";
	// 保存后的文件名
	String imageName = null;
	String separator = File.separator;

	public void upload() {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // 设置编码
		realFilePath = "";
		dataFilePath = "";
		String rootFilePath = request.getSession().getServletContext().getRealPath("/") +separator + "importupload"+separator;
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

		// 创建磁盘文件工厂
		DiskFileItemFactory fac = new DiskFileItemFactory();
		// 创建servlet文件上传组件
		ServletFileUpload upload = new ServletFileUpload(fac);
		// 解决上传文件名的中文乱码
		upload.setHeaderEncoding("utf-8");
		// 文件列表
		List fileList = null;
		// 解析request从而得到前台传过来的文件
		try {
			fileList = upload.parseRequest(request);
		} catch (FileUploadException ex) {
			ex.printStackTrace();
			return;
		}

		// 便利从前台得到的文件列表
		Iterator<FileItem> it = fileList.iterator();
		while (it.hasNext()) {
			FileItem item = it.next();
			// 如果不是普通表单域，当做文件域来处理
			if (!item.isFormField()) {
				imageName = new Date().getTime() + (int) (Math.random() * 10000) + item.getName();
				realFilePath += imageName;

				try {
					BufferedInputStream in;
					BufferedOutputStream out;
					in = new BufferedInputStream(item.getInputStream());
					out = new BufferedOutputStream(new FileOutputStream(new File(realFilePath)));
					Streams.copy(in, out, true);
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
		}
		try {
			System.out.println("上传地址为：" + realFilePath);
			response.getWriter().write(realFilePath);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
