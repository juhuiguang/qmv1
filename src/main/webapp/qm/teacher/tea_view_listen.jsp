<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>
<script src="script/common/datepicker/jquery.datetimepicker.js"
	type="text/javascript"></script>
<link rel="stylesheet"
	href="script/common/datepicker/jquery.datetimepicker.css" />
<title>校内教学质量监控运行平台</title>
<style>
.ui.fluid.selection.dropdown {
	width: 25%;
	
}

.listenxxInf {
	display: none;
}


 
.ui.blue.striped.table {
	width: 100%;
}

#tkjs {
	width: 13%;
}  
</style>   
</head>   
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
		<div class="ui">
			<h3 class="ui header" id='grbtkjl'>
				<i class="tasks icon"></i>
				<div class="content">个人被听课记录</div>
			</h3>


			<div class="ui fluid selection dropdown">
				<i class="dropdown icon"></i> <span class="default text">请先选择课程</span>
				<div class="menu infro"></div>
			</div>
		</div>

		<table class="ui blue striped table" id="tableinf">
			<tbody>
				<tr>
					<td id="tkjs">听课教师</td>
					<td>听课时间</td>
					<td>课程名称</td>
					<td>上课班级</td>
					<td>课程类型</td>
					<td>查看详情</td>
				</tr>


			</tbody>
		</table>

	</div>
	<!--这里绘制页面-->
</body>
<script>
	$(function() {
		var SYSOBJCET =<%=SYSOBJCET%>; 
		var USEROBJECT =<%=USEROBJECT%>;   
		var term_no = SYSOBJCET.term_no;   
		var tea_no =USEROBJECT.loginname;    

		loadDropdown(tea_no); //初始化下拉框和当前学期信息  

		function loadDropdown(tea_no) { //提取学期   

			$.ajax({
						url : "do?invoke=teaViewListen@getTermInf",
						type : 'POST',
						dataType : 'json',
						success : function(rep) {
							if(rep.result==0){
								var dom='<div class="ui green large message" id="messageinf">'+
								'<i class="announcement large inverted yellow up circular icon"></i>'+
									' 没有学期信息'+   
								'</div>';

								$('#container').append($(dom));
							}else{
									var termInf = rep.data;
									for (var i = 0; i < termInf.length; i++) {
										var dom = '<div class="item termInf" name="'+termInf[i].term_no+'">'
												+ termInf[i].term_name + '</div>';
										$(".menu.infro").append($(dom));
										if (parseInt(termInf[i].term_status) == 1) {
											loadtable(termInf[i].term_no, tea_no);
											$(".default.text").text(
													termInf[i].term_name);
										}
									}
		
									$('.ui.dropdown').dropdown();
		
									$(".termInf").click(function() { //更换学期 
												$("#tableinf").show();  
												$("#messageinf").remove();  
												$('.listenInf').remove();
												$('.listenxxInf').remove(); 
												var term_No = $(this).attr("name");
												loadtable(term_No, tea_no);
											})
								}

						}
					});
		}
		function loadtable(term_no, tea_no) { //点击学期刷新表单学期  
			$
					.ajax({
						url : "do?invoke=teaViewListen@getTableInf",
						type : 'POST',
						dataType : 'json',
						data : {
							term_no : term_no,
							tea_no : tea_no,
						},
						success : function(rep) {
							if (rep.result == 0) {  
								$("#tableinf").hide(); 
								var dom='<div class="ui green large message" id="messageinf">'+
								'<i class="announcement large inverted yellow up circular icon"></i>'+
									' 本学期还没有被听课记录哦!'+   
								'</div>'; 

								$('#container').append($(dom));
							} else {
								var tableInf = rep.data;
								for (var j = 0; j < tableInf.length; j++) {
									var times = tableInf[j].listen_time
											.split(" ");
									var listentime = times[0];
									if (tableInf[j].skpj == "") {
										tableInf[j].skpj = "该督学什么评价都没有留下~";
									}
									if (tableInf[j].jxjy == "") {
										tableInf[j].jxjy = "该督学什么建议都没有留下~";
									}
									var table = '<tr class="listenInf">'
											+ '<td>'
											+ tableInf[j].teacher_name
											+ '</td>'
											+ '<td>'
											+ listentime
											+ '</td>'
											+ '<td>'
											+ tableInf[j].course_name
											+ '</td>'
											+ '<td>'
											+ tableInf[j].class_name
											+ '</td>'
											+ '<td>'
											+ tableInf[j].course_type
											+ '</td>'
											+ '<td >'
											+ '<div class="btnfirst circular ui small blue basic icon button"  >'
											+ '<i class="file text icon"></i>'
											+ '</div>'
											+ '</td>'
											+ '</tr>'
											+ '<tr class="listenxxInf" >'
											+ '<td colspan=1 class="positive">听课评价</td>'
											+ '<td colspan=5 class="positive">'
											+ tableInf[j].skpj
											+ ' </td>'
											+ '</tr>'
											+ '<tr class="listenxxInf">'
											+ '<td colspan=1 class="positive" >教学建议  </td>'
											+ '<td colspan=5 class="positive" >'
											+ tableInf[j].jxjy
											+ ' </td>'
											+ '</tr>';
									$('.ui.blue.striped.table')
											.append($(table));
								}

								$('.btnfirst.circular.ui').click(
										function() { //点击查看详情        
											$(this).parents(".listenInf")
													.next().fadeToggle(500)
													.next().fadeToggle(500);
										})
							}

						}

					});
		}

	});//JQ
	//--------------------------
</script>
<!--这里引用其他JS-->
</html>