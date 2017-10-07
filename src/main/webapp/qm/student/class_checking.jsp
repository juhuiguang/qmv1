<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/commonjsp/doctype.jsp"%>
		<html>

		<head>
			<%@ include file="/commonjsp/meta.jsp"%>
				<!--这里引用其他样式-->
				<title>校内教学质量监控运行平台</title>
				<style>
.ui.form .field>.selection.dropdown {
    width: 80%;
}
				</style>
		</head>

		<body>
			<%@ include file="/commonjsp/header.jsp"%>
				<div id="container">
					<h3 class="ui header">
								<i class="list layout icon"></i>
                               <div class="content">班级出勤查询 </div>
                               </h3>
					<div class="ui raised " id="class_checking">
						<div class="ui form">
							<div class="fields">
								<div class="field">

									<select class="ui three dropdown" id="menu_term">
									</select>

								</div>
								<div class="  five wide field">

									<select class="ui one dropdown" id="menu_class">

									</select>
								</div>
								<div class="  field" style="margin-left: -50px;">
									<select class="ui two dropdown" id="menu_condition">
										<option value="2" selected="selected">所有的记录</option>
										<!-- <option value="1">有缺勤记录</option> -->
									</select>

								</div>
								<div class="field">
									<button class="ui small basic button" id="btnsubmit"><i class="large search icon"></i><b>查&nbsp;询</b></button>
								</div>
								<button class="ui basic button" style="position:absolute;left:88%;"  id="export_dc" data-content="点击导出" data-variation="small"><i class="upload icon"></i> 导 出 </button>			
							</div>      
						</div>

					</div>

					<table class="ui compact blue table" >
						<thead>
							<tr>
								<th>学号</th>
								<th>姓名</th>
								<th>请假</th>
								<th>迟到</th>
								<th>旷课</th>
								<th>早退</th>
								<th>未到勤</th>
								<th>查看详情</th>
							</tr>
						</thead>
						<tbody id="form_table">
							<div class="ui green large message" id="no_checking">
								<i class="thumbs large inverted yellow up circular icon"></i> 本课程表现良好，无人有缺勤记录！
							</div>
						</tbody>
						</table>
						<div class="ui green large message" id="bzr">
							<i class="frown large inverted yellow circular icon"></i> 抱歉！您不是班主任哦，暂不能使用此功能！
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
				var SYSOBJCET = <%= SYSOBJCET %>;
				var USEROBJECT = <%= USEROBJECT %>;
				var currentweek = SYSOBJCET.currentweek;
				var termno = SYSOBJCET.term_no;
				var coursename=""; //获取所选课程名称
				var classname=""; //获取所选班级名称	
				var classno=""; //获取所选班级编号	
				var flag = "";//获得班级课程下拉框“所有记录”的 value 值    
				loadterm();
				$('#no_checking').hide();
				$('#bzr').hide();
				$("#menu_condition").dropdown(); //初始化条件的下拉菜单
				$("#btnsubmit").click(function() { //点击的时候执行postFormData语句
					if ($(this).hasClass("loading")) return;
					$("#btnsubmit").addClass("loading");
					run($("#menu_condition").val());
				});

				function run(value) {
					if (value == 2) {
						loadstu_all();
					}
					if (value == 1) {
						$("#form_table").find('tr').hide();
						$("#form_table").find('tr[zh!=0]').show();
						$("#btnsubmit").removeClass("loading");
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
								var term_table = rep.data; //所获取的数据库的资源
								for (var i = term_table.length - 1; i >= 0; i--) { //将学生记录以表格的形式展现出来	
									if (i == term_table.length - 1) {
										var dom_term = '<option  selected="selected" value="' + term_table[i].term_no + '">' + term_table[i].term_name + '</option>';
										$('#menu_term').append($(dom_term));
									} else {
										var dom_term = '<option value="' + term_table[i].term_no + '">' + term_table[i].term_name + '</option>';
										$('#menu_term').append($(dom_term));
									}
								}
								loadclass($("#menu_term >option:selected").val());
								$("#menu_term").dropdown({
									onChange: function(value, text) {
										termno = value;
										loadclass();
									}
								});
							}
						}
					});
				}
				//根据学年学期获取老师的课程
				function loadclass() {
					$.ajax({
						url: "do?invoke=student_checking_inquire@get_checking_classcenter",
						type: 'POST',
						dataType: 'json',
						data: {
							teacher_no: USEROBJECT.loginname,
							term_no: termno
						},
						success: function(rep) {
							console.log(rep);
							if (rep.result == 0) {
								$('#menu_class').find("option").remove();
								$('#bzr').show();
								$('#class_checking').hide();
								$('#form_table').hide();
							} else {
								$('#menu_class').find("option").remove();
								$('#form_table tr:gt(0)').remove();
								var table_class = rep.data; //所获取的数据库的资源
								$('#menu_class').append($('<option selected="selected" value="ALL"> 所有记录 </option>'));
								for (var i = 0; i < table_class.length; i++) { //将学生记录以表格的形式展现出来 
									if (i == 0) {
										var dom_class = '<option  value="'+i+'">' + table_class[i].course_name + '-' + table_class[i].class_name + '</option>';
										$('#menu_class').append($(dom_class));
									} else {
										var dom_class = '<option value="'+i+'">' + table_class[i].course_name + '-' + table_class[i].class_name + '</option>';
										$('#menu_class').append($(dom_class));
									}
								}
								classname = table_class[0].class_name;
								classno  = table_class[0].class_no;
								loadstu_all();
								$("#menu_class").dropdown({
									onChange: function(value, text) {
										data = text.split("-"); //分割字符串
										coursename = data[0]; //所选课程名称
										classname = data[1];
									}
								});
								
							}
						}
					});
				}

				//导出功能
		    	$("#export_dc").unbind('click').click(function(){
					var params = [];			
					params.push(classno);
					params.push(termno);
					params.push(currentweek);
					console.log(classno);
					var type = "excel";   
					open(BASE_PATH+"/qm/base/export.jsp?export_id=10&params="+params+"&type="+type+"&more=1");			    
		    	});
				
				
				//获取所选课程和对应的班级名称，得到相应的班级所有学生的信息   ok
				function loadstu_all() {
					flag=$('#menu_class > option:selected').val();//函数正确
					$.ajax({ //获取本班级所有人的信息的缺勤信息
						url: "do?invoke=student_checking_inquire@get_classes_checking",
						type: 'POST',
						dataType: 'json',
						data: {
							class_name_one: classname, 
							class_name_two: classname,
							course_name: coursename,
							term_no: termno,
							selected:flag
						},
						success: function(rep) {
								$("#btnsubmit").removeClass("loading");
								$('#form_table').find('tr').remove();
								$('#no_checking').hide();
								$('#form_table thead').show();
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
										dom_stu+='<td>';
										if (tablestu[i].zh != 0) {
											dom_stu += '<div class="lookstu circular mini ui teal basic icon button" stu_name="'+tablestu[i].stu_name+'" stu_no="' + tablestu[i].stu_no + '">' +
												'<i class=" search teal large icon"></i>';
										} else {
											dom_stu += '<div class="nocheck circular mini ui green basic icon button" data-content="无缺勤">' +
												'<i class=" checkmark green large icon"></i>';
										}
										dom_stu+='</td>';
										dom_stu+='</tr>';
									$('#form_table').append($(dom_stu));
								}
								$('.nocheck').popup();
								$('.lookstu').click(function() {
									$('#form_table_gr tr:gt(0)').remove();
									$('#grxq').modal({
										transition: 'vertical flip',
										observeChanges: true,
										allowMultiple:true,
									}).modal('show');
									var stu_no = $(this).attr("stu_no");
									var stu_name = $(this).attr("stu_name");
									loadperson_checking(termno, stu_no, stu_name);
								});
						}
					});
				}
				
				function loadperson_checking(term_no, stu_no, stu_name) {
					var starttime="";
					var endtime="";
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
			}); //初始化的括号
		</script>
		<!--这里引用其他JS-->

		</html>