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
<script src="qm/js/baseTeacher.js" type="text/javascript"></script>
<!--这里引用其他样式-->
<title>校内教学质量监控运行平台</title>
<style>
#depdiv .label {
	margin-bottom: 10px;
}
.ui.form .four.fields>.field {
float:right;
}
.get_termyear_select{
min-width:auto!important;
}
.changewidth{
max-width:110%
} 
 .teacher_type_select1{
min-width:8em!important;
} 
.dep_no_select{
min-width:13em!important;
}
</style>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<!--这里绘制页面-->
	<div id="container">
		<div class="ui  header">
			<h3 class="ui header" id='tittle'>
				<i class="tasks icon"></i>
				<div class="content">教职工管理</div>
			</h3>
			<!-- 			<div class="sub header" style="margin-left: 14px; margin-top: 5px">课程管理，您可对课程信息进行添加、修改、删除、设置等操作</div> -->
		</div>
		<div id="depdiv">
			<a class="ui blue label" id="all">全&nbsp;&nbsp;&nbsp;&nbsp;部</a> <a
				class="dep ui gray label" id="2241">能源与电气工程学院</a>
		</div>
		<div class="ui raised">
			<div class="ui form">
				<div id="container_function" style="margin-top: 10px;">

					<div class="four fields">
					<div class="field"   style="float: left;">
							<select class="ui mini get_termyear_select" 
								id="get_termyear_select">
								 <option value="0">全部</option>
 								 <option value="1">校内教师</option>
 								 <option value="2">外聘</option>
							</select>
						</div> 
						<div class="field">
							<div class="ui small input circulari  basic icon "
								data-content="输入教工姓名">
								<input id="search_teacher_name" type="text" placeholder="教工姓名">
							</div>
						</div>
						<div class="field">
							<div class="ui circulari olive icon button" id="searchbutton">
								<i class="search icon"></i>搜索
							</div>
						</div>
						<div class="field">
						</div>
						<div class="field">
							<div class="ui small teal button addAward" id="addBtn" style="float:right">
								<i class="plus icon"></i> 添加
							</div>
						</div>


					</div>
				</div>

			</div>
		</div>


		<div class="ui modal" id="newBaseTeacherModal">
			<i class="close icon"></i>
			<div class="header" id="statustitle">新建教职工</div>
			<div class="content">
				<div class="ui form addBaseTeamForm" id="addBaseTeamForm">
					<div class="fields">
						<div class="field required " id="divTeacherNo">
							<label>教工号</label> <input type="text" class="changewidth" placeholder="请输入教工号"
								name="base_teacher_no" id="base_teacher_no">
						</div>
						<div id="divTeacherName" class="field required">
							<label>姓名</label> <input  class="changewidth"  placeholder="请输入姓名"
								name="base_teacher_name" type="text" id="base_teacher_name" />
						</div>
						<div id="divteacher_title" class="field required">
							<label>教师职称</label><input  class="changewidth"  type="text" placeholder="请输入教师职称"
								name="baseteacher_title" id="baseteacher_title">
						</div>
						<div id="divdep_no" class="field required">
							<label>教工类别</label> <select class="ui mini teacher_type_select1 changewidthselect"
								id="teacher_type_select1">
								 <option value="1">校内教师</option>
 								 <option value="2">外聘</option>
							</select>
						</div>
						<div id="divdep_no" class="field required">
							<label>所属部门</label> <select class="ui mini dep_no_select changewidthselect"
								id="dep_no_select">
							</select>
						</div>
						
					</div>
					<div id="newusererror" class="ui error message">
						<div class="header">错误提示</div>
						<p></p>
					</div>
				</div>
			</div>
			<div class="actions">
				<div class="ui black  button" id="teacherCancelModal">取消</div>
				<div class="ui red right labeled icon button" id="teacherSaveModal">
					保存 <i class="checkmark icon"></i>
				</div>
			</div>
		</div>


		<table class="ui celled center very compact blue striped table">
			<thead>
				<tr class="center aligned">
					<th>教工号</th>
					<th>教师姓名</th>
					<th>教工职称</th>
					<th>教工类别</th>
					<th>部门</th>
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
    $('.teacher_type_select1').dropdown();
	$('.ui.input.circulari.basic.icon').popup();
	var temp_termno = SYSOBJCET.term_no;
	var temp_termname = SYSOBJCET.term_name;
	var temp_dep_no = "all";
	var temp_dep_name = '全部';
	var temp_serach_teacher_name = "";
	var temp_serach_teacher_type = "";
	var totalpage;
	var pageindex = 1; 
	var temppage = 1;
	var pagelength = 15;
	var isEdit = false;//添加、编辑
	var userpurview = USEROBJECT.userpurview; 
	if(userpurview == null){ 
		$('#container').empty();
		 var dom='<div class="ui green large message" id="messageinf">'+
			'<i class="announcement large inverted yellow up circular icon"></i>'+
				'您没有此功能权限！'+     
			'</div>';  

			$('#container').append($(dom));
	} 
	$('#get_termyear_select')
	  .dropdown()
	;
	
	//获取部门列表分类
	$("#depdiv").hide();
	if(userpurview.trim() == "ALL"){
		initDep();
		function initDep() {
			
			var deps = SYSOBJECT.departments;
			console.log(deps);
			$("#depdiv .dep").remove();
			for (var i = 0; i < deps.length; i++) {
				if (deps[i].dep_type!="行政"){
					var depdiv = $('<a class="dep ui gray label"" id="'+deps[i].dep_no+'">'
							+ deps[i].dep_name + '</a>');
					$("#depdiv").append(depdiv);
				}
			}
			$("#depdiv").fadeIn();
			$("#depdiv .label").click(function() {
				$("#depdiv .blue").removeClass("blue");
				$(this).addClass("blue");
				temp_dep_no = this.id;
				pageindex = 1;
				temppage = 1;
				pagelength = 15;
				temp_serach_teacher_name = "";
				$("#search_teacher_name").val("");
				loadingTable();
			});
		}
	}else{
		temp_dep_no = userpurview; 
		pageindex = 1;
		temppage = 1;
		pagelength = 15; 
		temp_serach_teacher_name = "";
		$("#search_teacher_name").val("");
		
	}

	$("#searchbutton").click(function() {
		temp_serach_teacher_name = $("#search_teacher_name").val();
		temp_serach_teacher_type = $('.get_termyear_select .text').text();
		pageindex = 1;
		temppage = 1;
		pagelength = 15;
		if(temp_serach_teacher_name == "" && temp_serach_teacher_type=="全部" ){
			loadingTable()
		}else{
		searchTable();
		}

	});
	//获取教师表格数据
	loadingTable();
	function loadingTable() {
		$('#tablepane').html("");
		$("#spanFirst").attr("temp", '0');
		$("#spanNext").attr("temp", '0');
		$("#spanPre").attr("temp", '0');
		$("#spanLast").attr("temp", '0');
		$.ajax({
			url : "do?invoke=baseTeacherAction@queryBaseTeacherList",
			type : 'POST',
			dataType : 'json',
			data : {
				term_no : temp_termno,
				dep_no : temp_dep_no,
				serach_teacher_name : temp_serach_teacher_name,
				pageindex : pageindex,
				pageLength : pagelength,
				temppage : temppage
			},
			success : function(rep) {
				if (rep.result == 0) {
					$.alert("", rep.message);
					return;
				}
				if (temppage == 1) {
					var count = 0;
					if (rep.total % pagelength != 0)
						count = 1;
					totalpage = parseInt(rep.total / pagelength) + count;
					$("#spanLast").attr("page", totalpage);
					$("#spanTotalPage").text(totalpage)
				}
				temppage++;
				initTableRow(rep.rows);
			}

		});
	}
	//初始化教师表格数据
	function initTableRow(tabledata) {
		var temp = tabledata;
		for (var i = 0; i < temp.length; i++) {
			var dom = '<tr id="tr'+i+'">';
			dom += '<td id="teacher_name'+i+'">' + temp[i].teacher_no + '</td>';
			dom += '<td id="course_name'+i+'">' + temp[i].teacher_name+ '</td>';
			dom += '<td id="teacher_title'+i+'">' + temp[i].teacher_title+ '</td>';
			if(temp[i].teacher_type==""||temp[i].teacher_type==null){
				dom += '<td id="teacher_type'+i+'"></td>';
			}else{
			dom += '<td id="teacher_type'+i+'">' + temp[i].teacher_type+ '</td>';
			}
			dom += '<td id="course_type'+i+'">' + temp[i].dep_name + '</td>';
			if (temp[i].teacher_status == 1) {
				dom += '<td id="teacher_status'+i+'">' + "正常" + '</td>';
				dom += '<td>'
						+ '<div style="margin-left:5px;" class="editT btnfirst circular ui small blue basic icon button" teacherno="'+temp[i].teacher_no+'" teachername="'+temp[i].teacher_name+'" teacherstatus="'+temp[i].teacher_status+'" teacherdepno="'+temp[i].dep_no+'" teacherdepname="'+temp[i].dep_name+'" teacehrtitle="'+temp[i].teacher_title+'" data-content="点击修改教师信息">'
						+ '<i class="edit icon"></i>'
						+ '</div>'
						+ '<div style="margin-left:5px; margin-top:5px;" class="remove btnfirst circular ui small blue basic icon button" teacherno="'+temp[i].teacher_no+'" teachername="'+temp[i].teacher_name+'" teacherstatus="'+temp[i].teacher_status+'" data-content="点击停用此教师">'
						+ '<i class="lock icon"></i>' + '</div>' + '</td>';
			} else {
				dom += '<td class="error" id="teacher_status'+i+'">' + "停用"
						+ '</td>';
				dom += '<td>'
						+ '<div style="margin-left:5px;" class="editT btnfirst circular ui small blue basic icon button" teacherno="'+temp[i].teacher_no+'" teachername="'+temp[i].teacher_name+'" teacherstatus="'+temp[i].teacher_status+'" teacherdepno="'+temp[i].dep_no+'" teacherdepname="'+temp[i].dep_name+'" teacehrtitle="'+temp[i].teacher_title+'" data-content="点击修改教师信息">'
						+ '<i class="edit icon"></i>'
						+ '</div>'
						+ '<div style="margin-left:5px; margin-top:5px;" class="remove btnfirst circular ui small blue basic icon button" teacherno="'+temp[i].teacher_no+'" teachername="'+temp[i].teacher_name+'" teacherstatus="'+temp[i].teacher_status+'" data-content="点击启用此教师">'
						+ '<i class="unlock alternate icon"></i>' + '</div>'
						+ '</td>';
			}

			$("#tablepane").append(dom);
		}
		$('.btnfirst.circular.ui.blue.basic.icon.button').popup();
		$('.editT').bind(
				"click",
				function() {
					var tempclass = $(this).closest("tr");
					var teacher_no = $(this).attr('teacherno');
					var teacher_name = $(this).attr('teachername');
					var teacher_status = $(this).attr('teacherstatus');
					var teacher_depno = $(this).attr('teacherdepno');
					var teacher_depname = $(this).attr('teacherdepname');
					var teacher_title = $(this).attr("teacehrtitle")
					editBaseTeacherRow(tempclass, teacher_no, teacher_name,
							teacher_status, teacher_depno, teacher_depname,teacher_title);
				});
		$('.remove').bind(
				"click",
				function() {
					var tempclass = $(this).closest("tr");
					var teacher_no = $(this).attr('teacherno');
					var teacher_name = $(this).attr('teachername');
					var teacher_status = $(this).attr('teacherstatus');
					removeBaseTeacherRow(tempclass, teacher_no, teacher_name,
							teacher_status);
				});

		if (totalpage == 0)
			$("#spanPageNum").text(0);
		else
			$("#spanPageNum").text(pageindex);
		//判断按钮是否禁用
		if (pageindex == 1 || totalpage == 0) {
			$("#spanPre").removeAttr("href");
			$("#spanPre").addClass("display")
		}
		if (totalpage > 1) {
			if (pageindex == 2 || pageindex == totalpage) {
				if (typeof ($("#spanPre").attr("href")) == "undefined") {
					$("#spanPre").attr("href", "javascript:void(0);");
					$("#spanPre").removeClass("display")
				}
			}
		}
		if (pageindex == 1 || totalpage == 0) {
			$("#spanFirst").removeAttr("href");
			$("#spanFirst").addClass("display")
		}
		if (totalpage > 1) {
			if (pageindex == 2 || pageindex == totalpage) {
				if (typeof ($("#spanFirst").attr("href")) == "undefined") {
					$("#spanFirst").attr("href", "javascript:void(0);");
					$("#spanFirst").removeClass("display")
				}
			}
		}
		if (pageindex == totalpage) {
			$("#spanNext").removeAttr("href");
			$("#spanNext").addClass("display")
		}
		if (totalpage > 1) {
			if (pageindex == totalpage - 1 || pageindex == 1) {
				if (typeof ($("#spanNext").attr("href")) == "undefined") {
					$("#spanNext").attr("href", "javascript:void(0);");
					$("#spanNext").removeClass("display")
				}
			}
		}
		if (pageindex == totalpage) {
			$("#spanLast").removeAttr("href");
			$("#spanLast").addClass("display")
		}
		if (totalpage > 1) {
			if (pageindex == totalpage - 1 || pageindex == 1) {
				if (typeof ($("#spanLastt").attr("href")) == "undefined") {
					$("#spanLast").attr("href", "javascript:void(0);");
					$("#spanLast").removeClass("display")
				}
			}
		}
	}

	$("#spanFirst").bind("click", function() {
		if (pageindex == 1)
			return;
		if (totalpage > 1)
			if ($(this).attr('temp') == 1) {
				$("#tablepane").html("");
				pageindex = 1;
				searchTable();
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
				searchTable();
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
				searchTable();
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
				searchTable();
			} else {
				$("#tablepane").html("");
				pageindex--;
				loadingTable();
			}
		}
	});

	function editBaseTeacherRow(tempclass, teacher_no, teacher_name,
			teacher_status, teacher_depno, teacher_depname,teacher_title) {
		console.log("教师职称为：" + teacher_title );
		console.log("教师部门ID为：" + teacher_depno );
		console.log("教师部门名称为：" + teacher_depname );
		$("#baseteacher_title").val("");
		isEdit = true;
		$("#base_teacher_no").prop('disabled', true);
		$("#statustitle").text('编辑教职工');
		$("#base_teacher_no").val(teacher_no);
		$("#base_teacher_name").val(teacher_name);
		$("#baseteacher_title").val(teacher_title);
		temp_dep_name = teacher_depname;
		temp_dep_no = teacher_depno;
		$("#base_dep_no").val(temp_dep_name);
		
		loadingDropDownDep();
		function loadingDropDownDep() {
			$.ajax({
				url : "do?invoke=commonAction@queryBaseDep",
				type : 'POST',
				dataType : 'json',
				success : function(rep) {
					if (rep.result == 0) {
						$.alert("", rep.message);
					} else {
						editDropDownDep(rep.data);
					}
				}
			});
		}
		showTeachermodal();
	}

	function removeBaseTeacherRow(tempclass, teacher_no, teacher_name,
			teacher_status) {
		var tempMsg = '';
		var tempBtnMsg = '';
		if (teacher_status == 1) {
			tempMsg = '确定从' + USEROBJECT.userinfo.dep_name + '停用'
					+ teacher_name + ' 吗？';
			tempBtnMsg = '停用';
		} else {
			tempMsg = '确定从' + USEROBJECT.userinfo.dep_name + '启用'
					+ teacher_name + ' 吗？';
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
									url : "do?invoke=baseTeacherAction@updateBaseTeacherStatus",
									type : 'POST',
									dataType : 'json',
									data : {
										teacher_no : teacher_no,
										teacher_status : teacher_status
									},
									success : function(rep) {
										if (rep.result == 0) {
											$.alert("", rep.message);
										} else {
											tempclass.remove();
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

	
	//添加所属部门
	function addDropDownDep(temp_data) {
		$("#dep_no_select").empty();
		var selectDep = temp_data;
		for (var i = 0; i < selectDep.length; i++) {
			$("#dep_no_select").append(
					"<option value=\""+selectDep[i].dep_no+"\">"
							+ selectDep[i].dep_name + "</option>");
			//console.log(selectDep[i].dep_name);
			//console.log(selectDep[i].dep_no);
		}
		$('.ui.dep_no_select').dropdown();
		if ($("#dep_no_select option").length > 0) {
			console.log("缺省选中项："
					+ $("#dep_no_select").get(0).options[0].selected);
			//$("#dep_no_select").get(0).options[0].selected = true;
		}
		//获取当前选择的
		temp_dep_no = $("#dep_no_select").val();
		temp_dep_name = $("#dep_no_select").find("option:selected").text();
		console.log("缺省选中部门号：" + temp_dep_no);
		console.log("缺省选中部门名称：" + temp_dep_name);
	}
	
	$("#addBtn").click(function() {
		//添加
		$("#base_teacher_no").prop('disabled', false);
		temp_dep_no = '';
		temp_dep_name = '';
		isEdit = false;
		$("#statustitle").text("添加教职工");
		$("#base_teacher_no").val("");
		$("#base_teacher_name").val("");
		$("#baseteacher_title").val("");
		addDropDownDep(SYSOBJECT.departments);
// 		loadingDropDownDep();
// 		function loadingDropDownDep() {
// 			$.ajax({
// 				url : "do?invoke=commonAction@queryBaseDep",
// 				type : 'POST',
// 				dataType : 'json',
// 				success : function(rep) {
// 					if (rep.result == 0) {
// 						$.alert("", rep.message);
// 					} else {
// 						addDropDownDep(rep.data);
// 					}
// 				}
// 			});
// 		}
		showTeachermodal();
	});

	function editDropDownDep(temp_data) {
		console.log("编辑教师职称为：" + temp_dep_name );
		$("#dep_no_select").empty();
		var selectDep = temp_data;
		for (var i = 0; i < selectDep.length; i++) {
			$("#dep_no_select").append(
					"<option value=\""+selectDep[i].dep_no+"\">"
							+ selectDep[i].dep_name + "</option>");
		}
		var count = $("#dep_no_select option").length;
		for (var i = 0; i < count; i++) {
			console.log("编辑教师职称为：" + i +  $("#dep_no_select").get(0).options[i].text );
			if ($("#dep_no_select").get(0).options[i].text == temp_dep_name) {
				$("#dep_no_select").get(0).options[i].selected = true;
				break;
			}
		}
		$('.ui.dep_no_select').dropdown();
		//获取当前选择的
		temp_dep_no = $("#dep_no_select").val();
		temp_dep_name = $("#dep_no_select").find("option:selected").text();
		console.log("缺省选中部门号：" + temp_dep_no);
		console.log("缺省选中部门名称：" + temp_dep_name);
		
		
	}

	//切换所属部门
	$("#dep_no_select").change(function() {
		temp_dep_no = $("#dep_no_select").val();
		temp_dep_name = $("#dep_no_select").find("option:selected").text();
		console.log("选中部门号：" + temp_dep_no);
		console.log("选中部门名称：" + temp_dep_name);
	});

	$("#teacherSaveModal")
			.click(
					function() {
						if ($("#base_teacher_no").val() == "") {
							setError("#divTeacherNo", "请输入教工号。",
									"#addBaseTeamForm");
						} else if ($("#base_teacher_name").val() == "") {
							setError("#divTeacherName", "请输入姓名。",
									"#addBaseTeamForm");
						} else {
							console.log("新教师数据校验正确");
							//alert("学年学期编号" + studentFilePath);
							$
									.ajax({
										url : "do?invoke=baseTeacherAction@addOrEditBaseTeacher",
										type : 'POST',
										dataType : 'json',
										data : {
											teacher_no : $("#base_teacher_no")
													.val(),
											teacher_name : $(
													"#base_teacher_name").val(),
											teacher_title:$("#baseteacher_title").val(),
											dep_no : temp_dep_no,
											teacher_type:$('.teacher_type_select1 .text').text(),
											is_edit : isEdit
										},
										success : function(rep) {
											if (rep.result == 0) {
												clearError(
														"#addBaseTeamForm .field",
														"#addBaseTeamForm");
												$('#newBaseTeacherModal')
														.modal('hide')
												$.alert("", rep.message);
											} else {
												//console.log(rep);
												clearError(
														"#addBaseTeamForm .field",
														"#addBaseTeamForm");
												$('#newBaseTeacherModal')
														.modal('hide')
												pageindex = 1;
												temppage = 1;
												pagelength = 15;
												temp_dep_no = "all";
												loadingTable();
												//$.alert("", rep.message);
											}
										}
									});
						}
					});
	function setError(selector, msg, msgpnl) {
		if (!msgpnl) {
			msgpnl = "#addBaseTeahcerForm";
		}
		$(selector).addClass("error");
		$(msgpnl + " .ui.error.message p").html(msg);
		if ($(msgpnl + " .error").length > 0) {
			$(msgpnl).addClass("error");
		}

	}
	function clearError(selector, msgpnl) {
		if (!msgpnl) {
			msgpnl = "#addBaseTeahcerForm";
		}
		$(selector).removeClass("error");
		$(msgpnl).removeClass("error");
	}
	$("#teacherCancelModal").click(function() {
		//setTimeout(function(){$("#teacherModal").modal("hide")},2000);
		clearError("#addBaseTeamForm .field", "#addBaseTeamForm");
		$('#newBaseTeacherModal').modal('hide')
	});

	$("#base_teacher_no").on('input', function(e) {
		clearError("#addBaseTeamForm .field", "#addBaseTeamForm");
	});
	$("#base_teacher_name").on('input', function(e) {
		clearError("#addBaseTeamForm .field", "#addBaseTeamForm");
	});
	function showTeachermodal() {
		$('#newBaseTeacherModal').modal("setting", "closable", false).modal(
				"show");
	}

	
	function searchTable(search_like_data) {
		search_like_data = $("#search_teacher_name").val();
		$('#tablepane').html("");
		$("#spanFirst").attr("temp", '1');
		$("#spanNext").attr("temp", '1');
		$("#spanPre").attr("temp", '1');
		$("#spanLast").attr("temp", '1');
		$.ajax({
			url : "do?invoke=baseTeacherAction@searchBaseTeacherList",
			type : 'POST',
			dataType : 'json',
			data : {
				pageindex : pageindex,
				pageLength : pagelength,
				master_no : USEROBJECT.userinfo.teacher_no,
				term_no : SYSOBJCET.term_no,
				temppage : temppage,
				search_like_data : search_like_data,
				dep_no : temp_dep_no,
				temp_serach_teacher_type:temp_serach_teacher_type,
			},
			success : function(rep) {
				if (rep.result == 0) {
					$.alert("", rep.message);
					return;
				}
				if (temppage == 1) {
					var count = 0;
					if (rep.total % pagelength != 0)
						count = 1;
					totalpage = parseInt(rep.total / pagelength) + count;
					$("#spanLast").attr("page", totalpage);
					$("#spanTotalPage").text(totalpage)
				}
				temppage++;
				initTableRow(rep.rows);
			}

		});
	}
</script>
<!--这里引用其他JS-->
</html>