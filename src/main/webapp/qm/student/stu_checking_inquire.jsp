<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/commonjsp/doctype.jsp"%>
		<html>
		
		<head>
			<%@ include file="/commonjsp/meta.jsp"%>
				 <script src="script/common/echarts/echarts-all.js"></script>
				<!--这里引用其他样式-->
				<title>校内教学质量监控运行平台</title>
				<style>
				</style>
		</head>

		<body>
			<%@ include file="/commonjsp/header.jsp"%>
				<div id="container">
				<h3 class="ui header">
								<i class="list layout icon"></i>
                               <div class="content" id="one">考勤查询 </div>
                               </h3>
					<div class="ui raised">
						<div class="ui form">
							<div class="fields">
								<div class="field">

                               <select class="ui three dropdown" id="menu_term">
                               </select>

								</div>
								<div class="  six wide field">

                             <select class="ui one dropdown" id="menu_class">                      
                             </select>
								</div>
								<div class="  field">
                                   <select class="ui two dropdown" id="menu_condition">             
								     <option value="1" selected="selected">有缺勤记录</option>								   
								     <option value="2"> 无缺勤记录</option>
								     <option value="3"  >所有的记录</option>
								     <option value="0">图表总分析</option>
                                  </select>
								</div>
								<div class="field" >
									<button class="ui small basic button" id="btnsubmit"><i class="large search icon"></i></button>
								</div>      
    
							</div>
						</div>

					</div>
					
					<table class="ui compact blue table" id="form_table2" >
						<thead>
							<tr>
								<th>学号</th>
								<th>姓名</th>
								<th>请假</th>
								<th>迟到</th>
								<th>旷课</th>
								<th>早退</th>
								<th>未到勤 </th>
								<th>详情记录</th>
							</tr>
						</thead>
						<tbody class="form" id="form_table">
							<div class="ui green large message" id="no_checking">
							<i class="thumbs large inverted yellow up circular icon"></i>
								优秀班级，本学期截至目前没有缺勤记录。
							</div>
							<div class="ui green large message" id="yes_checking">
							<i class="frown large inverted yellow up circular icon"></i>
								本学期截至目前所有人都有缺勤记录。
							</div>
						</tbody>
					</table>
					
					<div class="ui first modal"  id="grxq" >
  <i class="close icon"></i>
  <div class="header">
  学生缺勤详情
  </div>
  <div class="image content">
    <div class="description">
<table class="ui striped blue table" id="form_table_gr">
						<tdead>
							<tr>
								<td>学号</td>
								<td>姓名</td>
								<td>状态</td>
								<td>课程</td>
								<td>周次</td>
								<td>星期</td>
								<td>节次</td>
								<td>删除</td>
								<td>修改</td>
							</tr>
						</tdead>
						<tbody>

						</tbody>
					</table>
    </div>
  </div>
</div>

					<div class="ui second modal"  id="xg" >
  <i class="close icon"></i>
  <div class="header">
  修改未到勤状态
  </div>
  <div class="image content">
    <div class="description">
    <div class="ui form ">
										<div class="fields">

											<div class="field">
												<select class="ui three dropdown" id="menu_status">
												<option selected="selected">请假</option>
												<option>旷课</option>
												<option>早退</option>
												<option>迟到</option>
												</select>
											</div>

											<div class="  field">
												<button class="ui basic button" id="change_status"><i class="edit circle icon"></i><b>点击修改</b></button>
											</div>
										</div>
									</div>
                          </div>
                     </div>
         </div>
		<div class="ui raised segment" id="main_">
 <div id="main" style="height:400px"></div>
</div>			

