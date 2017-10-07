<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>
<%@ include file="/commonjsp/jgxgridtable.jsp"%>
<script src="script/common/datepicker/jquery.datetimepicker.js"
	type="text/javascript"></script>
<script src="script/common/uploadify/jquery.uploadify.min.js"
	type="text/javascript"></script>
<link rel="stylesheet"
	href="script/common/datepicker/jquery.datetimepicker.css" />
<title>校内教学质量监控运行平台</title>
<style>
	#depdiv .label {
		margin-bottom: 10px;
	}
	.results {
		overflow-y:scroll;
		height:300px;  
	} 
	.display{
	 color:black;
	 pointer-events:none;
	color:#afafaf;
	cursor:default
	}
	.file {
    position: relative;
    display: inline-block;
    background: #1B1C1D;
    border-radius: 4px; 
    overflow: hidden;
    color: white;
    text-decoration: none;
    text-indent: 0;
    font-size: .92857143rem;
    font-weight:700;
    width:50%;
    text-align:center;
    height:15%;
    padding: 0.3em;
	}
	.file input {
	    position: absolute;
	    font-size: 100px;
	    right: 0;
	    top: 0;
	    opacity: 0;
	    color: white;
	}
	.file:hover {
	    background: #27292A;
	    /* border-color: #27292A; */
	     color: white;
	    text-decoration: none;
	}
	.one.field{
		margin-left:5%!important;
	}
	.second.field{
		margin-left:-5%!important;
	}
	.dropdownImport{
		max-width:80%!important;
	}
	#serach_class_name{
	min-width:200%!important;
	margin-left:10%;
	}
	.get_termyear_select1{
	min-width:auto!important;
	}
 	 .templeftfiled{
 	     margin-left:88px!important;
	}  
	.search_like_data{
	    width:130%!important;
	}
	.clear{
		clear:both;
	}
