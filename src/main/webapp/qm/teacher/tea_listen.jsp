<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<%
	String rootpath = new PropertyConfig("sysConfig.properties").getValue("rootpath");
%>
<html>
<head>
<%@include file="/commonjsp/meta.jsp" %>
<!--这里引用其他样式-->
<title>欢迎使用-首页</title>
<style>
	#btnsubmit{
		width:100%;
		margin:10px auto;
	}
	textarea{
		width:100%;
		margin-top:10px;
	}
	#tableinfo .header{
		font-size:100%;
		font-weight:200;
	}
	#taskgrid{
		margin-top:2px;
		height:400px;
		overflow-y:scroll;
	}
	
	#taskgrid .card{
		cursor:pointer;
		width:200px;
		overflow-y:scroll;
	}
	
	#taskgrid a{
		cursor:pointer;
	}
	
	#teacherspnl .label{
		margin-top:5px;
		margin-left:5px;
		cursor:pointer;
	}
	#teachertaskpnl{
		margin-top:5px;
		height:350px;
		overflow-y:scroll;
	}
	#teachertaskpnl .card{
		cursor:pointer;
		width:200px;
		overflow-y:scroll;
	}
	
	#tableinfo .gradediv{
		margin-left:10px;
	}
	
	#tableinfo .gradediv input{
	    width: 25px;
	    background-color: transparent;
	    text-align: center;
	    border: none;
	}
	
	#myplan .week{
		cursor:pointer;
		margin-top:5px;
	}
	
	#btnlastweek{
		cursor:pointer;
		color:blue;
	}
	#plandiv{
		margin-top:10px;
	}
	
	#plandiv .card{
		cursor:pointer;
	}
	#zongfen{
		font-weight:500;
	}
	#infodiv{
		position:relative;
	}
	#divzongfen{
		width:35%;
		position:absolute;
		right:0;
		margin-top:5px;
	}
	#tableheader{
		width:65%;
		position:absolute;
		left:10px;
	}
	#tableinfo{
		margin-top:45px;
	}
	.file.text.outline.icon {
		color:#DADADA;   
		margin-left: 85%;
		margin-bottom: 5%;  
	} 
	.file.text.outline.icon:hover {
		color:#000000;
		
	}
	.meta.schejc {
		font-size: 90% !important;
    	color: #BB6262 !important;    
	}
	.bq { 
		display: inline-block;
	    width: auto;
	    vertical-align: baseline; 
	    font-size: .9em;
	    font-weight: 700;
	    color: rgba(0,0,0,.87);
	    text-transform: none;
	    margin-bottom: 8px;   
	    width: 43%;   
    	margin-left: 6%;
	}
	#CMessage {
		background: white;
	}
	.bq2 { 
	    font-size: .91em;
	    font-weight: 600;
	    color: rgba(0,0,0,.87);
    	margin-left: 5%;   
	}
	.see_down {
    	float: right !important;
		margin-right: 10% !important;
	}
	.unsee_down {
		float: right !important;
		margin-right: 10% !important; 
	}
	.ui.middle.list {
		margin-bottom: -10px;
	}
							 		    