</div>  
		</body>
		<script>
			$(function() {
				var SYSOBJCET = <%= SYSOBJCET %> ;
				var USEROBJECT = <%= USEROBJECT %> ;
				var termno=SYSOBJCET.term_no;
				var stu_no;
				var coursename; 
				var classname; 
				loadterm();
				$('#no_checking').hide();
				$('#yes_checking').hide();
				$("#menu_condition").dropdown();
				$("#menu_status").dropdown({
					onChange: function(value, text) {
                     text=status;
					}
				});
				$("#btnsubmit").click(function() { 
					if ($(this).hasClass("loading")) return;
					$("#btnsubmit").addClass("loading");
					run($("#menu_condition > option:selected").val());
				});
				function run(value){
					if($("#menu_class > option:selected").val()=='ALL'){
						loadall_yeschecking(value);
					}else{
						if( value==3)
						{
						loadstu_all();
						}
					if(value==2)
						{
						loadstu_no_checking();
						}
					if(value==1)
						{
						loadstu_checking();
						}
					if(value==0)
						{
						all();
						}
					}
				}
				function loadterm() {
						$.ajax({
							url: "do?invoke=student_checking_inquire@get_checking_term",
							type: 'POST',
							dataType: 'json',
							success: function(rep) {
								if (rep.result == 0) {
									$.alert("", rep.message);
								} else {
									var term_table = rep.data; 
									for (var i = term_table.length - 1; i >= 0; i--) { 	
										if(i == term_table.length - 1)
										{
										var dom_term = '<option  selected="selected" value="' + term_table[i].term_no + '">' + term_table[i].term_name + '</option>';
										$('#menu_term').append($(dom_term));}
										else
											{
											var dom_term = '<option value="' + term_table[i].term_no + '">' + term_table[i].term_name + '</option>';
											$('#menu_term').append($(dom_term));
											}	
									}
									
									loadclass($("#menu_term > option:selected").val());
									$("#menu_term").dropdown({
										onChange: function(value, text) {
											termno=value;
											loadclass(value);
										}
									});
								}
							}
						});
					}
				
				function loadclass(term_no) {
					$.ajax({
						url: "do?invoke=student_checking_inquire@get_checking_class",
						type: 'POST',
						dataType: 'json',
						data: {
							teacher_no: USEROBJECT.loginname,  
							term_no: term_no
						},
						success: function(rep) {
							if (rep.result == 0) {
								$.alert("抱歉，暂无此学期课程记录")
								$('#menu_class').find("option").remove();
								$('#form_table2 tr:gt(0)').remove();
							} else {
								$('#menu_class').find("option").remove();
								$('#form_table2 tr:gt(0)').remove();
								$('#menu_class').append('<option value="ALL" selected="selected" >全 部 课 程 </option>');
								var table_class = rep.data; 
								for (var i = 0; i < table_class.length; i++) {  
									if(i==0)
									{
									var dom_class = '<option  value="' + i + '">' + table_class[i].course_name + '-' + table_class[i].class_name + '</option>';
									$('#menu_class').append($(dom_class));}
									else
									{
									var dom_class = '<option value="' + i + '">' + table_class[i].course_name + '-' + table_class[i].class_name + '</option>';
									$('#menu_class').append($(dom_class));
									}
								}
								var data =($("#menu_class > option:selected").text()).split("-"); 
								coursename = data[0]; 
								classname = data[1]; 
								run($("#menu_condition > option:selected").val());
								$("#menu_class").dropdown({
									onChange: function(value, text) {
										var data =text.split("-"); 
										coursename = data[0]; 
										classname = data[1]; 
									}
								});
							}
						}
					});
				}
				function loadstu_all() {//根据班级，学期课程，获取本学期的所有缺勤内容
					$.ajax({ 
						url: "do?invoke=student_checking_inquire@get_checking_stu",
						type: 'POST',
						dataType: 'json',
						data: {
							class_name_one: classname, 
							term_no_one: SYSOBJCET.term_no,
							term_no_two: termno,
							teacher_no: USEROBJECT.loginname,
							class_name_two: classname,
							course_name: coursename
						},
						success: function(rep) {
							if (rep.result == 0) {
								$("#btnsubmit").removeClass("loading");
								$('#form_table2 tr:gt(0)').remove();
								$('#main_').hide();
								$('#form_table2').show();
							} else {
								$('#form_table2').show();
								$("#btnsubmit").removeClass("loading");
								$('#form_table2 tr:gt(0)').remove();
								$('#main_').hide();
								$('#no_checking').hide();
								$('#yes_checking').hide();
								tablestu = rep.data;
								for (var i = 0; i < tablestu.length; i++) {
									var dom_stu = '<tr zh="'+tablestu[i].zh+'">' +
										'<td>' + tablestu[i].stu_no + '</td>' +
										'<td>' + tablestu[i].stu_name + '</td>' +
										'<td>' + tablestu[i].qj + '</td>' +
										'<td>' + tablestu[i].cd + '</td>' +
										'<td>' + tablestu[i].kk + '</td>' +
										'<td>' + tablestu[i].zt + '</td>' +
										'<td>' + tablestu[i].zh + '</td>';
										if(tablestu[i].zh==0){
											dom_stu+='<td>' +
											'<div class="look_ circular mini ui blue basic icon button" name="' + tablestu[i].stu_no+ '"  data-content="无缺勤">' +
											'<i class="checkmark blue large icon"></i>' +
											'</div>' +
											'</td>';
										}else{
											dom_stu+='<td>' +
											'<div class="look circular mini ui teal basic icon button" name="' + tablestu[i].stu_no+ '"  data-content="查看详情">' +
											'<i class="search teal large icon"></i>' +
											'</div>' +
											'</td>';
										}
										dom_stu+='</tr>';
									$('#form_table').append($(dom_stu));
								}
								$('.look').popup();
								$('.look_').popup();
								$('.look').click(function(){
									var stu_no=$(this).attr("name");
									loadstu_xq(stu_no);
								});
							}
						}
					});
				}		
				function loadstu_xq(stu_no) {
					$.ajax({ 
						url: "do?invoke=student_checking_inquire@loadstu_xq",
						type: 'POST',
						dataType: 'json',
						data: {
							term_no:termno,
							stu_no:stu_no,
							teacher_no: USEROBJECT.loginname,
						},
						success: function(rep) {
							$('#form_table2').show();
							$('#form_table_gr tr:gt(0)').remove();
							console.log(rep.data);
							tablestu = rep.data;
							for (var i = 0; i < tablestu.length; i++) {
								var dom_stu = '<tr>' +
									'<td>' + tablestu[i].stu_no + '</td>' +
									'<td>' + tablestu[i].stu_name + '</td>' +
									'<td>' + tablestu[i].check_status + '</td>' +
									'<td>' + tablestu[i].course_name + '</td>' +
									'<td>' + tablestu[i].check_week + '</td>';
									console.log(tablestu[i].sche_set.substring(1, 2));
									console.log(tablestu[i].sche_set.substring(2, 3));
									if (tablestu[i].sche_set.substring(1, 2) == 1) {
										dom_stu += '<td>一</td>';
									} else if (tablestu[i].sche_set.substring(1, 2) == 2) {
										dom_stu += '<td>二</td>';
									} else if (tablestu[i].sche_set.substring(1, 2) == 3) {
										dom_stu += '<td>三</td>';
									} else if (tablestu[i].sche_set.substring(1, 2) == 4) {
										dom_stu += '<td>四</td>';
									} else if (tablestu[i].sche_set.substring(1, 2) == 5) {
										dom_stu += '<td>五</td>';
									} else if (tablestu[i].sche_set.substring(1, 2) == 6) {
										dom_stu += '<td>六</td>';
									} else if (tablestu[i].sche_set.substring(1, 2) == 7) {
										dom_stu += '<td>日</td>';
									} else {
										dom_stu += '<td>实 训 课</td>';
									}


                                if (tablestu[i].sche_set.substring(2, 3) == 1) {
                                    if(!SINGLESCHE){
                                        dom_stu += '<td>1,2节</td>';
                                    }else{
                                        dom_stu += '<td>1节</td>';
                                    }
                                } else if (tablestu[i].sche_set.substring(2, 3) == 2) {
                                    if(!SINGLESCHE){
                                        dom_stu += '<td>3,4节</td>';
                                    }else{
                                        dom_stu += '<td>2节</td>';
                                    }
                                } else if (tablestu[i].sche_set.substring(2, 3) == 3) {
                                    if(!SINGLESCHE){
                                        dom_stu += '<td>5,6节</td>';
                                    }else{
                                        dom_stu += '<td>3节</td>';
                                    }
                                } else if (tablestu[i].sche_set.substring(2, 3) == 4) {
                                    if(!SINGLESCHE){
                                        dom_stu += '<td>7,8节</td>';
                                    }else{
                                        dom_stu += '<td>4节</td>';
                                    }
                                } else if (tablestu[i].sche_set.substring(2, 3) == 5) {
                                    if(!SINGLESCHE){
                                        dom_stu += '<td>晚自习</td>';
                                    }else{
                                        dom_stu += '<td>5节</td>';
                                    }
                                } else {
                                    dom_stu += '<td>'+tablestu[i].sche_set.substring(2, 3)+'节</td>';
                                }
									dom_stu +='<td><div class="remove circular mini ui red basic icon button" name="' + tablestu[i].stu_no+ '" time="'+tablestu[i].check_time.substring(0,19)+'">' +
									'<i class="trash red large icon"></i>' +
									'</div>' +
									'</td>';
									dom_stu +='<td><div class="change circular mini ui blue basic icon button" name="' + tablestu[i].stu_no+ '" time="'+tablestu[i].check_time.substring(0,19)+'">' +
									'<i class="edit blue large icon"></i>' +
									'</div>' +
									'</td>' +
									'</tr>';
								$('#form_table_gr').append($(dom_stu));
							}
							$('#grxq').modal({
								transition: 'vertical flip',
								observeChanges: true,
								closable: false
							})
							.modal('show');
							$('.remove').click(function(){
								stu_no=$(this).attr("name");
								var check_time=$(this).attr("time");
								console.log(stu_no)
								console.log(check_time)
								getdelete(stu_no,check_time);
							});
							$('.change').click(function(){
								$('#xg').modal({
									transition: 'vertical flip',
									observeChanges: true,
									closable: false
								})
								.modal('show');	
								stu_no=$(this).attr("name");
								var check_time_=$(this).attr("time");
								$('#change_status').click(function(){
									var status=$("#menu_status > option:selected").text();
									getchange(stu_no,check_time_,status);
								});
							});
						}
					});
				}		
				function getdelete(stu_no,check_time) {
					$.ajax({ 
						url: "do?invoke=student_checking_inquire@getdelete",
						type: 'POST',
						dataType: 'json',
						data: {
							stu_no:stu_no,
							check_time: check_time
						},
						success: function(rep) {
							loadstu_xq(stu_no);
							loadall_yeschecking($("#menu_condition > option:selected").val());
						}
					});
				}
				function getchange(stu_no,check_time,status) {
					$.ajax({ 
						url: "do?invoke=student_checking_inquire@getchange",
						type: 'POST',
						dataType: 'json',
						data: {
							stu_no:stu_no,
							check_time: check_time,
							check_status:status
						},
						success: function(rep) {
							loadstu_xq(stu_no);
							loadall_yeschecking($("#menu_condition > option:selected").val());
						}
					});
				}
				function loadstu_checking() {//函数正确
					$.ajax({
						url: "do?invoke=student_checking_inquire@get_checking_stu_yes",
						type: 'POST',
						dataType: 'json',
						data: {
							class_name_one: classname, 
							term_no_one: SYSOBJCET.term_no,
							term_no_two: termno,
							teacher_no: USEROBJECT.loginname,
							class_name_two: classname,
							course_name: coursename
						},
						success: function(rep) {
							if (rep.result == 0) {
								$('#form_table2').hide();
								$('#yes_checking').hide();
								$('#no_checking').show();
								$("#btnsubmit").removeClass("loading");
								$('#main_').hide();
							} else {
								$('#form_table2').show();
								$('#no_checking').hide();
								$('#yes_checking').hide();
								$("#btnsubmit").removeClass("loading");
								$('#form_table2 tr:gt(0)').remove();
								$('#main_').hide();
								tablestu = rep.data;
								for (var i = 0; i < tablestu.length; i++) {
									var dom_stu = '<tr>' +
										'<td>' + tablestu[i].stu_no + '</td>' +
										'<td>' + tablestu[i].stu_name + '</td>' +
										'<td>' + tablestu[i].qj + '</td>' +
										'<td>' + tablestu[i].cd + '</td>' +
										'<td>' + tablestu[i].kk + '</td>' +
										'<td>' + tablestu[i].zt + '</td>' +
										'<td>' + tablestu[i].zh + '</td>' +
										'<td>' +
										'<div class="look circular mini ui teal basic icon button" name="' + tablestu[i].stu_no+ '"  data-content="查看详情">' +
										'<i class="search teal large icon"></i>' +
										'</div>' +
										'</td>' +
										'</tr>';
									$('#form_table').append($(dom_stu));
								}
								$('.look').popup();
								$('.look').click(function(){
									var name = $(this).attr("name"); 
									loadstu_xq(name);
								});
							}
						}
					});
				}
				function loadstu_no_checking() {
					$.ajax({ 
						url: "do?invoke=student_checking_inquire@get_checking_stu_no",
						type: 'POST',
						dataType: 'json',
						data: {
							class_name_one: classname, 
							term_no_one: SYSOBJCET.term_no,
							term_no_two:termno,
							teacher_no: USEROBJECT.loginname,
							class_name_two: classname,
							course_name: coursename
						},
						success: function(rep) {
							if (rep.result == 0) {
								$("#btnsubmit").removeClass("loading");
								$('#main_').hide();
								$('#no_checking').hide();
								$('#yes_checking').show();
								$('#form_table2').hide();
							} else {
								$('#form_table2').show();
								$("#btnsubmit").removeClass("loading");
								$('#form_table2 tr:gt(0)').remove();
								$('#main_').hide();
								$('#no_checking').hide();
								$('#yes_checking').hide();
								tablestu = rep.data;
								for (var i = 0; i < tablestu.length; i++) {
									var dom_stu = '<tr>' +
										'<td>' + tablestu[i].stu_no + '</td>' +
										'<td>' + tablestu[i].stu_name + '</td>' +
										'<td>' + tablestu[i].qj + '</td>' +
										'<td>' + tablestu[i].cd + '</td>' +
										'<td>' + tablestu[i].kk + '</td>' +
										'<td>' + tablestu[i].zt+ '</td>' +
										'<td>' + tablestu[i].zh + '</td>' +
										'<td>' +
										'<div class="look circular mini ui teal basic icon button" name="' + tablestu[i].stu_no+ '"  data-content="无缺勤记录">' +
										'<i class="checkmark teal large icon"></i>' +
										'</div>' +
										'</td>' +
										'</tr>';
									$('#form_table').append($(dom_stu));
								}
								$('.look').popup();
							}
						}
					});
				}
				function loadall_yeschecking(value){
					$.ajax({ 
						url: "do?invoke=student_checking_inquire@loadall_yeschecking",
						type: 'POST',
						dataType: 'json',
						data: {
							term_no: termno,
							teacher_no: USEROBJECT.loginname,
						},
						success: function(rep) {
							if (rep.result == 0) {
								//所有人都到勤；
							} else {
								$('#form_table2').show();
								$("#btnsubmit").removeClass("loading");
								$('#form_table').find('tr').remove();
								$('#main_').hide();
								$('#no_checking').hide();
								$('#yes_checking').hide();
								tablestu = rep.data;
								console.log(rep.data);
								for (var i = 0; i < tablestu.length; i++) {
									if(value==3){
											var dom_stu = '<tr zh="'+tablestu[i].zh+'">' +
											'<td>' + tablestu[i].stu_no + '</td>' +
											'<td>' + tablestu[i].stu_name + '</td>' +
											'<td>' + tablestu[i].qj + '</td>' +
											'<td>' + tablestu[i].cd + '</td>' +
											'<td>' + tablestu[i].kk + '</td>' +
											'<td>' + tablestu[i].zt + '</td>' +
											'<td>' + tablestu[i].zh + '</td>';
											if(tablestu[i].zh==0){
												dom_stu+='<td>' +
												'<div class="look_ circular mini ui blue basic icon button" name="' + tablestu[i].stu_no+ '"  data-content="无缺勤">' +
												'<i class="checkmark blue large icon"></i>' +
												'</div>' +
												'</td>';
											}else{
												dom_stu+='<td>' +
												'<div class="look circular mini ui teal basic icon button" name="' + tablestu[i].stu_no+ '"  data-content="查看详情">' +
												'<i class="search teal large icon"></i>' +
												'</div>' +
												'</td>';
											}
											dom_stu+='</tr>';
										$('#form_table').append($(dom_stu));
									}
									if(value==2){
										if(tablestu[i].zh==0){
											var dom_stu = '<tr zh="'+tablestu[i].zh+'">' +
											'<td>' + tablestu[i].stu_no + '</td>' +
											'<td>' + tablestu[i].stu_name + '</td>' +
											'<td>' + tablestu[i].qj + '</td>' +
											'<td>' + tablestu[i].cd + '</td>' +
											'<td>' + tablestu[i].kk + '</td>' +
											'<td>' + tablestu[i].zt + '</td>' +
											'<td>' + tablestu[i].zh + '</td>';
											if(tablestu[i].zh==0){
												dom_stu+='<td>' +
												'<div class="look_ circular mini ui blue basic icon button" name="' + tablestu[i].stu_no+ '"  data-content="无缺勤">' +
												'<i class="checkmark blue large icon"></i>' +
												'</div>' +
												'</td>';
											}else{
												dom_stu+='<td>' +
												'<div class="look circular mini ui teal basic icon button" name="' + tablestu[i].stu_no+ '"  data-content="查看详情">' +
												'<i class="search teal large icon"></i>' +
												'</div>' +
												'</td>';
											}
											dom_stu+='</tr>';
										$('#form_table').append($(dom_stu));
										}
									}
									if(value==1){
                                        if(tablestu[i].zh!=0){
                                        	var dom_stu = '<tr zh="'+tablestu[i].zh+'">' +
											'<td>' + tablestu[i].stu_no + '</td>' +
											'<td>' + tablestu[i].stu_name + '</td>' +
											'<td>' + tablestu[i].qj + '</td>' +
											'<td>' + tablestu[i].cd + '</td>' +
											'<td>' + tablestu[i].kk + '</td>' +
											'<td>' + tablestu[i].zt + '</td>' +
											'<td>' + tablestu[i].zh + '</td>';
											if(tablestu[i].zh==0){
												dom_stu+='<td>' +
												'<div class="look_ circular mini ui blue basic icon button" name="' + tablestu[i].stu_no+ '"  data-content="无缺勤">' +
												'<i class="checkmark blue large icon"></i>' +
												'</div>' +
												'</td>';
											}else{
												dom_stu+='<td>' +
												'<div class="look circular mini ui teal basic icon button" name="' + tablestu[i].stu_no+ '"  data-content="查看详情">' +
												'<i class="search teal large icon"></i>' +
												'</div>' +
												'</td>';
											}
											dom_stu+='</tr>';
										$('#form_table').append($(dom_stu));
										}
									}
								}
								$('.look').popup();
								$('.look_').popup();
								$('.look').click(function(){
									var stu_no=$(this).attr("name");
									loadstu_xq(stu_no);
								});
							}
						}
					});
				}
				function all(){
					$.ajax({
						url: "do?invoke=student_checking_inquire@get_qq_sl",
						type: 'POST',
						dataType: 'json',
						data: {
							term_no: termno,
							teacher_no:USEROBJECT.loginname,
							class_name:classname,
							course_name:coursename
						},
						success: function(rep) {
							                     var table=rep.data;
							                            $('#no_checking').hide();
														$('#yes_checking').hide();
															var tablestu_leave = rep.data;
															$('#form_table2').hide();
															$('#main_').show();
															$("#btnsubmit").removeClass("loading");
														var myChart = echarts.init(document.getElementById('main'));
													    var dataStyle = {
														normal: {
															label: {
																show: false
															},
															labelLine: {
																show: false
															}
														}
													};
													var placeHolderStyle = {
														normal: {
															color: 'rgba(0,0,0,0)',
															label: {
																show: false
															},
															labelLine: {
																show: false
															}
														},
														emphasis: {
															color: 'rgba(0,0,0,0)'
														}
													};
													var option = {
														title: {
															text: '缺勤了吗？',
															subtext: '你的学生',
															x: 'center',
															y: 'center',
															itemGap: 30,
															textStyle: {
																color: 'rgba(30,144,255,0.8)',
																fontFamily: '微软雅黑',
																fontSize: 25,
																fontWeight: 'bolder'
															}
														},
														   toolbox: {
														        show : true,
														        feature : {
														            mark : {show: true},
														            dataView : {show: true, readOnly: false},
														            restore : {show: true},
														            saveAsImage : {show: true}
														        }
														    },
														legend: {
															orient: 'vertical',
															x: document.getElementById('main').offsetWidth / 2,
															y: 45,
															itemGap: 12,
															data: [table[2].qjgs+'个人无“缺课”记录', table[1].qjgs+'个人有“请假”记录', table[0].qjgs+'个人有“缺课”记录']
														},
														series: [{
															type: 'pie',
															clockWise: false,
															radius: [125, 150],
															itemStyle: dataStyle,
															data: [{
																value: table[2].qjgs,
																name: table[2].qjgs+'个人无“缺课”记录'
															},{
																value:100-table[2].qjgs,
																 itemStyle : placeHolderStyle
															}]
														}, {
															type: 'pie',
															clockWise: false,
															radius: [100, 125],
															itemStyle: dataStyle,
															data: [{
																value: table[1].qjgs,
																name: table[1].qjgs+'个人有“请假”记录'
															},{
																value:100-table[1].qjgs,
																 itemStyle : placeHolderStyle
															}]
														}, {
															type: 'pie',
															clockWise: false,
															radius: [75, 100],
															itemStyle: dataStyle,
															data: [{
																value: table[0].qjgs,
																name: table[0].qjgs+'个人有“缺课”记录'
															},{
																value:100-table[0].qjgs,
																 itemStyle : placeHolderStyle
															}]
														}]
													};
													myChart.setOption(option);
													}
					});
					
				}
					
			}); 
		</script>
		<!--这里引用其他JS-->

		</html>