</style>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<%
		//接收参数
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String term_noacceptance = "";
		if(request.getParameter("term_no")!=null){
			term_noacceptance = request.getParameter("term_no");
		}
	%>
	<!--这里绘制页面-->
	<div id="container">
			<!-- 标题 -->
		<div class="ui  header">
			<h3 class="ui header" id='tittle'>
				<i class="tasks icon"></i>
				<div class="content">班级管理</div>
			</h3>
			<!-- 			<div class="sub header" style="margin-left:14px; margin-top: 5px">课程管理，您可对课程信息进行添加、修改、删除、设置等操作</div> -->
		</div>
		<!-- 标题 -->
		<div class="ui raised">
			<div class="ui form">
				<div id="depdiv">
					<a class="ui blue label" id="all">全&nbsp;&nbsp;&nbsp;&nbsp;部</a>
				</div>
				<div id="container_function" style="margin-top: 10px;">
					<div class="fields">
						<div class="field">
							<select class="ui mini get_termyear_select"
								id="get_termyear_select">
							</select>
						</div>
						<div class=" field get_termyear_select1">
							<div  class="ui input circulari  basic icon search_like_data"
								data-content="输入班级名称">
								<input id="serach_class_name" type="text" placeholder="班级名称">
							</div>
						</div>
						<div class="clear"></div>
						<div class="field templeftfiled">
							<div class="ui circulari olive icon button " id="searchbutton">
								<i class="search icon"></i>搜索
							</div>

						</div>
						<div class="field" style="float: left!important">
							<div class="ui input circulari  basic icon "
								data-content="导入班级数据" >
								<div class="ui small teal  button addAward" id="importBtn">
									<i class="paw icon"></i> 导入
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>


		<div class="ui modal" id="newBaseTermModal">
			<i class="close icon"></i>
			<div class="header" id="statustitle">编辑班级</div>
			<div class="content">
				<form class="ui form addBaseStuForm" id="addBaseStuForm">
					<div class="three fields">
						<div id="divAddClassName" class="field required">
							<label>班级名称</label> <input placeholder="请输入班级名称"
								name="add_classname" type="text" id="addclassname" />
						</div>
						<div id="divAddClassStuAmount" class="field required">
							<label>班级人数</label> <input placeholder="请输入班级人数"
								name="add_classstuamount" type="text" id="addclassstuamount" />
						</div>
						<div id="divAddStuMajor" class="field required ">
							<label class="ui pointing  ">所属专业</label> 
							
							<div id="addmajor" class="ui selection dropdown">
							  <input type="hidden" name=major> 
							  <i class="dropdown icon"></i>
							  <div class="default text"></div>  
							  <div class="menu"> 
							    
							  </div>
							</div>

						</div>
					</div>
						<div class="two fields">
								<div class="field">
							      <label>设置本班班主任</label>
							      <div class="tea ui small search">   
									  <div class="ui icon input">
							      		  <input class="prompt" id="tea" placeholder="请输入教师姓名或教工号..." type="text">
							   		  </div>
							          <div class="results"></div>
							       </div>
							     </div>
								
								<div class="field">
							      <label>设置本班信息员</label>
							      <div class="stu ui small search">   
									  <div class="ui icon input">
							      		  <input class="prompt" id="stu" placeholder="请输入学生学号或姓名..." type="text">
							   		  </div>
							          <div class="results"></div>
							       </div>
							     </div>
						</div>
					<div class="two fields"> 
						<div id="divdep_no" class="field required">
							<label>所属部门</label> 
							
							
							<div id="dep_no_select" class="ui selection dropdown">
							  <input type="hidden" name=dep> 
							  <i class="dropdown icon"></i>
							  <div class="default text"></div>  
							  <div class="menu"> 
							    
							  </div>
							</div>

						</div>
						<div id="divis_over" class="field required"> 
							<label>是否毕业班</label>   
							
							<div id="is_over_select" class="ui selection dropdown">
							  <input type="hidden" name="isover"> 
							  <i class="dropdown icon"></i>
							  <div class="default text">否</div> 
							  <div class="menu">
							    <div class="item" name = '0'>否</div>
							    <div class="item" name="1">是</div>
							  </div>
							</div>

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
			<div class="header" id="statusExcelTitle">导入班级数据</div>
			<div class="content">
				<form class="ui form addBaseTeamForm" id="addBaseTeamForm">
					<div class="three fields">
						<div id="divTermNo" class="field">
							<label class="ui pointing">学年学期编号</label> <select
								class="ui mini dropdownImport" id="dropdownImport">
							</select>
						</div>
						<div class="one field">
							<label>导入班级数据</label>
							 <a href="javascript:;" class="file"><!-- 选择文件 --> 
								<input  type="file" name="stuuploadify" id="stuuploadify" />
							</a> 

						</div>
						<div class="second field">
							<label>模板下载</label> 
							<a class="selectButton ui red small labeled icon add button"href="template/class.xls"><i class="download icon"></i>导入班级模板</a>
						</div>

					</div>
					
				</form>
			</div>
			<div class="actions">
				<div class="ui black deny button" id="termCancelModal2">取消</div>
				<div class="ui red right labeled icon button"
					id="excelImportSaveModal">
					导入 <i class="checkmark icon"></i>
				</div>
			</div>
		</div>


		<table class="ui celled center very compact blue striped table"
			id="tablehead">
			<thead>
				<tr class="center aligned">
					<th>班级名称</th>
					<th>班级人数</th>
					<th>班主任</th>
					<th>信息员</th>
					<th>是否毕业班</th>
					<th>专业</th>
					<th>部门</th>
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
<!-- 		<div class="ui green large message" id="no_function2"> -->
<!-- 			<i class="announcement large inverted yellow up circular icon"></i> -->
<!-- 			本学期还没有班级哦! -->
<!-- 		</div> -->
	</div>
</body>
<script type="text/javascript">
	$('.ui.input.circulari.basic.icon').popup();
	var temp_termno = SYSOBJCET.term_no;
	var temp_termname = SYSOBJCET.term_name;
	var temp_dep_no = "all";
	var temp_dep_name = '全部';
	var temp_serach_class_name = "";
	var totalpage;
	var pageindex = 1;
	var temppage = 1;
	var pagelength = 15;
	var temp_edit_major_no = ""; 
	var temp_edit_major_name = "";
	var temp_get_dep_no = 'all';
	var temp_edit_dep_no = 'all';//所属部门号
	var temp_edit_dep_name = '';//所属部门名称
	var temp_edit_is_over = 0;
	var temp_save_class_no;
	var teaid=""; 
	var stuid="";  
	var studentFilePath = "";
	var userpurview = USEROBJECT.userpurview;
	var term_noacceptance = "";
	var teacher_noT="";
	var stu_noT="";
	term_noacceptance = '<%=term_noacceptance%>'
	//导入学年
	var temp_term_no ="";
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
	loadingTable();
	$("#searchbutton").click(function() {
		temp_serach_class_name = $("#serach_class_name").val();
		pageindex = 1;
		temppage = 1;
		pagelength = 15;
		loadingTable();

	}); 

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

	 
    $("#importBtn").unbind('click').click(function() {
    	showmodel();
    });
   
    function showmodel(){
    		$('#importExcelModal').modal("setting", "closable", false).modal("show");
    			loadImportterm();
    			initFilePath();
    }
    var term_dep ="";
