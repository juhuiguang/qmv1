<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>
<%@ include file="/commonjsp/jgxgridtable.jsp"%>
<!--这里引用其他样式-->
<title>学年学期管理</title>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<!--这里绘制页面-->
	<div id="container" class="ui container">
		<div class="ui  header">
			<h2 style="margin-left: 10px; margin-top: 10px; color: #626F82">学年学期管理</h2>
			<div class="sub header" style="margin-left: 14px; margin-top: 5px">学年学期管理，您可对学年学期信息进行添加、修改、删除、设置等操作</div>
		</div>
		<div id="container_function" style="margin: 10px; padding: 10px">
			<div class="ui grid">
				<div class="ui left aligned left floated eight wide column search">
					<div class="ui teal button addAward" id="addBtn">
						<i class="inverted add square icon"></i> 新建
					</div>
					<div class="ui blue button export" id="editBtn">
						<i class="inverted edit icon"></i> 编辑
					</div>
					<div class="ui red button export" id="excelExport">
						<i class="inverted download icon"></i> 导出
					</div>
				</div>


			</div>


		</div>
		<ul id="tableinfo">
			<li>
				<div class="ui container">
					<div id="jqxgrid" style="margin-top: 10px;"></div>
				</div>
			</li>
		</ul>
	</div>



