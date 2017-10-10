<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/commonjsp/doctype.jsp"%>
		<html>

		<head>
			<%@ include file="/commonjsp/meta.jsp"%>
				<script src="script/common/echarts/echarts-all.js"></script>
				<link rel="stylesheet" href="script/common/datepicker/jquery.datetimepicker.css">
				<nk>
					<script src="script/common/datepicker/jquery.datetimepicker.js"></script>
					<!--这里引用其他样式-->
					<title>校内教学质量监控运行平台</title>
					<style>
						.img {
							margin-right: 82px;
						}
						
						#lookdepratio {
							margin-top: 12px;
							width: 220px;
						}
					</style>
		</head>

		<body>
			<%@ include file="/commonjsp/header.jsp"%>
				<div id="container">
					<h3 class="ui header">
								<i class="list layout icon"></i>
                               <div class="content">辅导员查看出勤 </div>
                               </h3>

					<div class="ui raised">
						<div class="ui form">
							<div class="fields">
								<div class="field">

									<select class="ui three dropdown" id="menu_term">
									</select>

								</div>
								<div class=" field">

									<select class="ui one dropdown" id="menu_grade">
										<option value="3" selected="selected">所有的年级</option>

									</select>
								</div>
								<div class=" field">

									<input id="date_timepicker_start" type="text" style="width: 140px;" placeholder="开始时间" data-content="也可以自己输入日期哦！">

								</div>
								<div class="  field">

									<input id="date_timepicker_end" type="text" style="width: 140px;" placeholder="截止时间" data-content="也可以自己输入日期哦！">

								</div>

								<div class="field">
									<button class="ui small basic button" id="btnsubmit"><i class=" img large search icon"></i></button>
								</div>
								<button class="ui basic button" style="position:absolute;left:88%;" id="export_dc" data-content="点击导出" data-variation="small"><i class="upload icon"></i> 导 出 </button>

							</div>
						</div>

					</div>

					<table class="ui compact blue table" id="form_table">
						<thead>
							<tr>
								<th>编号</th>
								<th>班级</th>
								<th>平均出勤率</th>
								<th>参与总人次</th>
								<th>查看详情</th>

							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
					<div class="ui coupled  first long test modal" id="bjxq">
						<i class="close icon"></i>
						<div class="header">
							班级 缺勤详情
						</div>
						<div class="image content">
							<div class="description">
								<table class="ui striped blue table" id="form_table_bj">
									<thead>
										<tr>
											<th>编号</th>
											<th>学号</th>
											<th>姓名</th>
											<th>旷课</th>
											<th>迟到</th>
											<th>早退</th>
											<th>请假</th>
											<th>未到勤</th>
											<th>查看详情</th>
										</tr>
									</thead>
									<tbody>

									</tbody>
								</table>
							</div>
						</div>
					</div>

					<div class="ui coupled second long test modal" id="grxq">
						<i class="close icon"></i>
						<div class="header">
							个人缺勤详情
						</div>
						<div class="content">
							<table class="ui striped blue table" id="form_table_gr">
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
									</tr>
								</thead>
								<tbody>

								</tbody>
							</table>
						</div>
					</div>
				</div>
		</body>
		<script>
			$(function() {
				var now = new Date();
				//获取当前日期
				var starttime = "";
				var endtime = "";
				var depno = USEROBJECT.userpurview;
				var end = now.getFullYear() + "-" + ((now.getMonth() + 1) < 10 ? "0" : "") + (now.getMonth() + 1) + "-" + (now.getDate() < 10 ? "0" : "") + now.getDate();
				jQuery(function() {
					jQuery('#date_timepicker_start').datetimepicker({
						format: 'Y-m-d',
						lang: 'zh',
						onShow: function(ct) {
							this.setOptions({})
						},
						timepicker: false
					});
					jQuery('#date_timepicker_end').datetimepicker({
						format: 'Y-m-d',
						lang: 'zh',
						onShow: function(ct) {
							this.setOptions({})
						},
						timepicker: false
					});
				});
				var termno = SYSOBJCET.term_no;
				$("#menu_condition").dropdown();
				$("#menu_grade").dropdown();
				$("#btnsubmit").click(function() {
					if ($(this).hasClass("loading")) return;
					$("#btnsubmit").addClass("loading");
					run($('#menu_grade>option:selected').val());
				});

				function run(value) {
					if (value == 3) {
						load_college_checking(SYSOBJCET.departments.find(function(d){return (d.dep_no===USEROBJECT.userpurview)}).dep_name);
					} else {
						load_grade_attendace(value, termno);
					}
				}
				loadterm();

				function loadterm() {
					$.ajax({
						url: "do?invoke=student_checking_inquire@get_checking_term",
						type: 'POST',
						dataType: 'json',
						success: function(rep) {
							console.log(rep);
							var dom = "";
							if (rep.result == 0) {} else {
								var term_table = rep.data;
								console.log(rep);
								for (var i = term_table.length - 1; i >= 0; i--) {
									if (i == term_table.length - 1) {
										var dom_term = '<option   selecter="selected" value="' + term_table[i].term_no + '" start="' + term_table[i].term_startdate.substring(0, 4) + '-' + term_table[i].term_startdate.substring(4, 6) + '-' + term_table[i].term_startdate.substring(6, 8) + '" end="' + end + '">' + term_table[i].term_name + '</option>';
										$('#menu_term').append($(dom_term));
									} else {
										var dom_term = '<option value="' + term_table[i].term_no + '" start="' + term_table[i].term_startdate.substring(0, 4) + '-' + term_table[i].term_startdate.substring(4, 6) + '-' + term_table[i].term_startdate.substring(6, 8) + '" end="' + term_table[i + 1].term_startdate.substring(0, 4) + '-' + term_table[i + 1].term_startdate.substring(4, 6) + '-' + term_table[i + 1].term_startdate.substring(6, 8) + '">' + term_table[i].term_name + '</option>';
										$('#menu_term').append($(dom_term));
									}
								}
								$('#date_timepicker_start').attr("value", $('#menu_term>option:selected').attr("start"));
								$('#date_timepicker_end').attr("value", $('#menu_term>option:selected').attr("end"));
								$("#menu_term").dropdown({
									onChange: function(value, text) {
										termno = value;
										$('#date_timepicker_start').val($('#menu_term>option:selected').attr("start"));
										$('#date_timepicker_end').val($('#menu_term>option:selected').attr("end"));
									}
								});
							}
						}
					});
				}
				loadtermyear();

				function loadtermyear() {
					$.ajax({
						url: "do?invoke=TeacherCenter@loadtermyear",
						type: 'POST',
						dataType: 'json',
						success: function(rep) {
							var term_year = rep.data;
							var dom = "";
							for (var i = 0; i < term_year.length; i++) {
								dom += '<option value="' + term_year[i].class_session_year + '">' + term_year[i].class_session_year + '届</option>';
							}
							$('#menu_grade').append(dom);
						}
					});
				}
				load_college_checking(SYSOBJCET.departments.find(function(d){return (d.dep_no===USEROBJECT.userpurview)}).dep_name);
				//导出功能
				$("#export_dc").unbind('click').click(function() {
					starttime = $('#date_timepicker_start').val();
					endtime = $('#date_timepicker_end').val();
					var params = [];
					params.push(termno);
					params.push(USEROBJECT.userpurview);
					params.push(starttime);
					params.push(endtime+ ',');
					params.push(termno);
					params.push($('#menu_grade>option:selected').val());
					params.push(termno);
					params.push(USEROBJECT.userpurview);
					params.push(starttime);
					params.push(endtime + ',');
					params.push(termno);
					params.push($('#menu_grade>option:selected').val());
					params.push(termno);
					params.push(USEROBJECT.userpurview);
					params.push(starttime);
					params.push(endtime);
					var type = "excel";
					open(BASE_PATH + "/qm/base/export.jsp?export_id=9&params=" + encodeURIComponent(params) + "&type=" + type + "&more=3");
				});

				function load_college_checking(dep_name) {
					starttime = $('#date_timepicker_start').val();
					endtime = $('#date_timepicker_end').val();
					$.ajax({
						url: "do?invoke=TeacherCenter@get_college_attendancerate",
						type: 'POST',
						dataType: 'json',
						data: {
							term_no: termno,
							dep_name: dep_name,
							starttime: starttime,
							endtime: endtime
						},
						success: function(rep) {
							if (rep.result == 0) {
								$("#btnsubmit").removeClass("loading");
								$('#form_table tr:gt(0)').remove();
								$.alert("抱歉！暂无记录")
							} else {
								console.log(rep);
								$('#main').hide();
								$('#form_table tr:gt(0)').remove();
								$("#btnsubmit").removeClass("loading");
								tablecollege = rep.data;
								for (var i = 0; i < tablecollege.length; i++) {
									var avg = parseFloat(tablecollege[i].ratio);
									var dom = '<tr>' +
										'<td>' + (i + 1) + '</td>' +
										'<td>' + tablecollege[i].class_name + '</td>' +
										'<td>' + avg.toFixed(2) + '%' + '</td>' +
										'<td>' + parseInt(tablecollege[i].numble) + '</td>' +
										'<td>';
									if (avg.toFixed(2) != 100.00) {
										dom += '<div class="look circular mini ui teal basic icon button"  class_no="' + tablecollege[i].class_no + '">' +
											'<i class=" search teal large icon"></i>';
									} else {
										dom += '<div class="nocheck_ circular mini ui green basic icon button" data-content="班级无缺勤">' +
											'<i class=" checkmark green large icon"></i>';
									}
									dom += '</div>'
									'</td>' +
									'</tr>';
									$('#form_table').append($(dom));
								}
								$('.look').click(function() {
									var class_no = $(this).attr("class_no");
									$('#bjxq').modal({
											transition: 'vertical flip',
											observeChanges: true,
											allowMultiple: false,
										})
										.modal('show');
									$('#form_table_bj tr:gt(0)').remove();
									loadgradexq(class_no);
								});
							}
						}
					});
				}

				function load_grade_attendace(value, termno) { //根据年级显示
					var data = "" + termno;
					var grade_no = $('#menu_grade>option:selected').val();
					starttime = $('#date_timepicker_start').val();
					endtime = $('#date_timepicker_end').val();
					$.ajax({
						url: "do?invoke=TeacherCenter@get_grade_attendace",
						type: 'POST',
						dataType: 'json',
						data: {
							term_no: termno,
							dep_no: USEROBJECT.userpurview,
							grade_no: grade_no,
							starttime: starttime,
							endtime: endtime
						},
						success: function(rep) {
							if (rep.result == 0) {
								$("#btnsubmit").removeClass("loading");
								$('#form_table tr:gt(0)').remove();
								$.alert("抱歉！暂无记录")
							} else {
								$('#form_table tr:gt(0)').remove();
								$("#btnsubmit").removeClass("loading");
								tablegrade = rep.data;
								for (var i = 0; i < tablegrade.length; i++) {
									var avg = parseFloat(tablegrade[i].ratio);
									var dom = '<tr>' +
										'<td>' + (i + 1) + '</td>' +
										'<td>' + tablegrade[i].class_name + '</td>' +
										'<td>' + avg.toFixed(2) + '%' + '</td>' +
										'<td>' + parseInt(tablegrade[i].numble) + '</td>' +
										'<td>';
									if (avg.toFixed(2) != 100.00) {
										dom += '<div class="look circular mini ui teal basic icon button"  class_no="' + tablegrade[i].class_no + '">' +
											'<i class=" search teal large icon"></i>';
									} else {
										dom += '<div class="nocheck_ circular mini ui green basic icon button" data-content="班级无缺勤">' +
											'<i class=" checkmark green large icon"></i>';
									}
									dom += '</div>'
									'</td>' +
									'</tr>';
									$('#form_table').append($(dom));
								}
								$('.nocheck_').popup();
								$('.look').click(function() {
									var class_no = $(this).attr("class_no");
									console.log(class_no)
									$('#bjxq').modal({
											transition: 'vertical flip',
											observeChanges: true,
											allowMultiple: true,
										})
										.modal('show');
									$('#form_table_bj tr:gt(0)').remove();
									loadgradexq(class_no);
								});
							}
						}
					});
				}

				function loadgradexq(class_no) {
					$.ajax({
						url: "do?invoke=TeacherCenter@get_grade_xq",
						type: 'POST',
						dataType: 'json',
						data: {
							class_no_one: class_no,
							term_no: termno,
							class_no_two: class_no,
							starttime: starttime,
							endtime: endtime
						},
						success: function(rep) {
							if (rep.result == 0) {
								console.log(rep)
							} else {
								tablestu = rep.data;
								for (var i = 0; i < tablestu.length; i++) {
									var dom_stu = '<tr>' +
										'<td>' + (i + 1) + '</td>' +
										'<td>' + tablestu[i].stu_no + '</td>' +
										'<td>' + tablestu[i].stu_name + '</td>' +
										'<td>' + tablestu[i].kk + '</td>' +
										'<td>' + tablestu[i].cd + '</td>' +
										'<td>' + tablestu[i].zt + '</td>' +
										'<td>' + tablestu[i].qj + '</td>' +
										'<td>' + tablestu[i].zh + '</td>' +
										'<td>';
									if (tablestu[i].zh != 0) {
										dom_stu += '<div class="lookstu circular mini ui teal basic icon button" stu_name="' + tablestu[i].stu_name + '" stu_no="' + tablestu[i].stu_no + '">' +
											'<i class=" search teal large icon"></i>';
									} else {
										dom_stu += '<div class="nocheck circular mini ui green basic icon button" data-content="无缺勤">' +
											'<i class=" checkmark green large icon"></i>';
									}
									dom_stu += '</div>' +
										'</td>' +
										'</tr>';
									$('#form_table_bj').append($(dom_stu));
								}
								$('.nocheck').popup();
								$('.lookstu').click(function() {
									$('#form_table_gr tr:gt(0)').remove();
									$('#grxq').modal({
										transition: 'vertical flip',
										observeChanges: true,
										allowMultiple: false,
									}).modal('show');
									var stu_no = $(this).attr("stu_no");
									var stu_name = $(this).attr("stu_name");
									loadperson_checking(termno, stu_no, stu_name);
								});
							}
						}
					});
				}

				function loadperson_checking(term_no, stu_no, stu_name) {
					$.ajax({
						url: "do?invoke=TeacherCenter@get_checking_person",
						type: 'POST',
						dataType: 'json',
						data: {
							stu_no: stu_no, //从系统中获取学生号
							term_no: term_no,
							starttime: starttime,
							endtime: endtime
						},
						success: function(rep) {
							var person_checking = rep.data;
							for (var i = 0; i < person_checking.length; i++) {
								console.log(person_checking[i].sche_set);
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
//								if (person_checking[i].sche_set.substring(2, 3) == 1) {
//									dom_person += '<td>1 , 2 节</td>';
//								} else if (person_checking[i].sche_set.substring(2, 3) == 2) {
//									dom_person += '<td>3 , 4 节</td>';
//								} else if (person_checking[i].sche_set.substring(2, 3) == 3) {
//									dom_person += '<td>5 , 6 节</td>';
//								} else if (person_checking[i].sche_set.substring(2, 3) == 4) {
//									dom_person += '<td>7 , 8 节</td>';
//								} else if (person_checking[i].sche_set.substring(2, 3) == 5) {
//									dom_person += '<td>晚 自 习</td>';
//								} else {
//									dom_person += '<td>无</td>';
//								}
                                if (person_checking[i].sche_set.substring(2, 3) == 1) {
                                    if(!SINGLESCHE){
                                        dom_person += '<td>1,2节</td>';
                                    }else{
                                        dom_person += '<td>1节</td>';
                                    }
                                } else if (person_checking[i].sche_set.substring(2, 3) == 2) {
                                    if(!SINGLESCHE){
                                        dom_person += '<td>3,4节</td>';
                                    }else{
                                        dom_person += '<td>2节</td>';
                                    }
                                } else if (person_checking[i].sche_set.substring(2, 3) == 3) {
                                    if(!SINGLESCHE){
                                        dom_person += '<td>5,6节</td>';
                                    }else{
                                        dom_person += '<td>3节</td>';
                                    }
                                } else if (person_checking[i].sche_set.substring(2, 3) == 4) {
                                    if(!SINGLESCHE){
                                        dom_person += '<td>7,8节</td>';
                                    }else{
                                        dom_person += '<td>4节</td>';
                                    }
                                } else if (person_checking[i].sche_set.substring(2, 3) == 5) {
                                    if(!SINGLESCHE){
                                        dom_person += '<td>晚自习</td>';
                                    }else{
                                        dom_person += '<td>5节</td>';
                                    }
                                } else {
                                    dom_person += '<td>'+person_checking[i].sche_set.substring(2, 3)+'节</td>';
                                }
								dom_person += '</tr>';
								$('#form_table_gr').append($(dom_person));
							}
						}
					});
				}
				/* 				function load_school_checking_photo() {//其他院系出勤率
									$.ajax({
										url: "do?invoke=TeacherCenter@get_school_attendancerate",
										type: 'POST',
										dataType: 'json',
										data: {
											term_no: termno
										},
										success: function(rep) {
											if (rep.result == 0) {
												$.alert("暂无任何记录")
												$('#form_table').hide();
											} else {
												$('#form_table').hide();
												$("#btnsubmit").removeClass("loading");
												$('#form_table tr:gt(0)').remove();
												$('#main_').show();
												tableschool = rep.data;
												var names=[];
									    		var radios=[];
												for (var i = 0; i < tableschool.length; i++) {
													var radio = parseFloat(tableschool[i].radio).toFixed(2);
										    		names.push(tableschool[i].dep_name);
										    		radios.push(radio);
												}
												$("#btnsubmit").removeClass("loading");
												var myChart = echarts.init(document.getElementById('main')); 
												myChart.setTheme("macarons");     // 设置echart的主题(改变颜色)
										        var option = {
										    title: {
										        x: 'center',
										        text: '全校出勤率统计图',
										        subtext: '点击查看详情哦！',
										    },
										    tooltip: {
										        trigger: 'item',
										    },
										    toolbox: {
										        show: true,
										        feature: {
										            dataView: {show: true, readOnly: false},
										            restore: {show: true},
										            saveAsImage: {show: true}
										        }
										    },
										    grid: {
										        borderWidth: 0,
										        y: 80,
										        y2: 60
										    },
										    xAxis: [
										        {
										            type: 'category',
										            show: false,
										            data: names
										        }
										    ],
										    yAxis: [
										        {
										            type: 'value',
										            show: false
										        }
										    ],
										    series: [
										        {
										            name: '全校出勤率统计',
										            type: 'bar',
										            itemStyle: {
										                normal: {
										                    color: function(params) {
										                        // build a color map as your need.
										                        var colorList = [
										                           '#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',
										                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD'
										                        ];
										                        return colorList[params.dataIndex]
										                    },
										                    label: {
										                        show: true,
										                        position: 'top',
										                        formatter: '{b}\n{c}%'
										                    }
										                }
										            },
										            data: radios,

										        }
										    ]
										};               
										        myChart.setOption(option);
											}
										}
									});
								} */
			});
		</script>
		<!--这里引用其他JS-->

		</html>