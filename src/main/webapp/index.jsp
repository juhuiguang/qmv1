<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>
<script src="script/common/alienlab/dashboardlayer/alienlab.dashboard.js" type="text/javascript"></script>
<script src="script/common/alienlab/alienlab.framework2.loading.js" type="text/javascript"></script>
<link rel="stylesheet" href="script/common/alienlab/dashboardlayer/alienlab.dashboard.css" />
<link rel="stylesheet" href="script/common/alienlab/alienlab.framework2.loading.css" />
<title>校内教学质量监控运行平台</title>
<style>
	.ui.container.segment .button{
		margin-top:10px;
		margin-right:10px;
	}
	
	#leftcolumn{
		padding-right:0px;
		padding-top:0px;
		min-width:7.25%;
	}
	#leftcolumn .menu .item{
		padding-left:1em;
		padding-right:1em;
		line-height:1.5;
		
	}
	#leftcolumn .menu .item.active{
		border-color:#d4d4d5 !important;
	}
	#indexnav .ui.floating.label{
		top:0;
		left:90%;
	}
	#rightcolumn{
		padding:0;
		max-width:92.75% !important;
	}
	#container .ui.tab{
		border:1px solid #d4d4d5;
		border-left:none;
		min-height:545px;
		max-width:98%;
	}
	.menucard .header{
		font-weight:500 !important;
		font-size:1.1em !important;
	}
	.modulediv{
		margin-top:0 !important;
		margin-left:2em !important;
		margin-bottom:2em !important;
	}
	
	.modulediv .modulename{
		font-size:1em !important;
		font-weight:500 !important;
	}
	.modulediv .cards{
		margin-top:0em;
	}
	
	.modulediv .cards .card{
		max-width:30%;
		cursor:pointer;
	}
	
	.modulediv .cards .card .description{
		font-size:0.9em;
		margin-top:0.7em;
		max-height: 3.2em;
	    overflow: hidden;
	    word-wrap: break-word;
	    word-break:break-all;
	    line-height:1.5;
	}
	
	#logicapp,#logicapp2{
		margin-top:0 !important;
		padding-top:0 !important;
	}
	
	#personaldiv{
		margin-top:0.5em;
	}
	#personaldiv .card{
		width:auto !important;
		max-width:45%;
	}
	#personaldiv .card .description{
		margin-top:0.5em;
	}
	
	
