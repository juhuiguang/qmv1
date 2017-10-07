<%@page import="org.apache.catalina.connector.Request"%>
<%@page import="com.jhg.utils.Uploader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="utf-8"%>
            <%
            request.setCharacterEncoding("utf-8");
        	response.setCharacterEncoding("utf-8");
            Uploader up = new Uploader(request);//接受前台传过来的表单
        /*     up.setSavePath("upload"); */
            String PATH1 = request.getContextPath();
        	String BASE_URL1  = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
        	String BASE_PATH1 = BASE_URL1 + PATH1 +"/";
        	 String BASE_HOME1 = BASE_PATH1 +"PersonalSpace/";
        	  String path1=request.getRealPath("/template"); 
        	  System.out.println(path1);
            up.setSavePath(path1);////文件保存 路径  
            
            System.out.println(path1);
            String[] fileType = { ".docx" , ".doc"};//限制其类型
            /* up.setSavePath("F:\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp41\\wtpwebapps\\PersonalSpace\\resource\\image\\photo");////文件保存 路径 
             up.setSavePath(path1+"\\resource\\image\\photo");////文件保存 路径 */
             up.setAllowFiles(fileType);
            up.setMaxSize(10000); //单位KB
            up.upload();
            String callback = request.getParameter("name");
            String term_no = request.getParameter("term_no");
            String course_no = request.getParameter("course_no");
            String teacher_no = request.getParameter("teacher_no");
				String filetype = request.getParameter("filetype");
            String result = "{\"name\":\""+ up.getFileName() +"\", \"originalName\": \""+ up.getOriginalName() +"\", \"size\": "+ up.getSize() +", \"state\": \""+ up.getState() +"\", \"type\": \""+ up.getType() +"\", \"url\": \""+ up.getPrivateUrl() +"\"}";
            System.out.println(result);
            result = result.replaceAll( "\\\\", "\\\\" );
            String url = up.getPrivateUrl();
            String file_name = up.getOriginalName();
            
            %>
             <% 
			    String PATH = request.getContextPath();
				String BASE_URL  = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
				String BASE_PATH = BASE_URL + PATH +"/";
				String BASE_HOME = BASE_PATH ;
				request.setAttribute("BASE_PATH", BASE_PATH);
			 %>
		<head>
		<base href="<%=BASE_PATH%>"> 
		<script src="script/common/jquery/jquery-2.0.0.min.js" type="text/javascript"></script>
		<script src="script/common/alert/jquery.alert.js" type="text/javascript"></script>
		<script src="script/common/jquery/jquery-resize.js"  type="text/javascript"></script>
		<link rel="stylesheet" href="script/common/alert/jquery.alert.css" />
		</head>
		<html>
		<body>
		</body>
		<script>
		//拿到了地址
		  var url='<%=url%>';
		  var file_name='<%=file_name%>'
		  var term_no='<%=term_no%>'
		  var teacher_no='<%=teacher_no%>'
		  var course_no='<%=course_no%>'
		  var state='<%=up.getState()%>'
        var filetype='<%=filetype%>'
		  if(state=="不允许的文件格式"){
			  $.alert(state,function(){
			  	window.close()
			  });
		  }else{
          if(url==""||url==null){
        	  $.alert("请先选择文件",function(){
			  	window.close()
			  });
          }else{
        	  $.ajax({
        		  url: "do?invoke=TeaUploadCoursePlan@insertFile",
 				 type: 'POST',
 				 dataType: 'json',
  				data:{
  					 url:url,
  				     file_name:file_name,
  				 	 term_no:term_no,
  					 teacher_no:teacher_no,
  					 course_no:course_no,
                    filetype:filetype
  				},
  				success:function(rep){
  					if(rep.result==0){
  						$.alert(rep.message,function(){
  							window.close();
  						})
  					}else{
  						$.alert("上传成功",function(){
  							window.close();
  						})
  					}
  					
  				}
  				});
          }
		  }
			
		</script>
		</html>
