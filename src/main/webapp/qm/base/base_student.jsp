<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>
<%@ include file="/commonjsp/jgxgridtable.jsp"%>
<script src="script/common/datepicker/jquery.datetimepicker.js"
	type="text/javascript"></script>
<link rel="stylesheet" 
	href="script/common/datepicker/jquery.datetimepicker.css" />
<link rel="stylesheet" href="script/common/uploadify/uploadify.css "
	type=" text/css" />
<script src="script/common/uploadify/swfobject.js"
	type="text/javascript"></script>

<script src="script/common/uploadify/jquery.uploadify.min.js"
	type="text/javascript"></script>
<script src="script/common/jhg/json2.js" type="text/javascript"></script>
<script src="qm/js/baseStudent.js" type="text/javascript"></script>
<!--这里引用其他样式-->
<title>校内教学质量监控运行平台</title>
<style>
#depdiv .label {
	margin-bottom: 10px;
}

#importdetail {
	margin: 0px auto;
	text-align: center; /* 文字居中 */
	font-size: 30px; /* 文字大小 */
}

#dropdown {
	height: auto;
}

.ui.input.circulari.basic.icon {
	width: auto
}
</style>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<!--这里绘制页面-->
	<div id="container">
		<!-- 标题 -->
		<div class="ui  header">
			<h3 class="ui header" id='tittle'>
				<i class="tasks icon"></i>
				<div class="content">学生管理</div>
			</h3>
			<!-- 			<div class="sub header" style="margin-left: 14px; margin-top: 5px">课程管理，您可对课程信息进行添加、修改、删除、设置等操作</div> -->
		</div>
		<!-- 标题 -->
		<!-- 功能模块 -->
		<div class="ui raised">
			<div class="ui form">
				<div id="depdiv">
					<a class="ui blue label" id="all">全&nbsp;&nbsp;&nbsp;&nbsp;部</a> <a
						class="dep ui gray label" id="2241">能源与电气工程学院</a>
				</div>
				<div id="container_function" style="margin-top: 10px;">
					<div class="container center aligned segmentsinput"
						id="segmentsinput"></div>
					<div class="fields">
						<div class="field" style="float: left;">
							<select class="ui mini get_termyear_select" 
								id="get_termyear_select">
							</select>
						</div> 
						<div class="field" style="float: left">
							<div style="width: 220px" class="ui input circulari  basic icon "
								data-content="输入学生姓名">
								<input id="search_like_data" type="text" placeholder="输入学生姓名...">
							</div>
						</div>

						<div class="field"  style="float: left;"> 
							<div class="ui circulari olive icon button" id="searchbutton">
								<i class="search icon"></i>搜索
							</div>
						</div>
						<div class="field" style="float: right!important">
							<div class="ui input circulari  basic icon "
								data-content="导入当年学年学期的学生" style="float: right">
								<div class="ui small teal  button addAward" id="importBtn">
									<i class="paw icon"></i> 导入
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>


		</div>
		<!-- 功能模块 -->

		<div class="ui modal" id="newBaseTermModal">
			<i class="close icon"></i>
			<div class="header" id="statustitle">编辑学生</div>
			<div class="content">
				<form class="ui form addBaseStuForm" id="addBaseStuForm">
					<div class="three fields">
						<div id="divAddStuNo" class="field required">
							<label>学号</label> <input placeholder="请输入学号" name="add_stuno"
								type="text" id="addstuno" />
						</div>
						<div id="divAddStuName" class="field required">
							<label>姓名</label> <input placeholder="请输入姓名" name="add_stuname"
								type="text" id="addstuname" />
						</div>
						<div id="divAddStuBir" class="field required">
							<label>生日</label> <input placeholder="请输入生日" name="add_stubir"
								type="text" id="addstubir" />
						</div>
					</div>
					<div class="three fields">
						<div id="divAddStuPhone" class="field required">
							<label>手机号码</label> <input placeholder="请输入手机号码"
								name="add_stuphone" type="text" id="addstuphone" />
						</div>
						<div id="divAddStuMajor" class="field required ">
							<label class="ui pointing  ">所属专业</label> <select
								class="ui mini addmajor" id="addmajor">
							</select>
						</div>

						<div class="field required" id="divAddStuYear">
							<label>入学年份</label> <input placeholder="请输入入学年份"
								name="add_stuyear" type="text" id="addstuyear" />
						</div>
					</div>
					<div id="newusererror" class="ui error message">
						<div class="header">错误提示</div>
						<p></p>
					</div>
				</form>
			</div>
			<div class="actions">
				<div class="ui black deny button" id="termCancelModal">取消</div>
				<div class="ui red right labeled icon button" id="stuSaveModal">
					保存 <i class="checkmark icon"></i>
				</div>
			</div>
		</div>

		<div class="ui modal" id="importExcelModal">
			<i class="close icon"></i>
			<div class="header" id="statusExcelTitle">导入学生数据</div>
			<div class="content">
				<form class="ui form addBaseTeamForm" id="addBaseTeamForm">
					<div class="three fields">
						<div id="divTermNo" class="field">
							<label class="ui pointing">学年学期编号</label> <select
								class="ui mini dropdownImport" id="dropdownImport">
							</select>
						</div>
						<div class="one field">
							<label>导入新生数据</label>
							<div class="ui left icon input" style="margin-top: 5px">
								<input type="file" name="stuuploadify" id="stuuploadify" />
							</div>

						</div>
						<div class="field">
							<label>模板下载</label> <a
								class="ui red small labeled icon add button"
								href="template/student.xls"><i class="download icon"></i>导入学生模板</a>
						</div>

					</div>
					<div
						class="ui two column middle aligned very relaxed stackable grid">
						<div class="column">
							<div class="ui">
								<div class="fields"></div>
								<div class="field required">
									<div id="fileQueue"></div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="actions">
				<div class="ui black deny button" id="termCancelModal">取消</div>
				<div class="ui red right labeled icon button"
					id="excelImportSaveModal">
					导入 <i class="checkmark icon"></i>
				</div>
			</div>
		</div>


		<div class="ui modal" id="exportExcelModal">
			<i class="close icon"></i>
			<div class="header" id="statusExcelTitle">导出学生数据</div>
			<div class="content">
				<form class="ui form addBaseTeamForm" id="addBaseTeamForm">
					<div class="three fields">
						<div id="divTermNo" class="field">
							<label class="ui pointing">学年学期编号</label> <select
								class="ui mini dropdownExport" id="dropdownExport">
							</select>
						</div>
					</div>
				</form>
			</div>
			<div class="actions">
				<div class="ui black deny button" id="termCancelModal">取消</div>
				<div class="ui red right labeled icon button"
					id="excelExportSaveModal">
					导出 <i class="checkmark icon"></i>
				</div>
			</div>
		</div>

		<div class="ui modal" id="exportDetailModal">
			<i class="close icon"></i>
			<div class="header" id="statusExcelTitle">导入详情</div>
			<div class="content">
				<p id="importdetail">
					共计导入数据<a class="ui large blue circular label" id="detailSum">0</a>
					个,成功<a class="ui large green circular label" id="detailSuccessSum">0</a>个，失败<a
						class="ui large red circular label" id="detailErrorSum">0</a>个
				</p>
			</div>
			<div class="actions">
				<div class="ui black deny button" id="termCancelModal">取消</div>
				<div class="ui red right labeled icon button">
					确定 <i class="checkmark icon"></i>
				</div>
			</div>
		</div>

		<table class="ui celled center very compact blue striped table"
			id="tablehead">
			<thead>
				<tr class="center aligned">
					<th>学号</th>
					<th>姓名</th>
					<th>手机号</th>
					<th>专业</th>
					<th>年级</th>
					<th>班级</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody id="tablepane" class="center aligned">
			</tbody>
		</table>
		<center>
			<div id="spanbutton">

				<div class="ui  horizontal divided list">
					<div class="item">
						<a href="javascript:void(0);" id="spanFirst" page="1">第一页</a>
					</div>
					<div class="item">
						<a href="javascript:void(0);" id="spanPre" page="1">上一页</a>
					</div>
					<div class="item">
						<a href="javascript:void(0);" id="spanNext" page="2">下一页</a>
					</div>
					<div class="item">
						<a href="javascript:void(0);" id="spanLast">最后一页</a>
					</div>
					<div class="item">
						第<span id="spanPageNum"></span>页 /共<span id="spanTotalPage"></span>页
					</div>

				</div>
			</div>
		</center>

	</div>