</style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
<div id="container" >
		<div class="ui grid">
		  <div id="leftcolumn" class="one wide column">
		    <div id="indexnav" class="ui vertical  icon tabular blue menu">
		      <a class="item " data-tab="tab_personal" ><i class="icon ui  outline user large" ></i><span>个人<br/>中心</span>  </a>
		      <a class="item active" data-tab="tab_apps" ><i class="ui icon browser large"></i><span>业务<br/>应用</span> </a>
		      <a class="item" data-tab="tab_msg" ><i class="ui icon mail outline large"></i><span>消息<br/>盒子</span><!-- <div class="floating circular mini ui red label">22</div> --> </a>
		      <a class="item" data-tab="tab_account" ><i class="ui icon payment large"></i><span>账户<br/>设置</span>  </a>
		    </div>
		  </div>
		  <div id="rightcolumn" class="fifteen wide column">
		    <div class=" ui tab " data-tab="tab_personal">
		    <!--  -->
		    	<div id="personaldiv" class="ui cards container">
		    	<!--  
		    		<div class="ui card">
		    			<div class="content">
		    				<div class="header">我的课程</div>
		    				<div class="meta">点击数字查看详情</div>
				    			<div class="ui mini statistics">
				    				<div class="ui small statistic">
				    					<div class="value">2门</div>
				    					<div class="label">课程</div>
				    				</div>
				    				<div class="ui mini statistic">
				    					<div class="value">3个</div>
				    					<div class="label">班级</div>
				    				</div>
				    				<div class="ui mini statistic">
				    					<div class="value">35次</div>
				    					<div class="label">考勤</div>
				    				</div>
				    				<div class="ui mini statistic">
				    					<div class="value">2次</div>
				    					<div class="label">被听课</div>
				    				</div>
				    			</div>
				    			<div class="description">
				    				您本学期有 2 门课程，共3个班学生；截至目前，您共考勤35次；被督学听课2次。
				    			</div>
		    			</div>
		    			
		    		</div>
		    		<div class="ui card">
			    		<div class="content">
			    			<div class="header">全校出勤</div>
			    			<div class="meta">点击数字查看详情</div>
			    			<div class="ui mini statistics">
			    				<div class="ui mini statistic">
			    					<div class="value">98.56%</div>
			    					<div class="label">全校出勤率</div>
			    				</div>
			    				<div class=" ui mini statistic">
			    					<div class="value">97.43%</div>
			    					<div class="label">国教院</div>
			    				</div>
			    				<div class="ui mini statistic">
			    					<div class="value">99.56%</div>
			    					<div class="label">软件</div>
			    				</div>
			    				
			    			</div>
			    			<div class="description">
				    				本周全校出勤率为98.56%，其中国教院出勤率最低 97.43%，计算机与软件学院出勤率最高 99.56%；
				    			</div>
			    		</div>	
		    		</div>
		    		<div class="ui card">
			    			<div class="content">
			    				<div class="header">督学听课</div>
			    				<div class="meta">点击数字查看详情</div>
			    				<div class="ui mini statistics">
				    				<div class="ui mini statistic">
				    					<div class="value">5位</div>
				    					<div class="label">督导</div>
				    				</div>
				    				<div class="ui mini statistic">
				    					<div class="value">18次</div>
				    					<div class="label">听课</div>
				    				</div>
				    			</div>
				    			<div class="description">
				    				本周全校有5位督导共听课18次；
				    			</div>
			    			</div>
			    		</div>
			    		-->
		    	</div>
		    	
		    </div>
		    <div class="ui tab active" data-tab="tab_apps">
		    	<div class="modulediv ui grid">
		    		<div id="logicapp"  class="eight wide column ui grid">
		    		
		    		</div>
		    		<div id="logicapp2"  class="eight wide column ui grid">
		    		
		    		</div>
		    	</div>
		    </div>
		    <div class="ui tab" data-tab="tab_msg" >
					<iframe id="messageBox" style = "height:100%;width:100%;padding:0;margin:0;"> 
					
					</iframe> 
			</div>
		    <div class="ui tab" data-tab="tab_account">
		    	<iframe id="changePwd" style = "overflow-y:none;width:100%;padding:0;margin:0;"> 
					
					</iframe> 
		    </div>
		  </div>
		</div>
