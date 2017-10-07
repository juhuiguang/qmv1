<%@page import="com.jhg.utils.PropertyConfig"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String PATH = request.getContextPath();
	String BASE_URL  = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String BASE_PATH = BASE_URL + PATH +"/";
	String BASE_HOME = BASE_PATH +"QualityMonitor2/";
	request.setAttribute("BASE_PATH", BASE_PATH);
	String VERSIONTYPE=new PropertyConfig("sysConfig.properties").getValue("versiontype");
	String SINGLESCHE=new PropertyConfig("sysConfig.properties").getValue("singleSche");
	if(VERSIONTYPE==null){
		VERSIONTYPE="0";
	}
	if(SINGLESCHE==null){
		SINGLESCHE="false";
	}
	
%>
<base href="<%=BASE_PATH%>"> 
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0,user-scalable=no"/>		
<meta content="yes" name="apple-mobile-web-app-capable"/>
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta name="format-detection" content="telephone=no">
<meta http-equiv="x-rim-auto-match" content="none">  
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible"/>
<meta name="description" content="qm" />
<meta name="author" content="juhuiguang" />
<link rel="icon" href="favicon.ico">
<script src="script/common/jquery/jquery-2.0.0.min.js" type="text/javascript"></script>
<script src="script/common/semantic/semantic.min.js" type="text/javascript"></script>
<script src="script/common/alert/jquery.alert.js" type="text/javascript"></script>
<script src="script/common/jquery/jquery-resize.js"  type="text/javascript"></script>
<script src="script/common/baseInterface.js"  type="text/javascript"></script>
<script src="script/common/jquery.dateformat.js"  type="text/javascript"></script>
<link rel="stylesheet" href="script/common/semantic/semantic.min.css" />
<link rel="stylesheet" href="resource/common/css/reset.css" />
<link rel="stylesheet" href="script/common/alert/jquery.alert.css" />
<style id="J_style"></style>

<!--[if lt IE 9]>
	<script src="script/common/html5/css3-mediaqueries.js"></script> 
    <script src="script/common/html5/html5.js"></script>
<![endif]-->
<script type="text/javascript">
   
	var BASE_URL  = '<%=BASE_URL %>';
	var BASE_PATH = '<%=BASE_PATH %>';
	var BASE_HOME = '<%=BASE_HOME %>';
	var DEV_DEBUG = false;			
	var VERSIONTYPE=<%=VERSIONTYPE%>;
    var SINGLESCHE=<%=SINGLESCHE%>;
	
</script>
<!-- <script src="http://192.168.1.101:8080/target/target-script-min.js#anonymous"></script> -->
<style type="text/css">
	.ibMask{width:100%;min-height:100%;background:rgba(0,0,0,0.5);position:fixed;top:0;z-index:200;}
	.ibLoader{width:40px;height:40px;position:absolute;top:50%;left:50%;width:50%;text-align:center;margin:0 auto;margin-top:-20px;}
	.sk-spinner-wave.sk-spinner { margin: 0 auto;width: 50px;height: 30px;text-align: center;font-size: 10px;}
	.sk-spinner-wave div { background-color: #fff;height: 100%;width: 6px;display: inline-block;-webkit-animation: sk-waveStretchDelay 1.2s infinite ease-in-out;animation: sk-waveStretchDelay 1.2s infinite ease-in-out;}
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
	
input[type=range] {
  -webkit-appearance: none;
  width: 50%;
}
input[type=range]:focus {
  outline: none;
}
input[type=range]::-webkit-slider-runnable-track {
  width: 100%;
  height: 11.4px;
  cursor: pointer;
  box-shadow: 1px 1px 1px #000000, 0px 0px 1px #0d0d0d;
  background: rgba(48, 113, 169, 0.78);
  border-radius: 1.3px;
  border: 0.2px solid #010101;
}
input[type=range]::-webkit-slider-thumb {
  box-shadow: 0.9px 0.9px 1px #000031, 0px 0px 0.9px #00004b;
  border: 1.8px solid #00001e;
  height: 26px;
  width: 26px;
  border-radius: 15px;
  background: #fffffd;
  cursor: pointer;
  -webkit-appearance: none;
  margin-top: -7.5px;
}
input[type=range]:focus::-webkit-slider-runnable-track {
  background: rgba(54, 126, 189, 0.78);
}
input[type=range]::-moz-range-track {
  width: 100%;
  height: 11.4px;
  cursor: pointer;
  box-shadow: 1px 1px 1px #000000, 0px 0px 1px #0d0d0d;
  background: rgba(48, 113, 169, 0.78);
  border-radius: 1.3px;
  border: 0.2px solid #010101;
}
input[type=range]::-moz-range-thumb {
  box-shadow: 0.9px 0.9px 1px #000031, 0px 0px 0.9px #00004b;
  border: 1.8px solid #00001e;
  height: 26px;
  width: 26px;
  border-radius: 15px;
  background: #fffffd;
  cursor: pointer;
}
input[type=range]::-ms-track {
  width: 100%;
  height: 11.4px;
  cursor: pointer;
  background: transparent;
  border-color: transparent;
  color: transparent;
}
input[type=range]::-ms-fill-lower {
  background: rgba(42, 255, 149, 0.78);
  border: 0.2px solid #010101;
  border-radius: 2.6px;
  box-shadow: 1px 1px 1px #000000, 0px 0px 1px #0d0d0d;
}
input[type=range]::-ms-fill-upper {
  background: rgba(48, 113, 169, 0.78);
  border: 0.2px solid #010101;
  border-radius: 2.6px;
  box-shadow: 1px 1px 1px #000000, 0px 0px 1px #0d0d0d;
}
input[type=range]::-ms-thumb {
  box-shadow: 0.9px 0.9px 1px #000031, 0px 0px 0.9px #00004b;
  border: 1.8px solid #00001e;
  height: 26px;
  width: 26px;
  border-radius: 15px;
  background: #fffffd;
  cursor: pointer;
  height: 11.4px;
}
input[type=range]:focus::-ms-fill-lower {
  background: rgba(48, 255, 169, 0.78);
}
input[type=range]:focus::-ms-fill-upper {
  background: rgba(54, 126, 189, 0.78);
}
/*
 .card:hover{	
    transform:translate(0,-10px);
	-ms-transform:translate(0,-10px); 	
	-moz-transform:translate(0,-10px); 	
	-webkit-transform:translate(0,-10px);
	-o-transform:translate(0,-10px);
	 } 	
*/	

.card:hover{
	border:1px solid #2185d0 !important;
}

.card:hover .header{
	font-weight:600 !important;
}


</style>

<title>校内教学质量监控系统</title>