</style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<!--这里绘制页面-->
	<div id="container" class="ui grid">
		<div id="leftpanel" class="sixteen wide column">
			<div class="ui top attached tabular menu" id="datatype">
			  <a class="item" data-tab="first">我的计划</a>
			  <a class="item" data-tab="second">我关注的教师</a>
			  <a class="item" data-tab="third">全部教学任务</a>
			</div>
			<div class="ui bottom attached tab segment active" data-tab="first" id="myplan">
				<div class="weekpnl">
					<div class="ui label" >
						当前周：
					</div>
				  	<div class="ui label blue week current"  id="btncurrweek"></div>
				  	<span id="btnlastweek">看看上周</span>
				</div>
				<div class="ui visible message" id="noplanmsg">
				  <p>没有查询到您 <span id="weekshow">17</span> 周的听课计划。</p>
				  <p>看看其他周的听课计划，请点击上方“看看上周”。</p>
				  <p>您也可以立即<a id="addplanbtn" href="qm/teacher/sup_listenplanadd.jsp?module=<%=MODULE_ID %>">添加听课计划</a>。</p>
				</div>
				<div id="plandiv" class="ui cards">
					
				</div>
			</div>
			<div class="ui bottom attached tab segment" data-tab="second" id="mymark">
			 	<div class="ui visible message" id="nomarkmsg">
				  <p>您还没有关注教师，点我进入<a id="addmarkbtn" href="qm/teacher/sup_markadd.jsp?module=<%=MODULE_ID %>">我关注的教师</a>。</p>
				</div>
				<div id="teachertaskpnl" class="ui cards">
			 		
			 	</div>
			</div>
			<div class="ui bottom attached tab segment" data-tab="third" id="alltask">
				<div id="searpnl">
					<div class="ui pointing secondary bule menu" id="searchtab">
					  <a class="item" data-tab="searchname">按教师查询</a>
					  <a class="item" data-tab="searchweek">按周查询</a>
					</div>
					<div class="ui bottom attached tab segment active" data-tab="searchname" id="teachersearch">
						<div class="ui search"  id="teachernamesrch">
						  <div class="ui icon input">
						    <input class="prompt"  type="text" placeholder="请输入教师名称...">
						    <i class="search icon"></i>
						  </div>
						  <div class="results"></div>
						</div>
					</div>
					<div class="ui bottom attached tab segment" data-tab="searchweek" id="weeksearch">
						<div class="ui label" id="srchweek_1">周一</div>
						<div class="ui label" id="srchweek_2">周二</div>
						<div class="ui label" id="srchweek_3">周三</div>
						<div class="ui label" id="srchweek_4">周四</div>
						<div class="ui label" id="srchweek_5">周五</div>
						<div class="ui label" id="srchweek_6">周六</div>
						<div class="ui label" id="srchweek_7">周日</div>
					</div>
				</div>
			 	<div id="taskgrid" class="ui cards">
			 		
			 	</div>
			</div>
		</div>
		<div id="rightpanel" class="seven wide column" style="display:none;">
				<div class="ui blue message" id="infodiv">
					<div id="tableheader"></div>
			 		<div id="divzongfen" class="ui raised  content">
				 		<div class="header">
				 			<i class=" pie chart  big icon"></i> 
				 			总分：<span id="zongfen"></span>
			 			</div>
			 		</div>
				<!-- 
				<ul id="tableinfo">
					<li>
							<div class="ui container">
							<div class="ui form">
							  <div class="field">
							    <div class="ui blue ribbon label">6、听课评价</div>
							    <textarea id="txttkpj"  rows="3"></textarea>
							  </div>
							  <div class="ui divider"></div>
							  <div class="field">
							    <div class="ui blue ribbon label">7、教学建议</div>
							    <textarea id="txtjxjy" rows="3"></textarea>
							  </div>
							</div>
						</div>
					</li>
				</ul>
				 -->
				 <div id="tableinfo" class="ui relaxed divided list">
				 	<div class="item">
				 		<div class="ui raised  content">
					 		<div class="header">
					 		<i class=" github middle aligned file word outline icon"></i> 
					 			6.听课评价 <a msgtype="听课评价"  textid="txttkpj" class="msgbtn" href="javascript:void(0);">使用常用语</a>
					 		</div>
					 		<div class="description">
						       	<textarea id="txttkpj" rows="4"></textarea>
						     </div>
					     </div>
				 	</div>
				 	<div class="item">
				 		<div class="ui raised  content">
					 		<div class="header">
					 			<i class=" github middle aligned file word outline icon"></i> 
					 			7.教学建议<a msgtype="教学建议"  textid="txtjxjy"  class="msgbtn" href="javascript:void(0);">使用常用语</a>
					 		</div>
					 		<div class="description">
						       	<textarea id="txtjxjy" rows="4"></textarea>
						     </div>
					     </div>
				 	</div>
				 	
				 	<div class="item">
				 		<div class="ui raised  content">
					 		<div class="header">
					 			<i class=" github middle aligned file word outline icon"></i> 
					 			选择听课日期：
					 			<input type="text" id="listendate"  style="border:1px solid #a9a9a9;"/>
					 		</div>
				 	</div>
				 </div>
				<div class="ui container center aligned">
					<button id="btnsubmit" class="ui green button">
					  <i class="checkmark icon"></i>
					  提交 
				</button>
				</div>
		</div>
		<div class="ui long modal" id="showMessage">
		 	<i class="close icon"></i>
			<div class="header">请选择您的常用语</div>
				<div class="ui segment content">
					<div class="ui relaxed divided list" id="msglist">
					 	<div class="ui message green" id="mymsg">
					 		您还没有设置常用语，前往设置>><a href="qm/teacher/sup_config.jsp?module=<%=MODULE_ID%>">常用语设置</a>
					 	</div>
					    
					  </div>
					  <div class="ui positive tiny labeled icon button" id="msgsurebtn">
					     确定
					      <i class="checkmark icon"></i>
					    </div>
				</div>
		</div>
		
		<div id="modCourseFile" class="ui modal gr">      
			  <div class="header">
			    查看本学期授课计划详情:     
			    <i class="close icon" style="float: right;"></i>
			  </div>
			  <div class="content">
			  	<div class="description">
			  			<div class="ui message">
				  			<label class="bq" id="C_no">课程代码：</label>
							<label class="bq" id="T_no">教师工号：</label>
			  				<label class="bq" id="C_name">课程名称：</label>    
		  					<label class="bq" id="T_name">教师姓名：</label> 
			  			</div>
			  			<div class="ui message" id="CMessage">
							<div id="CourseFilePane">
								 
							</div>
						</div>
			    </div>
			  </div>
		</div>
	</div>
