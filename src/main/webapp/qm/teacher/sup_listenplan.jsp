<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>

<!--这里引用其他样式-->
<title></title>
<style>
	
</style>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
		<h3  class="ui header "> 
	  			<i class="unordered list icon"></i>
	  			<div class="content">督学关注教学任务</div>
		</h3>
	
	<div class="ui action input">
	  <input type="text" id="searchtea" placeholder="可输入教师名字...">
	  <button class="btnone ui icon button">
	    <i class="search icon"></i>
	  </button>
	</div>
	<div class="ui action input">
	  <input type="text" id="searchcourse" placeholder="可输入课程名称...">
	  <button class="btntwo ui icon button">
	    <i class="search icon"></i>
	  </button>
	</div>
	
	<table class="ui blue table" id="tablepane">
		  <thead>
		    <tr>
		      <th>学期</th>
		      <th>课程</th>
		      <th>详情</th>
		      <th>状态</th>	      
		    </tr>
		  </thead>
		  <tbody>	    
		  </tbody>
	  </table>
	  
	  <table class="ui blue table" id="tableteacher">
		  <thead>
		    <tr>
		      <th>学期</th>
		      <th>教工号</th>
		      <th>教师姓名</th>
		      <th>课程名</th>
		      <th>教学任务编号</th>
		      <th>操作</th>	      
		    </tr>
		  </thead>
		  <tbody>	    
		  </tbody>
	  </table>
		
		<div id="markmod" class="ui modal">
			  <i class="close icon"></i>
			  <div class="header">
			    课程详情查看:
			  </div>
			  <div class="content">
			  	<div class="description">
			  		<div class="ui two cards" id="tablemodel">
			  		
			  		</div>
			    </div>
			  </div>
		</div>			
	</div>
	<!--这里绘制页面-->
