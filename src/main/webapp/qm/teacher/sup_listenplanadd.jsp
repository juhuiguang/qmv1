<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>

<!--这里引用其他样式-->
<title></title>
<style>
	#viewinformation{
		margin-top: 10px;
	}
	.coursecolor {
		color:teal!important;
		font-weight:bold;
	}
</style>

</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
			<h3  class="ui header "> 
		  			<i class="unordered list icon"></i>
		  			<div class="content">督学制定听课计划</div>
			</h3>
		
		<div id="depdiv">
			<a class="ui blue label" id="viewplan">查看听课计划</a>
			<a class="dep ui gray label" id="markplan">制定听课计划</a>
		</div>
		
		<div id="viewinformation">

		</div>
		
		<div id="markinformation">
		
		</div>
					  
	  
	  <div id="planmod" class="ui modal">
			  <div class="header">
			    所关注教师教学任务详情查看:
			    <i class="close icon" style="float: right;"></i>
			  </div>
			  <div class="content">
			  	<div class="description">
			  		<div class="ui three cards" id="tablemodel">
			  		
			  		</div>
			    </div>
			  </div>
		</div>
		
		<div id="planaddmod" class="ui modal">
			  <div class="header">
			    	添加教学任务至计划:
			    	<i class="close icon" style="float: right;"></i>
			  </div>
			  <div class="content">
			  	<div class="description">
			  		<div id="plan_teaname"></div>
			  		<br>
			  		<div id="plan_course"></div>
			  		<br>
			  		<div id="plan_classa"></div>
			  		<br>
			  		<div id="plan_time">
			  			计划时间： <input id="datetimepicker" type="text" >
			  		</div>
			  	</div>
			  </div>
			  <div class="actions">
			    <div class="ui positive right labeled icon button" id="addsubmit">
			      添&nbsp;&nbsp;&nbsp;&nbsp;加
			      <i class="checkmark icon"></i>
			    </div>
			  </div>
		</div>
		

		<div id="xgplanmod" class="ui modal">
			  <div class="header">
			    	修改该听课计划:
			    	<i class="close icon" style="float: right;"></i>
			  </div>
			  <div class="content">
			  	<div class="description">
			  		<div id="plan_teacher"></div>
			  		<br>
			  		<div id="plan_coursename"></div>
			  		<br>
			  		<div id="plan_class"></div>
			  		<br>
			  		<div id="plan_time">
			  			计划时间：<input id="datetimepicker2" type="text" >
			  		</div>
			  	</div>
			  </div>
			  <div class="actions">
			    <div class="ui positive right labeled icon button" id="updatasubmit">
			      提&nbsp;&nbsp;&nbsp;&nbsp;交
			      <i class="checkmark icon"></i>
			    </div>
			  </div>
		</div>
		
	</div>



	<!--这里绘制页面-->
</body>

