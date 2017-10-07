<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>

<html>
<head>
<%@include file="/commonjsp/meta.jsp" %>
<script src="script/common/jquery/jquery.cookie.js" type="text/javascript"></script>
<% 
	org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger("登录页面");
	com.jhg.utils.PropertyConfig pc=new com.jhg.utils.PropertyConfig("sysConfig.properties");
	com.jhg.utils.Azdg az=new com.jhg.utils.Azdg();
	String showApp=pc.getValue("showApp");
	if(showApp.equals("true")){
		showApp="block";
	}else{
		showApp="none";
	}
	String targetUrl=request.getParameter("url");
	if(targetUrl==null||targetUrl.equals("")){
		targetUrl=java.net.URLEncoder.encode(az.encrypt(BASE_PATH+"index.jsp"));
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
<title>教学质量监控系统</title>
<style>
	.container{
		margin:0px auto;
		border-radius:5px;
		width:40%;
		min-width:300px;
		max-width:500px;
		background:rgba(255,255,255,0.7);
		float:left;
		display:none;
		margin-left:12%;
		color:#ccc;
		position:absolute;
		top:0;
		left:40%;
	}
	.rightalign{
		width:100%;
		text-align:center;
		position:relative;
		padding-bottom:10px;
	}
	.rightalign .loginbtn{
		text-align:center;
		color:#fff;
		font-size:120%;
		cursor:pointer;
		margin:0 auto;
	}
	#btnlogin,#newuseradd{
		height:40px;
		line-height:40px;
		width:80%;
	}
	#newuser,#newuserreturn{
		margin:0 auto;
		margin-top:20px;
		width:80%;
		text-align:right;
		color:#555;
		cursor:pointer;
	}
	#losepwd{
		color:#000;
		display:none;
	}
	#remeber label,#newuserform label{
		color:#000;
	}
	
	#newuseradd,#btnlogin{
		background:#2185d0;
		font-weight:500;
	}
	.loginbanner{
		height:auto;
		width:100%;
		text-align:center;
		padding-top:5px;
		
	}
	.loginbanner .header{
		font-size:150%;
		color:#54c8ff;
		margin:10px auto;
	}
	.formlogin{
		padding:15px;
	}
	#remeber{
		width:100%;
		margin:20px auto;
		color:#fff;
	}
	#remebermepnl{
		width:70%;
	}
	
	
	body{
		background-image:url("resource/image/login/loginbg2.jpg");
		background-size:100% 100%;
	}
	.loginmask{
		background-color:rgba(43,148,226,0.45);
		width:100%;
		height:100%;
		position:absolute;
		top:-100%;
		left:0;
	}
	#logincontent{
		margin-left:8%;
		opacity:0;
		position:relative;
		height:100%
	}
	.logintitle{
		width:40%;
		height:auto;
		float:left;
		line-height:100%;
	}
	.logintitle img{
		width:100%;
	}
	#newuser{
		display:none;
	}
</style>
	<script>
        if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
            window.location = "mobile/login.jsp"; //可以换成http地址
        }
	</script>
