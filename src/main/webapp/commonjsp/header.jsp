<%@page import="com.service.system.SystemStart"%>
<%@page import="com.jhg.common.TypeUtils"%>
<%@ page language="java" import="java.util.* " pageEncoding="UTF-8"%>
<%
	//获取登录名称
	Object curloginname = session.getAttribute("loginname");

	String curuser = "";
	if (curloginname != null) {
		curuser = curloginname.toString();
	}
	com.alibaba.fastjson.JSONObject USEROBJECT = SystemStart
			.getUser(curuser);
	com.alibaba.fastjson.JSONObject SYSOBJCET = SystemStart.getSys();

	String MODULE_ID = request.getParameter("module");
	String MENU_ID = request.getParameter("menu");

	if (MODULE_ID == null) {
		MODULE_ID = "0";
	}
	if (MENU_ID == null) {
		MENU_ID = "";
	}
%>
<style>
.pagewidth {
	margin: 0 auto;
}

.sysheader {
	box-sizing: border-box;
	position: fixed;
	top: 0;
	background: #fff;
	z-index: 999;
}

.sysfooter {
	text-align: center;
	box-sizing: border-box;
	background: transparent;
	z-index: 999;
}

#header_top .ui.menu {
	margin-top: 0;
	border-radius: 0;
}

.sys_banner {
	width: 100%;
	margin: 0 auto;
	box-sizing: border-box;
	background-color: #2185d0;
	color: #fff;
}

.sys_logo {
	float: left;
	width: 60%;
	font-weight: 500;
	font-size: 150%;
	margin-left: 20px;
	margin-top: 20px;
	box-sizing: border-box;
}

#header_top .ui.blue.inverted.menu.fluid{
	min-height:2.5em;
}

#sysmainmenu .item{
	padding-top:5px;
	padding-bottom:5px;
}
.sys_user {
	float: right;
	margin-top: 20px;
	margin-right: 50px;
}

.page {
	margin: 0 auto;
	min-height: 100%;
	position: relative;
	padding-bottom: 10px;
	overflow: hidden;
}

.syssubmenu {
	width: 20%;
	float: left;
	background: #eee;
	margin-right: 20px;
	margin-top: 106px;
	z-index: 990;
}

#container {
	box-sizing: boder-box;
	display: none;
	position: relative;
	z-index: 900;
	width: 100%;
	margin: 0;
	float: left;
}

.sysfooter {
	height: 100px;
	background: #333;
	color: #eee;
	text-align: center;
	padding-top:5px;
}

#footpnl {
	text-align: center;
}

#footpnl ul {
	margin: 20px auto;
	text-align: center;
	overflow-y: hidden;
}

#footpnl ul li {
	display: inline;
	margin-left: 10px;
}

#footpnl ul li a {
	color: #fff;
}

#modheader {
	background-color: #0089A7; 
	color: white ;
}

#submitback {
	width: 480px;
	margin-left: 80px;
}
#returnold{
}
#returnold a{
padding-top:5px;
	color:#bbb;
	font-size:16px;
}

.ui.modal > .close {
    cursor: pointer;
    position: absolute;
    top: 0px;
    right: 0px;
    opacity: 0.8;
    font-size: 1.25em;
    color: rgba(33, 33, 33, 1);
    width: 2.25rem;
    height: 2.25rem;
    padding: .625rem 0 0;
}
.ui.dimmer{
    background-color:rgba(88,88,88,0.7);
}