</body>
<script type="text/javascript">
	$('.ui.input.circulari.basic.icon').popup();
	var temp_dep_no = "all";
	var temp_dep_name = '全部';
	var totalpage;
	var pageindex = 1;
	var temppage = 1;
	var pagelength = 15;
	var temp_major_no = "";
	var temp_major_name = "";
	var studentFilePath = "";
	var temp_term_no = "";
	var temp_year = "";
	var userpurview = USEROBJECT.userpurview; 
	console.log("权限：" + userpurview);
	if(userpurview == null){ 
		$('#container').empty();
		 var dom='<div class="ui green large message" id="messageinf">'+
			'<i class="announcement large inverted yellow up circular icon"></i>'+
				'您没有此功能权限！'+     
			'</div>';  

			$('#container').append($(dom));
	} 
	if(!(userpurview.trim() == "ALL")){ 
		temp_dep_no = userpurview;  
	}
	getCurrentDep(SYSOBJECT.departments);
	getCurrentTermYear();
	
	
	// 获取当前所有的学年(2015/2014)
	function getCurrentTermYear() {
		$("#get_termyear_select").empty();
		$.ajax({
			url : "do?invoke=baseStudentAction@getStuYear",
			type : 'POST',
			dataType : 'json',
			success : function(rep) {
				if (rep.result == 0) {
					$.alert("", rep.message);
					return;
				} else {
					var temp = rep.data
					for (var i = 0; i < temp.length; i++) {
						var dom = ' <option value="' + temp[i].stu_year + '">'
								+ temp[i].stu_year + '年</option>';
						$("#get_termyear_select").append(dom)
					}
					$('.ui.get_termyear_select').dropdown();
					if ($("#get_termyear_select option").length > 0) {
						console.log("缺省选中项："
								+ $("#get_termyear_select").get(0).options[0].selected);
						//$("#dep_no_select").get(0).options[0].selected = true;
					}
					temp_year = $("#get_termyear_select").val();
					console.log("js获取的年份："+ temp_year);
					loadingTable();
				}

				$("#get_termyear_select").change(function() {
					// 判断当前的学年学期是否存在
					temp_year = $("#get_termyear_select").val();
					pageindex = 1;
					temppage = 1;
					loadingTable();

				});
			}
		});
		//year = 	$("#get_termyear_select").val();
		//console.log("获取的年份："+ year);
	}
	
	// 切换所属部门
	$("#addmajor").change(function() {
		temp_major_no = $("#addmajor").val();
		temp_major_name = $("#addmajor").find("option:selected").text();
		console.log("选中专业号：" + temp_major_no);
		console.log("选中专业名称：" + temp_major_name);
	});
	
	// 获取表格数据
	function loadingTable() {
		$('#tablepane').html("");
		$("#spanFirst").attr("temp", '0');
		$("#spanNext").attr("temp", '0');
		$("#spanPre").attr("temp", '0');
		$("#spanLast").attr("temp", '0');
		$
				.ajax({
					url : "do?invoke=baseStudentAction@getBaseStudentList",
					type : 'POST',
					dataType : 'json',
					data : {
						pageindex : pageindex,
						pageLength : pagelength,
						year : temp_year,
						temppage : temppage,
						temp_dep_no : temp_dep_no
					},
					success : function(rep) {
						if (rep.result == 0) {
							$.alert(rep.message);
							return;
						}
						if (rep.total == 0) {
							$("#spanbutton").hide();
							$('#tablehead').hide();
							$('#message').remove();
							var dom = '<div class="ui green large message" id="message">'
									+ '<i class="frown large inverted yellow circular icon"></i> 暂无相关学生数据！'
									+ '</div>';
							$('#container').append(dom);
						} else {
							$("#spanbutton").show();
							$('#tablehead').show();
							$('#message').remove();
							if (temppage == 1) {
								var count = 0;
								if (rep.total % pagelength != 0)
									count = 1;
								totalpage = parseInt(rep.total / 8) + count;
								$("#spanLast").attr("page", totalpage);
								$("#spanTotalPage").text(totalpage)
							}
							temppage++;
							initTableBody(rep.rows);
						}

					}

				});
	}
	
	// 分页功能
	$("#spanFirst").bind("click", function() {
		if (pageindex == 1)
			return;
		if (totalpage > 1)
			if ($(this).attr('temp') == 1) {
				$("#tablepane").html("");
				pageindex = 1;
				searchtable();
			} else {
				$("#tablepane").html("");
				pageindex = 1;
				loadingTable();
			}
	});
	$("#spanLast").bind("click", function() {
		if (pageindex == totalpage)
			return;
		if (totalpage > 1) {
			if ($(this).attr('temp') == 1) {
				$("#tablepane").html("");
				pageindex = totalpage;
				searchtable();
			} else {
				$("#tablepane").html("");
				pageindex = totalpage;
				loadingTable();
			}
		}
	});
	$("#spanNext").bind("click", function() {
		if (pageindex == totalpage)
			return;
		if (totalpage > 1) {
			if ($(this).attr('temp') == 1) {
				$("#tablepane").html("");
				pageindex++;
				searchtable();
			} else {
				$("#tablepane").html("");
				pageindex++;
				loadingTable();
			}
		}
	});
	$("#spanPre").bind("click", function() {
		if (pageindex == 1)
			return;
		if (totalpage > 1) {
			if ($(this).attr('temp') == 1) {
				$("#tablepane").html("");
				pageindex--;
				searchtable();
			} else {
				$("#tablepane").html("");
				pageindex--;
				loadingTable();
			}
		}
	});

	$('#addstubir').datetimepicker({
		lang : 'ch',
		format : 'Y-m-d',
		formatDate : 'Y-m-d',
		onShow : function(ct) {
			this.setOptions({
				maxDate : $('#addstubir').val() ? $('#addstubir').val() : false
			})
		},
		timepicker : false
	});

	$("#stuSaveModal").click(function() {
		var tempPhone = $("#addstuphone").val();
		//判断手机号码
		if(tempPhone !=  ''){
			if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(tempPhone))){ 
		        alert("不是正确的11位手机号");  
		        return; 
		    } 
		}
		
		$.ajax({
			url : "do?invoke=baseStudentAction@updateBaseStudent",
			type : 'POST',
			dataType : 'json',
			data : {
				stu_no : $("#addstuno").val(),
				stu_name : $("#addstuname").val(),
				stu_birthday : $("#addstubir").val(),
				stu_phone : $("#addstuphone").val(),
				major_no : temp_major_no,
				stu_year : $("#addstuyear").val(),
			},
			success : function(rep) {
				if (rep.result == 0) {
					hideEditModal();
					$.alert("", rep.message);
				} else {
					hideEditModal();
					pageindex = 1;
					temppage = 1;
					pagelength = 15;
					loadingTable();
				}
			}
		});
	});
	

	function removeStuTableRow(tempclass, stu_no, stu_name, stu_status) {
		var tempMsg = '';
		var tempBtnMsg = '';
		if (stu_status == 1) {
			tempMsg = '是否确认停用[' + stu_name + ']该学生账号？';
			tempBtnMsg = '停用';
		} else {
			tempMsg = '是否确认启用[' + stu_name + ']该学生账号？';
			tempBtnMsg = '启用';
		}

		$
				.confirm({
					msg : tempMsg,
					btnSure : tempBtnMsg,
					btnCancel : '取消',
					sureDo : function() {
						$
								.ajax({
									url : "do?invoke=baseStudentAction@updateBaseStudentStatus",
									type : 'POST',
									dataType : 'json',
									data : {
										stu_no : stu_no,
										stu_status : stu_status
									},
									success : function(rep) {
										if (rep.result == 0) {
											$.alert("", rep.message);
										} else {
											tempclass.remove();
											/* pageindex = 1;
											temppage = 1; */
											pageindex = 1;
											temppage = 1;
											pagelength = 15;
											loadingTable();
										}
									}
								})
					},
					cancelDo : function() {
						return;
					}
				});
	}
	$("#searchbutton").click(function() {
		var search_like_data = $("#search_like_data").val();
		if (search_like_data == "") {
			pageindex = 1;
			temppage = 1;
			loadingTable();
		} else {
			pageindex = 1;
			temppage = 1;
			searchtable();
		}
	});

	function searchtable() {
		console.log(123)
		$('#tablepane').html("");
		$("#spanFirst").attr("temp", '1'); 
		$("#spanNext").attr("temp", '1');
		$("#spanPre").attr("temp", '1');
		$("#spanLast").attr("temp", '1');
		pagelength = 15;
		var search_like_data = $("#search_like_data").val();
		$.ajax({
			url : "do?invoke=baseStudentAction@searchBaseStudentList",
			type : 'POST',
			dataType : 'json',
			data : {
				pageindex : pageindex,
				pageLength : pagelength,
				year:temp_year, 
				temppage : temppage,
				dep_no : temp_dep_no,
				search_like_data : search_like_data,
			},
			success : function(rep) {
				if (rep.result == 0) {
					$.alert("", rep.message);
					return;
				}
				if (temppage == 1) {
					var count = 0;
					console.log("长度为：" + rep.total);
					if (rep.total % pagelength != 0)
						count = 1;
					totalpage = parseInt(rep.total / pagelength) + count;
					$("#spanLast").attr("page", totalpage);
					$("#spanTotalPage").text(totalpage)
				}
				temppage++;
				initTableBody(rep.rows);
			}

		});
	}

	//读取所有的学期信息放入下拉框
	function loadImportterm() {
		$.ajax({
			url : "do?invoke=ManageTeacher@gettermnoinformation",
			type : 'POST',
			dataType : 'json',
			success : function(rep) {
				if (rep.result == 0) {
					$.alert("", rep.message);
					return;
				} else {
					var temp = rep.data
					for (var i = 0; i < temp.length; i++) {
						var dom = ' <option value="'+temp[i].term_no+'">'
								+ temp[i].term_name + '</option>';
						$("#dropdownImport").prepend(dom)
					}

					$('.ui.dropdownImport').dropdown();
				}
				temp_term_no = $("#dropdownImport").val();
				$("#dropdownImport").change(
						function() {
							var date = new Date();
							var year = date.getFullYear();
							console.log("当前的年份：" + date.getFullYear());
							//判断当前的学年学期是否存在
							var term_no = $("#dropdownImport").val();
							var term_name = $("#dropdownImport").find(
									"option:selected").text();
							console.log("选中学年学期：" + term_no);
							temp_term_no = term_no;
							isYearImport(years, term_no, term_name);
						});
			}
		});
	}

	function isYearImport(years, term_no, term_name) {
		var tempYears = years;
		for (var i = 0; i < tempYears.length; i++) {
			console.log("现在的学年为：" + tempYears[i]);
		}
		var tempStatus = 0;
		for (var i = 0; i < tempYears.length; i++) {
			if (tempYears[i] == term_no) {
				tempStatus = 1;
				console.log("存在当前的学年为：" + term_no);
				break;
			}
		}
		if (tempStatus == 0) {
			console.log("不存在当前的学年为：" + term_no);
			var msg = "当前学年[" + term_name + "]不存在,请添加学年学期！";
			$.alert("", msg);
		}

	}

	$("#importBtn").click(
			function() {
				$('#importExcelModal').modal("setting", "closable", false)
						.modal("show");
				loadImportterm();
				initFilePath();

			});
	$("#excelImportSaveModal")
			.click(
					function() {
						$
								.ajax({
									url : "do?invoke=baseStudentAction@importExcelBaseStudents",
									type : 'POST',
									dataType : 'json',
									data : {
										term_no : temp_term_no,
										student_file_path : studentFilePath,
									},
									success : function(rep) {
										if (rep.result == 0) {
											var tempMsg = rep.message;
											console.log(tempMsg);
											if (tempMsg == 0) {
												//$.alert("", rep.message);
												var errorOb = rep.data;
												console.log(errorOb);
												errorEditModal();
												for (var i = 0; i < errorOb.length; i++) {
													console
															.log("批次号为："
																	+ errorOb[i].brach_id);
													console
															.log("总数为："
																	+ errorOb[i].totalnum);
													console
															.log("成功为："
																	+ errorOb[i].successnum);
													console
															.log("失败为："
																	+ errorOb[i].errornum);
													$("#detailSum")
															.text(
																	errorOb[i].totalnum);
													$("#detailSuccessSum")
															.text(
																	errorOb[i].successnum);
													$("#detailErrorSum")
															.text(
																	errorOb[i].errornum);
												}
											} else {
												console.log("不为空");
												$.alert("", rep.message);
											}
										} else {

										}
									}
								});
						$('#importExcelModal').modal("setting", "closable",
								false).modal("hide");
					});
	function errorEditModal() {
		$('#exportDetailModal').modal("setting", "closable", false).modal(
				"show");
	}
	function errorhideModal() {
		$('#exportDetailModal').modal("setting", "closable", false).modal(
				"hide");

	}
	$("#exportBtn").click(
			function() {
				$('#exportExcelModal').modal("setting", "closable", false)
						.modal("show");
				loadExportterm();
			});
	$("#excelExportSaveModal").click(
			function() {
				$('#exportExcelModal').modal("setting", "closable", false)
						.modal("hide");
			});

	function initFilePath() {
		$("#stuuploadify").uploadify(
				{
					//接受true or false两个值，当为true时选择文件后会自动上传；为false时只会把选择的文件增加进队列但不会上传，这时只能使用upload的方法触发上传。不设置auto时默认为true
					'auto' : true,
					//设置上传按钮的class
					//buttonClass: "some-class", 
					//设置鼠标移到按钮上的开状，接受两个值'hand'和'arrow'(手形和箭头)
					//buttonCursor: 'hand',
					//设置图片按钮的路径（当你的按钮是一张图片时）。如果使用默认的样式，你还可以创建一个鼠标悬停状态，但要把两种状态的图片放在一起，并且默认的放上面，悬停状态的放在下面
					//buttonImage: 'img/browse-btn.png', 
					//设置按钮文字。值会被当作html渲染，所以也可以包含html标签
					'buttonText' : '选择文件',
					//接受一个文件路径。此文件检查正要上传的文件名是否已经存在目标目录中。存在时返回1，不存在时返回0(应该主要是作为后台的判断吧)，默认为false
					//checkExisting: '/uploadify/check-exists.php',
					//开启或关闭debug模式
					// debug: false,
					//设置在后台脚本使用的文件名。举个例子，在php中，如果这个选项设置为'the_files',你可以使用$_FILES['the_files']存取这个已经上传的文件。
					//fileObjName:'filedata',
					//设置上传文件的容量最大值。这个值可以是一个数字或者字符串。如果是字符串，接受一个单位（B,KB,MB,GB）。如果是数字则默认单位为KB。设置为0时表示不限制
					//fileSizeLimit:'100MB',
					//swf的相对路径，必写项
					'swf' : 'script/common/uploadify/uploadify.swf',
					'method' : 'post',
					'uploader' : '../../do?invoke=uploadAction@upload',
					'cancelImg' : 'cancel.png',
					//设置上传队列DOM元素的ID，上传的项目会增加进这个ID的DOM中。设置为false时则会自动生成队列DOM和ID。默认为false
					'queueID' : 'fileQueue',
					//设置是否允许一次选择多个文件，true为允许，false不允许
					'multi' : false,
					//是否缓存swf文件。默认为true，会给swf的url地址设置一个随机数，这样它就不会被缓存。(有些浏览器缓存了swf文件就会触发不了里面的事件--by rainweb)
					'preventCaching' : false,
					//设置文件上传时显示数据，有‘percentage’ or ‘speed’两个参数(百分比和速度)
					'progressData' : 'percentage',
					//设置每一次上传队列中的文件数量。注意并不是限制总的上传文件数量（那是uploadLimit）.如果增加进队列中的文件数量超出这个值，将会触发onSelectError事件。默认值为999
					//	queueSizeLimit: 999,
					//是否移除掉队列中已经完成上传的文件。false为不移除
					//removeCompleted: true,
					//设置上传完成后删除掉文件的延迟时间，默认为3秒。如果removeCompleted为false的话，就没意义了
					//removeTimeout : 3,
					//设置上传过程中因为出错导致上传失败的文件是否重新加入队列中上传
					//requeueErrors : false,
					//设置文件上传后等待服务器响应的秒数，超出这个时间，将会被认为上传成功，默认为30秒
					//successTimeout : 30,
					//可选文件的描述。这个值出现在文件浏览窗口中的文件类型下拉选项中。（chrome下不支持，会显示为'自定义文件',ie and firefox下可显示描述）
					'fileDesc' : '表格文件(*.xls;*.xlsx;)',
					//设置允许上传的文件扩展名（也就是文件类型）。但手动键入文件名可以绕过这种级别的安全检查，所以你应该始终在服务端中检查文件类型。输入多个扩展名时用分号隔开('*.jpg;*.png;*.gif')
					'fileTypeExts' : '*.xls;*.xlsx',

					//通过get或post上传文件时，此对象提供额外的数据。如果想动态设置这些值，必须在onUploadStartg事件中使用settings的方法设置
					// 				 formData: {
					// 	                    timestamp: '<?php echo $timestamp;?>',
					// 	                    token: '<?php echo md5('unique_salt' . $timestamp);?>'
					// 	                },

					onCancel : function(file) {
						//文件被移除出队列时触发,返回file参数
						console.log('将文件  ' + file.name + ' 移除出队列中.')
					},

					onClearQueue : function(queueItemCount) {
						//当调用cancel方法且传入'*'这个参数的时候触发，其实就是移除掉整个队列里的文件时触发，上面有说cancel方法带*时取消整个上传队列
						console.log(queueItemCount
								+ 'file(s) were removed frome the queue')
					},
					onDestroy : function() {
						//调用destroy方法的时候触发
					},
					onDialogClose : function(queueData) {
						//关闭掉浏览文件对话框时触发。返回queueDate参数，有以下属性：
						/*
						    filesSelected 浏览文件对话框中选取的文件数量
						    filesQueued 加入上传队列的文件数
						    filesReplaced 被替换的文件个数
						    filesCancelled 取消掉即将加入队列中的文件个数
						    filesErrored 返回错误的文件个数
						 */
						console.log('\r 浏览文件对话框中选取的文件数量:'
								+ queueData.filesSelected + '\n 加入上传队列的文件数:'
								+ queueData.filesQueued + '\r\n 被替换的文件个数:'
								+ queueData.filesReplaced
								+ '\r\n 取消掉即将加入队列中的文件个数:'
								+ queueData.filesCancelled + '\r\n 返回错误的文件个数:'
								+ queueData.filesErrored)
					},

					onDialogOpen : function() {
						//打开选择文件对话框时触发
					},
					onDisable : function() {
						//禁用uploadify时触发(通过disable方法)
					},
					onEnalbe : function() {
						//启用uploadify时触发(通过disable方法)
					},
					onFallback : function() {
						//在初始化时检测不到浏览器有兼容性的flash版本时实触发
					},

					onInit : function(instance) {
						//每次初始化一个队列时触发，返回uploadify对象的实例
						console.log('The queue ID is '
								+ instance.settings.queueID)
					},

					onQueueComplete : function(queueData) {
						//队列中的文件都上传完后触发，返回queueDate参数，有以下属性：
						/*
						    uploadsSuccessful 成功上传的文件数量
						    uploadsErrored 出现错误的文件数量
						 */
						console.log(queueData.uploadsSuccessful + '\n'
								+ queueData.uploadsErrored)
					},

					onSelect : function(file) {
						//选择每个文件增加进队列时触发，返回file参数
						console.log('增加文件\r' + file.name + '\r到上传队列中')
					},

					onSelectError : function(file, errorCode, errorMsg) {
						console.log(errorCode);
						console.log(this.queueData.errorMsg);
					},

					onSWFReady : function() {
						//swf动画加载完后触发，没有参数
					},
					onUploadComplete : function(file) {
						//在每一个文件上传成功或失败之后触发，返回上传的文件对象或返回一个错误，如果你想知道上传是否成功，最后使用onUploadSuccess或onUploadError事件
					},
					onUploadError : function(file, errorCode, erorMsg,
							errorString) {
					},
					//一个文件完成上传但返回错误时触发，有以下参数
					/*
					    file 完成上传的文件对象
					    errorCode 返回的错误代码
					    erorMsg 返回的错误信息
					    errorString 包含所有错误细节的可读信息
					 */
					onUploadProgress : function(file, bytesUploaded,
							bytesTotal, totalBytesUploaded, totalBytesTotal) {
						//每更新一个文件上传进度的时候触发,返回以下参数
						/*
						    file 正上传文件对象
						    bytesUploaded 文件已经上传的字节数
						    bytesTotal 文件的总字节数
						    totalBytesUploaded 在当前上传的操作中（所有文件）已上传的总字节数
						    totalBytesTotal 所有文件的总上传字节数
						 */
						$('#pregress').html(
								'总共需要上传' + bytesTotal + '字节，' + '已上传'
										+ totalBytesTotal + '字节')
					},

					onUploadStart : function(file) {
						//每个文件即将上传前触发
						console.log('start update')
					},

					onUploadSuccess : function(file, data, respone) {
						studentFilePath = "" + data;
						// 									//每个文件上传成功后触发  
						// 									alert('id: ' + file.id
						// 											+ ' - 索引: '
						// 											+ file.index
						// 											+ ' - 文件名: '
						// 											+ file.name
						// 											+ ' - 文件大小: '
						// 											+ file.size + ' - 类型: '
						// 											+ file.type
						// 											+ ' - 创建日期: '
						// 											+ file.creationdate
						// 											+ ' - 修改日期: '
						// 											+ file.modificationdate
						// 											+ ' - 文件状态: '
						// 											+ file.filestatus
						// 											+ ' - 服务器端消息: ' + data
						// 											+ ' - 是否上传成功: ');
					}

				});

		$('#uploadFile').click(function() {
			$("#stuuploadify").uploadify('upload', '*');
		});
		$('#cancelFile').click(function() {
			$("#stuuploadify")
			//cancel：取消第一个上传的文件，如果后面带参数"*"则是取消掉整个上传队列，如$(el).uploadify('cancel', '*')
			//upload：上传第一个上传的文件，如果后面带参数"*"则上传整个队列，跟cancel一样
			//destroy：移除掉上传组建，按html默认的方法上传
			//disable：有true or false 两个参数，表示是否禁止上传按钮，true表示禁止，false表示允许上传
			//settings：返回或者更新一个实例的方法值，接受一个方法名的参数时是返回那个方法的值，当后面再跟一个参数，则是更新那个方法的值
			//stop：停止正在上传中的文件或队列
			.uploadify('cancel', '*');
		});

	}
</script>
<!--这里引用其他JS-->
</html>