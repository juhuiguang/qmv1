<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>
<link rel="stylesheet" href="script/common/uploadify/uploadify.css "
	type=" text/css" />
<script src="script/common/uploadify/swfobject.js"
	type="text/javascript"></script>
<script src="script/common/uploadify/jquery.uploadify.min.js"
	type="text/javascript"></script>

<!--这里引用其他样式-->
<title></title>
<style>
</style>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
		<table style="width: 90%;">
			<tr>
				<td style="width: 100px;"><input type="file" name="uploadify"
					id="uploadify" /></td>
				<td align="left"><a
					href="javascript:$('#uploadify').uploadifyUpload()">开始上传</a>| <a
					href="javascript:jQuery('#uploadify').uploadifyClearQueue()">取消上传</a>
					<span id="result" style="font-size: 13px; color: red"></span></td>
			</tr>
		</table>
		<div id="fileQueue"
			style="width: 400px; height: 300px; border: 2px solid green;"></div>
	</div>
	<!--这里绘制页面-->
</body>
<script>
	$("#uploadify").uploadify({
		'uploader' : 'script/common/uploadify/uploadify.swf',
		'script' : 'UploadPhotoServlet',
		'cancelImg' : 'script/common/uploadify/cancel.png',
		'folder' : '/jxdBlog/photos',
		'queueID' : 'fileQueue',
		'auto' : false,
		'multi' : true,
		'wmode' : 'transparent',
		'simUploadLimit' : 999,
		'fileExt' : '*.png;*.gif;*.jpg;*.bmp;*.jpeg',
		'fileDesc' : '图片文件(*.png;*.gif;*.jpg;*.bmp;*.jpeg)',
		'onAllComplete' : function(event, data) {
			$('#result').html(data.filesUploaded + '个图片上传成功');
		}
	});
	$(function() {

	});
</script>
<!--这里引用其他JS-->
</html>