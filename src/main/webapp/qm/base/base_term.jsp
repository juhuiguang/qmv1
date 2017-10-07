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
<script src="qm/js/baseTerm.js" type="text/javascript"></script>
<!--这里引用其他样式-->
<title>校内教学质量监控运行平台</title>
<style>
#depdiv .label {
	margin-bottom: 10px;
}

#addBtn {
	float: right;
}
</style>
<script type="text/javascript">
	function formSubmit() {
		document.getElementById("myForm").submit()
	}
</script>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<!--这里绘制页面color: #626F82-->
	<div id="container">
		<div class="ui  header">
			<h3 class="ui header" id='tittle'>
				<i class="tasks icon"></i>
				<div class="content">学年学期管理</div>
			</h3>
			<!-- 			<div class="sub header" style="margin-left: 14px; margin-top: 5px">课程管理，您可对课程信息进行添加、修改、删除、设置等操作</div> -->
		</div>
		<div>
			<div style="marign-left: 10px ;margin-bottom:5px ;" class="ui small  teal button addAward"
				id="addBtn">
				<i class="plus icon"></i> 添加
			</div>
		</div>
		<!-- 		<div id="container_function" style="margin-top: 10px;"> -->
		<!-- 			<div class="ui grid"> -->
		<!-- 				<div -->
		<!-- 					class="ui  aligned floated thirteen wide column search"> -->
		<!-- 					<div style="marign-left: 10px" -->
		<!-- 						class="ui mini  teal button addAward" id="addBtn"> -->
		<!-- 						<i class="plus icon"></i> 添加 -->
		<!-- 					</div> -->
		<!-- <!-- 					<form id="myForm" action="DownLoadServlet" -->
		<!-- <!-- 						method="post"> -->
		<!-- <!-- 						<input type="button" onclick="formSubmit()" value="Submit"> -->
		<!-- <!-- 					</form> -->
		<!-- 				</div> -->
		<!-- 			</div> -->
		<!-- 		</div> -->
		<div class="ui modal" id="newBaseTermModal">
			<i class="close icon"></i>
			<div class="header" id="statustitle">新建学年学期</div>
			<div class="content">
				<form class="ui form addBaseTeamForm" id="addBaseTeamForm">
					<div class="three fields">
						<div id="divTermNo" class="field required ">
							<label class="ui pointing  ">学年学期编号</label> <select
								class="ui mini term_no_select" id="term_no_select">
							</select>

						</div>
						<div id="divTermName" class="field required">
							<label>学年学期名称</label> <input placeholder="请输入学年学期名称"
								name="term_name" type="text" id="term_name" />
						</div>
						<div id="divTermPrintName" class="field required">
							<label>学年学期打印名称</label> <input placeholder="请输入学年学期打印名称"
								name="term_print_name" type="text" id="term_print_name" />
						</div>
					</div>
					<div class="two fields">
						<div class="field required ">
							<label class="ui pointing">学期开始日期</label>
							<div class="ui icon input" id="divTermStartDate">
								<input type="text" placeholder="XXXX-XX-XX"
									name="term_startdate" id="term_startdate" /><i class="edit"></i>
							</div>
						</div>
						<div class="field required" id="divTermEndDate">
							<label>学期结束日期</label> <input placeholder="XXXX-XX-XX"
								name="term_enddate" type="text" id="term_enddate" />
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
				<div class="ui red right labeled icon button" id="termSaveModal">
					保存 <i class="checkmark icon"></i>
				</div>
			</div>
		</div>



		<table class="ui celled center very compact blue striped table">
			<thead>
				<tr class="center aligned">
					<th>学年学期编号</th>
					<th>学年学期名称</th>
					<th>学年学期打印名称</th>
					<th>学期开始日期</th>
					<th>学期结束日期</th>
					<th>学期状态</th>
					<th>操作</th>
					<th>开关</th>
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

		<div class="ui  modal long">
			<i class="close icon"></i>
			<div class="header">
				<i class="write icon"></i> 学期开关设置
			</div> 
			<div class="content switch"></div>

		</div>

	</div>
