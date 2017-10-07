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
					.dep {
						width: 23% !important;
						margin-left: 3px;
						float: left;
					}
					
					.allclass {
						width: 100% !important;
					}
					
					.item {
						height: 40px !important;
						line-height: -3px !important;
					}
					
					#right_page {
						width: 75%;
						margin-left: 25%;
					}
					#no_checking{
					margin-top:30px;
					}
			 		.sliderDiv {
						    height: 440px;  
						    position: absolute;
						    overflow-y: scroll;
					}
					#qqxq { 
						width: 105% !important;
    					margin-left: -2.9% !important; 
					}
					.tableMessage {
					    width: 102% !important;  
						background: #fff !important;  
    					box-shadow: 0 0 0 0px rgba(34,36,38,.22) inset,0 0 0 0 transparent !important; 
					}
				</style>
		</head>

		<body>
			<%@ include file="/commonjsp/header.jsp"%>
				<div id="container">
					<h3 class="ui header">
								<i class="list layout icon"></i>
                               <div class="content">教学秘书查看缺勤 </div>
                               </h3>
					<div class="ui styled dep accordion">

					</div>
					<div id="right_page">
						<div class="ui raised">
							<div class="ui form">
								<div class="fields">
									<div class="field">

										<select class="ui dropdown" id="menu_term">
										</select>

									</div>
									<div class="field">
										<button class="ui basic button" id="searchinfomation"><i class="icon search"></i> 点击查询 </button>
									</div>

								</div>
							</div>

						</div>

						<table class="ui compact blue table" id="form_table_head">
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
							</tbody>
						</table>
						<div class="ui green large message" id="no_checking">
							<i class="thumbs large inverted yellow up circular icon"></i> 优秀班级，本学期截至目前没有缺勤记录。
						</div>

						<div class="ui coupled second long test modal" id="grxq">
							<i class="close icon"></i>
							<div class="header">
								个人缺勤详情
							</div>
							<div class="content"> 
								<div class="ui message tableMessage" id="">
									<table class="ui striped blue table" id="qqxq">
										<thead>
											<tr>
												<th>编号</th>
												<th>姓名</th>
												<th>教师</th>
												<th>课程</th>
												<th>状态</th>
												<th>周次</th>
												<th>星期</th>
												<th>节次</th>
												<th>删除</th>
												<th>修改</th>
											</tr>
										</thead>
										<tbody id="form_table_gr">
	
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="ui second modal" id="xg">
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
					</div>

				</div>
		</body>
		<script>
			$(function() {
				var SYSOBJCET = <%= SYSOBJCET %>;
				var USEROBJECT = <%= USEROBJECT %>;
				console.log(SYSOBJCET);
				console.log(USEROBJECT.userpurview);//
				var term_no = SYSOBJCET.term_no; //获取当前学期（全局变量）
				var year = parseInt(term_no.substring(0, 4)); //获取当前学年（全局变量）
				var class_no;
				var stu_no;
				var stu_name;
				$('#no_checking').hide();
				$('#searchinfomation').click(function() {
					if ($(this).hasClass("loading")) return;
					$("#searchinfomation").addClass("loading");
					loadCheckByClassNo()
				});
				loadallclass();

				function loadallclass() {
					$.ajax({
						url: "do?invoke=TeacherCenter@loadallclass",
						type: 'POST',
						dataType: 'json',
						data: {
							class_year: (year - 2),
						},
						success: function(rep) {
							var class_infomation = rep.data[0];
							for (var i = 0; i < class_infomation.number; i++) {
								if (class_infomation[i][year].length == 0) {
									
								} else {
									var dom = '<div class=" dep_no '+class_infomation[i][year][0].dep_no+' title"><i class="dropdown icon"></i> ' + class_infomation[i][year][0].dep_name + ' </div>' +
										'<div class="content">' +
										'<div class="accordion transition hidden">' +
										' <div class="title"><i class="dropdown icon"></i> ' + year + ' 级</div>' +
										'<div class=" content" >' +
										' <div class="ui allclass vertical menu">';
									for (var j = 0; j < class_infomation[i][year].length; j++) {
										dom += '<a class=" all_class_no item" class_no="' + class_infomation[i][year][j].class_no + '">' + class_infomation[i][year][j].class_name + '</a>';
									}
									dom += '</div>';
									dom += '</div>';
									dom += ' <div class="title"><i class="dropdown icon"></i> ' + (year - 1) + ' 级 </div>';
									dom += '<div class=" content" >';
									dom += ' <div class="ui allclass vertical menu">';
									for (var m = 0; m < class_infomation[i][year - 1].length; m++) {
										dom += '<a class=" all_class_no item" class_no="' + class_infomation[i][year - 1][m].class_no + '">' + class_infomation[i][year - 1][m].class_name + '</a>';
									}
									dom += '</div>';
									dom += '</div>';
									dom += ' <div class="title"><i class="dropdown icon"></i> ' + (year - 2) + ' 级 </div>';
									dom += '<div class=" content" >';
									dom += ' <div class="ui allclass vertical menu">';
									for (var n = 0; n < class_infomation[i][year - 2].length; n++) {
										dom += '<a class=" all_class_no item" class_no="' + class_infomation[i][year - 2][n].class_no + '">' + class_infomation[i][year - 2][n].class_name + '</a>';
									}
									dom += '</div>';
									dom += '</div>';
									dom += '</div>';
									dom += '</div>';
									dom += '</div> ';
									$('.dep').append($(dom));
								}
							}
							console.log(USEROBJECT.userpurview);
							if(USEROBJECT.userpurview == 'ALL'){
								
							}else{
								$('.dep_no').hide();
								$('.'+USEROBJECT.userpurview+'').show();
							}
							
							$('.all_class_no').click(function() {
								$('.all_class_no').removeClass('active');
								$(this).addClass('active');
								class_no = $(this).attr("class_no");
								loadCheckByClassNo();
							});
							$('.ui.accordion').accordion({});
						}
					});
				}
				
				
				loadterm();
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
									if (i == term_table.length - 1) {
										var dom_term = '<option  selected="selected" value="' + term_table[i].term_no + '">' + term_table[i].term_name + '</option>';
										$('#menu_term').append($(dom_term));
									} else {
										var dom_term = '<option value="' + term_table[i].term_no + '">' + term_table[i].term_name + '</option>';
										$('#menu_term').append($(dom_term));
									}
								}
								$("#menu_term").dropdown();
							}
						}
					});
				}

				function loadCheckByClassNo() {
					console.log(class_no);
					console.log(term_no); //函数正确
					term_no = $("#menu_term > option:selected").val();
					$.ajax({
						url: "do?invoke=TeacherCenter@loadCheckByClassNo",
						type: 'POST',
						dataType: 'json',
						data: {
							class_no: class_no,
							term_no: term_no,
						},
						success: function(rep) {
							$("#searchinfomation").removeClass("loading");
							$('body').animate({
								scrollTop: 0
							}); //页面滚动事件 里上的距离
							if (rep.result == 0) {
							} else {
								$('#form_table').find('tr').remove();
								tablestu = rep.data;
								var  i = 0;
								var  m = 0;
								for ( i ; i < tablestu.length; i++) {
									if(tablestu[i].zh == 0){
										m++;
									}
									var dom_stu = '<tr>' +
										'<td>' + tablestu[i].stu_no + '</td>' +
										'<td>' + tablestu[i].stu_name + '</td>' +
										'<td>' + tablestu[i].qj + '</td>' +
										'<td>' + tablestu[i].cd + '</td>' +
										'<td>' + tablestu[i].kk + '</td>' +
										'<td>' + tablestu[i].zt + '</td>' +
										'<td>' + tablestu[i].zh + '</td>' +
										'<td>';
									if (tablestu[i].zh != 0) {
										dom_stu += '<div class="look circular mini ui teal basic icon button" stu_name = "' + tablestu[i].stu_name + '" stu_no="' + tablestu[i].stu_no + '"  data-content="查看详情">' +
											'<i class="search teal large icon"></i>';
									} else {
										dom_stu += '<div class="nocheck_ circular mini ui green basic icon button" data-content="无缺勤">' +
											'<i class=" checkmark green large icon"></i>';
									}
									dom_stu += '</div>' +
										'</td>' +
										'</tr>';
									$('#form_table').append($(dom_stu));
								}
								if(i == m){
									$('#form_table_head').hide();
									$('#no_checking').show();
								}else{
									$('#form_table_head').show();
									$('#no_checking').hide();
									$('.look').popup();
									$('.look').click(function() {
										stu_no = $(this).attr("stu_no");
										stu_name = $(this).attr("stu_name");
										$('#grxq').modal({
											observeChanges: true,
										}).modal('show');
										$('#xg').modal({
											observeChanges: true,
										})
										.modal('hide');
										loadperson_checking(term_no, stu_no, stu_name);
									});
								}
								
							}
						}
					});
				}

				function loadperson_checking(term_no, stu_no, stu_name) {
					$('.ui.message.tableMessage.sliderDiv').removeClass("sliderDiv");
					$.ajax({
						url: "do?invoke=TeacherCenter@get_checking_person",
						type: 'POST',
						dataType: 'json',
						data: {
							stu_no: stu_no, //从系统中获取学生号
							term_no: term_no,
							starttime: '',
							endtime: ''
						},
						success: function(rep) {
							$('#form_table_gr').find('tr').remove();
							var person_checking = rep.data;
							console.log(rep.data);
							if(person_checking.length > 20) {
								$('.ui.message.tableMessage').addClass("sliderDiv");                
 
							}
							for (var i = 0; i < person_checking.length; i++) {
								var dom_person = '<tr>' +
									'<td>' + (i + 1) + '</td>' +
									'<td>' + stu_name + '</td>' +
									'<td>' + person_checking[i].teacher_name + '</td>' +
									'<td>' + person_checking[i].course_name + '</td>' +
									'<td>' + person_checking[i].check_status + '</td>' +
									'<td>' + '第 ' + person_checking[i].check_week + ' 周' + '</td>';
								if (person_checking[i].sche_set.substring(1, 2) == 1) {
									dom_person += '<td>一</td>';
								} else if (person_checking[i].sche_set.substring(1, 2) == 2) {
									dom_person += '<td>二</td>';
								} else if (person_checking[i].sche_set.substring(1, 2) == 3) {
									dom_person += '<td>三</td>';
								} else if (person_checking[i].sche_set.substring(1, 2) == 4) {
									dom_person += '<td>四</td>';
								} else if (person_checking[i].sche_set.substring(1, 2) == 5) {
									dom_person += '<td>五</td>';
								} else if (person_checking[i].sche_set.substring(1, 2) == 6) {
									dom_person += '<td>六</td>';
								} else if (person_checking[i].sche_set.substring(1, 2) == 7) {
									dom_person += '<td>日</td>';
								} else {
									dom_person += '<td>实 训 课</td>';
								}
								if (person_checking[i].sche_set.substring(2, 3) == 1) {
									dom_person += '<td>1 , 2 节</td>';
								} else if (person_checking[i].sche_set.substring(2, 3) == 2) {
									dom_person += '<td>3 , 4 节</td>';
								} else if (person_checking[i].sche_set.substring(2, 3) == 3) {
									dom_person += '<td>5 , 6 节</td>';
								} else if (person_checking[i].sche_set.substring(2, 3) == 4) {
									dom_person += '<td>7 , 8 节</td>';
								} else if (person_checking[i].sche_set.substring(2, 3) == 5) {
									dom_person += '<td>晚 自 习</td>';
								} else {
									dom_person += '<td>无</td>';
								}
								dom_person += '<td><div class="remove circular mini ui red basic icon button"  check_status="' + person_checking[i].check_status + '"  check_main_no = "' + person_checking[i].check_main_no + '" time="' + person_checking[i].check_time.substring(0, 19) + '"  name="' + stu_no + '">' +
									'<i class="trash red large icon"></i>' +
									'</div>' +
									'</td>';
								dom_person += '<td><div class="change circular mini ui blue basic icon button"  check_status="' + person_checking[i].check_status + '" check_main_no = "' + person_checking[i].check_main_no + '"   time="' + person_checking[i].check_time.substring(0, 19) + '"  name="' + stu_no + '">' +
									'<i class="edit blue large icon"></i>' +
									'</div>' +
									'</td>' +
									'</tr>';
								$('#form_table_gr').append($(dom_person)); 
							}
							$('.remove').unbind('click').click(function() {
								var check_time = $(this).attr("time");
								var check_main_no = $(this).attr("check_main_no");
								var check_status = $(this).attr("check_status");
								var check_change_status = "";
								$.confirm({
									msg: '您确定要删除这条记录吗？',
									btnSure: '确认删除 ',
									btnCancel: '取消选择',
									sureDo: function() {
										 changecheckrate(check_main_no, check_status, check_change_status);
										getdelete(stu_no, check_time);
									},
									cancelDo: function() {
									}
								});
								
							});
							$('.change').unbind('click').click(function() {
								$('#grxq').modal({
									observeChanges: true,
								}).modal('hide');
								$('#xg').modal({
										observeChanges: true,
									})
									.modal('show');
								$('#menu_status').dropdown();
								var check_status_ = $(this).attr("check_status");
								var check_time_ = $(this).attr("time");
								var check_main_no_ = $(this).attr("check_main_no");
								$('#change_status').click(function() {
									var check_change_status = $("#menu_status > option:selected").text();
									getchange(stu_no, check_time_, check_change_status);
									changecheckrate(check_main_no_, check_status_, check_change_status);
								});
							});
						}
					});
				}

				function getdelete(stu_no, check_time) {
					$.ajax({
						url: "do?invoke=student_checking_inquire@getdelete",
						type: 'POST',
						dataType: 'json',
						data: {
							stu_no: stu_no,
							check_time: check_time
						},
						success: function(rep) {
							loadperson_checking(term_no, stu_no, stu_name);
							loadCheckByClassNo();
						}
					});
				}

				function changecheckrate(check_main_no, check_status, check_change_status) {
					$.ajax({
						url: "do?invoke=student_checking_inquire@changecheckrate",
						type: 'POST',
						dataType: 'json',
						data: {
							check_main_no: check_main_no,
							check_status: check_status,
							check_change_status: check_change_status,
						},
						success: function(rep) {}
					});
				}

				function getchange(stu_no, check_time, status) {
					$.ajax({
						url: "do?invoke=student_checking_inquire@getchange",
						type: 'POST',
						dataType: 'json',
						data: {
							stu_no: stu_no,
							check_time: check_time,
							check_status: status
						},
						success: function(rep) {
							loadCheckByClassNo();
							$('#xg').modal({
								observeChanges: true,
							})
							.modal('hide');
							$('#grxq').modal({
								observeChanges: true,
							}).modal('show');
							loadperson_checking(term_no, stu_no, stu_name);
						}
					});
				}
			});
		</script>
		<!--这里引用其他JS-->

		</html>