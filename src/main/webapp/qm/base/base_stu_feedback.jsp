<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<%
	String rootpath = new PropertyConfig("sysConfig.properties").getValue("rootpath");
%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>
<script src="script/common/datepicker/jquery.datetimepicker.js"
	type="text/javascript"></script>
<link rel="stylesheet"
	href="script/common/datepicker/jquery.datetimepicker.css" />
<title>校内教学质量监控运行平台</title>
<style>
#depdiv .label {
	margin-bottom: 10px;
}

.ui.fluid.selection.dropdown {
	width: 30%;
	margin-left: 70%;
}

.listenxxInf {
	display: none;
}

#grbtkjl {
	float: left;
}

.ui.blue.striped.table {
	width: 100%;
}

#tkjs {
	width: 13%;
}
#addBtn{
margin-left:80.5%;
}
</style>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
		<div class="ui  header" id="feedback_head">
			<h3  class="ui header "> 
		  			<i class="unordered list icon"></i>
		  				信息员反馈
			</h3>
			<div class="sub header" style="margin-left: 14px; margin-top: 5px">您可对当前班级所上的课程进行评价</div>
		</div>
		<div class="ui small teal button addAward" id="addBtn">
			<i class="smile square icon"></i> 填写建议与反馈
		</div>
		<!-- 		<div class="ui selection dropdown"> -->
		<!-- 			<i class="dropdown icon"></i> <span class="default text">请先选择学年学期</span> -->
		<!-- 			<div class="menu infro"></div> -->
		<!-- 		</div> -->

		<div class="ui modal" id="newBaseTeacherModal">
			<i class="close icon"></i>
			<div class="header" id="statustitle">填写建议与反馈</div>
			<div class="content">
				<div class="ui one column grid">
					<div class="column">
						<div class="ui form">
							<div class="field">
								<div class="ui blue ribbon label" id="aaa">1、教师教学情况(选择反馈的课程)</div>
								<div id="depdiv" style="margin: 10px;">
									
								</div>
								<div class="inline fields" style="margin: 10px">
									<a class="teal label">建议作用：</a>
									<div class="field">
										<div class="ui radio checkbox">
											<input type="radio" name="teach_case" checked="checked"
												value="正面意见"> <label>正面意见</label>
										</div>
									</div>
									<div class="field">
										<div class="ui radio checkbox">
											<input type="radio" name="teach_case" value="反面意见"> <label>反面意见</label>
										</div>
									</div>
								</div>
								<p style="margin: 10px">
									<textarea id="teach_case_text" rows="3" placeholder="可以输入100个字"></textarea>
								</p>
							</div>
							<div class="field">
								<div class="ui blue ribbon label">2、教学条件</div>
								<div class="inline fields" style="margin: 10px">
									<a class="teal label">建议区域：</a>
									<div class="field">
										<div class="ui radio checkbox">
											<input type="radio" name="teach_conditions" checked="checked"
												value="教室"> <label>教室</label>
										</div>
									</div>
									<div class="field">
										<div class="ui radio checkbox">
											<input type="radio" name="teach_conditions" value="实验室">
											<label>实验室</label>
										</div>
									</div>
									<div class="field">
										<div class="ui radio checkbox">
											<input type="radio" name="teach_conditions" value="图书资料">
											<label>图书资料</label>
										</div>
									</div>
									<div class="field">
										<div class="ui radio checkbox">
											<input type="radio" name="teach_conditions" value="运动场馆">
											<label>运动场馆</label>
										</div>
									</div>
									<div class="field">
										<div class="ui radio checkbox">
											<input type="radio" name="teach_conditions" value="其他">
											<label>其他</label>
										</div>
									</div>
								</div>
								<p style="margin: 10px">
									<textarea id="teach_conditions_text" rows="3"
										placeholder="可以输入100个字"></textarea>
								</p>
							</div>
							<div class="field">
								<div class="ui blue ribbon label">3、学风</div>
								<p style="margin: 10px">
									<textarea id="stu_learningStyle" rows="3"
										placeholder="可以输入100个字"></textarea>
								</p>
							</div>
							<div class="field">
								<div class="ui blue ribbon label">4、其他</div>
								<p style="margin: 10px">
									<textarea id="stu_other" rows="3" placeholder="可以输入100个字"></textarea>
								</p>
							</div>
							<div class="field">
								<div class="ui blue ribbon label">5、措施及建议</div>
								<p style="margin: 10px">
									<textarea id="stu_advice" rows="3" placeholder="可以输入100个字"></textarea>
								</p>
							</div>
							<div class="field">
								<div class="ui blue ribbon label">6、备注</div>
								<p style="margin: 10px">
									<textarea id="stu_remarks" rows="3" placeholder="可以输入100个字"></textarea>
								</p>
							</div>
						</div>
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

		<table class="ui celled center very compact blue striped table"
			id="feedback_table">
			<thead>
				<tr class="center aligned">
					<th>反馈日期</th>
					<th>反馈标题</th>
					<th>反馈类型</th>