</body>
<script type="text/javascript">
	var add_termno = "";//添加的学年学期号
	var add_termname = "";//添加学年学期名称
	var add_TermNo = "";
	var totalpage;
	var pageindex = 1;
	var temppage = 1;
	var pagelength = 10;
	var isEdit = false;
	var data_dep_no = '';//所属部门号
	var data_dep_name = '';//所属部门名称
	var studentFilePath = "";
	var courseFilePath = "";
	//加载表格数据
	settable();
	function settable() {
		$('#tablepane').html("");
		$("#spanFirst").attr("temp", '0');
		$("#spanNext").attr("temp", '0');
		$("#spanPre").attr("temp", '0');
		$("#spanLast").attr("temp", '0');

		$.ajax({
			url : "do?invoke=baseTeamAction@getBaseTermList",
			type : 'POST',
			dataType : 'json',
			data : {
				pageindex : pageindex,
				pageLength : pagelength,
				term_no : SYSOBJCET.term_no,
				temppage : temppage,
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
				initTable(rep.rows);
			}

		});
	}

	function initTable(tabledata) {
		var temp = tabledata;
		console.log(temp);
		for (var i = 0; i < temp.length; i++) {
			var dom = '<tr id="tr'+i+'">';
			var temp_termNo = temp[i].term_no;

			// 			if (temp_termNo.substring(4, 5) == 0) {
			// 				dom += '<td id="term_no'+i+'">' + temp_termNo.substring(0, 4)
			// 						+ "学年第一学期" + '</td>';
			// 				dom += '<td id="term_no'+i+'">' + temp_termNo.substring(0, 4)
			// 				+ "学年第一学期" + '</td>';
			// 			} else if (temp_termNo.substring(4, 5) == 1) {
			// 				dom += '<td id="term_no'+i+'">' + temp_termNo.substring(0, 4)
			// 						+ "学年第二学期" + '</td>';
			// 			} else {
			dom += '<td id="term_no'+i+'">' + temp[i].term_no + '</td>';
			//			}
			dom += '<td id="course_name'+i+'">' + temp[i].term_name + '</td>';
			dom += '<td id="course_name'+i+'">' + temp[i].term_print_name
					+ '</td>';
			dom += '<td id="course_name'+i+'">' + temp[i].term_startdate
					+ '</td>';
			dom += '<td id="course_name'+i+'">' + temp[i].term_enddate
					+ '</td>';
			if (temp[i].term_status == 1) {
				dom += '<td id="teacher_status'+i+'">' + "正常" + '</td>';
				dom += '<td>'
						+ '<div style="margin-left:5px; margin-top:5px;" class="remove btnfirst circular ui small blue basic icon button" termno="'+temp[i].term_no+'" termname="'+temp[i].term_name+'" termstatus="'+temp[i].term_status+'" data-content="点击停用此学期">'
						+ '<i class="lock icon"></i>' + '</div>' + '</td>';
			} else {
				dom += '<td class="error" id="teacher_status'+i+'">' + "停用"
						+ '</td>';
				dom += '<td>'
						+ '<div style="margin-left:5px; margin-top:5px;" class="remove btnfirst circular ui small blue basic icon button" termno="'+temp[i].term_no+'" termname="'+temp[i].term_name+'" termstatus="'+temp[i].term_status+'" data-content="点击启用此学期">'
						+ '<i class="unlock alternate icon"></i>' + '</div>' 
						+ '</td>'; 
			}

			dom += '<td>'
					+ '<div style="margin-left:5px; margin-top:5px;" class="remove btnsecond circular ui small blue basic icon button" termno="'+temp[i].term_no+'" id="term'+temp[i].term_no+'" tk="'+temp[i].term_tk+'" pj="'+temp[i].term_pj+'" kh="'+temp[i].term_kh+'" kq="'+temp[i].term_kq+'" >'
					+ '<i class="options icon"></i> ' + '</div>' + '</td>';

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
					edittableteacher(tempclass, teacher_no, teacher_name,
							teacher_status, teacher_depno, teacher_depname);
				});
		$('.remove.btnfirst').bind("click", function() {
			var tempclass = $(this).closest("tr");
			var term_no = $(this).attr('termno');
			var term_name = $(this).attr('termname');
			var term_status = $(this).attr('termstatus');
			removetableteacher(tempclass, term_no, term_name, term_status);
		});
		$('.btnsecond').unbind('click').click(
				function() { //开关
					$('.content.switch').empty();
					var dom = '<div class="ui toggle checkbox">'
							+ '<input type="checkbox"  class="tk" >'
							+ '<label>督学听课开关</label>' + '</div>' +

							'<div class="ui toggle checkbox" style="margin-left:5%;">'
							+ '<input type="checkbox"  class="pj">'
							+ '<label>学生评教开关</label>' + '</div>' +

							'<div class="ui toggle checkbox"style="margin-left:5%;">'
							+ '<input type="checkbox"  class="kh">'
							+ '<label>学年考核开关</label>' + '</div>'+  
							
							'<div class="ui toggle checkbox" style="margin-left:5%;">'
							+ '<input type="checkbox"  class="kq">' 
							+ '<label>考勤时限开关</label>' + '</div>';
					$('.content.switch').append($(dom));
					var term = $(this).attr("termno");

					if ($(this).attr("tk") != "1") {

						$('.tk').attr("checked", "checked");
					}
					if ($(this).attr("kh") != "1") {

						$('.kh').attr("checked", "checked");
					}
					if ($(this).attr("pj") != "1") {

						$('.pj').attr("checked", "checked");
					}
					if ($(this).attr("kq") != "1") { 
 
						$('.kq').attr("checked", "checked");
					}
					$('.modal.long') //弹出层初始化 
					.modal('show');
					$('.ui.checkbox').checkbox();

					$('.tk').change(function() {

						changestatus(term, "tk");
					})
					$('.kh').change(function() {
						changestatus(term, "kh");
					})
					$('.pj').change(function() {
						changestatus(term, "pj");
					})
					$('.kq').change(function() { 
						changestatus(term, "kq");
					})
				})
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
	function removetableteacher(tempclass, term_no, term_name, term_status) {
		var tempMsg = '';
		var tempBtnMsg = '';
		if (term_status == 1) {
			return ;
		} else {
			tempMsg = '是否确认启用[' + term_name + ']该学期？';
			tempBtnMsg = '启用';
		}

		$.confirm({
			msg : tempMsg,
			btnSure : tempBtnMsg,
			btnCancel : '取消',
			sureDo : function() {
				$.ajax({
					url : "do?invoke=baseTeamAction@updataBaseTermStatus",
					type : 'POST',
					dataType : 'json',
					data : {
						term_no : term_no,
						term_status : term_status
					},
					success : function(rep) {
						if (rep.result == 0) {
							$.alert("", rep.message);
						} else {
							console.log(SYSOBJCET)
							tempclass.remove();
							/* pageindex = 1;
							temppage = 1; */
							pageindex = 1;
							temppage = 1;
							pagelength = 10;
							settable();
						}
					}
				})
			},
			cancelDo : function() {
				return;
			}
		});
	}

	function showTeachermodal() {
		$('#newBaseTermModal').modal("setting", "closable", false)
				.modal("show");
	}
	function hideTeacherModal() {
		$('#newBaseTermModal').modal("setting", "closable", false)
				.modal("hide");
	}

	function getDefaultAddTerm() {
		$("#term_no_select").empty();
		var date = new Date();
		var year = date.getFullYear();
		console.log("当前的年份：" + date.getFullYear());
		var years = new Array();
		years[0] = year + "学年第一学期";
		years[1] = year + "学年第二学期";
		for (var i = 0; i < years.length; i++) {
			$("#term_no_select").append(
					"<option value=\""+i+"\">" + years[i] + "</option>");
		}
		$('.ui.term_no_select').dropdown();
		if ($("#term_no_select option").length > 0) {
			console.log("缺省选中项："
					+ $("#term_no_select").get(0).options[0].selected);
			//$("#dep_no_select").get(0).options[0].selected = true;
		}
		//获取当前选择的
		var term_no = $("#term_no_select").val();
		var term_name = $("#term_no_select").find("option:selected").text();
		//console.log("缺省选中学年学期ID：" + term_no);
		//console.log("缺省选中学年学期：" + term_name);
		add_TermNo = year + term_no;
		console.log("缺省改造选中学年学期：" + add_TermNo);
		//切换所属部门
		$("#term_no_select").change(
				function() {
					var term_no = $("#term_no_select").val();
					var term_name = $("#term_no_select")
							.find("option:selected").text();
					add_TermNo = year + term_no;
					//console.log("缺省选中学年学期ID：" + term_no);
					//console.log("缺省选中学年学期：" + term_name);
					console.log("缺省改造选中学年学期：" + add_TermNo);
				});
	}

	$('#term_startdate').datetimepicker(
			{
				lang : 'ch',
				format : 'Y-m-d',
				defaultDate : new Date(),
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

	$("#term_no").on('input', function(e) {
		clearError("#addBaseTeamForm .field", "#addBaseTeamForm");
	});
	$("#term_name").on('input', function(e) {
		clearError("#addBaseTeamForm .field", "#addBaseTeamForm");
	});
	$("#term_print_name").on('input', function(e) {
		clearError("#addBaseTeamForm .field", "#addBaseTeamForm");
	});
	$("#term_startdate").on('input', function(e) {
		clearError("#addBaseTeamForm .field", "#addBaseTeamForm");
	});
	$("#term_enddate").on('input', function(e) {
		clearError("#addBaseTeamForm .field", "#addBaseTeamForm");
	});
	function setError(selector, msg, msgpnl) {
		if (!msgpnl) {
			msgpnl = "#addBaseTeamForm";
		}
		$(selector).addClass("error");
		$(msgpnl + " .ui.error.message p").html(msg);
		if ($(msgpnl + " .error").length > 0) {
			$(msgpnl).addClass("error");
		}
		$('#newusererror').show();
	}
	function changestatus(term, status) {
		$.ajax({
			url : "do?invoke=baseTeamAction@changestatus",
			type : 'POST',
			dataType : 'json',
			data : {
				term_no : term,
				status : status,
			},
			success : function(rep) {
				if ($("#term" + term + "").attr(status) == "1") {
					$("#term" + term + "").attr(status, "0");
				} else {
					$("#term" + term + "").attr(status, "1");
				}
			}
		});
	}
	function clearError(selector, msgpnl) {
		if (!msgpnl) {
			msgpnl = "#addBaseTeamForm";
		}
		$(selector).removeClass("error");
		$(msgpnl).removeClass("error");
	}

	//添加学年学期
	$("#addBtn").click(function() {
		getCurrentBaseTerm();
	});
	//获取添加的学年学期
	function getCurrentBaseTerm() {
		$('.removeerror').removeClass('error');
		$('#newusererror').html('<div class="header">错误提示</div><p></p>');
		 $('#newusererror').css('display','none');
		 $('.input.error').removeClass('error');
		//获取当前最大的学年学期
		$.ajax({
			url : "do?invoke=baseTeamAction@getAddMaxBaseTeamNew",
			type : 'POST',
			dataType : 'json',
			success : function(rep) {
				if (rep.result == 0) {
					$.alert("", rep.message);
					return;
				} else {
					console.log(rep.data);
					var tempData = rep.data;
					$(".term_no_select").remove();
					var item =  '<select class="ui mini term_no_select" id="term_no_select"></select>';
					$('#divTermNo').append(item);
					for (var i = 0; i < tempData.length; i++) {
						$("#term_no_select").append(
								"<option value=\""+tempData[i].term_no+"\">"
										+ tempData[i].term_name + "</option>");
						add_termno = tempData[i].term_no;
						add_termname = tempData[i].term_name;
						console.log("" + add_termno + "," + add_termname);
					}
					$('.ui.term_no_select').dropdown();
					$("#term_name").val(add_termname);
					$("#term_print_name").val(add_termname);
					$("#term_startdate").val("");
					$("#term_enddate").val("");
					studentFilePath = "";
					courseFilePath = "";
					showTeachermodal();
				}
			}

		});
	}

	//保存学年学期
	$("#termSaveModal").click(
			function() {
				if ($("#term_name").val() == "") {
					setError("#divTermName", "请输入学年学期名称。", "#addBaseTeamForm");
				} else if ($("#term_print_name").val() == "") {
					setError("#divTermPrintName", "请输入学年学期打印名称。",
							"#addBaseTeamForm");
				} else if ($("#term_startdate").val() == "") {
					setError("#divTermStartDate", "请选择学期开始日期。",
							"#addBaseTeamForm");
				}  else {
					console.log("新学期数据校验正确");
					var term_name = $("#term_name").val();
					var term_print_name = $("#term_print_name").val();
					var term_startdate = $("#term_startdate").val();
					var term_enddate = $("#term_enddate").val();
					//alert("学年学期编号" + studentFilePath);
					$.ajax({
						url : "do?invoke=baseTeamAction@addBaseTermNew",
						type : 'POST',
						dataType : 'json',
						data : {
							term_no : add_termno,
							term_name : term_name,
							term_print_name : term_print_name,
							term_startdate : term_startdate,
							term_enddate : term_enddate,
							student_file_path : studentFilePath,
							course_file_path : courseFilePath,
						},
						success : function(rep) {
							if (rep.result == 0) {
								clearError("#addBaseTeamForm .field",
										"#addBaseTeamForm");
								$('#termModal').modal('hide')
								$.alert("", rep.message);
							} else {
								clearError("#addBaseTeamForm .field",
										"#addBaseTeamForm");
								pageindex = 1;
								temppage = 1;
								pagelength = 10;
								settable();
								if(term_name.indexOf("第一")>0){
									$.confirm({
										msg :'您已成功添加['+term_name+'],点击导入对应班级',
										btnSure : "导入班级",
										btnCancel : '取消',
										sureDo : function() {
											open(BASE_PATH+"/qm/base/base_class.jsp?term_no="+add_termno+"&module=10&menu=18")
											$.confirm({
												msg :'请继续导入['+term_name+']对应班级学生',
												btnSure : "导入学生",
												btnCancel : '取消',
												sureDo : function() {
													open(BASE_PATH+"/qm/base/new_base_student.jsp?term_no="+add_termno+"&module=10&menu=18")
													$.confirm({
														msg :'请继续导入['+term_name+']对应班级课程',
														btnSure : "导入课程",
														btnCancel : '取消',
														sureDo : function() {
															open(BASE_PATH+"/qm/base/base_course_wh.jsp?term_no="+add_termno+"&module=10&menu=18")
														}, 
														cancelDo : function() {
															return;
														}
													});
												},
												cancelDo : function() {
													return;
												}
											});
										},
										cancelDo : function() {
											return;
										}
									});
								}else if(term_name.indexOf("第二")>0){
									$.confirm({
										msg :'请导入['+term_name+']对应班级课程',
										btnSure : "导入课程",
										btnCancel : '取消',
										sureDo : function() {
											open(BASE_PATH+"/qm/base/base_course_wh.jsp?term_no="+add_termno+"&module=10&menu=18")
										}, 
										cancelDo : function() {
											return;
										}
									});
								}
							}
						}
					});
					hideTeacherModal();
				}
			});
	//取消添加
	$("#termCancelModal").click(function() {
		//setTimeout(function(){$("#teacherModal").modal("hide")},2000);
		clearError("#addBaseTeamForm .field", "#addBaseTeamForm");
		//$('#termModal').modal('hide')
	});
</script>
<!--这里引用其他JS-->
</html>