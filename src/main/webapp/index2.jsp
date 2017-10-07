<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>
<script src="script/common/datepicker/jquery.datetimepicker.js" type="text/javascript"></script>
<link rel="stylesheet" href="script/common/datepicker/jquery.datetimepicker.css" />

<title>校内教学质量监控运行平台</title>
<style>
	.ui.container.segment .button{
		margin-top:10px;
		margin-right:10px;
	}
</style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
<div id="container" >
		<img class="ui fluid image" src="resource/image/index/indexbanner.jpg">
	
		
</div>
</body>
<script>
	var MODULE_ID=""; //当前页面
	var MENU_ID="";
	$(function() {
		var menus=USEROBJECT.menu;
		var colors=["red","orange","yellow","olive","green","teal","blue","violet","purple","pink","brown"];
		for(var i=0;i<menus.length;i++){
			var module='<div class="ui container segment">'+
					'<div class="ui  ribbon label">'+menus[i].menu_name+'</div><p>';
			if(menus[i].menu_children){
				var submenus=menus[i].menu_children;
				for(var j=0;j<submenus.length;j++){
					module+='<button link="'+submenus[j].menu_link+'" module="'+menus[i].menu_id+'" menu="'+submenus[j].menu_id+'" class="ui  tiny '+colors[Math.floor((Math.random()*colors.length))]+' button">'+submenus[j].menu_name+'</button>';
				}
			}else{
				module+='<button link="'+menus[i].menu_link+'" module="'+menus[i].menu_id+'" menu="" class="ui  tiny '+colors[Math.floor((Math.random()*colors.length))]+' button">'+menus[i].menu_name+'</button>'
			}
			module+='</p></div>';
			$("#container").append($(module));
		}
		
		$(".ui.container.segment .button").click(function(){
			var link=$(this).attr("link");
			var menu=$(this).attr("menu");
			var module=$(this).attr("module");
			if(link=="")return;
			if(link.indexOf("?")>0){
				link=link+("&module="+module+"&menu="+menu);
			}else{
				link=link+("?module="+module+"&menu="+menu);
			}
			window.location.href=link;
		});
  	});
</script>
</html>