<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<%@ include file="common/header.jsp" %>
<%
org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger("登录页面");
com.jhg.utils.PropertyConfig pc=new com.jhg.utils.PropertyConfig("sysConfig.properties");
com.jhg.utils.Azdg az=new com.jhg.utils.Azdg();
String targetUrl=request.getParameter("url");
if(targetUrl==null||targetUrl.equals("")){
	targetUrl=java.net.URLEncoder.encode(az.encrypt(BASE_PATH+"mobile/student/index.jsp"));
	logger.info("未指定跳转页面，默认生成首页访问地址："+targetUrl);
}else{
	targetUrl=java.net.URLEncoder.encode(targetUrl);
	logger.info("通过parameter获得到的url："+targetUrl);
}
targetUrl=java.net.URLDecoder.decode(targetUrl,"UTF-8");
logger.info("获取跳转地址并decode："+targetUrl);
targetUrl=az.decrypt(targetUrl);
logger.info("解密地址，进行跳转："+targetUrl);
%>
<head>
    <title>登录</title>
    <style type="text/css">
    	#header{
    		height:0.9138rem;
    		text-align:center;
    	}
    	#formlogin{
    		margin-top:40%;
    		margin-left:15%;
    		width:70%;
    		font-size:120%;
    	}
    	#formlogin .item{
    		margin-top:0.3rem;
    		margin-bottom:0.3rem;
    		width:100%;
    		position:relative;
    	}
    	#formlogin .item i{
    		width:30px;
    		height:30px;
    		position:absolute;
    		left:4px;
    		top:1px;
    	}
    	#formlogin .item input{
    		height:40px;
    		line-height:40px;
    		font-weight:500;
    		width:100%;
    		padding-left:35px;
    		border-radius:5px;
    		border:1px solid #595959;
    	}
    	#footer{
    		width:100%;
    		line-height:48px;
    		text-align:center;
    		margin-top:10px;
    	}
    	#btnlogin{
    		background-color:#43b930;
    		height:40px;
    		line-height:40px;
    		margin:0 auto;
    		margin-top:1rem;
    		width:70%;
    		text-align:center;
    		color:#fff;
    		font-size:130%;
    		
    	}
    </style>
    <link rel="stylesheet" href="mobile/common/fa/css/font-awesome.min.css">
    <script src="script/common/jquery/jquery.cookie.js" type="text/javascript"></script>
</head>
<body>
	<!-- fixed定位的头部 -->
	<div id="header">
    	<h1>欢迎使用</h1><h1>教学质量监控平台</h1>
    </div>
    <!-- 可以滚动的区域 -->
   	<div class="" >
   			<form id="formlogin" class="ui  form formlogin">
   				<div class="item">
   					<h3>请登录</h3>
   				</div>
   				<div class="item">
   					<i class="fa fa-2x fa-user"></i>
   					<input id="loginname"  placeholder="请输入教工号/学号 " type="text">
   				</div>
				<div class="item">
					<i class="fa fa-2x fa-lock"></i>
					<input id="loginpwd" type="password" placeholder="请输入登录密码" >
				</div>
		    	<div id="remeber" >
		    		<div id="remebermepnl" class="ui checkbox">
				      <input id="remeberme" type="checkbox" />
				      <label>记住我</label>
				    </div>
		    	</div>
			</form>
			<div id="btnlogin">登&nbsp;&nbsp;&nbsp;&nbsp;录</div>
	</div>
	<div id="footer" class="copyright">
		Design by AlienLab 2015.
    </div>
    <script type="text/javascript">
    $(function(){
    	var targetUrl="<%=targetUrl%>";
    	getRemember();
    	//登录按钮
		$("#btnlogin").click(function(){
			var loginname=$("#loginname").val();
			var loginpwd=$("#loginpwd").val();
			if(loginname==""){
				$.alert("请填写您的登录用户名!");
			}else if(loginpwd==""){
				$.alert("请填写您的登录密码!");
			}else{
				$(this).text("正在登录...");
				$.ajax({
					url:'do?invoke=login@Login',
					type:'POST',
					dataType:'json',
					data:{
						loginname:loginname,
						loginpwd:loginpwd
					},
					success:function(rep){
						$("#btnlogin").text("登  录");
						if(rep.flag){
							rememberMe();
							if(rep.user.usertype=='学生'){
                                window.location.href=targetUrl;
							}else{
                                window.location.href="mobile/teacher/tea_dep_comment.jsp";
							}

						}else{
							$.alert("用户名或者密码错误!");
						}
					}
				});
			}
		});
    	 
		function rememberMe(){
			if($("#remeberme")[0].checked){
				$.cookie('rememberme', true, { expires: 365 });
				$.cookie("loginname",$("#loginname").val(),{ expires: 365 });
				$.cookie("loginpwd",$("#loginpwd").val(),{ expires: 365 });
			}else{
				$.cookie('rememberme', false, { expires: 365 });
				$.cookie("loginname","");
				$.cookie("loginpwd","");
			}
		}
		
		function getRemember(){
			var rememberme=$.cookie("rememberme");
			if(rememberme!=null&&rememberme=="true"){
				$("#remeberme")[0].checked=true;
				$("#loginname").val($.cookie("loginname"));
				$("#loginpwd").val($.cookie("loginpwd"));
			}else{
				$("#remeberme")[0].checked=false;
				$("#loginname").val("");
				$("#loginpwd").val("");
			}
			
		}
    });
    


    </script>
</body>
</html>