</body>
<script>
	$(function() {
		$("#tableteacher").hide();
		searchteatable();
		function searchteatable() {
			$('.btnone').click(function(){
				$("#tablepane").remove();
				$("#tableteacher").show();
				$("#tableteacher").empty();
				var teaname=$("#searchtea").val();
				console.log(teaname);				
				$.ajax({
					url:"do?invoke=supervisorMarkTask@getSupSearchTea",
					type:'POST',
					dataType:'json',
					data:{
						teaname:teaname,
						termno:SYSOBJECT.term_no												
					},
					success:function(rep) {
						console.log(rep);
						if(rep.result == 0) {
							$.alert("该教师相关数据获取失败！");
						} else {
							var table = rep.data;
							for(var i=0;i<table.length;i++) {
								var dom2=
									'<tr>'+
								  	  '<td>'+table[i].term_no+ '</td>'+
								  	  '<td>'+table[i].teacher_no+ '</td>'+
								  	  '<td>'+table[i].teacher_name + '</td>'+
								      '<td>'+'《'+table[i].course_name+'》'+'</td>'+		
								  	  '<td>'+table[i].task_no+ '</td>'+
								      '<td>'+
										'<div class="btnthird circular ui blue basic icon button" id="'+table[i].task_no+'" data-content="">'+
					                     	'<i class="plus icon"></i>'+
						                 '</div>'+ 	                
					                 '</td>'+
							   	  '</tr>';
					          $("#tableteacher").append($(dom2));
							}
							$('.btnthird').click(function(){
								var taskno=$(this).attr("id");
								$.ajax({
									url:"do?invoke=supervisorMarkTask@getSupMarkTaskADD",
									type:'POST',
									dataType:'json',
									data:{
										supno:USEROBJECT.loginname,
										taskno:taskno,
										termno:SYSOBJECT.term_no												
									},
									success:function(rep) {
										console.log(rep);
										if(rep.result == 0) {
											$.alert("教学任务关注添加失败！");
										} else {
											$.alert("关注添加成功！");
										}
									}									
								});
								});
							
						}
					}
				});
			});
		}
		searchcoursetable();
		function searchcoursetable() {
			$('.btntwo').click(function(){
				$("#tablepane").remove();
				$("#tableteacher").show();
				$("#tableteacher").empty();
				var coursename=$("#searchcourse").val();
				console.log(coursename);
				$.ajax({
					url:"do?invoke=supervisorMarkTask@getSupSearchCourse",
					type:'POST',
					dataType:'json',
					data:{
						coursename:coursename,
						termno:SYSOBJECT.term_no
					},
					success:function(rep) {
						console.log(rep);
						if(rep.result == 0) {
							$.alert("该课程相关数据获取失败！");
						} else {
							var table = rep.data;
							for(var i=0;i<table.length;i++) {
								var dom3=
									'<tr>'+
								  	  '<td>'+table[i].term_no+ '</td>'+
								  	  '<td>'+table[i].teacher_no+ '</td>'+
								  	  '<td>'+table[i].teacher_name + '</td>'+
								      '<td>'+'《'+table[i].course_name+'》'+'</td>'+		
								  	  '<td>'+table[i].task_no+ '</td>'+
								      '<td>'+
										'<div class="btnfour circular ui blue basic icon button" id="'+table[i].task_no+'" data-content="">'+
					                     	'<i class="plus icon"></i>'+
						                 '</div>'+ 	                
					                 '</td>'+
							   	  '</tr>';
					          $("#tableteacher").append($(dom3));
							}
							$('.btnfour').click(function(){
								var taskno=$(this).attr("id");
								$.ajax({
									url:"do?invoke=supervisorMarkTask@getSupMarkTaskADD",
									type:'POST',
									dataType:'json',
									data:{
										supno:USEROBJECT.loginname,
										taskno:taskno,
										termno:SYSOBJECT.term_no												
									},
									success:function(rep) {
										console.log(rep);
										if(rep.result == 0) {
											$.alert("教学任务关注添加失败！");
										} else {
											$.alert("关注添加成功！");
										}
									}									
								});
								});
						}
					}
				});
			});
		}
			
		marktable();
		function marktable() {
			$.ajax({
				url:"do?invoke=supervisorMarkTask@getSupMarkTask",
				type:'POST',
				dataType:'json',
				data:{
					supno:USEROBJECT.loginname,
					depno:USEROBJECT.userinfo.dep_no,
					termno:SYSOBJECT.term_no
				},
				success:function(rep) {
					console.log(rep);
					if(rep.result == 0) {
						$.alert("本学院教学任务相关内容获取失败！");
					} else {
						var table = rep.data;
						for(var i=0; i<table.length;i++) {
							var dom=
								'<tr>'+
							  	  '<td>'+table[i].term_no+ '</td>'+
							      '<td>'+'《'+table[i].course_name+'》'+'</td>'+										      							     
							      '<td>'+
									'<div class="btnfirst circular ui blue basic icon button" id="'+table[i].course_name+'" data-content="">'+
				                     	'<i class="file text icon"></i>'+
					                 '</div>'+ 	                
				                 '</td>'+
				                 '<td><i class="large basic grey checkmark icon"></i></td>'+
						   	  '</tr>';
					          $("#tablepane").append($(dom));
						}
						$('.btnfirst').click(function(){
							$('#markmod')
							.modal({
			    				transition:'slide down',
			    				observeChanges:true,
			    				closable:false
			    			})	    
							.modal('show');
							var coursename=$(this).attr("id");
							$.ajax({
								url:"do?invoke=supervisorMarkTask@getSupMarkTaskXQ",
								type:'POST',
								dataType:'json',
								data:{
									depno:USEROBJECT.userinfo.dep_no,
									termno:SYSOBJECT.term_no,
									coursename:coursename								
								},
								success:function(rep) {
									console.log(rep);
									if(rep.result == 0) {
										$.alert("本课程相关内容获取失败！");
									} else {
										var table = rep.data;
										$("#tablemodel .ui.card").remove();
										for(var i=0; i<table.length;i++) {
											var dom=
												'<div class="ui card">'+
												  '<div class="content">'+
												    '<div class="header">'+ '《'+ table[i].course_name +'》' +'</div>'+
												    '<div class="meta">教工号：'+ table[i].teacher_no +'</div>'+
												    '<div class="description">'+
												      '<p>' + table[i].teacher_name +'</p>'+
												      '<p>学期：'+ table[i].term_no +'</p>'+
												      '<p>教学任务编号：'+ table[i].task_no +'</p>'+
												    '</div>'+
												  '</div>'+
										          '<div class="btnsecond ui bottom attached button" id="'+table[i].task_no+'"><i class="add icon"></i> 添加至自己的教学任务 </div>'+
										        '</div>';
									          $("#tablemodel").append($(dom));
										}
										$('.btnsecond').click(function(){
											var taskno=$(this).attr("id");
											$.ajax({
												url:"do?invoke=supervisorMarkTask@getSupMarkTaskADD",
												type:'POST',
												dataType:'json',
												data:{
													supno:USEROBJECT.loginname,
													taskno:taskno,
													termno:SYSOBJECT.term_no												
												},
												success:function(rep) {
													console.log(rep);
													if(rep.result == 0) {
														$.alert("教学任务关注添加失败！");
													} else {
														$.alert("关注添加成功！");
													}
												}											
											});
											});
										
									}
								}
								
							});
						});
					}
				}
			});
		}
		
	});
</script>
<!--这里引用其他JS-->
</html>