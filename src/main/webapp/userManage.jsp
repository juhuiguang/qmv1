<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/commonjsp/doctype.jsp"%>
		<html>

		<head>
			<%@ include file="/commonjsp/meta.jsp"%>
				
		</head>

		<body>
			<%@ include file="/commonjsp/header.jsp"%>
				<iframe id="container" name = "userManageIframe" class = "userManageIframe" style = "" scrolling="no"> 
				</iframe> 
		</body>
		<script> 
			$(function() { 
			
				 $('#container').attr('src' ,$.getUrl({
						config:{
							fromurl:"testLogin.html",
							tourl:"userManage.jsp" ,
							time:new Date().getTime()
						} 
					})); 
				 
				 
			});
		</script>
				