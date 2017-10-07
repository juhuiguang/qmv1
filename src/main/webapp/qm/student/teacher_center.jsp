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
					#card_class {
						width: 50%;
						height: 120px;
						margin-left: 8%;
						margin-top: 57px;
					}
					
					#card_evaluate {
						width: 30%;
						height: 250px;
						margin-left: 5%;
						margin-top: 57px;
					}
					
					#card_listen {
						width: 30%;
						height: 250px;
						margin-top: -100px;
						margin-left: 8%;
					}
					
					#card_teaching {
						width: 50%;
						height: 120px;
						margin-left: 44%;
						margin-top: -130px;
					}
					
					#btnsumbit {
						width: 120px;
						margin-top: -266px;
						margin-left: 44%;
					}
					
					#main {
						width: 330px;
						height: 240px;
						margin-left: -55px;
					}
					
					#chart {
						width: 330px;
						height: 240px;
						margin-left: -55px;
					}
					
					#word {
						color: white;
					}
					
					.title {
						margin-top: 50px;
					}
					
					#cards {
						width: 88%;
						height: 80%;
					}
				</style>
		</head>

		<body>
			<%@ include file="/commonjsp/header.jsp"%>
				<div id="container">

					<div class="ui cards" id="cards">
						<div class=" card " id="card_class">
							<div class="content" id="px">
								<a href="<%=BASE_PATH %>/qm/teacher/tea_commentclass.jsp?module=12&menu=36">
									<div class="btnfirst circular right floated ui red basic icon button  prompt" data-content="点击可进行 评学哦！" data-variation="small">
										<i class="file red text icon"></i>
									</div>
								</a>
								<div class="header">评学记录 </div>
							</div>
						</div>
						<div class="card" id="card_evaluate">
							<div class="content" id="checking">
								<a href="<%=BASE_PATH %>/qm/student/stu_checking_inquire.jsp?module=12&menu=37">
									<div class="btnfirst circular right floated ui purple basic icon button prompt" data-content="点击可查看详情哦！" data-variation="small">
										<i class="file purple text icon"></i>
									</div>
								</a>
								<div class="header">缺勤记录 </div>
								<div id="main"></div>
							</div>
						</div>
						<div class="card" id="card_listen">
							<div class="content" id="listen">
								<a href="<%=BASE_PATH %>/qm/teacher/tea_view_listen.jsp?module=12&menu=38">
									<div class="btnfirst circular right floated ui green basic icon button prompt" data-content="点击可查看详情哦！" data-variation="small">
										<i class="file green text icon"></i>
									</div>
								</a>
								<div class="header">听课记录 </div>
								<div id="chart"></div>
							</div>

						</div>
						<div class="card" id="card_teaching">
							<div class="content" id="evaluate">
								<a href="<%=BASE_PATH %>/qm/teacher/tea_view_comment.jsp?module=12&menu=39">
									<div class="btnfirst circular right floated ui teal basic icon button prompt" data-content="点击可查看详情哦！" data-variation="small">
										<i class="file teal text icon"></i>
									</div>
								</a>
								<div class="header">评教记录 </div>
							</div>

						</div>
						<div id="btnsumbit">
							<a href="<%=BASE_PATH %>/qm/student/tea_check.jsp?module=12&menu=35">
								<button class="ui blue button">
									<h2 class="ui center header " id="word">进入考勤</h2> </button>
							</a>
						</div>
					</div>
				</div>
		</body>
		<script>
			$(function() {
				var SYSOBJCET = <%= SYSOBJCET %>;
				var USEROBJECT = <%= USEROBJECT %>;
				var numble_checking_leave;
				var numble_checking_yes;
				var numble_checking_no;
				console.log(SYSOBJCET.term_no)
				$('.prompt').popup();
				loadtea_listen();

				function loadtea_listen() {
					$.ajax({ //获取本班级所有人的信息，只是班级人的姓名和学号
						url: "do?invoke=TeacherCenter@get_table_listen",
						type: 'POST',
						dataType: 'json',
						data: {
							teacher_no: USEROBJECT.loginname, //获取到教师的教工号
							term_no: SYSOBJCET.term_no,
						},
						success: function(rep) {
							if (rep.data == 0) {
								var dom_two = '<div class="description">' + '您暂时还没被听课哦！' + '</div>';
								$('#chart').before($(dom_two));
							} else {
								var per_pj;
								var col_pj;
								var sch_pj;
								var tabletea_listen = rep.data;
								var avg = 0;
								for (var i = 0; i < tabletea_listen.length; i++) {
									avg += parseInt(tabletea_listen[i].total);
								}
								per_pj = parseFloat((avg) / tabletea_listen.length).toFixed(1);
								var dom_one = '<div class="meta">' + '本学期被听课' + tabletea_listen.length + '次' + ' </div>';
								$('#chart').before($(dom_one));
								$.ajax({
									url: "do?invoke=TeacherCenter@get_college_pj",
									type: 'POST',
									dataType: 'json',
									data: {
										term_no: SYSOBJCET.term_no,
										college_no: USEROBJECT.userinfo.dep_no
									},
									success: function(rep) {
										var table = rep.data;
										col_pj = parseFloat(table[0].pj).toFixed(1);
										$.ajax({
											url: "do?invoke=TeacherCenter@get_school_pj",
											type: 'POST',
											dataType: 'json',
											data: {
												term_no: SYSOBJCET.term_no,
											},
											success: function(rep) {
/* 												var table = rep.data;
												sch_pj = parseFloat(table[0].pj).toFixed(1);
												var myChart = echarts.init(document.getElementById('chart'));
												var option = {
													title: {
														x: 'center',
														text: '平均分统计图',
														textStyle: {
															fontSize: 18,
															fontWeight: 'bolder',
															color: '#2185D0'
														},
													},
													tooltip: {
														trigger: 'item'
													},
													grid: {
														borderWidth: 0,
														y: 80,
														y2: 60
													},
													xAxis: [{
														type: 'category',
														show: false,
														data: ['自己', '部门', '全校']
													}],
													yAxis: [{
														type: 'value',
														show: false
													}],
													series: [{
														name: '平均分',
														type: 'bar',
														itemStyle: {
															normal: {
																color: function(params) {
																	var colorList = [
																		'#8fd2e7', '#d7504b', '#f6bf75'
																	];
																	return colorList[params.dataIndex]
																},
																label: {
																	show: true,
																	position: 'top',
																	formatter: '{b}\n{c}'
																}
															}
														},
														data: [per_pj, col_pj, sch_pj],
														markPoint: {
															tooltip: {
																trigger: 'item',
																backgroundColor: 'rgba(0,0,0,0)'
															},
															data: [{
																xAxis: 0,
																y: 350,
																name: 'Line',
																symbolSize: 20
															}, {
																xAxis: 1,
																y: 350,
																name: 'Bar',
																symbolSize: 20
															}, {
																xAxis: 2,
																y: 350,
																name: 'Scatter',
																symbolSize: 20
															}, ]
														}
													}]
												};
												myChart.setOption(option); */
											}
										});
									}
								});
							}
						}
					});
				}
				loadtea_evaluate();

				function loadtea_evaluate() { //函数正确
					$.ajax({ //获取本班级所有人的信息，只是班级人的姓名和学号
						url: "do?invoke=TeacherCenter@get_table_evaluate_numble",
						type: 'POST',
						dataType: 'json',
						data: {
							teacher_no: USEROBJECT.loginname, //获取到教师的教工号
							term_no: SYSOBJCET.term_no
						},
						success: function(rep) {
							if (rep.result == 0) {
								var dom_two = '<div class="description">' + '暂时还没有学生进行评教哦！' + '</div>';
								$('#evaluate').append($(dom_two));
							} else {
								var tablestu_numble = rep.data;
								$.ajax({ //获取本班级所有人的信息，只是班级人的姓名和学号
									url: "do?invoke=TeacherCenter@get_table_evaluate",
									type: 'POST',
									dataType: 'json',
									data: {
										teacher_no: USEROBJECT.loginname,
										term_no: SYSOBJCET.term_no
									},
									success: function(rep) {
										if (rep.result == 0) {
											$.alert("系统故障");
										} else {
											console.log(rep);
											var tablestu_avg = rep.data;
											var dom_one = '<div class="meta">' + '共有' + tablestu_numble.length + '名学生对您进行了评教' + ' </div>';
											$('#evaluate').append($(dom_one));
											var avg = parseInt(tablestu_avg[0].pj);
											/* var dom_two = '<div class="description">' + '您的平均得分为' + (avg).toFixed(1) + '分' + '</div>';
											$('#evaluate').append($(dom_two)); */
										}
									}
								});
							}
						}
					});
				}
				loadtea_px();

				function loadtea_px() {
					$.ajax({ //获取本班级所有人的信息，只是班级人的姓名和学号
						url: "do?invoke=TeacherCenter@get_table_px",
						type: 'POST',
						dataType: 'json',
						data: {
							teacher_no: USEROBJECT.loginname, //获取到教师的教工号
							term_no: SYSOBJCET.term_no,
						},
						success: function(rep) {
							if (rep.result == 0) {
								var dom_two = '<div class="description">' + '抱歉，本学期您没有课程哦！' + '</div>';
								$('#px').append($(dom_two));
							} else {
								var tabletea_px = rep.data;
								var dom_one = '<div class="meta">' + '本学期您需要评学' + tabletea_px.length + '门课' + ' </div>';
								$('#px').append($(dom_one));
								var numble_no = 0;
								var numble_yes = 0;
								for (var i = 0; i < tabletea_px.length; i++) {
									if (tabletea_px[i].total != "") {
										numble_yes++;
									} else {
										numble_no++;
									}
								}
								if (numble_no == 0) {
									var dom = '<div class="description ui red header title"><h4 class=" ui red header title">' + '评学已完成，点击可查看详情哦！' + '</h4></div>';
									$('#px').append($(dom));
								} else {
									var dom = '<div class="description"><h4 class=" ui red header title">' + '您未评学' + numble_no + '门课,点击可进行评学哦！' + '</h4></div>';
									$('#px').append($(dom));
								}
							}
						}
					});
				}
				all();

				function all() {
					$.ajax({
						url: "do?invoke=TeacherCenter@get_stu_checking_no",
						type: 'POST',
						dataType: 'json',
						data: {
							teacher_no_one: USEROBJECT.loginname,
							term_no_one: SYSOBJCET.term_no,
							term_no_two: SYSOBJCET.term_no,
							teacher_no_two: USEROBJECT.loginname,
						},
						success: function(rep) {
							var tablestu = rep.data;
							numble_checking_no = tablestu.length; //没有缺勤的人
							console.log(rep);
							$.ajax({
								url: "do?invoke=TeacherCenter@get_stu_checking_yes",
								type: 'POST',
								dataType: 'json',
								data: {
									teacher_no_one: USEROBJECT.loginname,
									term_no_one: SYSOBJCET.term_no,
									term_no_two: SYSOBJCET.term_no,
									teacher_no_two: USEROBJECT.loginname,
								},
								success: function(rep) {
									var tablestu_yes = rep.data;
									numble_checking_yes = tablestu_yes.length;
									console.log(rep);
									$.ajax({
										url: "do?invoke=TeacherCenter@get_stu_checking_leave",
										type: 'POST',
										dataType: 'json',
										data: {
											teacher_no_one: USEROBJECT.loginname,
											term_no_one: SYSOBJCET.term_no,
											term_no_two: SYSOBJCET.term_no,
											teacher_no_two: USEROBJECT.loginname,
										},
										success: function(rep) {
											var dom = '<div class="meta">' + '任课班级的所有学生 ' + ' </div>';
											$('#main').before($(dom));
											var tablestu_leave = rep.data;
											numble_checking_leave = tablestu_leave.length;
											var myChart = echarts.init(document.getElementById('main'));
											var option = {
												title: {
													x: 'center',
													text: '学生缺勤统计图',
													textStyle: {
														fontSize: 18,
														fontWeight: 'bolder',
														color: '#2185D0'
													},
												},
												tooltip: {
													trigger: 'item'
												},
												grid: {
													borderWidth: 0,
													y: 80,
													y2: 60
												},
												xAxis: [{
													type: 'category',
													show: false,
													data: ['没有缺勤', '请假', '缺勤']
												}],
												yAxis: [{
													type: 'value',
													show: false
												}],
												series: [{
													name: '学生缺勤统计图',
													type: 'bar',
													itemStyle: {
														normal: {
															color: function(params) {
																var colorList = [
																	'#C6E579', '#F4E001', '#F0805A'
																];
																return colorList[params.dataIndex]
															},
															label: {
																show: true,
																position: 'top',
																formatter: '{b}\n{c}'
															}
														}
													},
													data: [numble_checking_no, numble_checking_leave, numble_checking_yes],
													markPoint: {
														tooltip: {
															trigger: 'item',
															backgroundColor: 'rgba(0,0,0,0)'
														},
														data: [{
															xAxis: 0,
															y: 350,
															name: 'Line',
															symbolSize: 20
														}, {
															xAxis: 1,
															y: 350,
															name: 'Bar',
															symbolSize: 20
														}, {
															xAxis: 2,
															y: 350,
															name: 'Scatter',
															symbolSize: 20
														}, ]
													}
												}]
											};
											myChart.setOption(option);
										}
									});
								}
							});
						}
					});
				}
			}); //初始化的括号
		</script>
		<!--这里引用其他JS-->

		</html>