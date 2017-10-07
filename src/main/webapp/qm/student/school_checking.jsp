<%@page import="com.service.system.SystemStart"%>
<%@page import="com.jhg.common.TypeUtils"%>
<%@ page language="java" import="java.util.* " pageEncoding="UTF-8"%>
	<%@ include file="/commonjsp/doctype.jsp"%>
	<%
	//获取登录名称
	Object curloginname = session.getAttribute("loginname");

	String curuser = "";
	if (curloginname != null) {
		curuser = curloginname.toString();
	}
	com.alibaba.fastjson.JSONObject USEROBJECT = SystemStart
			.getUser(curuser);
	com.alibaba.fastjson.JSONObject SYSOBJCET = SystemStart.getSys();

	String MODULE_ID = request.getParameter("module");
	String MENU_ID = request.getParameter("menu");

	if (MODULE_ID == null) {
		MODULE_ID = "0";
	}
	if (MENU_ID == null) {
		MENU_ID = "";
	}
%>
		<html>

		<head>
			<%@ include file="/commonjsp/meta.jsp"%>
				<script src="http://echarts.baidu.com/build/dist/echarts-all.js"></script>
				<!--这里引用其他样式-->
				<title>校内教学质量监控运行平台</title>
				<style>
				</style>
		</head>

		<body>
				<div id="container">
				
					<div class="ui raised">
						<div class="ui form">
							<div class="fields">
								<div class="field">

									<select class="ui three dropdown" id="menu_term">
									</select>

								</div>
								<div class="field">

									<select class="ui one dropdown" id="menu_college">

									</select>
								</div>
								<div class="  field">
									<select class="ui two dropdown" id="menu_condition">
										<option value="8" selected="selected">预警值(默认为8)</option>
										<option value="1" >预警值:1</option>
										<option value="2" >预警值:2</option>
										<option value="3" >预警值:3</option> 
										<option value="4" >预警值:4</option>
										<option value="5" >预警值:5</option>
										<option value="6" >预警值:6</option>
										<option value="7" >预警值:7</option>
										<option value="9" >预警值:9</option>
										<option value="10" >预警值:10</option>
										<option value="15" >预警值:15</option>
										<option value="20" >预警值:20</option>
										<option value="25" >预警值:25</option>
										<option value="30" >预警值:30</option>
										<option value="50" >预警值:50</option>
									</select>

								</div>

								<div class="field">
									<button class="ui basic button" id="btnsubmit"><i class="search icon"></i><b>查询</b></button>

								</div>
								<div class="field">
									<button class="ui basic button" id="exportBtn_"><i class="download icon"></i><b>导出</b></button>

								</div>

							</div>
						</div>

					</div>

					<table class="ui compact blue table" id="form_table">
						<thead>
							<tr>
								<th>编号</th>
								<th>班级</th>
								<th>学号</th>
								<th>姓名</th>
								<th>旷课</th>
								<th>迟到</th>
								<th>早退</th>
								<th>累计缺勤</th>
								<th>查看详情</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>

					<div id="main" style="height:400px"></div>
				</div>
				
				<div class="ui modal" id="qqxq">
  <i class="close icon"></i>
  <div class="header">
    缺勤详情
  </div>
  <div class="image content">
    <div class="description">
<table class="ui striped blue table" id="form_table_">
						<tdead>
							<tr>
								<td>姓名</td>
								<td>教师</td>
								<td>课程</td>
								<td>旷课</td>
								<td>迟到</td>
								<td>早退</td>
							</tr>
						</tdead>
						<tbody>

						</tbody>
					</table>
    </div>
  </div>