</head>
<body>
	<div class="loginmask">
		<!--  
			<div class="ui message" id="indexmsg">
				  <i class="close icon"></i>
				  欢迎使用新版质量监控系统，目前系统正在内测中，如遇问题欢迎及时反映，
				  <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=284587785&site=qq&menu=yes">与我联系</a>
			</div>
		-->
		<div id="logincontent">
			<div class="logintitle">
				<img src="resource/image/login/title.png" />
			</div>
			<div id="loginpnl" class="container">
				<div class="loginbanner ">
						<i class="ui icon inverted user huge blue"></i>
						<div class="header">Login</div>
				</div>
			
				<form id="formlogin" class="ui  form formlogin">
					<div id="divloginname" class="field ">
				     	<div class="ui icon input">
				     		<i class="user icon blue big"></i>
				        	<input  placeholder="请输入教工号/学号 " type="text">
				        	
				      	</div>
				    </div>
			    	<div id="divpwd" class="field">
			
			      		<div class="ui icon input">
			      			<i class="lock icon blue big"></i>
			        		<input type="password" placeholder="请输入登录密码" >
			     		</div>
			    	</div>
			    	<div id="remeber">
			    		<div id="remebermepnl" class="ui checkbox">
					      <input id="remeberme" type="checkbox" />
					      <label>记住我</label>
					    </div>
			    	</div>
			    	<div id="app" style="display:<%=showApp%>;margin-bottom:10px;">
				    		<a target="_blank" href="http://www.pgyer.com/niitqm" style="margin-right:10px;">APP下载</a>
				    		<a target="_blank" href="http://owa.xd.scs.niit.edu.cn/wv/wordviewerframe.aspx?WOPISrc=http%3a%2f%2f210.28.101.76%3a81%2fwopi%2ffiles%2fapphelp.docx&access_token=123">APP帮助手册</a>
				    </div>
			    	<div id="errortip" class="ui error message">
				    	<div class="header">登录错误</div>
				    	<p></p>
				  </div>
			</form>
			
			 <div class="rightalign">
				  <div id="btnlogin"  class="loginbtn">登&nbsp;&nbsp;&nbsp;&nbsp;录</div>
				  <div id="newuser" >新用户立即绑定</div>
			 </div>
			</div>
			
			
			<div id="newuserpnl" class="container" >
				<div class="loginbanner ">
						<i class="ui icon inverted add user huge white"></i>
						<div class="header">New User</div>
				</div>
				<form id="newuserform" class="ui  form formlogin">
					<div class="inline fields">
						<div class="field">
					      <div class="ui radio checkbox">
					        <input type="radio"  id="radiotea"  name="role" checked=""  >
					        <label>我是老师</label>
					      </div>
					    </div>
					    <div class="field">
					      <div class="ui radio checkbox">
					        <input type="radio"  id="radiostu"  name="role" >
					        <label>我是学生</label>
					      </div>
					    </div>
					</div>
					<div id="new_no_div"   class="field ">
				     	<div class="ui  input">
				        	<input id="new_no" placeholder="请输入教工号/学号 " type="text">
				      	</div>
				    </div>
			    	<div id="new_name_div" class="field">
			      		<div class="ui  input">
			        		<input id="new_name" type="text" placeholder="请输入姓名" >
			     		</div>
			    	</div>
			    	<div id="new_pwd_div"  class="field">
			      		<div class="ui  input">
			        		<input id="new_pwd" type="password" placeholder="请设置登录密码" >
			     		</div>
			    	</div>
			    	<div id="new_pwd2_div"  class="field">
			      		<div class="ui  input">
			        		<input id="new_pwd2" type="password" placeholder="请确认登录密码" >
			     		</div>
			    	</div>
			    	
			    	<div id="newusererror" class="ui error message">
				    	<div class="header">错误提示</div>
				    	<p></p>
				  </div>
			</form>
			 <div class="rightalign">
			 	
				  <div id="newuseradd" class="loginbtn">创建用户</div>
				  <div id="newuserreturn" >返&nbsp;&nbsp;&nbsp;&nbsp;回</div>
			 </div>
			</div>
		</div>
	</div>
	
	
	