</style>
<div class="pagewidth page" id="jhgpage">
	<header class="pagewidth sysheader" id="header_top">
		<div class="sys_banner">
			<div class="sys_logo">
				<i class="home large icon"></i> <span>校内教学质量监控运行平台</span>
			</div>
			<div class="sys_user">
			
				<div id="user_corner"
					class="ui inline labeled icon top right pointing dropdown">
					
					<i class="user icon yellow large"></i> 您好，<%=USEROBJECT.getString("username")%>
					<i class="dropdown icon"></i>
					<div class="ui secondary  menu">
						<a class="item" id="person_set"><i class="setting  icon"></i>个人设置</a>
						<a class="item" href="logout.jsp"><i class="sign out icon"></i>注销登录</a>
					</div>
				</div>
				<a id="helpdoc" target="_blank"  href="http://owa.xd.scs.niit.edu.cn/wv/wordviewerframe.aspx?WOPISrc=http%3a%2f%2f210.28.101.76%3a81%2fwopi%2ffiles%2fhelp.docx&access_token=123"><i class="help large inverted circle icon"></i></a>
			</div>
			<div class="ui blue inverted menu fluid">
			<div id="sysmainmenu" class="left  menu" style="display: none;">
				<%
					com.alibaba.fastjson.JSONArray user_menus = USEROBJECT
							.getJSONArray("menu");
					for (int i = 0; i < user_menus.size(); i++) {
				%>
				<a class="item"
					id="module_<%=user_menus.getJSONObject(i).getString("menu_id")%>"
					href="javascript:void(0);"
					link="<%=user_menus.getJSONObject(i).getString("menu_link")%>">
					<i
					class="icon <%=user_menus.getJSONObject(i).getString("menu_attr")%>"></i>
					<%=user_menus.getJSONObject(i).getString("menu_name")%>
				</a>

				<%
					}
				%>
			</div>
		</div>
		</div>
		
	</header>
	
	<div class="syssubmenu" style="display: none;">
		<div class="verticalMenu">
			<div id="syssubmenu" class="ui vertical pointing menu fluid"></div>
		</div>
	</div>
	<div id="userwindow" class="ui modal" style="height:80% !important;">          
		<i class="close icon"></i>
		<div class="header">个人设置</div>
 		<!-- <div class="ui column relaxed grid">  
			<div class="column">
				<div class="ui fluid form segment">
					<div class="field">
						<label>原密码</label>
						<div class="ui small left icon input">
							<input type="password" id="oldpassword" name="password" size="30">
							<i class="lock icon"></i>
						</div>
					</div>
					<div class="field">
						<label>新密码</label>
						<div class="ui small left icon input">
							<input type="password" id="newpassword" name="password" size="30">
							<i class="lock icon"></i>
						</div>
					</div>
					<div class="field">
						<label>确认新密码</label>
						<div class="ui small left icon input">
							<input type="password" id="cnewpassword" name="password"
								size="30"> <i class="lock icon"></i>
						</div>
					</div>
				</div>
				<div style="margin: 5px; width: 95%; text-align: right;">
					<div id="personBtnSave" class="ui button green tiny">保存</div>
					<div id="btncancle" class="ui button red tiny">取消</div>
				</div>
			</div>
		</div> -->
		<iframe id="changePwd_grsz" style = "overflow-y:none;width:100%;padding:0;margin:0;height:60%">      
		
		</iframe>   
	</div>
	
	
	
</div>
<footer class="pagewidth sysfooter">
		<div id="footpnl" >
			<ul>
				<li><a href="javascript:void(0)" id="aboutours">关于我们</a></li>
				<li><a href="javascript:void(0)" id="feedback">意见反馈</a></li>
				<li><a href="javascript:void(0)" id="editionupgrade">当前版本：<span id="sysversion"></span></a></li>
			</ul>
		</div>
		<%--<div id="copyrights">--%>
			<%--&copy; 2015 南京工业职业技术学院 计算机与软件学院<br /> <a href="#" target="_blank"></a>--%>
		<%--</div>--%>
	</footer>
<div class="ibMask" id="ibMask" style="z-index: 1000;">
	<div class="sk-spinner sk-spinner-wave ibLoader">
		<div class="sk-rect1"></div>
		<div class="sk-rect2"></div>
		<div class="sk-rect3"></div>
		<div class="sk-rect4"></div>
		<div class="sk-rect5"></div>
	</div>
</div>

<div id="footmod" class="ui modal">
	<div class="header" id="modheader">
	 
	</div>
	<div class="content">
		<div class="description">
			<div class="ui grid">
				<div class="three wide column">
					<div id="mod_cbl" > 
						<div class="ui vertical basic buttons" id="buttonsdiv">      
							<button class="ui button role" id="about_ours">关于我们</button>
							<button class="ui button role" id="feed_back">意见反馈</button>
							<button class="ui button role" id="edition_upgrade">版本更新</button>			      
						</div>   
					</div>
				</div>
				<div class="twelve wide column">
					<div id="aboutoursInfor">
					
					</div>
					
				    <div id="feedbackInfor">
				    
				    </div>
				    
				    <div id="editionupgradeInfor">
						
				    </div>
				</div>
			</div>
		</div>		
	</div>
</div>