</div>

		</body>
		<script>
			$(function() {
				var SYSOBJCET=<%=SYSOBJCET%>;  
				var USEROBJECT=<%=USEROBJECT%>; 
				var college_no;
				var termno=SYSOBJCET.term_no;  
				loadterm();
				$("#menu_condition").dropdown(); //初始化条件的下拉菜单	
				$("#btnsubmit").click(function() { //点击的时候执行postFormData语句
					if ($(this).hasClass("loading")) return;
					$("#btnsubmit").addClass("loading");
					run($("#menu_condition> option:selected").val());
				});
				function run(value)
				{
					if(college_no==0)
						{
						load_school_checking(parseInt(value));
						}
					else
						{
						load_college_checking(parseInt(value));
						}
				}
				$('#exportBtn_').unbind('click').click(function(){
					var params = [];	
					
					params.push(SYSOBJCET.term_no);
					params.push(termno);
					var type = "excel"; 
					if(college_no==0){
						open(BASE_PATH+"/qm/base/export.jsp?export_id=20&params="+params+"&type="+type+"&more=1");
					}else{
						params.push(college_no); 
						open(BASE_PATH+"/qm/base/export.jsp?export_id=21&params="+params+"&type="+type+"&more=1");
					}
				})
				function loadterm() {//获取所有学期，
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
										$("#menu_term").dropdown({
											onChange: function(value, text) {
												termno=value;
											}
										});
									}
									loadcollege();
								}
							}
						});
					}
				
					//根据学年学期获取老师的课程

				function loadcollege() {
						if(USEROBJECT.userpurview=='ALL'){
							var dom='<option value="0" selected="selected">所有的院系</option>';
							$('#menu_college').append($(dom));
							for (var i = 0; i < (SYSOBJCET.departments).length; i++) { //将学生记录以表格的形式展现出来 
								var dom_college = '<option value="' + SYSOBJCET.departments[i].dep_no + '">' + SYSOBJCET.departments[i].dep_name + '</option>';
								$('#menu_college').append($(dom_college));
							}
							college_no = $("#menu_college > option:selected").val();
							$("#menu_college").dropdown({
								onChange: function(value, text) {
								college_no = value;
								}
							});
							load_school_checking($("#menu_condition> option:selected").val());
						}else{
							var dom='<option value="'+USEROBJECT.userinfo.dep_no+'" selected="selected">'+USEROBJECT.userinfo.dep_name+'</option>';
							$('#menu_college').append($(dom));
							$("#menu_college").dropdown();
							college_no = $("#menu_college > option:selected").val();
							load_college_checking($("#menu_condition> option:selected").val())
						}
				}

				function load_college_checking(value) //value为预警值
					{
						$.ajax({ //根据学期和院系名称调出缺勤的学生
							url: "do?invoke=student_checking_inquire@get_checking_stu_college",
							type: 'POST',
							dataType: 'json',
							data: {
								dep_no_one: college_no,
								term_no_one:SYSOBJCET.term_no ,
								term_no_two: termno
							},
							success: function(rep) {
								if (rep.result == 0) {
									$("#btnsubmit").removeClass("loading");
									$('#form_table tr:gt(0)').remove();
								} else {
									$('#form_table tr:gt(0)').remove();
									$("#btnsubmit").removeClass("loading");
									tablecollege = rep.data;
									var numble = 1;
									$('#form_table tr:gt(0)').remove();
									for (var i = 0; i < tablecollege.length; i++) {
										if (tablecollege[i].zh >= parseInt(value)) {
											var dom_stu = '<tr>' +
												'<td>' + numble + '</td>' +
												'<td>' + tablecollege[i].class_name + '</td>' +
												'<td>' + tablecollege[i].stu_no + '</td>' +
												'<td>' + tablecollege[i].stu_name + '</td>' +
												'<td>' + tablecollege[i].kk + '</td>' +
												'<td>' + tablecollege[i].cd + '</td>' +
												'<td>' + tablecollege[i].zt + '</td>' +
												'<td>' + tablecollege[i].zh + '</td>' +
												'<td>' +
												'<div class="look circular mini ui teal basic icon button" stu_no="' + tablecollege[i].stu_no + '">' +
												'<i class="search teal large icon"></i>' +
												'</div>' +
												'</td>' +
												'</tr>';
											$('#form_table').append($(dom_stu));
											numble++;
										}
									}
									$('.look').popup();
									$('.look').click(function(){
										var stu_no=$(this).attr("stu_no");
										loadxqjl(stu_no,termno);
										$('#qqxq').modal({
											blurring: true
										}).modal({
											transition: 'vertical flip',
											observeChanges: true,
											closable: false
										})
										.modal('show');
										
									});
								}
							}
						});
					}
				function load_school_checking(value) //获得学校所有的有缺勤的学生
					{
						$.ajax({
							url: "do?invoke=student_checking_inquire@get_checking_stu_school",
							type: 'POST',
							dataType: 'json',
							data: {
								term_no_one:SYSOBJCET.term_no ,
								term_no_two: termno
							},
							success: function(rep) {
								if (rep.result == 0) {
									$("#btnsubmit").removeClass("loading");
									$('#form_table tr:gt(0)').remove();
								} else {
									$("#btnsubmit").removeClass("loading");
									$('#form_table tr:gt(0)').remove();
									tableschool = rep.data;
									var numble = 1;
									for (var i = 0; i < tableschool.length; i++) {
										if (parseInt(tableschool[i].zh) >= parseInt(value)) {
											var dom_stu = '<tr>' +
												'<td>' + numble + '</td>' +
												'<td>' + tableschool[i].class_name + '</td>' +
												'<td>' + tableschool[i].stu_no + '</td>' +
												'<td>' + tableschool[i].stu_name + '</td>' +
												'<td>' + tableschool[i].kk + '</td>' +
												'<td>' + tableschool[i].cd + '</td>' +
												'<td>' + tableschool[i].zt+ '</td>' +
												'<td>' + tableschool[i].zh + '</td>' +
												'<td>' +
												'<div class="look circular mini ui teal basic icon button" stu_no="' + tableschool[i].stu_no + '">' +
												'<i class="search teal large icon"></i>' +
												'</div>' +
												'</td>' +
												'</tr>';
											$('#form_table').append($(dom_stu));
											numble++;
										}
									}
									$('.look').popup();
									$('.look').click(function(){
										var stu_no=$(this).attr("stu_no");
										loadxqjl(stu_no,termno);
										$('#qqxq').modal({
											blurring: true
										}).modal({
											transition: 'vertical flip',
											observeChanges: true,
											closable: false
										})
										.modal('show');
									});
								}
							}
						});
					}
				
				function loadxqjl(stu_no,termno) //获得学校所有的有缺勤的学生
				{
					console.log(termno)
					$.ajax({ //根据学期和院系名称调出缺勤的学生
						url: "do?invoke=student_checking_inquire@loadxqjl",
						type: 'POST',
						dataType: 'json',
						data: {
							stu_no: stu_no,
							term_no: termno
						},
						success: function(rep) {
							if (rep.result == 0) {
								$('#form_table_ tr:gt(0)').remove();
								console.log(rep)
							} else {
								$('#form_table_ tr:gt(0)').remove();
								table = rep.data;
								console.log(rep)
								for (var i = 0; i < table.length; i++) {
										var dom_stu = '<tr>' +
											'<td>' + table[i].stu_name + '</td>' +
											'<td>' + table[i].teacher_name + '</td>' +
											'<td>' + table[i].course_name + '</td>' +
											'<td>' + table[i].kk + '</td>' +
											'<td>' + table[i].cd+ '</td>' +
											'<td>' + table[i].zt + '</td>' +
											'</tr>';
										$('#form_table_').append($(dom_stu));
								}
							}
						}
					});
				}
				
			}); //初始化的括号
		</script>
		<!--这里引用其他JS-->

		</html>