//	function loadingDropDownDep() {
    //		$.ajax({
    //			url : "do?invoke=commonAction@queryBaseDep",
    //			type : 'POST',
    //			dataType : 'json',
    //			success : function(rep) {
    //				if (rep.result == 0) {
    //					$.alert("", rep.message);
    //				} else {
    //					term_dep=rep.data
    //					editDropDownDep(rep.data);
    //				}
    //			}
    //		});
    //	}
    //
    //	function editDropDownDep(temp_data) {
    //		var selectDep = temp_data;
    //		for (var i = 0; i < selectDep.length; i++) {
    //			$("#dep_no_select .menu").append(
    //					"<div class='item' name = '"+selectDep[i].dep_no+"'>"+selectDep[i].dep_name+"</div>");
    //		}
    //		 if(term_noacceptance==""||term_noacceptance==null){
    //		    }else{
    //		    	showmodel();
    //		    }
    //	}

	
	function loadingDropDownMajor() {
		$.ajax({
			url : "do?invoke=commonAction@queryBaseMajor",
			type : 'POST',
			dataType : 'json',
			success : function(rep) {
				if (rep.result == 0) {
					$.alert("", rep.message);
				} else {
					addDropDownMajor(rep.data);
				}
			}
		});
	}

	//添加所属部门
	function addDropDownMajor(temp_data) {
		var selectDep = temp_data;   
	 
		for (var i = 0; i < selectDep.length; i++) { 
			$("#addmajor .menu").append( 
					"<div class='item' name = '"+selectDep[i].major_no+"'>"+selectDep[i].major_name+"</div>");
		} 

		//获取当前选择的
	}
	

	//保存
	$("#stuSaveModal").unbind('click').click(function() {
		$.ajax({
			url : "do?invoke=baseClassAction@updateBaseClass",
			type : 'POST',
			dataType : 'json',
			data : {
				class_no : temp_save_class_no,
				class_name : $("#addclassname").val(),
				major_no : temp_edit_major_no,
				teacher_no : teaid,  
				stu_no : stuid,
				dep_no : temp_edit_dep_no,
				class_stu_amount : $("#addclassstuamount").val(),
				class_isover : temp_edit_is_over,
				teacher_noT:teacher_noT,
				stu_noT:stu_noT
			},
			success : function(rep) {
				if (rep.result == 0) {
					hideEditModal();
					$.alert("", rep.message);
				} else {
					hideEditModal();
					//pageindex = 1;
					temppage = 1;  
					pagelength = 15; 
					loadingTable();
				}
			}
		}); 
	});

	function searchSettable(search_like_data) {

		$('#tablepane').html("");
		$("#spanFirst").attr("temp", '0');
		$("#spanNext").attr("temp", '0');
		$("#spanPre").attr("temp", '0');
		$("#spanLast").attr("temp", '0');

		$.ajax({
			url : "do?invoke=baseClassAction@searchBaseClassList",
			type : 'POST',
			dataType : 'json',
			data : {
				pageindex : pageindex,
				pageLength : pagelength,
				master_no : USEROBJECT.userinfo.teacher_no,
				term_no : SYSOBJCET.term_no,
				temppage : temppage,
				dep_no : temp_get_dep_no,
				search_like_data : search_like_data,
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
				initTableBody(rep.rows);
			}

		});

	}
	/**
	 * 班级维护
	 */
	// 获取当前所有的部门
	function getCurrentDep(data) {
		var deps = data;
		$("#depdiv").hide(); 
		if( temp_dep_no.trim() != "all"){ 
			pageindex = 1; 
			temppage = 1; 
			pagelength = 15;
			
		}else{   
			$("#depdiv .dep").remove();
			console.log(deps)
			for (var i = 0; i < deps.length; i++) {
				if (deps[i].dep_name == "外语系") {

				} else {
					if (deps[i].dep_type!="行政"){
						var depdiv = $('<a class="dep ui gray label"" id="'
								+ deps[i].dep_no + '">' + deps[i].dep_name + '</a>');
						$("#depdiv").append(depdiv);
					}
				}
			}
			$("#depdiv").fadeIn();
			$("#depdiv .label").click(function() {
				$("#depdiv .blue").removeClass("blue");
				temp_serach_class_name="";
				$(this).addClass("blue");
				temp_dep_no = this.id;
				pageindex = 1;
				temppage = 1;
				pagelength = 15;
				loadingTable();
			});
		}
		
	}
	
	//读取所有的学期信息放入下拉框
	function loadImportterm() {
		$.ajax({
			url : "do?invoke=baseClassAction@gettermnyearoinformation",
			type : 'POST',
			dataType : 'json',
			success : function(rep) {
				console.log(temp)
				if (rep.result == 0) {
					$.alert("", rep.message);
					return;
				} else {
					var temp = rep.data
					for (var i = 0; i < temp.length; i++) {
						var dom = ' <option value="'+temp[i].year_no+'">'
								+ temp[i].year_no + '学年</option>';
						$("#dropdownImport").prepend(dom)
					}

					$('.ui.dropdownImport').dropdown();
				}
				temp_term_no = $("#dropdownImport").val();
				 $("#dropdownImport").change(
						function() {
							var term_no = $("#dropdownImport").val();
							var term_name = $("#dropdownImport").find(
									"option:selected").text();
							temp_term_no = term_no;
						});
			} 
		});
	}
	// 获取当前所有的学年(2015/2014)
	function getCurrentTermYear() {
		$("#get_termyear_select").empty();
		$.ajax({
			url : "do?invoke=baseClassAction@gettermnyearoinformation",
			type : 'POST',
			dataType : 'json',
			success : function(rep) {
				console.log(rep)
				if (rep.result == 0) {
					$.alert("", rep.message);
					return;
				} else {
					var temp = rep.data
					for (var i = 0; i < temp.length; i++) {
						var dom = ' <option value="' + temp[i].year_no + '">'
								+ temp[i].year_no + '年</option>';
						$("#get_termyear_select").append(dom)
					}
					$('.ui.get_termyear_select').dropdown();
				}

				$("#get_termyear_select").change(function() {
					// 判断当前的学年学期是否存在
					temp_termno = $("#get_termyear_select").val();
					pageindex = 1;
					temppage = 1;
					loadingTable();

				});
			}
		});
	}
	// 获取表格数据
	function loadingTable() {
		$('#tablepane').html("");
		$("#spanFirst").attr("temp", '0');
		$("#spanNext").attr("temp", '0');
		$("#spanPre").attr("temp", '0');
		$("#spanLast").attr("temp", '0');
		$
				.ajax({
					url : "do?invoke=baseClassAction@queryBaseClassList",
					type : 'POST',
					dataType : 'json',
					data : {
						term_no : temp_termno,
						dep_no : temp_dep_no,
						serach_class_name : temp_serach_class_name,
						pageindex : pageindex,
						pageLength : pagelength,
						temppage : temppage
					},
					success : function(rep) {
						if (rep.total == 0) {
							$("#spanbutton").hide();
							$('#tablehead').hide();
							$('#message').remove();
							var dom = '<div class="ui green large message" id="message">'
									+ '<i class="frown large inverted yellow circular icon"></i> 暂无相关班级数据！'
									+ '</div>';
							$('#container').append(dom);
							return;
						} else {
							$("#spanbutton").show();
							$('#tablehead').show();
							$('#message').remove();
							if (temppage == 1) {
								var count = 0;
								if (rep.total % pagelength != 0)
									count = 1;
								totalpage = parseInt(rep.total / pagelength)
										+ count;
								$("#spanLast").attr("page", totalpage);
								$("#spanTotalPage").text(totalpage);
							}
							temppage++;
							initTableBody(rep.rows);

						}

					}

				});
	}

	function initTableBody(tabledata) {
		var temp = tabledata;
		for (var i = 0; i < temp.length; i++) {
			var dom = '<tr id="tr' + i + '">';
			dom += '<td id="class_name' + i + '">' + temp[i].class_name + '</td>';
			dom += '<td id="class_stu_amount' + i + '">' + temp[i].class_stu_amount 
					+ '</td>';
			dom += '<td id="teacher_name' + i + '">' + temp[i].teacher_name
					+ '</td>';
			dom += '<td id="stu_name' + i + '">' + temp[i].stu_name + '</td>';
			if (temp[i].class_isover == 1) {
				dom += '<td id="class_isover' + i + '">' + '是' + '</td>';
			} else {
				dom += '<td id="class_isover' + i + '">' + '否' + '</td>';
			}
			dom += '<td id="major_name' + i + '">' + temp[i].major_name + '</td>';
			dom += '<td id="dep_name' + i + '">' + temp[i].dep_name + '</td>';
			dom += '<td>'
					+ '<div class="editT btnfirst circular ui small blue basic icon button" classno="'
					+ temp[i].class_no
					+ '" classname="'
					+ temp[i].class_name
					+ '" classstuamount="'
					+ temp[i].class_stu_amount 
					+ '" majorno="'
					+ temp[i].major_no
					+ '" majorname="'
					+ temp[i].major_name
					+ '" teacherno="'
					+ temp[i].teacher_no
					+ '" teachername="'
					+ temp[i].teacher_name
					+ '" stuno="'
					+ temp[i].stu_no
					+ '" stuname="'
					+ temp[i].stu_name
					+ '" depno="'
					+ temp[i].dep_no
					+ '" depname="'
					+ temp[i].dep_name
					+ '" classisover="'
					+ temp[i].class_isover
					+ '" data-content="点击编辑此班级">'
					+ '<i class="edit icon"></i>'
					+ '</div>' + 
					'<div class="adminClass btnfirst circular ui small blue basic icon button" classno="'
					+ temp[i].class_no
					+ '" classname="'
					+ temp[i].class_name
					+ '" depno="'
					+ temp[i].dep_no
					+ '" term_no="'
					+ temp[i].class_session_year
					+ '" data-content="点击编辑班级学生">'
					+ '<i class="unordered list icon"></i>'
					+ '</div>' +
					'</td>';
			$("#tablepane").append(dom);
		}
		$('.btnfirst.circular.ui.blue.basic.icon.button').popup();
		adminBindClick();
		$('.editT').unbind('click').bind(
				"click",
				function() {
					var tempclass = $(this).closest("tr");
					var class_no = $(this).attr("classno");
					var class_name = $(this).attr("classname");
					var class_stu_amount = $(this).attr("classstuamount");
					var major_no = $(this).attr("majorno");
					var major_name = $(this).attr("majorname");
					var teacher_no = $(this).attr("teacherno");
					var teacher_name = $(this).attr("teachername");
					var stu_no = $(this).attr("stuno");
					var stu_name = $(this).attr("stuname");
					var dep_no = $(this).attr("depno");
					var dep_name = $(this).attr("depname");
					var class_isover = $(this).attr("classisover");
					teacher_noT=$(this).attr("teacherno");
					stu_noT=$(this).attr("stuno");
					editClassesTableRow(tempclass, class_no, class_name,
							class_stu_amount, major_no, major_name, teacher_no,
							teacher_name, stu_no, stu_name, dep_no, dep_name,
							class_isover);
				});

		if (totalpage == 0)
			$("#spanPageNum").text(0);
		else
			$("#spanPageNum").text(pageindex);
		// 判断按钮是否禁用 
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

     //点击跳转管理班级人数
     function adminBindClick(){
    	 $('.adminClass').unbind('click').click(function(){
 			var class_Tno=$(this).attr('classno');
 			var dep =$(this).attr('depno');
 			var term = "";
 			term=temp_termno.substring(0,4);
 			term+=0;
 			open(BASE_PATH+"/qm/base/new_base_student.jsp?class_Tno="+class_Tno+"&term_no="+term+"&dep_no="+dep+"&module=10&menu=17")
 		})
     }
	//班级编辑信息
	function editClassesTableRow(tempclass, class_no, class_name, class_stu_amount,
			major_no, major_name, teacher_no, teacher_name, stu_no, stu_name,
			dep_no, dep_name, class_isover) {
		
		//
		temp_save_class_no = class_no;
		getAllTeaStu();
		//
		 
		$("#addclassname").val(class_name);  
		$("#addclassstuamount").val(class_stu_amount);
	/* 		$("#addTeacherNo").val();
		$("#addTeacherName").val();
		$("#addStuNo").val(); 
		$("#addStuName").val(); */
		$("#tea").val(teacher_name);
		$("#stu").val(stu_name);
		temp_edit_major_no = major_no; 
		temp_edit_major_name = major_name;
		temp_edit_is_over = class_isover;  
		temp_edit_dep_no = dep_no;
		temp_edit_dep_name = dep_name;
		teaid = teacher_no;  
		stuid=stu_no;
		
		if(temp_edit_is_over !='1'){   
			$('#is_over_select input').val('否'); 
		}else{  
			$('#is_over_select input').val('是');  
		}  
		   
		$("#addmajor input").val(temp_edit_major_name);  
		$("#dep_no_select input").val(temp_edit_dep_name); 
		//切换是否毕业班
		$("#is_over_select .item").click(function() { 
			temp_edit_is_over = $(this).attr('name');  
			console.log("选中毕业状态：" + temp_edit_is_over);
		});
		//切换所属部门
		$("#dep_no_select .item").unbind('click').click(
				function() {
					temp_edit_dep_no = $(this).attr('name');  
					temp_edit_dep_name = $(this).text().trim();
				});

		//切换所属于专业
		$("#addmajor .item").unbind('click').click(function() {  
			 
			temp_edit_major_no = $(this).attr('name');     
			temp_edit_major_name = $(this).text().trim();
			console.log(temp_edit_major_no)
		});
		showEditModal(); 
	}
	 
	function showEditModal() {
		$('#newBaseTermModal').modal("setting", "closable", false).modal("show");
		$('#is_over_select') 
		  .dropdown(); 
		$('#addmajor').dropdown();
		$('#dep_no_select').dropdown(); 
	}
	function hideEditModal() {
		$('#newBaseTermModal').modal("setting", "closable", false).modal("hide");
	}
	function getAllTeaStu() {
		$.ajax({
			url:"do?invoke=baseClassAction@getTeaStu",
			type:'POST', 
			dataType:'json',
			data:{
				classno:temp_save_class_no
			},
			success:function(rep) {
				
				if(rep.result==0) {
					$.alert("没有取到教师或学生的相关信息~");
					return;
				} else {  
					 
					var teastu=rep.data[0];
					var alltea=[];
					var allstu=[];
					for(var i=0; i<teastu.teatb.length; i++) {
						alltea[i] = {title:teastu.teatb[i].teacher_name,description:teastu.teatb[i].teacher_no,"id":teastu.teatb[i].teacher_no};
					}
					$('.tea.ui.search').search({
						 source: alltea,
						 maxResults:10000,   
						 onSelect:function(itemtea) {
							 teaid = itemtea.id;
						 }
					  });	
					console.log(rep)
					 for(var j=0; j<teastu.stutb.length; j++) {
						 allstu[j] = {title:teastu.stutb[j].stu_name,description:teastu.stutb[j].stu_no,"id":teastu.stutb[j].stu_no};
					 } 
					 $('.stu.ui.search').search({
						 source: allstu,
						 maxResults:10000,    
						 onSelect:function(itemstu) { 
							 stuid = itemstu.id; 
						 }
					  });	
				}
			}
		});
	}
	 //文件上传
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
				    $('#excelImportSaveModal').addClass('loading')
				    $('#excelImportSaveModal').attr({"disabled":"disabled"});
					//每个文件即将上传前触发
					console.log('start update')
				},

				onUploadSuccess : function(file, data, respone) {
					$('#excelImportSaveModal').removeAttr("disabled");
					  $('#excelImportSaveModal').removeClass('loading')
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
    $("#excelImportSaveModal").unbind('click').click(function() {
    	temp_term_no = $("#dropdownImport").val();
    	console.log(temp_term_no);
			 	$.ajax({
							url : "do?invoke=baseClassAction@importExcelBaseStudents",
							type : 'POST',
							dataType : 'json',
							data : {
								term_no : temp_term_no,
								student_file_path : studentFilePath,
							},
							success : function(rep) {
								$.alert(rep.message)
							}
						});
				$('#importExcelModal').modal("setting", "closable",
						false).modal("hide"); 
			});
</script>
<!--这里引用其他JS-->
</html>