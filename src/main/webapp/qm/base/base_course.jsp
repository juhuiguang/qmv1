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
<!--这里引用其他样式-->
<title>校内教学质量监控运行平台</title>
<style>
#depdiv .label {
	margin-bottom: 10px;
} 
 
.checkmark.large.icon {
	cursor: pointer;
}

.listenxxInf {
	display: none; 
}


#selectterm {
	float: left;
}

.ui.form .four.fields>.field {
	float: right;
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
				<div class="content">课程管理</div>
			</h3>
<!-- 			<div class="sub header" style="margin-left: 14px; margin-top: 5px">课程管理，您可对课程信息进行添加、修改、删除、设置等操作</div> -->
		</div>

		<div class="ui raised" id="selectinf">
			<div class="ui form">
				<div id="depdiv">
					<a class="ui blue label" id="all">全&nbsp;&nbsp;&nbsp;&nbsp;部</a> <a
						class="dep ui gray label" id="2241">能源与电气工程学院</a>
				</div>
				<div class="container center aligned segmentsinput"
					id="segmentsinput">
					<div class="fields">
						<div class="field" style="float: left">
							<select class="ui mini dropdown" id="dropdown">
							</select>
						</div>
						<div class="field" style="float: left">
							<div style="width: 260px" class="ui input circulari  basic icon "
								data-content="输入课程名称、教师">
								<input id="search_info" type="text" placeholder="课程名称、教师">
							</div>
						</div>
						<div class="field" style="float: left;">
							<div class="ui circulari olive icon button" id="searchbutton">
								<i class="search icon"></i>搜索
							</div>
						</div>
						<div class="field" style="float: right">
							<div class="ui  teal  button addAward" id="importBtn"
								style="float: right !important">
								<i class="paw icon"></i> 导入
							</div>
						</div>

					</div>
				</div>

			</div>
		</div>



		<div class="ui modal" id="importExcelModal">
			<i class="close icon"></i>
			<div class="header" >导入</div>
			<div class="content">
				<form class="ui form addBaseTeamForm" id="addBaseTeamForm">
					<div class="three fields">
						<div id="divTermNo" class="field">
							<label class="ui pointing">学年学期编号</label> <select
								class="ui mini dropdownImport" id="dropdownImport">
							</select>
						</div>
						<div class="one field">
							<label>导入课程数据</label>
							<div class="ui left icon input" style="margin-top: 5px">
								<input type="file" name="courseuploadify" id="courseuploadify" />
							</div>

						</div>
						<div class="field">
							<label>模板下载</label> <a
								class="ui red small labeled icon add button"
								href="template/course.xls"><i class="download icon"></i>导入课程模板</a>
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

		<div class="ui modal" id="exportDetailModal">
			<i class="close icon" ></i>
			<div class="header">导入详情</div>
			<div class="content">
				<p id="importdetail">
					共计导入数据<a class="ui large blue circular label" id="detailSum">0</a>
					个,成功<a class="ui large green circular label" id="detailSuccessSum">0</a>个，失败<a
						class="ui large red circular label" id="detailErrorSum">0</a>个
				</p>
			</div>
			<div class="actions">
				<div class="ui black deny button" id="termCancelModal">取消</div>
				<div class="ui red right labeled icon button" id='sumbit_sure'>
					确定 <i class="checkmark icon"></i> 
				</div>
			</div>
		</div>



		<table class="ui celled center very compact blue striped table"
			id="tableinf">
			<thead>
				<tr class="center aligned">

					<th>课程名称</th>
					<th>课程类型</th>
					<th>授课班级</th>
					<th>任课教师</th> 
					<th>教师工号</th>
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

		<div class="ui modal classinf" id="newBaseTeacherModal" >   
		 <i class="close icon"id="courseModal"></i>
			<div class="header" id="statustitle">修改课程信息</div>  


			<div class="content">
				
				
				<div >
					<lable id="teachername">授课教师：+++ </lable>
				</div>

				<div class="ui small search teacher" style="margin-top: 20px;float:left;">
					教师工号 :&nbsp;&nbsp;
					<div class="ui icon input">
						<input class="prompt" type="text" placeholder="搜索教师姓名、工号"
							id="teacherno"> <i class="search icon"></i>
					</div>
					<div class="results"
						style="height: 300px; overflow-y: scroll; margin-left: 15%;">
					</div>
				</div>
				 
				<div class="ui small search classInf" style="margin-top: 20px;margin-left:50%;">  
						授课班级：&nbsp;&nbsp;
						<div class="ui icon input"> 
							<input class="prompt" type="text" placeholder="搜索班级名称、编号"
								id="classSearch"> <i class="search icon"></i>
						</div>
						<div class="results"
							style="height: 300px; overflow-y: scroll; margin-left: 15%;">
						</div>
					</div>

				<div style="margin-top: 20px; float:left;">
 
					<lable>课程名称： </lable> 
					<div class="ui input small" > 
						<input type="text" id="coursename"> 
					</div>
					</div>
 
					
				<div style="margin-left: 50%;margin-top: 20px;">
					<lable>上课教室： </lable>
					<div class="ui input small">
						<input type="text" id="scheaddr">
					</div>
				</div>


				<table class="ui small definition table" id="tableset">  
					<thead>
						<tr> 
							<th width="17%;" id='tabletitle'>选择上课节次</th>
							<th>星期一</th>
							<th>星期二</th>
							<th>星期三</th>
							<th>星期四</th>
							<th>星期五</th>
							<th>星期六</th> 
							<th>星期天</th>
						</tr>
					</thead>
					<tbody>
						<tr id="K1">
							<td>1-2节</td>
							<td class="z1"><i class="checkmark large icon"></i></td>
							<td class="z2"><i class="checkmark large icon"></i></td>
							<td class="z3"><i class="checkmark large icon"></i></td>
							<td class="z4"><i class="checkmark large icon"></i></td>
							<td class="z5"><i class="checkmark large icon"></i></td>
							<td class="z6"><i class="checkmark large icon"></i></td>
							<td class="z7"><i class="checkmark large icon"></i></td>
						</tr>
						<tr id="K2">
							<td>3-4节</td>
							<td class="z1"><i class="checkmark large icon"></i></td>
							<td class="z2"><i class="checkmark large icon"></i></td>
							<td class="z3"><i class="checkmark large icon"></i></td>
							<td class="z4"><i class="checkmark large icon"></i></td>
							<td class="z5"><i class="checkmark large icon"></i></td>
							<td class="z6"><i class="checkmark large icon"></i></td>
							<td class="z7"><i class="checkmark large icon"></i></td>
						</tr>
						<tr id="K3">
							<td>5-6节</td>
							<td class="z1"><i class="checkmark large icon"></i></td>
							<td class="z2"><i class="checkmark large icon"></i></td>
							<td class="z3"><i class="checkmark large icon"></i></td>
							<td class="z4"><i class="checkmark large icon"></i></td>
							<td class="z5"><i class="checkmark large icon"></i></td>
							<td class="z6"><i class="checkmark large icon"></i></td>
							<td class="z7"><i class="checkmark large icon"></i></td>
						</tr>
						<tr id="K4">
							<td>7-8节</td>
							<td class="z1"><i class="checkmark large icon"></i></td>
							<td class="z2"><i class="checkmark large icon"></i></td>
							<td class="z3"><i class="checkmark large icon"></i></td>
							<td class="z4"><i class="checkmark large icon"></i></td>
							<td class="z5"><i class="checkmark large icon"></i></td>
							<td class="z6"><i class="checkmark large icon"></i></td>
							<td class="z7"><i class="checkmark large icon"></i></td>
						</tr>
						<tr id="K5">
							<td>9-10节</td>
							<td class="z1"><i class="checkmark large icon"></i></td>
							<td class="z2"><i class="checkmark large icon"></i></td>
							<td class="z3"><i class="checkmark large icon"></i></td>
							<td class="z4"><i class="checkmark large icon"></i></td>
							<td class="z5"><i class="checkmark large icon"></i></td>
							<td class="z6"><i class="checkmark large icon"></i></td>
							<td class="z7"><i class="checkmark large icon"></i></td>
						</tr>
					</tbody>
				</table>



			</div>
			<div class="actions">
				<div class="ui black deny   button" id="back">取消</div>
				<div class="ui green right labeled icon button" id="submitbtn">
					提交 <i class="checkmark icon"></i>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	var today_term_no = SYSOBJCET.term_no;
	var temp_termno = SYSOBJCET.term_no;
	var temp_termname = SYSOBJCET.term_name;
	var totalpage;
	var pageindex = 1;
	var temppage = 1;
	var pagelength = 15;
	var isEdit = false;
	var data_dep_no = '';//所属部门号
	var data_dep_name = '';//所属部门名称 
	var temp_course_type = "all"; 
	var temp_search_info;
	var courseFilePath = "";
	var temp_dep_no = "all";
	var userpurview = USEROBJECT.userpurview; 
	console.log(USEROBJECT) 
	$("#depdiv").hide(); 
	if(userpurview == null){ 
		$('#container').empty();
		 var dom='<div class="ui green large message" id="messageinf">'+
			'<i class="announcement large inverted yellow up circular icon"></i>'+
				'您没有此功能权限！'+     
			'</div>';  

			$('#container').append($(dom));
	} 
	if(userpurview.trim() == "ALL"){
		initDep();
		function initDep() {
			var deps = SYSOBJECT.departments;
			$("#depdiv .dep").remove();
			for (var i = 0; i < deps.length; i++) {
				if (deps[i].dep_name == "外语系") {
				} else {
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
				settable();
			});
		}
	}else{
		
		temp_dep_no = userpurview;
		pageindex = 1;
		temppage = 1;
		pagelength = 15;
	}
	//加载部门
	

	loadterm();
	//读取所有的学期信息放入下拉框 
	function loadterm() {
		$.ajax({
			url : "do?invoke=ManageTeacher@gettermnoinformation",
			type : 'POST',
			dataType : 'json',
			success : function(rep) {
				if (rep.result == 0) {
					$.alert("", rep.message);
					return;
				} else {
					console.log(rep)
					var temp = rep.data
					for (var i = 0; i < temp.length; i++) {
						var dom = ' <option value="'+temp[i].term_no+'">'
								+ temp[i].term_name + '</option>';
						$("#dropdown").append(dom);
					}
					$('.ui.dropdown').dropdown();
					temp_termno = $("#dropdown").val();
					temp_termname = $("#dropdown").find("option:selected").text();
					settable();
				}
				$("#dropdown").change(
						function() {
							$('#search_info').val("");//清空搜索框
							var term_no = $("#dropdown").val();
							var term_name = $("#dropdown").find(
									"option:selected").text();

							temp_termno = term_no;
							temp_termname = term_name;
							pageindex = 1;
							temppage = 1;
							pagelength = 15;
							settable();
						});
			}
		});
	}

	//加载表格数据
	//settable();
	function settable() {
		$('#tablepane').html("");
		$("#spanFirst").attr("temp", '0');
		$("#spanNext").attr("temp", '0');
		$("#spanPre").attr("temp", '0');
		$("#spanLast").attr("temp", '0');
		$
				.ajax({
					url : "do?invoke=baseCourseAction@getBaseCourseList",
					type : 'POST',
					dataType : 'json',
					data : {
						pageindex : pageindex,
						pageLength : pagelength,
						master_no : USEROBJECT.userinfo.teacher_no,
						term_no : temp_termno,
						temppage : temppage,
						search_info : temp_search_info,
						course_type : temp_course_type,
						dep_no : temp_dep_no
					},
					success : function(rep) {
						console.log(rep);
						if (rep.result == 0) {
							$.alert(rep.message)

						} else {
							if (rep.total == 0) {
								$('#tableinf').hide();
								$('#spanbutton').hide();
								$('#messageinf').remove();
								var dom = '<div class="ui green large message" id="messageinf">'
										+ '<i class="announcement large inverted yellow up circular icon"></i>'
										+ ' 没有相关课程信息！' + '</div>';

								$('#container').append($(dom));
							} else {
								$('#tableinf').show();
								$('#spanbutton').show();
								$('#messageinf').remove();
								if (temppage == 1) {
									var count = 0;
									if (rep.total % pagelength != 0)
										count = 1;
									totalpage = parseInt(rep.total / pagelength)
											+ count;
									$("#spanLast").attr("page", totalpage);
									$("#spanTotalPage").text(totalpage)
								}
								temppage++;
								initTable(rep.rows);
							}
						}

					}

				});
	}
	function initTable(tabledata) {
		var temp = tabledata;
		for (var i = 0; i < temp.length; i++) {
			var dom = '<tr class="tr">';
			var course_name = temp[i].course_name;   
			if( course_name.length > 16){  
				course_name= course_name.substring(0,16) + "……"; 
			}
			dom += '<td class="course_name" name= "'+ temp[i].course_name +'">' + course_name + '</td>';
			dom += '<td class="course_type">' + temp[i].course_type + '</td>';
			dom += '<td class="class_name">' + temp[i].class_name + '</td>';
			dom += '<td class="teacher_name">' + temp[i].teacher_name + '</td>';
			dom += '<td class="teacher_no">' + temp[i].teacher_no + '</td>';
 
			dom += '<td>'
					+ '<div style="margin:5px; " class="btnthird circular ui small blue basic icon button" name="'+temp[i].task_no+'" sche="'+temp[i].sche_no+'" data-content="查看详情">'
					+ '<i class="file text blue icon"></i>' + '</div>';
			if (temp_termno == SYSOBJCET.term_no) {
				dom += '<div style="margin:5px; " class="btnfirst circular ui small teal basic icon button" name="'+temp[i].task_no+'" sche="'+temp[i].sche_no+'" data-content="修改">'
						+ '<i class="edit teal icon"></i>' + '</div>';
			}
			dom += '<div style="margin:5px; " class="remove btnsecond circular ui small red basic icon button" sche="'+temp[i].sche_no+'" name="'+temp[i].task_no+'"  data-content="删除">'
					+ '<i class="remove red icon"></i>'
					+ '</div>'
					+ '</td></tr>';
			dom += '<tr class="listenxxInf">'
					+ '<td colspan=1 class="positive">上课周次</td>'
					+ '<td colspan=5 class="positive course_week" >'
					+ temp[i].course_week + '</td>' + '</tr>';
					var weekArray = ["星期一/","星期二/","星期三/","星期四/","星期五/","星期六/","星期天/"];
					var courseArray = ["一二节","三四节","五六节","七八节","九十节"];
					var sche = "";
					if(temp[i].sche_set.trim() != "" && temp[i].sche_set.trim() != "K99"){ 
						sche = weekArray[parseInt(temp[i].sche_set.trim().substring(1,2))-1]+courseArray[parseInt(temp[i].sche_set.trim().substring(2,3))-1];
					} 
			dom += '<tr class="listenxxInf" name = "'+temp[i].sche_set.trim()+'">' 
					+ '<td colspan=1 class="positive">上课节次</td>'
					+ '<td colspan=5 class="positive sche_set" >' 
					+ sche + '</td>' + '</tr>';
			dom += '<tr class="listenxxInf">'
					+ '<td colspan=1 class="positive">上课教室</td>'
					+ '<td colspan=5 class="positive sche_addr" >'
					+ temp[i].sche_addr + '</td>' + '</tr>';

			$("#tablepane").append(dom);
		}
		$('.circular.ui.basic.icon.button').popup();
		$('.btnthird').click(
				function() {
					$(this).parents('tr').next().fadeToggle(500).next()
							.fadeToggle(500).next().fadeToggle(500);
				})
		$('.btnfirst')
				.bind("click",function() {$.ajax({
										url : "do?invoke=baseCourseAction@getAddTeacher",
										type : 'POST',
										dataType : 'json',
										async : false, 
										success : function(rep) {
											if (rep.result == 0) {
												$.alert("没有可添加教师");
											} else {
												
												var content = [];
												var teacherInf = rep.data[0].teacher;
												for (var i = 0; i < teacherInf.length; i++) {
													content[i] = {
														title : teacherInf[i].teacher_no,
														description : teacherInf[i].teacher_name,
													};
												}
												var content_ = [];
												var classInf = rep.data[1].classInf;
												for (var i = 0; i < classInf.length; i++) {
													content_[i] = {
														title : classInf[i].class_name,
														description : classInf[i].class_no,  
													};
												}
												$('.ui.search.teacher')
														.search(
																{
																	source : content,
																	maxResults : 10000,
																	onSelect : function(
																			content,
																			response) { 
 
																		$(
																				'#teachername')
																				.text(
																						"授课教师 : "
																								+ content.description);
																	}
																});//初始化搜索
														$('.ui.search.classInf')
														.search(
																{
																	source : content_,
																	maxResults : 10000,
																});//初始化搜索
											}
										}
									});
							
							var task_no = $(this).attr("name");
							var sche_no = $(this).attr("sche"); 
							
							$('#teachername').text(
									"授课教师 :  "
											+ $(this).parents("tr").find(
													'.teacher_name').text());
							$(".checkmark.large.icon").removeClass("green");
							$('#tableset').show();
							if($(this).parents('tr').find('.course_type').text().trim() == '实训课'){
								$('#tableset').hide(); 
							}
							if ($(this).parents("tr").next().next().attr('name').substring(0, 1) == "K") {

								var day = $(this).parents("tr").next().next()
										.attr('name').substring(1,
												2);
								var set = $(this).parents("tr").next().next()
										.attr('name').substring(2,
												3);
								$('#K' + set + '').find('.z' + day + '').find(
										'i').addClass("green");
							}

							$('#termno').val(
									$(this).parents("tr").find('.term_no')
											.text());
							$('#coursename').val(
									$(this).parents("tr").find('.course_name')
											.attr('name')); 
							$('#classSearch').val( 
									$(this).parents("tr").find('.class_name') 
											.text()); 
							$('#teacherno').val(
									$(this).parents("tr").find('.teacher_no')
											.text());

							$('#scheaddr').val(
									$(this).parents("tr").next().next().next()
											.find('.sche_addr').text());
							
							loadmodal(task_no, sche_no, $(this).parents("tr").next().next().attr('name')); 
						});
		$('.btnsecond').bind("click", function() {
			var sche_no = $(this).attr("sche");
			var task_no = $(this).attr("name");
			removetableteacher(sche_no , task_no);
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
				searchtable();
			} else {
				$("#tablepane").html("");
				pageindex = 1;
				settable();
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
				settable();
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
				settable();
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
				settable();
			}
		}
	});
	function removetableteacher(sche_no , task_no) {
		$.confirm({
			msg : "确定删除该记录？",
			btnSure : '确定 ',
			btnCancel : '返回',
			sureDo : function() {
				$.ajax({
					url : "do?invoke=baseCourseAction@removeInf",
					type : 'POST',
					dataType : 'json',
					data : {
						sche_no : sche_no,
						task_no :task_no
					},
					success : function(rep) {
						$.alert({
							msg : "删除成功",
							type : 'info',
							btnText : '我知道啦',
							callback : function() { 
								$("#back").click();

								searchSettable();
							}
						});
					}
				});

			},
			cancelDo : function() {

			}
		});

	}

	function loadmodal(task_no, sche_no, sche_set) {
		$('.ui.modal.classinf').modal('show'); 
		var courseset = sche_set;
		$(".checkmark.large.icon").unbind("click").click(function() {
			$(".checkmark.large.icon").removeClass("green"); 
			$(this).addClass("green"); 
			var howweek = $(this).parent("td").attr("class").substring(1, 2);
			var howtime = $(this).parents("tr").attr("id").substring(1, 2);

			courseset = "K" + howweek + howtime;
		})
		$('#submitbtn').unbind('click').click(function() {
			if ($(this).hasClass("loading")) {
				return;
			}
			$(this).addClass("loading");
			var term_no = $('#termno').val();
			var course_name = $('#coursename').val();
			var class_name = $('#classSearch').val();
			if(class_name == null){
				class_name==""; 
			} 
			var teacher_no = $('#teacherno').val();  
			var sche_addr = $('#scheaddr').val(); 
			$.ajax({
				url : "do?invoke=baseCourseAction@changeInf",
				type : 'POST',
				dataType : 'json',
				data : {
					task_no : task_no,
					sche_no : sche_no,
					term_no : temp_termno,
					course_name : course_name,
					class_name : class_name,
					teacher_no : teacher_no,
					sche_set : courseset,
					sche_addr : sche_addr
				},
				success : function(rep) { 
					console.log(courseset);
					if (rep.result == 0) {
						$.alert({
							msg : "请检查班级输入是否合理",
							type : 'info',
							btnText : '我知道啦',
							callback : function() {
							}
						});
					} else {
						$.alert({
							msg : "修改成功",
							type : 'info',
							btnText : '我知道啦',
							callback : function() {
								$("#back").click();
 
								searchSettable();
							}
						});
					}
					$('#submitbtn').removeClass('loading');
				}
			});
		})
	}

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

	$("#base_teacher_no").on('input', function(e) {
		clearError("#addBaseTeamForm .field", "#addBaseTeamForm");
	});
	$("#base_teacher_name").on('input', function(e) {
		clearError("#addBaseTeamForm .field", "#addBaseTeamForm");
	});
	$("#searchbutton").click(function() {
		var search_info = $("#search_info").val();
		$('#tableinf').show();
		$('#spanbutton').show();
		$('#messageinf').remove();
		pageindex = 1;
		temppage = 1;
		searchSettable();
	});
	function searchSettable() {
		var search_info = $("#search_info").val();
		if (search_info == "") {
			$('#spanbutton').show();
			settable();
			return;
		}
		$('#tablepane').html("");
		$("#spanFirst").attr("temp", '1');
		$("#spanNext").attr("temp", '1');
		$("#spanPre").attr("temp", '1');
		$("#spanLast").attr("temp", '1');
		$
				.ajax({
					url : "do?invoke=baseCourseAction@getBaseSearchInf",
					type : 'POST',
					dataType : 'json',
					data : {
						term_no : temp_termno,
						search_info : search_info,
						dep_no : temp_dep_no
					},
					success : function(rep) {
						if (rep.result == 0) {
							//没有数据
							$('#tableinf').hide();
							$('#spanbutton').hide();
							var dom = '<div class="ui green large message" id="messageinf">'
									+ '<i class="announcement large inverted yellow up circular icon"></i>'
									+ ' 没有查询到该课程信息！' + '</div>';

							$('#container').append($(dom));
							return;
						}
						$('#spanbutton').hide();
						initTable(rep.data);
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
						$("#dropdownImport").append(dom)
					}
					$('.ui.dropdownImport').dropdown();
				}
				temp_termno = $("#dropdownImport").val(); 
				$("#dropdownImport").change(
						function() {
							var date = new Date();
							var year = date.getFullYear();
							console.log("当前的年份：" + date.getFullYear());
							var years = new Array();
							years[0] = year + "0";
							years[1] = year + "1";
							//判断当前的学年学期是否存在
							var term_no = $("#dropdownImport").val();
							var term_name = $("#dropdownImport").find(
									"option:selected").text();
							console.log("选中学年学期：" + term_no);
							temp_termno = term_no; 
							temp_termname = term_name; 
							//isYearImport(years, term_no, term_name);
						});
			}
		});
	}

	function isYearImport(years, term_no, term_name) {
		var tempYears = years;

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
						//确定是否导入该学年学期
						$
								.confirm({
									msg : "确定导入课程到[" + temp_termname + "]学年学期",
									btnSure : '确定 ',
									btnCancel : '返回',
									sureDo : function() {
										$
												.ajax({
													url : "do?invoke=baseCourseAction@importExcelBaseCourses",
													type : 'POST',
													dataType : 'json',
													data : {
														term_no : temp_termno,
														course_file_path : courseFilePath,
													},
													success : function(rep) {

														if (rep.result == 0) {
															var tempMsg = rep.message;
															if (tempMsg == 0) {
																var errorOb = rep.data;
																console
																		.log(errorOb);
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
																	$(
																			"#detailSum")
																			.text(
																					errorOb[i].totalnum);
																	$(
																			"#detailSuccessSum")
																			.text(
																					errorOb[i].successnum);
																	$(
																			"#detailErrorSum")
																			.text(
																					errorOb[i].errornum);
																}
																$("#sumbit_sure").unbind('click').click(function(){        
																	errorhideModal();              
																});
															} else {
																console
																		.log("不为空");
																$
																		.alert(
																				"",
																				rep.message);
															}
														}

													}
												});
									},
									cancelDo : function() {

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

	function initFilePath() {
		$("#courseuploadify").uploadify(
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
						//选择文件出错时触发，返回file,erroCode,errorMsg三个参数
						/*
						    errorCode是一个包含了错误码的js对象，用来查看事件中发送的错误码，以确定错误的具体类型，可能会有以下的常量：
						    QUEUE_LIMIT_EXCEEDED:-100 选择的文件数量超过设定的最大值；
						    FILE_EXCEEDS_SIZE_LIMIT:-110 文件的大小超出设定
						    INVALID_FILETYPE:-130 选择的文件类型跟设置的不匹配

						    errorMsg 完整的错误信息，如果你不重写默认的事件处理器，可以使用‘this.queueData.errorMsg’ 存取完整的错误信息
						 */
						console.log(errorCode)
						console.log(this.queueData.errorMsg)
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
						courseFilePath = "" + data;
					}

				});

		$('#uploadFile').click(function() {
			$("#courseuploadify").uploadify('upload', '*');
		});
		$('#cancelFile').click(function() {
			$("#courseuploadify")
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