<!-- 					<th>所属课程</th> -->
					<th>回复人员</th>
					<th>回复日期</th>
					<th>查看详情</th>
				</tr>
			</thead>
			<tbody id="tablepane" class="center aligned">
			</tbody>
		</table>
		<div class="ui green large message" id="no_function">
			<i class="frown large inverted yellow circular icon"></i>
			抱歉！您不是信息员哦，暂不能使用此功能！
		</div>
		<div class="ui green large message" id="no_function2">
			<i class="announcement large inverted yellow up circular icon"></i>
			本学期还未进行反馈哦!
		</div>
	</div>
	<!--这里绘制页面-->
</body>
<script>
	var SYSOBJCET =<%=SYSOBJCET%>;
	var USEROBJECT =<%=USEROBJECT%>;
	var temp_task_id;
	var userType = USEROBJECT.usertype;
	var term_no = SYSOBJCET.term_no;
	var stu_no = "";
	var class_no = "";
	var Tsperson = "";

	//判断当前是否是信息员
	if (userType == "教师") {
		$('#feedback_head').hide();
		$('#addBtn').hide();
		$('#feedback_table').hide();
		$('#no_function2').hide();
		$('#no_function').show();
	} else {
		//stu_no = USEROBJECT.loginname;
		//class_no = USEROBJECT.userinfo.class_no;
		loadingTable();
	}

	function loadingTable() { //点击学期刷新表单学期  
		$('#tablepane').html("");
		$.ajax({
			url : "do?invoke=baseFeedBackAction@getStudentFeedBacksList",
			type : 'POST',
			dataType : 'json',
			data : {
				stu_no : USEROBJECT.loginname,
			},
			success : function(rep) {
				if (rep.result == 0) {
					$('#feedback_head').show();
					$('#addBtn').show();
					$('#feedback_table').hide();
					$('#no_function').hide();
					$('#no_function2').show();
					return;
				} else {
					console.log(rep);
					//判断反馈列表是否为空
					Tsperson = rep.selresult.data;
					if(rep.result.data.length > 0){
						$('#feedback_head').show();
						$('#addBtn').show();
						$('#feedback_table').show();
						$('#no_function').hide();
						$('#no_function2').hide();
						initTable(rep.result);       
					}else{
						$('#feedback_head').show();
						$('#addBtn').show();
						$('#feedback_table').hide();
						$('#no_function').hide();
						$('#no_function2').show();
					}
					
				}

			}
		});
	}
	function initTable(rep) {
		var temp = rep.data;
		console.log(temp.length);
		for (var i = 0; i < temp.length; i++) {
			var dom = '<tr class="listenInf">';
			dom += '<td>' + temp[i].feedback_time + '</td>';
			if(temp[i].feedback_title == "教师教学情况") {
				dom += '<td>' + temp[i].feedback_title + ' 《'+ temp[i].course_name+'》 </td>';
			} else {
				dom += '<td>' + temp[i].feedback_title + '</td>';
			}
			
			dom += '<td>' + temp[i].feedback_type + '</td>';
			if (temp[i].task_id == 0) {
				temp[i].task_id = "";
			}
			//dom += '<td>' + temp[i].task_id + '</td>';
			dom += '<td>' + temp[i].account_no + '</td>';
			dom += '<td>' + temp[i].resp_time + '</td>';
			dom += '<td ><div class="btnfirst circular ui small blue basic icon button"><i class="file text icon"></i></div></td>';
			dom += '</tr>';
			dom += '<tr class="listenxxInf" >'
					+ '<td colspan=1 class="positive">反馈内容</td>'
					+ '<td colspan=5 class="positive">'
					+ temp[i].feedback_content + ' </td>' + '</tr>'
					+ '<tr class="listenxxInf">'
					+ '<td colspan=1 class="positive" >回复内容 </td>'
					+ '<td colspan=5 class="positive" >' + temp[i].resp_content
					+ ' </td>' + '</tr>';
			$("#tablepane").append(dom);
		}
		$('.btnfirst.circular.ui').click(
				function() { //点击查看详情        
					$(this).parents(".listenInf").next().fadeToggle(500).next()
							.fadeToggle(500);
				});

	}

	$("#addBtn").click(function() {
		$("#stu_remarks").val("")
		getStuCourse();
		showEditModal();
	});
	$("#teacherCancelModal").click(function() {
		hideEditModal();
	});
	$("#teacherSaveModal").click(
			function() {
					$.ajax({   
						url : "do?invoke=baseFeedBackAction@addStudentFeedBacks",
						type : 'POST',
						dataType : 'json',
						data : {
							stu_no : USEROBJECT.loginname,
							task_id : temp_task_id ,
							teach_case : $(
									"input[name='teach_case'][type='radio']:checked")
									.val(),
							teach_case_text:$(
							"#teach_case_text").val(),
							teach_conditions_type : $(
									"input[name='teach_conditions'][type='radio']:checked")
									.val(),
							teach_conditions_text : $(
									"#teach_conditions_text").val(),
							stu_learningStyle : $(
									"#stu_learningStyle").val(),
							stu_other : $("#stu_other").val(),
							stu_advice : $("#stu_advice").val(),
							stu_remarks : $("#stu_remarks").val(),

						},
						success : function(rep) {
							if (rep.result == 0) {
								hideEditModal();
								return;
							} else {
								hideEditModal();
								loadingTable();
								
		 						if(Tsperson == "" || Tsperson == null) {
		 							return;
		 						} else {
		 							for(var i=0; i<Tsperson.length; i++) {
		 								if(Tsperson[i].role_id == "7") {
		 									new $.getPort({
												config:{
													tourl:"postInfData.interface",           
													inf_type:"信息员意见反馈", 
													inf_importance:"0",
													inf_content:""+Tsperson[0].dep_name+" - "+Tsperson[0].class_name+" 班级信息员 "+USEROBJECT.username+" 反馈意见啦！",
													inf_post:"质量监控平台",
													inf_get_name:"质量监控平台",
													inf_get:Tsperson[i].user_loginname,
													inf_system:'qm',
													inf_return_url:'<%=rootpath%>'+"qm/base/base_qm_feedback.jsp?module=10&menu=57",
												},
												callback:function(rep){
													if(rep.result == '0'){
														console.log("信息发送失败！");
													}else{
													
													}
												}
											});
		 								} else if(Tsperson[i].role_id == "11") {
		 									new $.getPort({
												config:{
													tourl:"postInfData.interface",           
													inf_type:"信息员意见反馈", 
													inf_importance:"0",
													inf_content:""+Tsperson[0].dep_name+" - "+Tsperson[0].class_name+" 班级信息员 "+USEROBJECT.username+" 反馈意见啦！",
													inf_post:"质量监控平台",
													inf_get_name:"质量监控平台",
													inf_get:Tsperson[i].user_loginname,
													inf_system:'qm',
													inf_return_url:'<%=rootpath%>'+"qm/base/base_supvision_feedback.jsp?module=11&menu=32",
												},   
												callback:function(rep){
													if(rep.result == '0'){
														console.log("信息发送失败！");
													}else{
													
													}
												}
											});
		 								}
		 							}
		 							
									 
		 						}
								
								
							}

						}
					});
				
			});

	function showEditModal() {
		$('#newBaseTeacherModal').modal("setting", "closable", false).modal(
				"show");
	}
	function hideEditModal() {
		$('#newBaseTeacherModal').modal("setting", "closable", false).modal(
				"hide");
	}
	function getStuCourse() {
		$.ajax({
			url : "do?invoke=baseFeedBackAction@getStudentCoursesList",
			type : 'POST',
			dataType : 'json',
			data : {
				term_no : term_no,
				stu_no : USEROBJECT.loginname,  
				class_no : class_no,
			},
			success : function(rep) {
				if (rep.result == 0) {
					//$.alert("", rep.message);
					return;
				} else {
					initDep(rep);
				}

			}
		});
	}
	function initDep(rep) {
		var deps = rep.data;
		console.log(rep);                 
		$("#depdiv .dep").remove();
		for (var i = 0; i < deps.length; i++) {
			var depdiv = $('<a class="dep ui gray label"" id="'+deps[i].task_no+'">'
					+ deps[i].course_name + '</a>');
			$("#depdiv").append(depdiv);
		}
		$("#depdiv").fadeIn();
		$("#depdiv .blue").removeClass("blue");
		$('a.dep.label#'+deps[0].task_no).addClass("blue");
		temp_task_id = deps[0].task_no;     
		$("#depdiv .label").click(function() {
			$("#depdiv .blue").removeClass("blue");
			$(this).addClass("blue");
			temp_task_id = this.id;
		});
	}
</script>
<!--这里引用其他JS-->
</html>