</body>
<script>

    var Sys = {};
	
	var ua = navigator.userAgent.toLowerCase();
	
	if (window.ActiveXObject){
		Sys.ie = ua.match(/msie ([\d.]+)/)[1];
		if(parseInt(Sys.ie.substring(0,1))<9){
			if(confirm("浏览器版本过低,是否下载建议浏览器？")){//浏览器版本过低		
				window.open('script/common/chrome/ChromeStandalone_V45.0.2454.85_Setup.1441175508.exe');
			}
		}
	}

	$(function(){

		$('#indexmsg .close')
		  .on('click', function() {
		    $(this)
		      .closest('.message')
		      .transition('fade');
		  });
		
		$(window).resize(function(){
			if($(window).width()<$("#loginpnl").width()){
				$("#loginpnl").css("margin-left","0px");
			}else{
				$("#loginpnl").css("margin-left","12%");
			}
			
		});
		
		$("#loginpnl,#newuserpnl").resize(function(){
			$(this).css("margin-top",($("#logincontent").height()-$(this).height())/2);
		});
		setTimeout(function(){
			$(".loginmask").animate({top:0},500,null,function(){
				$("#loginpnl").show();
				//$("#logincontent").height(pnlheight);
				$(".logintitle").css("margin-top",($("#logincontent").height()-$(".logintitle").height())/2);
				$("#loginpnl").css("margin-top",($("#logincontent").height()-$("#loginpnl").height())/2);
				$("#newuserpnl").css("margin-top",($("#logincontent").height()-$("#newuserpnl").height())/2);
				$("#logincontent").animate({
					opacity:1
				},'slow');
			});
		},500);
		
		var targetUrl="<%=targetUrl%>";
		getRemember();
		
		$("#newuser").click(function(){
			showNewUser();
			
		});
		$("#newuserreturn").click(function(){
			showLogin();
		});
		
		function showLogin(){
			$("#newuserpnl").transition('horizontal flip', 500,function(){
				$("#loginpnl").transition('horizontal flip', 500);
			});
		}
		
		function showNewUser(){
			$("#loginpnl").transition('horizontal flip', 500,function(){
				$("#newuserpnl").transition('horizontal flip', 500);
			});
		}
		
		$(document).keypress(function(e){
			if(e.charCode==13){
				if($("#loginpnl").is(':visible')){
					$("#btnlogin").trigger("click");
				}else{
					$("#newuseradd").trigger("click");
				}
			}
			
			
		});
		
		//登录按钮
		$("#btnlogin").click(function(){
			clearError("#formlogin .field");
			var loginname=$("#divloginname input").val();
			var loginpwd=$("#divpwd input").val();
			if(loginname==""){
				setError("#divloginname","请填写您的登录用户名!");
			}else if(loginpwd==""){
				setError("#divpwd","请填写您的登录密码!");
			}else{
				$(this).addClass("loading");
				$.ajax({
					url:'do?invoke=login@Login',
					type:'POST',
					dataType:'json',
					data:{
						loginname:loginname,
						loginpwd:loginpwd
					},
					success:function(rep){
						console.log("login>>",rep);
						$("#btnlogin").removeClass("loading");
						if(rep.flag){
							rememberMe();
							var userobject=rep.user;
							var roles=userobject.roles;
							for(var i=0;i<roles.length;i++){
								if(roles[i].role_index!=""){
									targetUrl=BASE_PATH+roles[i].role_index;
									break;
								}
							}
							$("#loginpnl").transition('fly left', 1000,function(){
								window.location.href=targetUrl;
							});
						}else{
							setError("#divpwd","用户名或者密码错误!");
						}
					}
				});
			}
		});
		function setError(selector,msg,msgpnl){
			if(!msgpnl){
				msgpnl="#formlogin";
			}
			$(selector).addClass("error");
			$(msgpnl +" .ui.error.message p").html(msg);
			if($(msgpnl+" .error").length>0){
				$(msgpnl).addClass("error");
			}
				
		}
		function clearError(selector,msgpnl){
			if(!msgpnl){
				msgpnl="#formlogin";
			}
			$(selector).removeClass("error");
			$(msgpnl).removeClass("error");
		}
		
		//光标聚焦
		setTimeout(function(){
			$("#divloginname input[type='text']").focus();
		},1000);
		
		//创建新用户按钮
		$("#newuseradd").click(function(){
			if($("#new_no").val()==""){
				setError("#new_no_div","请输入您的教工号或学号。","#newuserform");
			}else if($("#new_name").val()==""){
				setError("#new_name_div","请输入您的姓名。","#newuserform");
			}else if($("#new_pwd").val()==""){
				setError("#new_pwd_div","请设置您的登录密码。","#newuserform");
			}else if($("#new_pwd2").val()==""){
				setError("#new_pwd2_div","请确认您的登录密码。","#newuserform");
			}else if($("#new_pwd").val()!=$("#new_pwd2").val()){
				setError("#new_pwd2_div","您两次设置的密码不相同。","#newuserform");
			}else{
				var isteacher=$("#radiotea")[0].checked;
				console.log(isteacher)
				var newuser={
						usertype:isteacher?"教师":"学生",
						user_no:$("#new_no").val(),
						user_name:$("#new_name").val(),
						user_pwd:$("#new_pwd").val()
				}
				$("#newuseradd").addClass("loading");
				$.ajax({
					url:'do?invoke=SystemAction@createUser',
					type:'POST',
					dataType:'json',
					data:newuser,
					success:function(rep){
						console.log(rep);
						$("#newuseradd").removeClass("loading");
						if(rep.result==0){
							setError("#new_no_div",rep.message,"#newuserform");
						}else{
							$.alert(rep.message,function(){
								showLogin();
							});
							
						}
					}
				});
			}
			
		});
		
		function rememberMe(){
			if($("#remeberme")[0].checked){
				$.cookie('rememberme', true, { expires: 365 });
				$.cookie("loginname",$("#divloginname input").val(),{ expires: 365 });
				$.cookie("loginpwd",$("#divpwd input").val(),{ expires: 365 });
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
				$("#divloginname input").val($.cookie("loginname"));
				$("#divpwd input").val($.cookie("loginpwd"));
			}else{
				$("#remeberme")[0].checked=false;
				$("#divloginname input").val("");
				$("#divpwd input").val("");
			}
			
		}
	});
	
	$(function(){
		
	});
</script>
</html>