<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>
<%@ include file="/commonjsp/dtgridtable.jsp"%>
<link rel="stylesheet" href="resource/css/main.css" />
<script src="script/common/datepicker/jquery.datetimepicker.js"
	type="text/javascript"></script>
<link rel="stylesheet"
	href="script/common/datepicker/jquery.datetimepicker.css" /> 
<!--这里引用其他样式-->
<title>添加学年学期</title>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<!--这里绘制页面-->
	<div id="container" class="ui container">
				<form class="ui form segment" method="post" enctype="multi-part/form-data" id="addBaseTeamForm">
					<p>添加学年学期</p>
					<div class="three fields">
						<div id="divTermNo" class="field required ">
							<label class="ui pointing  ">学年学期编号</label> <input
								placeholder="请输入学年学期编号" name="term_no" type="text" />
						</div>
						<div id="divTermName" class="field required">
							<label>学年学期名称</label> <input placeholder="请输入学年学期名称"
								name="term_name" type="text" />
						</div>
						<div id="divTermPrintName" class="field required">
							<label>学年学期打印名称</label> <input placeholder="请输入学年学期打印名称"
								name="term_print_name" type="text" />
						</div>
					</div>
					<div class="two fields">
						<div class="field required ">
							<label class="ui pointing">学期开始日期</label>
							<div class="ui icon input" id="divTermStartDate">
								<input type="text" placeholder="20XX-XX-XX"
									name="term_startdate" id="term_startdate"><i
									class="edit"></i>
							</div>
						</div>
						<div class="date field required" id="divTermEndDate">
							<label>学期结束日期</label> <input placeholder="20XX-XX-XX"
								name="term_enddate" type="text" id="term_enddate" />
						</div>
					</div>
					<div class="two fields">
						<div id="" class="field required">
							<label>学生信息</label> <input placeholder="请选择学生文件"
								name="term_stu_file" type="file" />
						</div>
						<div class="field">
							<a class="ui green small button"><i
								class=" download basic icon"></i>导出学生模板</a>
						</div>
					</div>
					
					<div class="two fields">
						<div id="" class="field required">
							<label>课程信息</label> <input placeholder="请选择课程文件"
								name="term_stu_file" type="file" />
						</div>
						<div class="field">
							<a class="ui green small button"><i
								class=" download basic icon"></i>导出课程模板</a>
						</div>
					</div>

					<div class="ui blue submit button" id="submitBtn">保存</div>
				</form>
			</div>
</body>
<script>
	$('#term_startdate').datetimepicker(
			{
				lang : 'ch',
				format : 'Y-m-d',
				formatDate : 'Y-m-d',
				onShow : function(ct) {
					this.setOptions({
						maxDate : $('#term_enddate').val() ? $('#term_enddate')
								.val() : false
					})
				},
				timepicker : false
			});
	$('#term_enddate').datetimepicker(
			{
				lang : 'ch',
				format : 'Y-m-d',
				formatDate : 'Y-m-d',
				onShow : function(ct) {
					this.setOptions({
						minDate : $('#term_startdate').val() ? $(
								'#term_startdate').val() : false
					})
				},
				timepicker : false
			});
</script>
<script type="text/javascript">
	$("#submitBtn").click(function() {
	});

</script>
<!--这里引用其他JS-->
</html>