<link rel="stylesheet"  href="script/common/datepicker/jquery.datetimepicker.css"></link>
<script src="script/common/datepicker/jquery.datetimepicker.js"></script>
<script>
	$(function() {
		viewplan();
		$("#depdiv .label").unbind("click").click(function(){
			$("#depdiv .blue").removeClass("blue");
			$(this).addClass("blue");
			var chooseid = this.id;
			if(chooseid == "viewplan"){
				$("#viewinformation").empty();
				$("#markinformation").empty();				
				viewplan();
			} else {
				$("#viewinformation").empty();
				$("#markinformation").empty();
				viewmarktable();
			}
		});
		
		
		function viewplan() {
			var tep =
				'<div class="ui three cards" id="viewlistenplan">'+

				'</div>';
				$("#viewinformation").append($(tep));			
			$.ajax({
				url:"do?invoke=supervisorListenPlan@getViewPlan",
				type:'POST',
				dataType:'json',
				data:{
					supno:USEROBJECT.loginname,
					termno:SYSOBJECT.term_no
				},
				success:function(rep) {
					console.log(rep);
					if(rep.result == 0) {
						$.alert("您制定的听课计划列表获取失败！");
					} else {
						var table = rep.data;
						for(var i=0; i<table.length; i++) {
							var dom2=								
								'<div class="ui card">'+
								  '<div class="content">'+
								    '<div class="header">'+ table[i].teacher_name +'</div>'+
								    '<div class="meta"></div>'+
								    '<div class="description">'+
								      '<p>课程名：《'+ table[i].course_name +'》</p>'+
								      '<p>班&nbsp;&nbsp;&nbsp;级： &nbsp;&nbsp; '+ table[i].class_name +'</p>'+
								      '<p>计划时间：'+ table[i].plan_time +'【第'+ table[i].plan_week +'周】</p>'+
								      '<br>'+
								      '<p style="margin-left:169px;">'+ table[i].set_time +'</p>'+
								    '</div>'+
								  '</div>';	
								  if(table[i].day_gap < 0) {
									  dom2 += 
										  '<div class="editarea extra content" style="color:red;" data-content="点击可编缉~" data-variation="tiny inverted">'+
											  '<div class="ui dimmer">'+
											    '<div class="content">'+
											      '<div class="center">'+
											      '<div>'+
											        '<div class="updplan ui circular mini blue button" id="'+ table[i].plan_no +'" teaname="'+table[i].teacher_name+'" coursename="'+table[i].course_name+'" classname="'+table[i].class_name+'" plantime="'+table[i].plan_time+'" taskno="'+table[i].task_no+'">修 改</div>'+
											        '<div class="delplan ui circular mini red button" id="'+ table[i].plan_no +'">删 除</div>'+
										        '</div>'+
											      '</div>'+
											    '</div>'+
											  '</div>'+
											  '该计划时间已过期！';
									  } else {
										  dom2 +=
											  '<div class="editarea extra content" data-content="点击可编缉~" data-variation="tiny inverted">'+
											  '<div class="ui dimmer">'+
											    '<div class="content">'+
											      '<div class="center">'+
											      '<div>'+
											        '<div class="updplan ui circular mini blue button" id="'+ table[i].plan_no +'" teaname="'+table[i].teacher_name+'" coursename="'+table[i].course_name+'" classname="'+table[i].class_name+'" plantime="'+table[i].plan_time+'" taskno="'+table[i].task_no+'">修 改</div>'+
											        '<div class="delplan ui circular mini red button" id="'+ table[i].plan_no +'">删 除</div>'+
										        '</div>'+
											      '</div>'+
											    '</div>'+
											  '</div>'+
								      		  '距离该计划还有 '+ table[i].day_gap +' 天！';
									  }
									  dom2 +=
										  '</div>'+
								 '</div>';
				          $("#viewlistenplan").append($(dom2));
				          $('.editarea').popup();
						}
						$('.editarea').hover(function(){
							$(this).css("cursor","pointer");
						});
						$('.ui .dimmer').dimmer({
						    on: 'click'
						});
						$('.updplan').click(function() {
							var planno = $(this).attr("id");
							var teacher = $(this).attr("teaname");
							var coursename = $(this).attr("coursename");
							var classname = $(this).attr("classname");
							var plantime = $(this).attr("plantime");
							var taskno = $(this).attr("taskno");
							updataModifyPlan(planno,teacher,coursename,classname,plantime,taskno);
						});
						$('.delplan').click(function() {
							var planno=$(this).attr("id");
							console.log(planno);
							deleteModifyPlan(planno);
						});
					}
				}
			});
		}
		
		function updataModifyPlan(planno,teacher,coursename,classname,plantime,taskno) {
			$("#xgplanmod").modal({
				transition:'slide down',
				observeChanges:true,
				closable:false
			}).modal('show');
			jQuery('#datetimepicker2').datetimepicker({
				  minDate:new Date(),
				  timepicker:false,
				  format:'Y.m.d',
				  lang:'zh'
			});
			$("#plan_teacher").text('任课教师：'+teacher);
			$("#plan_coursename").text('课程名称：《'+ coursename +'》');
			$("#plan_class").text('上课班级：'+classname);
			$("#datetimepicker2").val(plantime);
					
			$("#updatasubmit").unbind("click").click(function() {
				var plantime = $("#datetimepicker2").val();
				var o={
						planno:planno,
						supno:USEROBJECT.loginname,
						termno:SYSOBJECT.term_no,
						taskno:taskno,
						plantime:plantime,
						currentweek:SYSOBJECT.currentweek
				};
				saveModifyPlan(o);
			});			
		}
		
		function saveModifyPlan(plan){
			$.ajax({
				url:"do?invoke=supervisorListenPlan@getUpdataPlan",
				type:'POST',
				dataType:'json',
				data:plan,
				success:function(rep){
					if(rep.result == 0) {
						$.alert("该计划修改失败,您可以再试一下！");
					} else {
						$.alert("该计划修改成功！");
						$("#viewinformation").html("");
						viewplan();
					}
				}
			});
		}
		
		function deleteModifyPlan(planno) {
			$.confirm({
				msg          :"您确定删除该计划么？",
				btnSure     :'确定',
				btnCancel  :'取消',
				sureDo       : function(){
										$.ajax({
											url:"do?invoke=supervisorListenPlan@getDeletePlan",
											type:'POST',
											dataType:'json',
											data:{
												planno:planno
											},
											success:function(rep) {
												if(rep.result == 0) {
													$.alert("删除该计划失败！ ");
												} else {
													$.alert("该计划删除成功！");
													$("#viewinformation").html("");
													viewplan();
												}
											}
										});
				}
			});
		}
		
		function viewmarktable() {
			var temp =
				'<table class="ui compact blue table" id="tableteacher">'+
				  '<thead>'+
				    '<tr>'+
				      '<th>学期</th>'+
				      '<th>教工号</th>'+
				      '<th>教师姓名</th>'+
				      '<th>教学任务查看</th>'+	      
				    '</tr>'+
				  '</thead>'+
				  '<tbody>'+	    
				  '</tbody>'+
			  '</table>';
			  $("#markinformation").append(temp);
			$.ajax({
				url:"do?invoke=supervisorListenPlan@getSupViewMarkTea",
				type:'POST',
				dataType:'json',
				data:{
					supno:USEROBJECT.loginname,
					termno:SYSOBJECT.term_no
				},
				success:function(rep) {
					console.log(rep);
					if(rep.result == 0) {
						$.alert("您关注的教师数据获取失败！");
					} else {
						var table = rep.data;
						for(var i=0; i<table.length; i++) {
							var dom=
								'<tr>'+
							  	  '<td>'+table[i].term_no+ '</td>'+
							  	  '<td>'+table[i].teacher_no+ '</td>'+
							  	  '<td>'+table[i].teacher_name + '</td>'+
							      '<td>'+
									'<div class="btnfour circular mini ui blue basic icon button" id="'+table[i].teacher_no+'" data-content="点击我，可以查看该教师所教课程详情~">'+
										'<i class="file text icon"></i>'+
					                 '</div>'+ 	                
				                 '</td>'+
						   	  '</tr>';
				          $("#tableteacher").append($(dom));
				          $('.btnfour').popup();
						}
						$('.btnfour').unbind("click").click(function(){
							var teano=$(this).attr("id");
							showModify(teano);
							});						
						}
					}
				});
		}
		
		function showModify(teano) {
			$('#planmod').modal({
				transition:'slide down',
				observeChanges:true,
				closable:false
			}).modal('show');
			$.ajax({
				url:"do?invoke=supervisorListenPlan@getSupViewMarkTeaTask",
				type:'POST',
				dataType:'json',
				data:{
					teano:teano,
					termno:SYSOBJECT.term_no
				},
				success:function(rep) {
					console.log(rep);
					if(rep.result == 0) {
						$.alert("该教师教学任务相关数据获取失败！");
					} else {
						var cont = rep.data;
						$("#tablemodel .ui.card").remove();
						for(var i=0; i<cont.length; i++) {
							var dom=
								'<div class="ui card">'+
								  '<div class="content">'+
								    '<div class="header">'+ cont[i].teacher_name +'</div>'+
								    '<div class="meta">'+ cont[i].term_name +'</div>'+
								    '<div class="description">'+
								      '<p>课程名称：</p>'+
								      '<p  class="coursecolor">&nbsp;&nbsp;&nbsp;&nbsp;《'+ cont[i].course_name +'》</p>'+
								      '<p>上课班级：'+ cont[i].class_name +'</p>'+
								    '</div>'+
								  '</div>'+
						          '<div class="btnthird ui bottom attached button" id="'+cont[i].task_no+'" teaname="'+cont[i].teacher_name+'" course="'+cont[i].course_name+'" classname="'+cont[i].class_name+'"><i class="add icon"></i> 去添加听课计划 </div>'+
								'</div>';
							$("#tablemodel").append($(dom));
						}
						$('.btnthird').unbind("click").click(function(){											  
							var taskno = $(this).attr("id");
							var teaname = $(this).attr("teaname");
							var course = $(this).attr("course");
							var classname = $(this).attr("classname");							
							showMarkPlanModify(taskno,teaname,course,classname);

						});																
					}
				}
			});
		}
		
		function showMarkPlanModify(taskno,teaname,course,classname) {
			console.log(taskno);
			$("#datetimepicker").val("");
			$('#planaddmod').modal({
				transition:'slide down',
				observeChanges:true,
				closable:false
			}).modal('show');								
			jQuery('#datetimepicker').datetimepicker({
				  minDate:new Date(),
				  timepicker:false,
				  format:'Y.m.d',
				  lang:'zh'
			});			
			$("#plan_teaname").text('任课教师： '+ teaname);
			$("#plan_course").text('课程名称： 《'+course+'》');
			$("#plan_classa").text('上课班级： '+ classname);	
			
			$("#addsubmit").unbind("click").click(function(){
				var plantime = $("#datetimepicker").val();
				if(plantime == ""){
					$.alert("听课计划时间不能为空！");					
				} else {					
					$.ajax({
						url:"do?invoke=supervisorListenPlan@getSupPlanAdd",
						type:'POST',
						dataType:'json',
						data:{
							supno:USEROBJECT.loginname,
							termno:SYSOBJECT.term_no,
							taskno:taskno,
							plantime:plantime,
							currentweek:SYSOBJECT.currentweek
						},
						success:function(rep) {
							console.log(rep);
							if(rep.result == 0) {
								$.alert("该计划添加失败，您可以再试一次！");
							} else {
								if(rep.message == "") {
									$.alert("该计划已经存在，不可以重复添加！");
								} else {
									$.alert("该听课计划添加成功！");									
								}							
							}						
						}
					});
				}
			});
		}

	});
</script>
<!--这里引用其他JS-->
</html>