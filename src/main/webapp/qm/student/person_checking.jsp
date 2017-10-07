<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/commonjsp/doctype.jsp"%>
		<html>

		<head>
			<%@ include file="/commonjsp/meta.jsp"%>
				<!--这里引用其他样式-->
				<title>校内教学质量监控运行平台</title>
				<style>

				</style>
		</head>

		<body>
			<%@ include file="/commonjsp/header.jsp"%>
				<div id="container">
					<table class="ui striped table" id="form_table">
						<h3 class="ui left aligned  header"><i class="list layout icon"></i>本学期未到勤情况统计</h3>
						<thead>
							<tr>
								<th><i class="sort numeric ascending icon"></i>编号</th>
								<th><i class="book icon"></i>课程</th>
								<th><i class="user icon"></i>老师</th>
								<th><i class="empty heart icon"></i>状态</th>
								<th><i class="wait icon"></i>周次</th>
							</tr>
						</thead>
						<tbody>
							<div class="ui green large message" id="no_checking">
								<i class="thumbs large inverted yellow up circular icon"></i> 中国好学生，本学期截至目前没有缺勤记录。
							</div>

						</tbody>
					</table>
				</div>
		</body>
		<script>
			$(function() {
				var SYSOBJCET = <%= SYSOBJCET %>;
				var USEROBJECT = <%= USEROBJECT %>;
				//获取所选课程和对应的班级名称，得到相应的班级所有学生的信息
				loadperson_checking();
				$('#no_checking').hide();

				function loadperson_checking() {
					$.ajax({ //获取本班级所有人的信息，只是班级人的姓名和学号
						url: "do?invoke=student_checking_inquire@get_checking_person",
						type: 'POST',
						dataType: 'json',
						data: {
							stu_no: USEROBJECT.loginname, //从系统中获取学生号
							term_no: SYSOBJCET.term_no
						},
						success: function(rep) {
							if (rep.result == 0) {
								$('#no_checking').show();
								$('#form_table').hide();
							} else {
								var person_checking = rep.data;
								console.log(person_checking);
								for (var i = 0; i < person_checking.length; i++) {
									var dom_person = '<tr>' +
										'<td>' + (i + 1) + '</td>' +
										'<td>' + person_checking[i].course_name + '</td>' +
										'<td>' + person_checking[i].teacher_name + '</td>' +
										'<td class="ui red header">' + person_checking[i].check_status + '</td>' +
										'<td>第 ' + person_checking[i].check_week + ' 周</td>' +
										'</tr>';
									$('#form_table').append($(dom_person));
								}
							}
						}
					});
				}
			}); //初始化的括号s
		</script>
		<!--这里引用其他JS-->

		</html>