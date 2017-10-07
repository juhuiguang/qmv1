<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>

<title>校内教学质量监控运行平台</title>
<style>
</style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
<div id="container">
	<div id="cards" class="ui cards">
		
	</div>
</div>
</body>
<script>
	$(function() {
		var curmodule="<%=MODULE_ID%>";
		var curmenu="<%=MENU_ID%>";
		var colors=["red","orange","yellow","olive","green","teal","blue","violet","purple","pink","brown"];
		var submenus=getSubMenu(curmodule);
		for(var i=0;i<submenus.length;i++){
			var card='<div class="card '+colors[Math.floor((Math.random()*colors.length))]+'">'+
									'<div class="content">'+
										'<div class="header">'+'<a link="'+submenus[i].menu_link+'" module="'+curmodule+'" menu="'+submenus[i].menu_id+'" >'+submenus[i].menu_name+'</a>'+'</div>'+
									'</div>'+
								'</div>'+
			$("#cards").append($(card));
		}
		
		$("#cards a").click(function(){
			var link=$(this).attr("link");
			var menu=$(this).attr("menu");
			var module=$(this).attr("module");
			if(link=="")return;
			if(link.indexOf("?")>0){
				link=link+("&module="+module+"&menu="+menu);
			}else{
				link=link+("?module="+module+"&menu="+menu);
			}
			window.location.href=BASE_PATH+link;
		});
  	});
</script>
</html>