</body>
<link rel="stylesheet"  href="script/common/datepicker/jquery.datetimepicker.css"></link>
<script src="script/common/datepicker/jquery.datetimepicker.js"></script>
<script>
	$(function(){
		var suplisbutFlag = "";
		var btk_teaname = "";
		var btk_teano = "";
		var btk_coursename = "";
		
		var today=new Date();
		$("#listendate").datetimepicker({
			 maxDate:new Date(),
			  timepicker:false,
			  format:'Y-m-d',
			  lang:'zh',
			  value:today.getFullYear()+"-"+(((today.getMonth()+1)<10)?("0"+(today.getMonth()+1)):(today.getMonth()+1))+"-"+((today.getDate()<10)?("0"+today.getDate()):today.getDate())
		});
		initMsg();
		$("#tableinfo .msgbtn").click(function(){
			var textid=$(this).attr("textid");
			showMessage($(this).attr("msgtype"),function(msg){
				$("#"+textid).val(msg);
			});
		});
		function initMsg(){
			$.ajax({
				url: 'do?invoke=SupConfigAction@getConfig',
				dataType:"JSON",
				type:"POST",
				data:{
					master_no:USEROBJECT.userinfo.teacher_no
				},
				success:function(rep){
					renderMsg(rep.data);
				}
			});
			
			function renderMsg(msgs){
				if(msgs.length>0){
					$("#mymsg").text("请点击需要使用的常用语。");
				}
				$("#msglist .msgitem").remove();
				for(var i=0;i<msgs.length;i++){
					var msgtype="tkpj";
					if(msgs[i].config_type!="听课评价"){
						msgtype="jxjy";
					}
					var msgdom=$('<div class="item msgitem '+msgtype+'"><div class="ui basic blue button">'+msgs[i].content+'</div></div>');
					$("#msglist").append(msgdom);
				}
				$("#msglist .msgitem .button").click(function(){
					if($(this).hasClass("active")){
						$(this).removeClass("active");
					}else{
						$(this).addClass("active");
					}
					genMsg();
				});
			}
			
			function genMsg(){
				var nodes=$("#msglist .msgitem .active");
				var msg="";
				for(var i=0;i<nodes.length;i++){
					msg+=$(nodes[i]).text()+"<br/>";
				}
				if(msg==""){
					msg="请点击需要使用的常用语。";
				}
				$("#mymsg").html(msg);
			}    
		}                         
		
		
		
		function showMessage(msgtype,suredo){
			$("#msglist .msgitem .active").removeClass("active");
			if($("#msglist .msgitem").length>0){
				$("#mymsg").text("请点击需要使用的常用语。");
			}
			if(msgtype=="听课评价"){
				$("#msglist .jxjy").hide();
				$("#msglist .tkpj").show();
			}else{
				$("#msglist .tkpj").hide();
				$("#msglist .jxjy").show();
			}
			$("#showMessage").modal({
				closable:true
			}).modal("show");
			$("#msgsurebtn").unbind("click").click(function(){
				var msg=$("#mymsg").text();
				if(msg=="请点击需要使用的常用语。"){
					msg="";
				}
				if(suredo){
					suredo(msg);
				}
				$("#showMessage").modal("hide");
			});
		}
		
		
		$('#datatype .item,#searchtab .item').tab();
		var curr_rule_flag="";
		var userProperties={
				mark:null,
				plan:null
		}
		//初始化全部教学任务界面
		initAllTaskPnl();
		//获取个人听课计划
		getMyPlan(SYSOBJECT.currentweek,function(plan){
			initPlanPnl(plan.data);
			//获得关注的人，初始化界面
			getMyMark(function(mark){
				userProperties.mark=mark;
				initMarkPnl();
				if(plan.result>0){//获取个人计划，初始化个人计划界面
					userProperties.plan=plan;
					//切换至全部教学任务pnl
					changeDataTypePnl("first");
				}else{
					if(!mark.data||mark.data.length==0){
						//切换至全部教学任务pnl
						changeDataTypePnl("third");
					}else{
						//切换至全部教学任务pnl
						changeDataTypePnl("second");
					}
				}
				
			});
		});
		
		
		function changeDataTypePnl(tabname){
			$("#datatype .item.active").removeClass("active");
			$("#datatype .item[data-tab='"+tabname+"']").addClass("active");
			$.tab('change tab', tabname);
		}
		
		//初始化全部教学任务面板
		function initAllTaskPnl(){
			$.ajax({
				url: 'do?invoke=ListenAction@getTeachers',
				dataType:"JSON",
				type:"POST",
				success:function(data){
					console.log(data);
					$('#teachernamesrch').search({
						source : data,
					    searchFields   : [
					      'title'
					    ],
					    searchFullText: false,
					    onSelect:function(result,response){
					    	getTasks("teacher",result.title,function(data){
								drawTask(data.data,"taskgrid");
							});
					    }
				
					});
				}
			});
			
			
			
			//如果是校级督学，跳转至按姓名查找
			if(USEROBJECT.userpurview=="ALL"){
				$("#searpnl .item.active").removeClass("active");
				$("#searpnl .item[data-tab='searchname']").addClass("active");
				$.tab('change tab', 'searchname');
			}else{//部门督学跳转至按周次查找
				$("#searpnl .item.active").removeClass("active");
				$("#searpnl .item[data-tab='searchweek']").addClass("active");
				$.tab('change tab', 'searchweek');
				var curweekday=new Date().getDay();
				if(curweekday==0)curweekday=7;
				$("#srchweek_"+curweekday).addClass("blue selected");
				//初始化获取
				getTasks("week",curweekday,function(data){
					drawTask(data.data,"taskgrid");
				});
			}
			
			//绑定周选择按钮
			$("#weeksearch .label").unbind("click").click(function(){
				$("#weeksearch .selected").removeClass("blue selected");
				$(this).addClass("blue selected");
				var selectedweek=this.id.split("_")[1];
				getTasks("week",selectedweek,function(data){
					drawTask(data.data,"taskgrid");
				});
			});
		}
		
		//初始化周计划面板
		function initPlanPnl(){
			var curweek=SYSOBJECT.currentweek
			$("#btncurrweek").text(curweek);
			$("#weekshow").text(curweek);
			for(var i=curweek-1;i>=1;i--){
				var weeklabel=$('<div class="ui label  week" style="display:none;">'+i+'</div>');
				$("#btnlastweek").before(weeklabel);
			}
			
			getMyPlan(curweek,function(data){
				randerPlan(data);
			});
			
			$("#myplan .week").unbind("click").click(function(){
				$("#myplan .week.blue").removeClass("blue");
				$(this).addClass("blue");
				var week=$(this).text();
				$("#weekshow").text(week);
				getMyPlan(week,function(data){
					randerPlan(data);
				});
			});
			
			$("#btnlastweek").unbind("click").click(function(){
				if($(this).text()=="看看上周"){
					$("#myplan .week").fadeIn();
					$(this).text("<<收起");
				}else{
					$("#myplan .week").fadeOut();
					$("#myplan .current").fadeIn().addClass("blue");
					getMyPlan($("#myplan .current").text(),function(data){
						randerPlan(data);
					});
					$(this).text("看看上周");
				}
			});
			
			function randerPlan(data){
				if(data.result>0&&data.data.length>0){
					$("#noplanmsg").fadeOut();
					$("#plandiv").children().remove();
					for(var i=0;i<data.data.length;i++){
						var dom=$('<div class="ui card" teacher_name="'+data.data[i].teacher_name+'" course_name="'+data.data[i].course_name+'" task_no="'+data.data[i].task_no+'"></div>').append($("<div class='content'></div>")
										.append($('<div class="header" task_no="'+data.data[i].task_no+'">'+data.data[i].teacher_name+' '+data.data[i].course_name+'</div>'))
										.append($('<div class="meta">'+data.data[i].course_type+'</div>'))
										.append($('<div class="description">上课班级：'+data.data[i].class_name+' <br/>计划听课时间：'+data.data[i].plan_time+'</div>'))
										);
						$("#plandiv").append(dom);
					}
					$("#plandiv").fadeIn();
				}else{
					$("#noplanmsg").fadeIn();
					$("#plandiv").fadeOut();
				}
				
				$("#plandiv .card").unbind("click").click(function(){
					var task_no=$(this).attr("task_no");
					var course_type=$(this).find(".meta").text();
					if(course_type=="实训课") course_type="TK_SX";
					else course_type="TK_JS";
					
					beginListen(course_type,task_no,$(this).attr("teacher_name"),$(this).attr("course_name"));
				});
			}
		}
		
		//初始化关注的人面板
		function initMarkPnl(){
			var data=userProperties.mark;
			$("#nomarkmsg").hide();
			if(data.result>0){
				renderMarkTeacher(data.data);
			}else{
				$("#nomarkmsg").transition("fly up in");
			}
			
			$("#teacherspnl .label").unbind("click").click(function(){
				$("#teacherspnl .blue").removeClass("blue");
				$(this).addClass("blue");
				var id=this.id.split("_")[1];
				getTasks("teacher_no",id,function(data){
					drawTask(data.data,"teachertaskpnl");
				});
			});
			
			
			
			function renderMarkTeacher(teachers){
				$("#teacherspnl").remove();
				var teacherspnl=$("<div id='teacherspnl'></div>");
				for(var i=0;i<teachers.length;i++){
					var teacherpnl=$("<div id='teacher_"+teachers[i].teacher_no+"' class='ui label'>"+teachers[i].teacher_name+"</div>");
					teacherspnl.append(teacherpnl);
				}
				$("#mymark").prepend(teacherspnl);
			}
		}
		
		//获得我的听课计划
		function getMyPlan(planweek,callback){
			$.ajax({
				url: 'do?invoke=ListenAction@getMasterPlan',
				dataType:"JSON",
				data:{
					master_no:USEROBJECT.userinfo.teacher_no,
					week:planweek
				},
				type:"POST",
				success:function(myplan){
					if(callback){
						callback(myplan);
					}
				}
			});
			
		}
		
		//获得我关注的教学任务
		function getMyMark(callback){
			//获得关注的教师名单
			$.ajax({
				url: 'do?invoke=ListenAction@getMarkedTeacher',
				dataType:"JSON",
				data:{
					teacher:USEROBJECT.userinfo.teacher_no
				},
				type:"POST",
				success:function(data){
					if(callback){
						callback(data);
					}
				}
			});
			
		}
		
		function getTasks(type,keywords,callback){
			$.ajax({
				url:"do?invoke=ListenAction@getTasks",
				type:'POST',
				dataType:'json',
				data:{
					dep_no:USEROBJECT.userpurview,
					type:type,
					keywords:keywords
				},
				success:function(rep){
					console.log(rep.data);
					if(callback){
						callback(rep);
					}
				}
			})
		}
		
		//渲染教学任务
		function drawTask(data,containerid){
			console.log($("#"+containerid));
			$("#"+containerid).children().remove();
			console.log(data);
			for(var i=0;i<data.length;i++){   
				var task=data[i];      
				var dom='<div class="blue card">';
			 						/* '<div class="content firstpage">'+
						 				'<div class="header">'+
						 					task.teacher_name+
						 				'</div>'+    
						 				'<div class="meta">'+
									       	task.course_type+
									    '</div>'+
						 				'<div class="description">'+
						 					task.course_name+
									    '</div>'+
						 			'</div>'; */         
						 			if(task.classes&&task.classes.length>0){
							 			taskclass=task.classes[0];                                 
							 			dom += '<div class="content secondpage">'+   
							 							'<div class="header" id="'+task.course_type+'" taskno="'+taskclass.task_no+'" teano="'+task.teacher_no+'" coursename="'+task.course_name+'">'+task.teacher_name+'</div>'+         
										 				'<div class="description">'+   
											       			'<div class="ui middle aligned selection list">'+    
								       							'<div class="task item" id="task_'+taskclass.task_no+'">'+    
												    				'<div class="content">'+												      					
												      					'<div class="meta" style="font-size:95%;">';  
																   // 		task.course_type+
																   			for(var k=0; k<task.classes.length; k++) {
																   				for(var j=0; j<task.classes[k].sches.length; j++) {
																   					var jcz = task.classes[k].sches[j];
																   					if(jcz.sche_set == null || jcz.sche_set == "" || (jcz.sche_set.substring(0,1) != "k" && jcz.sche_set.substring(0,1) != "K") || jcz.sche_set == "K99" || jcz.sche_set == "k99"){
																				           dom += ' 实训周 '; 
																						}else{
																							var zc = jcz.sche_set.substring(1,2);
																							var jc = jcz.sche_set.substring(2,3);
																							if(!SINGLESCHE){//增加对单课时的兼容
                                                                                                dom += WEEK[zc] +" 【 "+ COURSE_JC[jc] +" 】<br/> "+ jcz.sche_addr +"</p>";
																							}else{
                                                                                                dom += WEEK[zc] +" 【 "+ COURSE_JC_SINGLE[jc] +" 】<br/> "+ jcz.sche_addr +"</p>";
																							}

																						} 
																   				}
																   			}													      			
													       			dom +=
																		'</div>'+
													       				'</p>'+ 
															 			'<div class="description" id="'+task.teacher_no+'">'+
															 				task.course_name+
																		'</div>'+        
												    				'</div>'+
												 				 '</div>'+
									   						'</div>'+  
												    	'</div>'+
										 			'</div>'+     
										 			'<i class="ck_see file text outline icon" id="'+task.course_no+'" coursename="'+task.course_name+'" teano="'+task.teacher_no+'" teaname="'+task.teacher_name+'"  data-content="点击可查看本教师此课程授课计划" data-variation="small"></i>'; 
													 
						 			}
/* 				if(task.classes&&task.classes.length>0){
					dom+='<div class="content secondpage" style="display:none;">'+
	 				'<div class="description">'+
			       	'<div class="ui middle aligned selection list">';
					for(var j=0;j<task.classes.length;j++){
						var taskclass=task.classes[j];
						var taskjc="";
						if(taskclass.sches&&taskclass.sches.length>0){
							for(var k=0;k<taskclass.sches.length;k++){
								var jcz=taskclass.sches[k];
								if(jcz.sche_set==null||jcz.sche_set==""||(jcz.sche_set.substring(0,1)!="k"&&jcz.sche_set.substring(0,1)!="K")||jcz.sche_set=="K99"||jcz.sche_set=="k99"){
									taskjc="实训周";
								}else{
									var zc=jcz.sche_set.substring(1,2);
									var jc=jcz.sche_set.substring(2,3);
									taskjc+=WEEK[zc]+" "+COURSE_JC[jc]+" "+jcz.sche_addr+";<br/>";
								}
							}
						}
						dom+= '<div class="task item" id="task_'+taskclass.task_no+'">'+
									    '<div class="content">'+
									      '<div class="header"><a href=javascript:void(0);>'+taskclass.class_name+'</a></div>'+
									      taskjc+
									    '</div>'+
									  '</div>';
					}
					dom+='</div>'+
				    '</div>'+
		 			'</div>';
				} */
				dom+=	'</div>';	 	
				$("#"+containerid).append($(dom));
			}
			$('.ck_see').popup();
			bindcardclick(containerid);
			readSinglCourseFile();       
		}
		
		//某教师某门课程已上传授课计划查看
		function readSinglCourseFile() {
			$('.ck_see.file.icon').unbind('click').click(function(){
				var courseno = $(this).attr("id");
				var coursename = $(this).attr("coursename");
				var teano = $(this).attr("teano");
				var teaname = $(this).attr("teaname"); 
				console.log(courseno,coursename,teano,teaname);   
				
				$.ajax({
					url:"do?invoke=ListenAction@getSinglCourseFileData",
					type:'POST',
					dataType:'json',
					data:{
						termno:SYSOBJCET.term_no,
						courseno:courseno,
						teano:teano
					},
					success:function(rep) {
						if(rep.result == 0) {
							$.alert("该教师所教授的本门课程尚无“授课计划”可查看！");
							return;
						} else {
							CFileData = rep.data;
							ShowCFileMod(courseno,coursename,teano,teaname,CFileData);
						}
					}
				});
			});
		}
		
		//该教师的本课程有授课计划，弹出框展示其内容
		function ShowCFileMod(courseno,coursename,teano,teaname,CFileData) {
			$("#CourseFilePane").empty(); 
			$('#modCourseFile').modal({
 				transition:'slide down',
 				observeChanges:true,
 				closable:false
 			 }).modal('show');     
			$("#C_no").text('课程代码：' + courseno );
			$("#T_no").text('教师工号：' + teano);
			$("#C_name").text('课程名称：' + coursename ); 
			$("#T_name").text('教师姓名：' + teaname);  
			for(var i=0; i<CFileData.length; i++) {
				var dom =
					'<div class="ui middle aligned selection list" id="'+CFileData[i].file_id+'">'+
						'<div class="item" id="'+CFileData[i].file_id+'">'+ 
							'<div class="bq2">'+    
								'文件编号 【 '+ CFileData[i].file_id +' 】&nbsp;&nbsp;：&nbsp;&nbsp;'+ CFileData[i].file_name ;
								if(CFileData[i].file_url == null || CFileData[i].file_url == "") {
									dom +=
									'<div class="unsee_down mini circular ui white basic icon button" href="" data-content="暂无文件下载地址！" data-variation="small">'+ 
				                        '<i class="hide small icon"></i>'+      
					                '</div>';  
								} else {
									dom +=
									'<a class="see_down mini circular ui black basic icon button" href="" id="'+CFileData[i].file_url+'" data-content="点击可下载文件查看授课计划~" data-variation="small">'+ 
				                        '<i class="unhide black small icon"></i>'+      
					                '</a>';  
								}
								dom +=
							'</div>'+ 
						'</div>'+        
					 '</div>';
				$("#CourseFilePane").append($(dom)); 
			} 
			$('.see_down').popup();  
			$('.unsee_down').popup();    
			$('#'+CFileData[CFileData.length-1].file_id).css({'margin-bottom':'8px'});    
			$('.unsee_down.button').css({'cursor':'default'});          
			
			$('.see_down.button').unbind('click').click(function(){
				var fileurl = $(this).attr("id");
				$(this).attr("href",fileurl);           
			});
		}
		
		//绑定卡片点击事件
		function bindcardclick(containerid){
			/* $("#"+containerid+" .card").unbind("click").click(function(){
				if($(this).hasClass("red")){
					$(this).removeClass("red");
					$(this).addClass("blue");
				}else{
					$(this).removeClass("blue");
					$(this).addClass("red");
				}
				$(this).children(".firstpage").transition('hide');       
				$(this).children(".secondpage").transition('show');
			}); */     
			$("#"+containerid+" .header").unbind("click").click(function(e){
				e.stopPropagation();     
				var task_no=$(this).attr("taskno");
				var course_type=$(this).attr("id");     
				//开始填写听课记录
				if(course_type=="实训课"){
					course_type="TK_SX";       
				}else{   
					course_type="TK_JS";  
				}
				var teacher_name=$(this).text();           
				var course_name=$(this).parents(".card").children(".secondpage").children(".description").children(".middle.aligned.selection.list").children(".task.item").children(".content").children(".description").text(); 
				var teano = $(this).parents(".card").children(".secondpage").children(".description").children(".middle.aligned.selection.list").children(".task.item").children(".content").children(".description").attr("id");
		//		console.log(task_no,course_type,teacher_name,course_name,teano);  
				btk_teaname = teacher_name;
				btk_teano = teano;
				btk_coursename = course_name;
				
				beginListen(course_type,task_no,teacher_name,course_name);  
			});
			
			 
			$("#"+containerid+" .task").unbind("click").click(function(e){
				e.stopPropagation();     
				
				$("#"+containerid+" .active").removeClass("active");
				$(this).addClass("active");    
				var task_no=this.id.split("_")[1];
				var course_type=$(this).parents(".card").children(".secondpage").children(".header").attr("id");    
				//开始填写听课记录
				if(course_type=="实训课"){
					course_type="TK_SX";       
				}else{   
					course_type="TK_JS";  
				}
		//		var taskdom=$("#task_"+task_no).parents(".secondpage").prev();
				var teacher_name=$(this).parents(".card").children(".secondpage").children(".header").text();           
				var course_name=$(this).parents(".card").children(".secondpage").children(".description").children(".middle.aligned.selection.list").children(".task.item").children(".content").children(".description").text(); 
				var teano = $(this).parents(".card").children(".secondpage").children(".header").attr("teano");
				
				btk_teaname = teacher_name;
				btk_teano = teano;
				btk_coursename = course_name;
		/* 		console.log(course_type);
				console.log(task_no); 
				console.log(teano);     */
				beginListen(course_type,task_no,teacher_name,course_name);
			}); 
			
			
			
		}
		
		var CURRENT_TASK="";
		//开始听课
		function beginListen(rule_flag,task_no,teacher_name,course_name){
			if(task_no==CURRENT_TASK) return ;
			CURRENT_TASK=task_no;
			//加载听课表
			loadtable(rule_flag);
			//显示打分面板
			$("#leftpanel").attr("class","nine wide column");
			$("#rightpanel").transition("fly left in");
			
			function loadtable(rule_flag){
				     
				$.ajax({   
					url:"do?invoke=teacherListen@getTeaListenTable",
					type:'POST',
					dataType:'json',
					data:{
						flag:rule_flag
					},
					success:function(rep){
						if(rep.result==0){
							$.alert("没有读取到听课指标");   
						}else{  
							var coursename = "《" +course_name+"》";       
							
							console.log("tttt"+coursename);    
							if(course_name.length > 5) {          
								course_name= course_name.substring(0,4) + "...";      
							}      
							$("#tableheader").html("<p data-title="+coursename+" id='kcmqx'>听课打分：("+teacher_name+") "+course_name+" </p>"+rep.data[0].rule_version_title);
							console.log("uuuu"+coursename);     
							$("#tableheader").attr("tablename",rep.data[0].rule_table);
							var table=rep.data;   
							$("#tableinfo .repeat").remove();
							for(var i=table.length-1;i>=0;i--){
								var grade=[];
								var maxgrade=table[i].rule_goal;
								var rulecontent=table[i].rule_content;
								var div=parseInt(maxgrade)/5;
								for(var j=0;j<5;j++){
									grade[j]=parseInt(maxgrade)-(j*div);
								}
								var dom='<div class="repeat item ruleitem" rownumber="'+i+'" fieldname="'+table[i].rule_field+'"> '+
													'<div class="ui raised content"> '+
												 		'<div class="header" >'+
												 		'<i class="grid layout icon"></i>'+
												 		(i+1)+'.'+'<span class="ruletitle" data-content="'+rulecontent+'" >'+table[i].rule_title+'</span>'+
												 		'<input class="gradebar middle aligned" type="range" name="item'+i+'" step=1 value='+parseInt(grade[0]/2)+' min="0" max="'+grade[0]+'" style="margin-left:20px;" />'+
												 		'<div class="ui olive circular label gradediv">'+'<input class="gradeinput" type="text" value='+parseInt(grade[0]/2)+' />'+'</div>'+
												 		
												 		'</div> '+
													 '</div>'
											 	'</div>';
								$("#tableinfo").prepend($(dom));
							}
							$("#kcmqx").popup();        
							$("#zongfen").text("49");
							$(".ruleitem .ruletitle").popup();
							$(".gradebar").unbind("change").change(function(a,b,c,d){
								//$(this).next().text($(this).val());
								$(this).next().find("input").val($(this).val());
								var total=0;
								$(".gradeinput").each(function(index,element){
									total+=parseInt($(this).val());
								});
								$("#zongfen").text(total);
							});
							
							$(".gradeinput").unbind("change").change(function(a,b,c,d){
								var max=parseInt($(this).parent().prev().attr("max"));
								var min=parseInt($(this).parent().prev().attr("min"))
								if($(this).val()>max){
									$(this).val(max)
								}
								if($(this).val()<min){
									$(this).val(min)
								}
								$(this).parent().prev().val($(this).val());
								var total=0;
								$(".gradeinput").each(function(index,element){
									total+=parseInt($(this).val());
								});
								$("#zongfen").text(total);
							});
							
							
						}
					}
				});
			}
			
			function postFormData(){
				var o={
					task_no:task_no,
					master_no:USEROBJECT.userinfo.teacher_no,
					fields:"",
					total:0,
					tkpj:"",
					rule_flag:rule_flag,
					jxjy:""
				};
				
				var items=$(".ruleitem");
				
				for(var i=0;i<items.length;i++){
					var item=items[i];
					var radio=$(item).find(".gradebar");
					var rowfield=  $(items[i]).attr("fieldname");
					if(o.fields==""){
						 o.fields+=rowfield;
					 }else{
						 o.fields+=","+rowfield;
					 }
					o[rowfield]=radio.val();
					o.total+=parseInt(radio.val());
				}
				o.tkpj=$("#txttkpj").val();
				o.jxjy=$("#txtjxjy").val();
				o.tablename=$("#tableheader").attr("tablename");
				o.listendate=$("#listendate").val();
				
				if(suplisbutFlag == 0) {
					$.alert("本学期督导听课功能已关闭，暂无权限使用！"); 
					$("#btnsubmit").removeClass("loading");
 
				} else if(suplisbutFlag == 1){
					if(o.tkpj==""||o.jxjy==""){
						$.confirm({
							msg       :"您没填写听课评价或教学建议，<br/>确认给该老师评 <b>"+o.total+"</b> 分吗？",
							btnSure   : '确认提交 ',
							btnCancel : '继续填写',
							sureDo	  : function(){
								postdata(o);
							},
							cancelDo:function(){
								$("#btnsubmit").removeClass("loading");
							}
						});
						return ;
					}else{
						$.confirm({
							msg       :"您确定要给该老师评 "+o.total+" 分吗？",
							btnSure   : '确认提交 ',
							btnCancel : '重新填写',
							sureDo	  : function(){
								postdata(o);
							},
							cancelDo:function(){
								$("#btnsubmit").removeClass("loading");
							}
						});
					}
				}
				suplisbutFlag = "";
			}
			
			function postdata(o){
				$.ajax({
					url:"do?invoke=teacherListen@postListen",
					type:'POST',
					dataType:'json',
					data:o,
					success:function(rep){
						$.alert("",rep.message);
						$("#btnsubmit").removeClass("loading");
					}
				});
			}
			
			function judgeSuplistenBut() {
				$.ajax({
					url:"do?invoke=ListenAction@judgeSupLisBut",
					type:'POST',
					async: false, 
					dataType:'json',
					success:function(rep){
						if(rep.result == 0) {
							$.alert("本学期督导听课功能开关取值失败，暂不能使用！");  
							return;
						
						} else {
							console.log(rep);
							suplisbutFlag = rep.data[0].term_tk; 
							if(suplisbutFlag == "" || suplisbutFlag == null) {
								//督导听课开关标记没取到值，默认给用 
								suplisbutFlag = 1;  
							}
							console.log("sssss"+suplisbutFlag);  
							return; 
						}
						
					}
				});
			}
			
			$("#btnsubmit").unbind("click").click(function(){
				if($(this).hasClass("loading"))return;
				$("#btnsubmit").addClass("loading");
				judgeSuplistenBut();
				postFormData();
				
	 			new $.getPort({
					config:{
						tourl:"postInfData.interface", 
						inf_type:"听课打分信息", 
						inf_importance:"0",
						inf_content:"您教授的课程《"+ btk_coursename +"》已被 "+USEROBJECT.username+" 老师听课打分啦！", 
						inf_post:"质量监控平台",
						inf_get_name:"质量监控平台",
						inf_get:btk_teano,
						inf_system:'qm',
						inf_return_url:'<%=rootpath%>'+"qm/teacher/tea_view_listen.jsp?module=12&menu=38",
					},
					callback:function(rep){
						if(rep.result == '0'){
							console.log("信息发送失败")
						}else{
						
						}
					}
				});
			});
		}
		
		
		
	});
</script>
<!--这里引用其他JS-->
</html>