<script>
	
	//控制页面loading
	window.onload = function(){
		$("#ibMask").fadeOut(1000);	
	};
	
	window.loading=function(){
		$("#ibMask").fadeIn(500);	
	}
	window.unloading=function(){
		$("#ibMask").fadeOut(1000);	
	}
	
	var SYSOBJECT=SYSOBJCET=<%=SYSOBJCET%>;  
	var USEROBJECT=<%=USEROBJECT%>;  
	var WEEK=["","周一","周二","周三","周四","周五","周六","周日"];
	var COURSE_JC=["","1~2节","3~4节","5~6节","7~8节","9~10节"];
	var COURSE_JC_SINGLE=["","第1节","第2节","第3节","第4节","第5节","第6节","第7节","第8节"];

	if(USEROBJECT.userpurview=="ALL"){
		
	}else{
		var deps=SYSOBJECT.departments;
		var newdeps=[];
		for(var i=0;i<deps.length;i++){
			if(deps[i].dep_no==USEROBJECT.userpurview){
				newdeps.push(deps[i]);
			}
		}
		SYSOBJECT.departments=newdeps;
	}
	$(function(){
		if(USEROBJECT&&USEROBJECT.usertype=="学生"){
			$("#helpdoc").attr("href","http://owa.xd.scs.niit.edu.cn/wv/wordviewerframe.aspx?WOPISrc=http%3a%2f%2f210.28.101.76%3a81%2fwopi%2ffiles%2fstuhelp.docx&access_token=123")
		}
		$("#user_corner").dropdown();
		var curmodule="<%=MODULE_ID%>";
		var curmenu="<%=MENU_ID%>";
		$("#sysmainmenu").transition("fade left in", 1000);
		var submenu = getSubMenu(curmodule);
		if (!submenu || submenu.length == 0) {
			$(".page").append($("#container"));
			$(".syssubmenu").remove();
			$("#container").css("padding-top", $(".sysheader").height() + 10);
				
		} else {
			//调整界面布局
			$(".page").append($("#container"));
			$(".syssubmenu").css("margin-top", $(".sysheader").height() + 10);
			$("#container").css("padding-top", $(".sysheader").height() + 30)
					.css("padding-bottom", $(".sysfooter").height() + 10);
			//		.css("padding-left", $(".syssubmenu").width() + 10);
			showsubMenu(submenu, curmodule);
			if (curmenu != "") {
				$("#menu_" + curmenu).addClass("active");
			}
		}
		$("#module_" + curmodule).addClass("active");
		
		adjustLayOut();
		$(window).resize(function() {
			adjustLayOut();
		});
		
		$(window).scroll(function(){
			if($(".syssubmenu").height()<$("#container").height()){
				if($(".syssubmenu").height()>($(window).height()-$(".sysheader").height()-10)){
					return;
				}else{
					$(".syssubmenu").stop().animate({opacity:0},100);
					$(".syssubmenu").css("margin-top", $(".sysheader").height() + 10+$(window).scrollTop()+"px");
					$(".syssubmenu").stop().animate({opacity:100},1000);
				}
			}
			//$(".syssubmenu").css("margin-top", $(".sysheader").height() + 10+$(window).scrollTop());
		});
		function adjustLayOut(){
			if (!submenu || submenu.length == 0) {
				$("#container").css("padding-top", $(".sysheader").height() + 30)
						.css("padding-bottom", $(".sysfooter").height() + 10);
				$("#container").width($("#jhgpage").width());
			} else {
				//调整界面布局
				$(".syssubmenu").css("margin-top", $(".sysheader").height() + 10);
				$("#container").css("padding-top", $(".sysheader").height() + 30)
						.css("padding-bottom", $(".sysfooter").height() + 10);
				//		.css("padding-left", $(".syssubmenu").width() + 10);
				$("#container").width($("#jhgpage").width()-$(".syssubmenu").width()-20);
			}
		}
		$("#container").transition("fade up in", 1000);

		//主菜单点击
		$("#person_set").click(function() {
			showmodal();
		});
		
		
		$("#personBtnSave").click(function() {
			$.ajax({
				url:'do?invoke=SystemAction@changeUserPass',
				type:'POST',
				dataType:'json',
				data:{
					loginname:'<%=USEROBJECT.getString("loginname")%>',
					userdname:'<%=USEROBJECT.getString("username")%>',
					oldPass : $('#oldpassword').val(),
					newPass : $('#newpassword').val()
				},
				success : function(rep) {
					if (rep.result == 0) {
						$.alert("", rep.message);
						$('#oldpassword').val("");
						$('#newpassword').val("");
						$('#cnewpassword').val("");

					} else {
						$('#userwindow').modal("hide");          
						$.alert("", rep.message);
					}
				}
			});
		});

		//主菜单点击
		$("#sysmainmenu .item").click(function() {
			moduleClick(this);
		});

		$("#syssubmenu .item").click(function() {
			menuClick(this);
		});

		//渲染左侧导航
		function showsubMenu(submenu, moduleid) {
			$("#sysmainmenu .item").removeClass("active");
			$("#module_" + moduleid).addClass("active");
			$("#syssubmenu .item").remove();
			for ( var i = 0; i < submenu.length; i++) {
				var item = $('<a class="item"  id="menu_' + submenu[i].menu_id
						+ '" module="' + moduleid + '"  link="'
						+ submenu[i].menu_link + '" href="javascript:void(0)">'
						+ '<i class="icon '+submenu[i].menu_attr+'"></i> '
						+ submenu[i].menu_name + ' ' + '</a>');
				$("#syssubmenu").append(item);
			}

			$('.syssubmenu').transition("fly right in", 500);

		}

		//获取子菜单
		function getSubMenu(menuid) {
			var menus = USEROBJECT.menu;
			var submenu = [];
			for ( var i = 0; i < menus.length; i++) {
				if (menus[i].menu_id == menuid) {
					submenu = menus[i].menu_children;
					break;
				}
			}
			return submenu;
		}

		window.getSubMenu = getSubMenu;
		//模块点击
		function moduleClick(moduleitem) {
			var link = $(moduleitem).attr("link");
			if (link == "") {
				return;
			}
			if(link.indexOf("http")==0){
			    link=link;
                var clickmodule = $(moduleitem).attr("id").split("_")[1];
                if (clickmodule == curmodule)
                    return;
                if (link.indexOf("?") > 0) {
                    link = link + ("&module=" + clickmodule);
                } else {
                    link = link + ("?module=" + clickmodule);
                }
                window.open(link);
			}else{
                link = BASE_PATH + link;
                var clickmodule = $(moduleitem).attr("id").split("_")[1];
                if (clickmodule == curmodule)
                    return;
                if (link.indexOf("?") > 0) {
                    link = link + ("&module=" + clickmodule);
                } else {
                    link = link + ("?module=" + clickmodule);
                }
                window.location.href = link;
			}

		}

		//菜单点击
		function menuClick(menuitem) {
			var link = $(menuitem).attr("link");
			var module = $(menuitem).attr("module");
			var menuid = $(menuitem).attr("id").split("_")[1];
			if (link == "") {
				return;
			}
			link = BASE_PATH + link;
			if (menuid == curmenu)
				return;
			if (link.indexOf("?") > 0) {
				link = link + ("&module=" + module + "&menu=" + menuid);
			} else {
				link = link + ("?module=" + module + "&menu=" + menuid);
			}
			window.location.href = link;
		}

	});

	function showmodal() {
		$('#userwindow').modal("setting", "closable", false).modal("show");                       
		/* 	$("#btnsave").unbind("click").click(function() {
			//saveUser(userid);
			$('#userwindow').modal("hide");
		});
		$("#btncancle").unbind("click").click(function() {
			$('#userwindow').modal("hide");
		}); */
		
		//修改密码界面
		 $('#changePwd_grsz').attr('src' ,$.getUrl({
			config:{
				fromurl:"index.jsp", 
				tourl:"changePwd.jsp" ,
				login_name:USEROBJECT.loginname, 
				user_name:USEROBJECT.username, 
			}
		})); 
	}

	function CheckMail(mail) {
		var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		if (filter.test(mail)) {
			return true;
		}
		else {
			$.alert('您的电子邮件格式不正确');
			return false;
		}
	}
        
	function CheckQQ(qq) {
		var re=/^[1-9][0-9]{4,}$/;
		if(!re.test(qq)){
		   $.alert("请输入正确的QQ号");
		   return;
		} else {
		   return true;
		}
	}
	
	function feedbackappend() {
		var tep=
			'<div class="ui form" id="fbmodbody">'+
				  '<p>如果您有任何关于校内教学质量监控运行平台的问题或建议，欢迎联系我们，我们会尽快给您答复。</p>'+	
				  '<label>问题与建议描述：</label>'+	  		  
				  '<div class="field">'+
				    '<textarea id="yjfk_area" placeholder="请详细描述您遇到的问题。"></textarea>'+
				  '</div>'+
				  '<p>如果您希望得到反馈，请留下您的联系方式：</p>'+
				  
				  '<div class="two fields">'+						    
					    '<div class="field">'+
						      '<input id="qq"  placeholder="QQ" type="text">'+
					    '</div>'+
					    
					    '<div class="field">'+	
						      '<input id="e-mail"  placeholder="E-mail" type="text">'+
					    '</div>'+						    
				  '</div>'+
				  '<button class="ui primary button" id="submitback">提交</button>'+
		  '</div>';
		  $('#feedbackInfor').append(tep);
	}
	
	function editionupgradeappend() {
		var tmp=
			'<div class="ui styled accordion" id="eumodbody">'+
			 
			'</div>';
		$('#editionupgradeInfor').append(tmp);
	}
	
	function aboutoursappend() {
		var temp=
			'<div id="aomodbody">'+
				'<div class="ui message">南京工业职业技术学院 计算机与软件学院</div>'+
			'</div>';
		$('#aboutoursInfor').append(temp);
	}
	
	//关于我们点击
	$("#aboutours").click(function() {
	    return;
		$("#modheader").text("关于我们");
		$("#modheader").append($('<i class="close icon" style="float: right;"></i>'));
		$('#aboutoursInfor').empty();    
		$('#feedbackInfor').empty();
		$('#editionupgradeInfor').empty();
		aboutoursappend();
		$('#footmod').modal({
			transition : 'slide down',
			observeChanges : true,
			closable : false
		}).modal('show');
		$("#buttonsdiv .active").removeClass("active");
		$("#about_ours").addClass("active");
		$("#buttonsdiv .role").click(function(){
		    return;
			$("#buttonsdiv .active").removeClass("active");
			$(this).addClass("active");
			var footid = this.id;			
			console.log(footid);
			if(footid == "about_ours") {
				$("#modheader").text("关于我们");
				$("#modheader").append($('<i class="close icon" style="float: right;"></i>'));
				$('#aboutoursInfor').empty();
				$('#feedbackInfor').empty();
				$('#editionupgradeInfor').empty();
				aboutoursappend();
			} else if (footid == "feed_back") {
				$("#modheader").text("意见反馈");
				$("#modheader").append($('<i class="close icon" style="float: right;"></i>'));
				$('#aboutoursInfor').empty();
				$('#feedbackInfor').empty();
				$('#editionupgradeInfor').empty();
				feedbackappend();
				saveModifyFeedBack();
			} else {
				$("#modheader").text("版本更新");
				$("#modheader").append($('<i class="close icon" style="float: right;"></i>'));
				$('#aboutoursInfor').empty();
				$('#feedbackInfor').empty();
				$('#editionupgradeInfor').empty();
				editionupgradeappend();
				showEditionUpgrade();
			}
		});
	});
	
	//意见反馈点击
	$("#feedback").click(function() {
	    return;
		$("#modheader").text("意见反馈");
		$("#modheader").append($('<i class="close icon" style="float: right;"></i>'));
		$("#yjfk_area").val("");
		$("#qq").val("");
		$("#e-mail").val("");
		$('#aboutoursInfor').empty();
		$('#feedbackInfor').empty();
		$('#editionupgradeInfor').empty();
		feedbackappend();
		$('#footmod').modal({
			transition : 'slide down',
			observeChanges : true,
			closable : false
		}).modal('show');	
		$("#buttonsdiv .active").removeClass("active");
		$("#feed_back").addClass("active");
		$("#buttonsdiv .role").click(function(){
			$("#buttonsdiv .active").removeClass("active");
			$(this).addClass("active");
			var footid = this.id;			
			console.log(footid);
			if(footid == "about_ours") {
				$("#modheader").text("关于我们");
				$("#modheader").append($('<i class="close icon" style="float: right;"></i>'));
				$('#aboutoursInfor').empty();
				$('#feedbackInfor').empty();
				$('#editionupgradeInfor').empty();
				aboutoursappend();
			} else if (footid == "feed_back") {
				$("#modheader").text("意见反馈");
				$("#modheader").append($('<i class="close icon" style="float: right;"></i>'));
				$('#aboutoursInfor').empty();
				$('#feedbackInfor').empty();
				$('#editionupgradeInfor').empty();
				feedbackappend();
				saveModifyFeedBack();
			} else {
				$("#modheader").text("版本更新");
				$("#modheader").append($('<i class="close icon" style="float: right;"></i>'));
				$('#aboutoursInfor').empty();
				$('#feedbackInfor').empty();
				$('#editionupgradeInfor').empty();
				editionupgradeappend();
				showEditionUpgrade();
			}
		});
        saveModifyFeedBack();
	});

	showEditionUpgrade();
     //版本更新点击
     $("#editionupgrade").click(function(){
         return;
    	$("#modheader").text("版本更新");
    	$("#modheader").append($('<i class="close icon" style="float: right;"></i>'));
    	$('#aboutoursInfor').empty();
		$('#feedbackInfor').empty();
		$('#editionupgradeInfor').empty();
    	editionupgradeappend();
    	 $('#footmod').modal({
 			transition : 'slide down',
 			observeChanges : true,
 			closable : false
 		  }).modal('show');	
    	 $("#buttonsdiv .active").removeClass("active");
    	 $("#edition_upgrade").addClass("active");
  		 $("#buttonsdiv .role").click(function(){
  			$("#buttonsdiv .active").removeClass("active");
  			$(this).addClass("active");
  			var footid = this.id;
  			console.log(footid);
  			if(footid == "about_ours") {
 				$("#modheader").text("关于我们");
 				$("#modheader").append($('<i class="close icon" style="float: right;"></i>'));
 				$('#aboutoursInfor').empty();
				$('#feedbackInfor').empty();
				$('#editionupgradeInfor').empty();             
				aboutoursappend();
 			} else if (footid == "feed_back") {
 				$("#modheader").text("意见反馈");
 				$("#modheader").append($('<i class="close icon" style="float: right;"></i>'));
 				$('#aboutoursInfor').empty();
				$('#feedbackInfor').empty();
				$('#editionupgradeInfor').empty();
				feedbackappend();
				saveModifyFeedBack();
 			} else {
 				$("#modheader").text("版本更新");
 				$("#modheader").append($('<i class="close icon" style="float: right;"></i>'));
 				$('#aboutoursInfor').empty();
				$('#feedbackInfor').empty();
				$('#editionupgradeInfor').empty();
				editionupgradeappend();
				showEditionUpgrade();
 			}
  		});
    	 showEditionUpgrade();
     });

     function showEditionUpgrade() {
    	 $.ajax({
    		 type:'POST',
    		 url:"version.json",
			 dataType:'json',
			 success:function(data){
				$("#eumodbody").empty();
				console.log(data);
				$.each(data,function(i,item){
					var content =
						 '<div class="title">'+
						    '<i class="dropdown icon"></i> V '+
						    	item.version_no +
						  '</div>'+
						  '<div class="content">'+
						    '<p>&nbsp;&nbsp;&nbsp;&nbsp;  更新时间：'+ item.version_date + '</p><br>'+
						    '<p>&nbsp;&nbsp;&nbsp;&nbsp;  更新内容：</p><br>';
						    for(var j=0; j<item.version_concent.length; j++) {
						    	var k= j+1;
							   content += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+k+'、'+ item.version_concent[j] +'</p>';				    	
						    }
						    content += '</div>';					    
					$("#eumodbody").prepend(content);
					$('#eumodbody').accordion({
					    selector: {
					      trigger: '.title .icon'
					    }
					  });
					$("#sysversion").text(item.version_no);
				}) 
			 }
    	 });
     }
     
     function saveModifyFeedBack(){
		$("#submitback").unbind("click").click(function(){
		    return;
			var area = $("#yjfk_area").val();
			var qq = $("#qq").val();
			var email = $("#e-mail").val();

			if( CheckQQ(qq) && CheckMail(email) ){
				$.ajax({
					url:"do?invoke=SystemAction@savaUserFeedBack",
					type:'POST',
					dataType:'json',
					data:{
						user:USEROBJECT.loginname,
						area:area,
						qq:qq,
						email:email
					},
					success:function(rep){
						console.log(rep);
						 if(rep.result == 0) {
							 $.alert("反馈意见提交失败，您可以再试一次！");
							 return;
						 } else {
							 $.alert("提交成功，请耐心等待我们的修改，谢谢！");
							 $("#yjfk_area").val("");
							 $("#qq").val("");
							 $("#e-mail").val("");
						 }
					}   
				});
			} else {
				return;
			}

		});	
     }

</script>