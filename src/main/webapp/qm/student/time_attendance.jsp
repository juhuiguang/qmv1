<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/commonjsp/doctype.jsp"%>
		<html>

		<head>
			<%@ include file="/commonjsp/meta.jsp"%>
				<script src="script/common/echarts/echarts-all.js"></script>
				<link rel="stylesheet" href="script/common/datepicker/jquery.datetimepicker.css">
					<script src="script/common/datepicker/jquery.datetimepicker.js"></script>
					<!--这里引用其他样式-->
					<title>校内教学质量监控运行平台</title>
					<style>
						#btnsubmit {
							width: 20px;
						}
						
						#img {
							margin-left: -12px;
						}
					</style>
		</head>

		<body>
			<%@ include file="/commonjsp/header.jsp"%>
				<div id="container">
					<h3 class="ui header">
								<i class="list layout icon"></i>
                               <div class="content">时间段出勤率查询 </div>
                               </h3>
					<div class="ui raised">
						<div class="ui form">
							<div class="fields">
								<div class="field">

									<select class="ui term dropdown" id="menu_term">
									</select>

								</div>
								<div class="field">

									<select class="ui dep dropdown" id="menu_dep">
									</select>

								</div>
								<div class=" field">

									<input id="date_timepicker_start" type="text" placeholder="开始时间" data-content="也可以自己输入日期哦！">

								</div>
								<div class="  field">

									<input id="date_timepicker_end" type="text" placeholder="截止时间" data-content="也可以自己输入日期哦！">

								</div>
								<div class="field">
									<button class="ui small basic button" id="btnsubmit"><i class=" large search icon" id="img"></i></button>

								</div>

							</div>
						</div>

					</div>

					<table class="ui compact blue table" id="form_table">
						<thead>
							<tr>
								<th>编号</th>
								<th>部门</th>
								<th>出勤率</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
		</body>
		<script>
			$(function() {
				var now = new Date();
				var date = now.getFullYear() + "-" + ((now.getMonth() + 1) < 10 ? "0" : "") + (now.getMonth() + 1) + "-" + (now.getDate() < 10 ? "0" : "") + now.getDate();
				var termno = SYSOBJCET.term_no;
				$('#btnsubmit').click(function() {
					run($('#menu_dep >option:selected').val());
				});

				function run(value) {
					if (value == 0) {
						load_time_attendance();
					} else {
						load_time_college();
					}
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
										var dom_term = '<option   selecter="selected" value="' + term_table[i].term_no + '" start="' + term_table[i].term_startdate.substring(0, 4) + '-' + term_table[i].term_startdate.substring(4, 6) + '-' + term_table[i].term_startdate.substring(6, 8) + '" end="' + date + '">' + term_table[i].term_name + '</option>';
										$('#menu_term').append($(dom_term));
									} else {
										var dom_term = '<option value="' + term_table[i].term_no + '" start="' + term_table[i].term_startdate.substring(0, 4) + '-' + term_table[i].term_startdate.substring(4, 6) + '-' + term_table[i].term_startdate.substring(6, 8) + '" end="' + term_table[i + 1].term_startdate.substring(0, 4) + '-' + term_table[i + 1].term_startdate.substring(4, 6) + '-' + term_table[i + 1].term_startdate.substring(6, 8) + '">' + term_table[i].term_name + '</option>';
										$('#menu_term').append($(dom_term));
									}
								}
								$('#date_timepicker_start').attr("value", $('#menu_term>option:selected').attr("start"));
								$('#date_timepicker_end').attr("value", $('#menu_term>option:selected').attr("end"));
								if(USEROBJECT.userpurview=='ALL'){
									load_time_attendance();
								}else{
									load_time_college();
								}
								$("#menu_term").dropdown({
									onChange: function(value, text) {
										termno = value;
										$('#date_timepicker_start').val($('#menu_term>option:selected').attr("start"));
										$('#date_timepicker_end').val($('#menu_term>option:selected').attr("end"));
										if(USEROBJECT.userpurview=='ALL'){
											load_time_attendance();
										}else{
											load_time_college();
										}
									}
								});
							}
						}
					});
				}
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
				$('#date_timepicker_start').popup();
				$('#date_timepicker_end').popup();
				
				loadcollege();
				function loadcollege() {
					if(USEROBJECT.userpurview=='ALL'){
						var dom='<option value="0" selected="selected">所有的院系</option>';
						$('#menu_dep').append($(dom));
						for (var i = 0; i < (SYSOBJCET.departments).length; i++) { //将学生记录以表格的形式展现出来
							if (SYSOBJCET.departments[i].dep_type!="行政") {
								var dom_college = '<option value="' + SYSOBJCET.departments[i].dep_no + '">' + SYSOBJCET.departments[i].dep_name + '</option>';
								$('#menu_dep').append($(dom_college));
							}
						}
						$("#menu_dep").dropdown();
					}else{
						var dom='<option value="'+USEROBJECT.userpurview+'" selected="selected">'+SYSOBJCET.departments.find(function(d){return (d.dep_no===USEROBJECT.userpurview)}).dep_name+'</option>';
						$('#menu_dep').append($(dom));
						$("#menu_dep").dropdown();
					}
				}

				function load_time_attendance() {
					var time_one = $('#date_timepicker_start').val();
					var time_two = $('#date_timepicker_end').val();
					
					$.ajax({
						url: "do?invoke=TeacherCenter@load_time_attendance",
						type: 'POST',
						dataType: 'json',
						data: {
							term_no: termno,
							time_one: time_one,
							time_two: time_two
						},
						success: function(rep) {
							if (rep.result == 0) {
								$("#btnsubmit").removeClass("loading");
								$('#form_table tr:gt(0)').remove();
								$.alert("抱歉！暂时还没有这个时间断的出勤率哦！")
							} else {
								$('#form_table tr:gt(0)').remove();
								$("#btnsubmit").removeClass("loading");
								table = rep.data;
								var xq = 0;
								var i;
								for (i = 0; i < table.length; i++) {
									var dom = '<tr>' +
										'<td>' + (i + 1) + '</td>' +
										'<td>' + table[i].dep_name + '</td>' +
										'<td>' + parseFloat((table[i].ratio)).toFixed(2) + '%' + '</td>' +
										'</tr>';
									$('#form_table').append($(dom));
									xq = parseFloat(xq) + parseFloat(table[i].ratio);
									console.log(xq);
								}
								var dom = '<tr>' +
									'<td>' + (i + 1) + '</td>' +
									'<td> 全校</td>' +
									'<td>' + (xq / table.length).toFixed(2) + '%' + '</td>' +
									'</tr>';
								$('#form_table').append($(dom));
							}
						}
					});
				}

				function load_time_college() {
					var dep_no = $('#menu_dep >option:selected').val();
					var time_one = $('#date_timepicker_start').val();
					var time_two = $('#date_timepicker_end').val();
					$.ajax({
						url: "do?invoke=TeacherCenter@load_time_college",
						type: 'POST',
						dataType: 'json',
						data: {
							term_no: termno,
							time_one: time_one,
							time_two: time_two,
							dep_no: dep_no
						},
						success: function(rep) {
							if (rep.result == 0) {
								$("#btnsubmit").removeClass("loading");
								$('#form_table tr:gt(0)').remove();
								$.alert("抱歉！暂时还没有这个时间断的出勤率哦！")
							} else {
								$('#form_table tr:gt(0)').remove();
								$("#btnsubmit").removeClass("loading");
								table = rep.data;
								var i;
								for (i = 0; i < table.length; i++) {
									var dom = '<tr>' +
										'<td>' + (i + 1) + '</td>' +
										'<td>' + table[i].class_name + '</td>' +
										'<td>' + parseFloat((table[i].ratio)).toFixed(2) + '%' + '</td>' +
										'</tr>';
									$('#form_table').append($(dom));
								}
							}
						}
					});
				}
			});
		</script>
		<!--这里引用其他JS-->

		</html>