</body>
<script>
	$(function() {
		loadingTable();
		//initTable();
		function loadingTable() {
			$.ajax({
				url : "do?invoke=baseTeamAction@queryBaseTeam",
				type : 'POST',
				dataType : 'json',
				success : function(rep) {
					if (rep.result == 0) {
						$.alert("", rep.message);
					} else {
						initJqxGridTable(rep.data);
					}
				}
			});
			function initJqxGridTable(dataJson) {
				//事件ID名称
				var idName = "jqxgrid";
				//表格标题列
				var columns = [
						{
							text : '学年学期编号',
							datafield : 'term_no',
							width : 150,
							cellsalign : 'center',
							align : 'center'
						},
						{
							text : '学年学期名称',
							datafield : 'term_name',
							width : 150,
							cellsalign : 'center',
							align : 'center'
						},
						{
							text : '学年学期打印名称',
							datafield : 'term_print_name',
							width : 150,
							cellsalign : 'center',
							align : 'center'
						},
						{
							text : '学期开始日期',
							datafield : 'term_startdate',
							width : 150,
							cellsalign : 'center',
							align : 'center'
						},
						{
							text : '学期结束日期',
							datafield : 'term_enddate',
							width : 150,
							cellsalign : 'center',
							align : 'center'
						},
						{
							text : '学期状态',
							datafield : 'term_status',
							width : 150,
							cellsalign : 'center',
							align : 'center',
							cellsrenderer : function(row, columnfield, value,
									defaulthtml, columnproperties) {
								var status = '<div style="padding-bottom: 2px; text-align: center; margin-top: 9.5px; color:#3c763d;">关闭</div>';
								if (value == 1) {
									status = '<div style="padding-bottom: 2px; text-align: center; margin-top: 9.5px; color:#cd2929;">开通</div>'
								}
								return status;
							}
						},
						{
							text : '学期新生数据状态',
							datafield : 'term_student',
							width : 150,
							cellsalign : 'center',
							align : 'center',
							cellsrenderer : function(row, columnfield, value,
									defaulthtml, columnproperties) {
								var status = '<div style="padding-bottom: 2px; text-align: center; margin-top: 9.5px;"><i class="large basic grey checkmark icon"></i></div>';
								if (value == 1) {
									status = '<div style="padding-bottom: 2px; text-align: center; margin-top: 9.5px;"><i class="large green checkmark icon"></div>'
								}
								return status;
							}
						},
						{
							text : '学期新班级数据状态',
							datafield : 'term_class',
							width : 150,
							cellsalign : 'center',
							align : 'center',
							cellsrenderer : function(row, columnfield, value,
									defaulthtml, columnproperties) {
								var status = '<div style="padding-bottom: 2px; text-align: center; margin-top: 9.5px;"><i class="large basic grey checkmark icon"></i></div>';
								if (value == 1) {
									status = '<div style="padding-bottom: 2px; text-align: center; margin-top: 9.5px;"><i class="large green checkmark icon"></div>'
								}
								return status;
							}
						},
						{
							text : '学期新课程数据状态',
							datafield : 'term_course',
							width : 150,
							cellsalign : 'center',
							align : 'center',
							cellsrenderer : function(row, columnfield, value,
									defaulthtml, columnproperties) {
								var status = '<div style="padding-bottom: 2px; text-align: center; margin-top: 9.5px;"><i class="large basic grey checkmark icon"></i></div>';
								if (value == 1) {
									status = '<div style="padding-bottom: 2px; text-align: center; margin-top: 9.5px;"><i class="large green checkmark icon"></div>'
								}
								return status;
							}
						},
						{
							text : '学期学生评教开关',
							datafield : 'term_pj',
							width : 150,
							cellsalign : 'center',
							align : 'center',
							cellsrenderer : function(row, columnfield, value,
									defaulthtml, columnproperties) {
								var status = '<div style="padding-bottom: 2px; text-align: center; margin-top: 9.5px;"><i class="large basic grey checkmark icon"></i></div>';
								if (value == 1) {
									status = '<div style="padding-bottom: 2px; text-align: center; margin-top: 9.5px;"><i class="large green checkmark icon"></div>'
								}
								return status;
							}
						},
						{
							text : '学期教学质量考核开关 ',
							datafield : 'term_kh',
							width : 150,
							cellsalign : 'center',
							align : 'center',
							cellsrenderer : function(row, columnfield, value,
									defaulthtml, columnproperties) {
								var status = '<div style="padding-bottom: 2px; text-align: center; margin-top: 9.5px;"><i class="large basic grey checkmark icon"></i></div>';
								if (value == 1) {
									status = '<div style="padding-bottom: 2px; text-align: center; margin-top: 9.5px;"><i class="large green checkmark icon"></div>'
								}
								return status;
							}
						} ];
				var source = {
					localdata : dataJson,
					datafields : [ {
						name : 'term_no',
						type : 'string'
					}, {
						name : 'term_name',
						type : 'string'
					}, {
						name : 'term_print_name',
						type : 'string'
					}, {
						name : 'term_startdate',
						type : 'string'
					}, {
						name : 'term_enddate',
						type : 'string'
					}, {
						name : 'term_status',
						type : 'string'
					}, {
						name : 'term_student',
						type : 'string'
					}, {
						name : 'term_class',
						type : 'string'
					}, {
						name : 'term_course',
						type : 'string'
					}, {
						name : 'term_pj',
						type : 'string'
					}, {
						name : 'term_kh',
						type : 'string'
					} ],
					datatype : "json",
					url : 'do?invoke=baseTeamAction@queryBaseTeam',
					type : 'POST',
					async : false,
				};
				bindTableData(idName, source, columns);
			}

			function bindTableData(idName, source, columns) {
				var dataAdapter = new $.jqx.dataAdapter(source);
				// 初始化 jqxGrid
				$("#" + idName).jqxGrid({
					theme : 'metro', //表格样式
					width : '100%',//单元格宽度
					pagerheight : 35,//分页高度
					columnsheight : 35,//列高度
					rowsheight : 35,//行高度
					//columnsresize : true,
					//showtoolbar: true,//显示工具栏
					//autorowheight : true,//自动宽度
					//autoheight : true,//完整显示所有内容
					//altrows : true,//行间底色区分
					//sortable: true,//排序
					//filterable : true,//
					//scrollmode: 'deferred'//增对大数据量 延迟滚动
					//sortable : true,//设置可排序  
					pageable : true,//设置可分页  
					pagesize : 10,//设置默认页数 
					pagesizeoptions : [ '10', '20', '50', '100' ],//设置分页数  
					//columnsresize : true,//列可适应调整 
					//clipboard : false,//屏蔽jqx的复制功能  
					//enablebrowserselection : true,//允许使用浏览器选择内容功能 
					//editable: true ,//编辑
					source : dataAdapter,//数据源
					//selectionmode : 'checkbox', //选择模式
					columns : columns
				//列字段
				});
			}
		}

	});
</script>
<script type="text/javascript">
	$("#addBtn").click(function() {
		var tableName = "学年学期数据表";
		//$('.ui.modal').modal('attach events', '#addBtn', 'show');
		location.href = 'qm/base/base_term_add.jsp';
	});
	$("#editBtn").click(function() {
		alert("确定");
	});
	$("#excelExport").click(function() {
		$("#jqxgrid").jqxGrid('exportdata', 'xls', tableName);
	});
</script>
<!--这里引用其他JS-->
</html>