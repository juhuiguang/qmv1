<%@page import="com.service.system.SystemStart"%>
<%@page import="com.jhg.common.TypeUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String PATH = request.getContextPath();
	String BASE_URL  = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String BASE_PATH = BASE_URL + PATH +"/";
	request.setAttribute("BASE_PATH", BASE_PATH);
	
	//获取登录名称
		Object curloginname = session.getAttribute("loginname");

		String curuser = "";
		if (curloginname != null) {
			curuser = curloginname.toString();
		}
		com.alibaba.fastjson.JSONObject USEROBJECT = SystemStart
				.getUser(curuser);
		com.alibaba.fastjson.JSONObject SYSOBJCET = SystemStart.getSys();
		
%>
<base href="<%=BASE_PATH%>"> 
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>		
<meta content="yes" name="apple-mobile-web-app-capable"/>
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta name="format-detection" content="telephone=no">
<meta http-equiv="x-rim-auto-match" content="none">  
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible"/>
<meta name="description" content="he" />
<meta name="author" content="AlienLab" />
<link rel="icon" href="favicon.ico"> 

<link href="<%=BASE_PATH %>/mobile/common/normalize.css?v=201500912" type="text/css" rel="stylesheet">
<link href="<%=BASE_PATH %>/mobile/common/main.css?v=20150912" type="text/css" rel="stylesheet">
<link href="<%=BASE_PATH %>/script/common/alert/jquery.alert.css?v=20150912" type="text/css" rel="stylesheet">
<link href="<%=BASE_PATH %>/script/common/animate/animate.min.css?v=20150912" type="text/css" rel="stylesheet">
<style id="J_style"></style>
<script type="text/javascript">
    !function(){
    	function b(){
    		var e,b=document.getElementById("J_style"),
    		c=document.documentElement.clientWidth||document.body.clientWidth,
    		d=1;d=c/640,
    		e=parseInt(100*d),
    		b.innerHTML="html{font-size:"+e+"px;}body{font-size:0.24rem;}",
    		a=d; 
    		window.BASE_SIZE = d;
    	}
    	var a=0;b(),window.addEventListener("resize",b);
    }();
	var BASE_URL  = '<%=BASE_URL %>';
	var BASE_PATH = '<%=BASE_PATH %>';
	var SYSOBJECT=SYSOBJCET=<%=SYSOBJCET%>;  
	var USEROBJECT=<%=USEROBJECT%>;  
</script>
<style type="text/css">
	html,body{height:100%;color:#2c4041;}
	body{
		font-size:16px;
	}
	.ibMask{width:100%;min-height:100%;height:100%;background:rgba(0,0,0,0.5);position:absolute;top:0;z-index:200;}
	.ibLoader{width:40px;height:40px;position:relative;top:50%;width:50%;text-align:center;margin:0 auto;margin-top:-20px;}
	.sk-spinner-wave.sk-spinner { margin: 0 auto;width: 50px;height: 30px;text-align: center;font-size: 10px;}
	.sk-spinner-wave div { 
		margin-left:2px;background-color: #fff;height: 100%;width: 6px;display: inline-block;
		-webkit-animation: sk-waveStretchDelay 1.2s infinite ease-in-out;animation: sk-waveStretchDelay 1.2s infinite ease-in-out;
	}
	.sk-spinner-wave .sk-rect2 { -webkit-animation-delay: -1.1s;animation-delay: -1.1s; }
	.sk-spinner-wave .sk-rect3 { -webkit-animation-delay: -1s;animation-delay: -1s; }
	.sk-spinner-wave .sk-rect4 { -webkit-animation-delay: -0.9s;animation-delay: -0.9s; }
	.sk-spinner-wave .sk-rect5 { -webkit-animation-delay: -0.8s;animation-delay: -0.8s; }
	@-webkit-keyframes sk-waveStretchDelay {
	  0%, 40%, 100% { -webkit-transform: scaleY(0.4);transform: scaleY(0.4); }
	  20% {	-webkit-transform: scaleY(1); transform: scaleY(1); } 
	}
	@keyframes sk-waveStretchDelay {
	  0%, 40%, 100% { -webkit-transform: scaleY(0.4);transform: scaleY(0.4); }
	  20% { -webkit-transform: scaleY(1); transform: scaleY(1); } 
	}
</style>
<script type="text/javascript">
document.write('<div class="ibMask" id="ibMask">'+
	'<div class="sk-spinner sk-spinner-wave ibLoader">'+
		'<div class="sk-rect1"></div>'+
		'<div class="sk-rect2"></div>'+
		'<div class="sk-rect3"></div>'+
		'<div class="sk-rect4"></div>'+
		'<div class="sk-rect5"></div>'+
   	'</div>'+
'</div>');
</script>
<script type="text/javascript" charset="utf-8" src="<%=BASE_PATH %>script/common/jquery/jquery-2.0.0.min.js?v=20150912"></script>
<script type="text/javascript" charset="utf-8" src="<%=BASE_PATH %>mobile/common/fastclick/fastclick.min.js?v=20150912"></script>
<script type="text/javascript" charset="utf-8" src="<%=BASE_PATH %>script/common/alert/jquery.alert.js?v=20150912"></script>
<script type="text/javascript" charset="utf-8" src="<%=BASE_PATH %>mobile/common/dragloader/dragloader.min.js?v=20150912"></script>
<script type="text/javascript">
	$(document).ready(function(){ $("#ibMask") && $("#ibMask").is(":visible") && $("#ibMask").fadeOut(1000); });
</script>