</div>
</body>
<script>
	window.setMsgBoxHeight=function(height){
		$("#messageBox").height(height);
	}
	var MODULE_ID=""; //当前页面
	var MENU_ID="";
	$(function() {
		//消息界面
		 $('#messageBox').attr('src' ,$.getUrl({
			config:{
				fromurl:"index.jsp",
				tourl:"InfCenter.jsp", 
				login_name:USEROBJECT.loginname
			}
		})); 
		//修改密码界面
		 $('#changePwd').attr('src' ,$.getUrl({
			config:{
				fromurl:"index.jsp",
				tourl:"changePwd.jsp" ,
				login_name:USEROBJECT.loginname, 
				user_name:USEROBJECT.username, 
			}
		})); 
		console.log(USEROBJECT)
		 $('#messageBox').css('height' , $('#messageBox').parent().height());
		 $('#changePwd').css('height' , $('#changePwd').parent().height());
		$("#indexnav .item").tab({
			//切换页面时，调整左侧导航高度，使边框闭合
			onVisible:function(){
				$("#indexnav").height($("#rightcolumn .tab.active").height());
			}
		});
		$("#rightcolumn").css("min-height",$("#indexnav").height());
		var menus=USEROBJECT.logicMenu;
		var menupurview=USEROBJECT.menu;
		//在用户有权限的菜单组里查找
		function findMenu(menu_id){
			for(var i=0;i<menupurview.length;i++){
				var submenus=menupurview[i].menu_children;
				if(submenus&&submenus.length>0){
					for(var j=0;j<submenus.length;j++){
						if(menu_id==submenus[j].menu_id){
							submenus[j].menu_pid=menupurview[i].menu_id;
							return submenus[j];
						}
					}
				}
			}
			return null;
		}
		if(!menus)return;
		var colors=["red","orange","yellow","olive","green","teal","blue","violet","purple","pink","brown"];
		for(var i=0;i<menus.length;i++){
			var module=$('<div class="moduleitem sixteen wide column"></div>');
			var modulesegment=$('<div class="ui segment"></div>');
			var moduleheader=$('<div class="ui modulename blue ribbon label">'+menus[i].menu_name+'</div>');
			var modulecontent=$('<div class="ui cards"></div>');
			modulesegment.append(moduleheader);
			module.append(modulesegment);
			if(menus[i].menu_children){
				var submenus=menus[i].menu_children;
				for(var j=0;j<submenus.length;j++){
					var menuitem=findMenu(submenus[j].menu_id);
					var menucard=$("<div class='menucard card' link='"+submenus[j].menu_link+"' menu='"+submenus[j].menu_id+"' module='"+(menuitem?menuitem.menu_pid:"")+"'></div>");
					if(!menuitem){
						menucard.addClass("disabled");
						menucard.append(
								$("<div class='content'></div>")
									.append($('<div class="header">'+submenus[j].menu_name+'</div><div class="ui divider"></div>'))
									.append($('<div class="description">'+(submenus[j].menu_desc?submenus[j].menu_desc:"")+'</div>'))
						);
					}else{
						menucard.append(
								$("<div class='content'></div>")
									.append($("<i class='right floated green chevron circle right ui  icon'></i>"))
									.append($('<div class="header">'+submenus[j].menu_name+'</div><div class="ui divider"></div>'))
									.append($('<div class="description">'+(submenus[j].menu_desc?submenus[j].menu_desc:"")+'</div>'))
						);
					}
					modulecontent.append(menucard);
				}
				modulesegment.append(modulecontent);
			}
			if(i%2){
				$("#logicapp2").append(module);
			}else{
				$("#logicapp").append(module);
			}
			$("#indexnav").height($("#rightcolumn").height());
			
			$(".modulediv .cards .card").click(function(){
				if($(this).hasClass("disabled"))return;
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
		}
  	});
	$(function(){
		var rolesmapping={
				"超级管理员":"xld,teacher,zkld,xssj,fdy,jxyz,xgcz,xld,zkld",
				"教师":"teacher",
				"学生":"",
				"校级督学":"xld,zkld",
				"二级学院（部）督学":"",
				"教学秘书":"",
				"学生信息员":"",
				"班主任":"",
				"二级学院学生工作书记、辅导员":"xssj,fdy",
				"二级学院（部）领导":"jxyz",
				"二级学院（部）督学组组长":"",
				"专业评估专家":"",
				"学工处":"xgcz",
				"校领导":"xld",
				"质控处":"zkld"
		}
		//准备参数
		function preparam(){
			var param={};
			var day=new Date();
			var pos=day.getDay();
			if(pos==0)pos=7;
			var weekstart=new Date();
			weekstart.setTime(day.getTime()-1000*60*60*24*(pos-1));
			var weekend=new Date();
			weekend.setTime(day.getTime()+1000*60*60*24*(7-pos));
			console.log(weekstart,weekend);
			console.log(SYSOBJECT,USEROBJECT);
			param.start_date=weekstart.Format("yyyyMMdd");
			param.end_date=weekend.Format("yyyyMMdd");
			param.term_no=SYSOBJECT.term_no;
			param.yjz="8";
			param.class_no="";
			param.week=SYSOBJECT.currentweek;
			param.term_start_time=SYSOBJECT.term_startdate;
			param.dep_no=USEROBJECT.userinfo.dep_no;
			param.login_no=USEROBJECT.loginname;
			
			var roles=[];
			for(var i=0;i<USEROBJECT.roles.length;i++){
				var role=USEROBJECT.roles[i].role_name;
				var flag=rolesmapping[role];
				if(flag!=""){
					if(flag.indexOf(",")>0){
						roles=roles.concat(flag.split(","));
					}else{
						roles.push(flag);
					}
				}
			}
			param.roles=roles.join(",");
			console.log(param);
			return param;
		}
		var param=preparam();
		//请求获得看板数据
		//$("#rightcolumn").alloading().loading();
		$("#personaldiv").append("<div id='loadingtip' class='ui message'>数据正在加载中，请稍后操作...</div>");
		$.ajax({
			url:'do?invoke=dashboard@getKeys',
			type : 'POST',
			dataType : 'json',
			data:param,
			success : function(rep) {
				console.log("dashboard data is>>>",rep);
				var config=getConfig(rep);
				console.log("dashboard config is>>>",config);
				
				var dashboard=new $.alienlab.dashboardEngine({groups:config});
				dashboard.rendergroup($("#personaldiv"));
				$("#indexnav").height($("#rightcolumn").height());
				$("#loadingtip").remove();
				//$("#rightcolumn").alloading().unloading();
			}
		});
		var config=null;
		//根据看板数据生成看板组件配置
		function getConfig(data){
			return getGroups();
			function getGroups(){
				var result=[];
				for(var i=0;i<data.length;i++){
					if(data[i].resultType=="detail")continue;
					var g={};
					g.name=data[i].title;
					if(data[i].resultText&&data[i].resultText.length>0){
						g.dataItems=getTexts(data[i].resultText);
					}
					result.push(g);
				}
				return result;
			}
			
			function getTexts(resultText){
				var result=[];
				for(var i=0;i<resultText.length;i++){
					var t={};
					t.key=resultText[i].textkey;
					t.value=resultText[i].shorttextvalue;
					t.unit="";
					t.shortText=resultText[i].shorttext;
					t.text=resultText[i].textvalue;
					if(resultText[i].detailkeyword&&resultText[i].detailkeyword!=""){
						t.detail=getDetail(resultText[i].detailkeyword);
					}
					result.push(t);
				}
				return result;
			}
			
			function getDetail(detail){
				var detailconfig=getDetailConfig(detail);
				var result={};
				result.key=detailconfig.keyword;
				result.data=detailconfig.sqlresult;
				result.fieldMapping=detailconfig.resultFields;
				return result;
			}
			
			function getDetailConfig(detailkey){
				for(var i=0;i<data.length;i++){
					if(data[i].resultType=="detail"){
						if(data[i].keyword==detailkey){
							return data[i];
						}
					}
				}
				return null;
			}
		}
		var dashboardconfig={
				groups:[{
					name:'我的教学',
					dataItems:[
						{
							key:"course",
							value:2,
							unit:"门",
							shortText:"课程",
							text:"您本学期共有2门课程",
							link:"www.baidu.com",
							detail:{
								key:'coursedetail',
								data:[
								      {course_name:"C语言程序设计",course_zxs:"96学时"},
								      {course_name:"数据结构",course_zxs:"48学时"}
								 ],
								 fieldMapping:{
									 course_name:"课程名称",
									 course_zxs:"课程学时"
								 }
							}
						},
						{
							key:"classes",
							value:3,
							unit:"个",
							shortText:"班级",
							text:"您本学期共带3个班级",
							link:"www.baidu.com",
							detail:{
								key:'classdetail',
								data:[
								      {class_name:"软件1431",class_count:46},
								      {class_name:"软件1421",class_count:40}
								 ],
								 fieldMapping:{
									 class_name:"班级",
									 class_count:"人数"
								 }
							}
						},
						{
							key:"listen",
							value:3,
							unit:"次",
							shortText:"听课",
							text:"您本学期已被听课了3次",
							link:"www.baidu.com",
							detail:{
								key:'listendetail',
								data:[
								      {course_name:'C语言程序设计',listen_date:"2016-02-29",master_name:'胡光永',jxjy:"多一些师生互动，增加课件的案例数量。"}
								 ],
								 fieldMapping:{
									 course_name:"课程名称",
									 listen_date:"听课日期",
									 master_name:"听课督学",
									 jxjy:"教学建议"
								 }
							}
						}
					]
				},{
					name:'学生考勤',
					dataItems:[
						{
							key:"wkqcs",
							value:3,
							unit:"次",
							shortText:"考勤",
							text:"您本学期有3次课程未打考勤",
							link:"www.baidu.com"
						},
						{
							key:"pjcql",
							value:"98.52",
							unit:"%",
							shortText:"出勤率",
							text:"您的课程平均出勤率达到98.52%",
							link:"www.baidu.com"
						}
					]
				}]
		}
		//console.log("dashboardconfig",dashboardconfig);
		
	});
	
</script>
</html>