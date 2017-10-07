package com.jhg.utils;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class WebUploader {
	private HttpServletRequest request = null;
	private HttpServletResponse response = null;
	private HashMap<String, String> errorInfo = new HashMap<String, String>();
	
	public WebUploader(HttpServletRequest request,HttpServletResponse response) {
		this.request = request;
		this.response = response;
		HashMap<String, String> tmp = this.errorInfo;
		tmp.put("SUCCESS", "SUCCESS"); //默认成功
		tmp.put("NOFILE", "未包含文件上传域");
		tmp.put("TYPE", "不允许的文件格式");
		tmp.put("SIZE", "文件大小超出限制");
		tmp.put("ENTYPE", "请求类型ENTYPE错误");
		tmp.put("REQUEST", "上传请求异常");
		tmp.put("IO", "IO异常");
		tmp.put("DIR", "目录创建失败");
		tmp.put("UNKNOWN", "未知错误");
		
	}
	public void upload() throws Exception {
		request.setCharacterEncoding("utf-8");  //设置编码
	    String returnUrl =  null; //文件路径
	    //获得磁盘文件条目工厂
	    DiskFileItemFactory factory = new DiskFileItemFactory();
	    
	    String separator = File.separator;
	    
	    //获取文件需要上传到的路径
	    String path = request.getSession().getServletContext().getRealPath("/");
    	String shotUrl =path.split(separator + "webapps")[0];
    	
    	shotUrl = shotUrl.substring(0, shotUrl.length()-1);	   
    	path = shotUrl.substring(0,shotUrl.lastIndexOf(separator)) + separator + "resservices" + separator + "goods_images" + separator;
    	
		String dateStr = "20141105";//DateUtil.dateToString(new Date(), DateUtil.FORMAT_FOUR);//yyyyMMdd日期格式的文件夹名
		File dateStrFolder = new File(path + dateStr);
		
		if(!dateStrFolder.exists() && !dateStrFolder.isDirectory()){//如果该日期目录不存在
			dateStrFolder.mkdir();
		}
	    //如果没以下两行设置的话，上传大的 文件 会占用 很多内存，
	    //设置暂时存放的 存储室 , 这个存储室，可以和 最终存储文件 的目录不同
	    /**
	     * 原理 它是先存到 暂时存储室，然后在真正写到 对应目录的硬盘上， 
	     * 按理来说 当上传一个文件时，其实是上传了两份，第一个是以 .tem 格式的 
	     * 然后再将其真正写到 对应目录的硬盘上
	     */
	    factory.setRepository(dateStrFolder);
	    
	    //设置 缓存的大小，当上传文件的容量超过该缓存时，直接放到 暂时存储室
	    factory.setSizeThreshold(1024*1024) ;
	    
	    //文件上传处理
	    ServletFileUpload upload = new ServletFileUpload(factory);
	    
	    try {
	      //可以上传多个文件
	      List<FileItem> list = (List<FileItem>)upload.parseRequest(request);
	      
	      for(FileItem item : list){
	        //获取表单的属性名字
	        String name = item.getFieldName();
	        
	        //如果获取的 表单信息是普通的 文本 信息
	        if(item.isFormField()){         
	          //获取用户具体输入的字符串 ，名字起得挺好，因为表单提交过来的是 字符串类型的
	          String value = item.getString() ;
	          request.setAttribute(name, value);
	        } else {//对传入的非 简单的字符串进行处理 ，比如说二进制的 图片，电影这些
	          /**
	           * 以下三步，主要获取 上传文件的名字
	           */
	          //获取路径名
	          String value = item.getName();
	          
	          UUID uuid = UUID.randomUUID();//生成随机字符串
	          String currFileName =  uuid + value.substring(value.indexOf("."), value.length());//文件名
	          returnUrl = separator + "goods_images" +separator + dateStr + separator + currFileName;
	          //String currFileUrl = path + dateStr + separator + currFileName;
	          File currFile =  new File(path + dateStr,currFileName);
	          item.write(currFile);//第三方提供
	          
	        }
	      }
	      //设置头信息
	      this.response.setContentType("text/plain;charset=UTF-8");
	      PrintWriter wirter= response.getWriter();;
	      if(wirter!=null){
	    	  wirter.write(returnUrl);
	    	  wirter.close();
	      }
	    } catch (FileUploadException e) {
	      e.printStackTrace();
	    }
	    catch (Exception e) {
	      //捕获item.write的异常
	      e.printStackTrace();
	    }
	}
}
