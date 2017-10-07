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

.mini.ui.button.week {
	margin-top: 5px;
}

.ui.blue.striped.table {
	width: 100%;
}

#addBtn {
	float: right;
}

#tkjs {
	width: 13%;
}

#changebtn {
	cursor: pointer;
}
#zkxcIcon:hover {
    cursor: pointer; 
}
</style>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
		<div class="ui  header" id="feedback_head">
			<h3 class="ui header" id='tittle'>
				<i class="tasks icon"></i>
				<div class="content">巡查报告管理</div>
			</h3>

		</div>

		<div class="ui selection dropdown" id="selectterm">
			<i class="dropdown icon"></i> <span class="default text">请先选择学年学期</span>
			<div class="menu infro"></div>
		</div>
		<div class="ui small teal button addAward" id="addBtn">
			<i class="smile square icon"></i> 填写质控巡查报告
		</div>
		<div class="ui modal" id="newBaseTeacherModal">
			     
			<div class="header" id="statustitle">填写质控巡查报告<i class="close icon" id="zkxcIcon" style="float:right;cursor:pointer;"></i></div>
			<div class="content">
 
				<div class="ui segment" data-tab="first" id="alltask">
					<div>
						<h4 class="ui  center aligned horizontal divider header">
							<i class="file word outline icon"></i> 校督学巡查记录表
						</h4>
						<div id="selectweek">巡查周次：</div>
						<div class="ui horizontal segments ">
							<div class="ui left aligned segment">
								开始时间： <input id="datestar" type="text" style="width: 25%;">
								&nbsp;结束时间： <input id="dateend" type="text" style="width: 25%;">
							</div>
							<div class="ui left aligned segment">
								<p>部门：质量监控与评估处</p>
							</div>
						</div>

						<h4 class="ui horizontal divider header"
							style="margin-bottom: 20px">
							<i class="tag icon"></i> 巡查情况
						</h4>
					</div>
					<div class="ui one column grid">
						<div class="column">
							<div class="ui form">
								<div class="field">
									<div class="ui blue ribbon label" id="stuattendance">1、学生出勤情况</div>
									<p style="margin: 10px">
										<textarea id="stuattendance_" rows="3"></textarea>
									</p>
								</div>

								<div class="field">
									<div class="ui blue ribbon label">2、学生学习情况</div>
									<p style="margin: 10px">
										<textarea id="stustudy" rows="3"></textarea>
									</p>
								</div>
								<div class="field">
									<div class="ui blue ribbon label">3、教师教学情况</div>
									<p style="margin: 10px">
										<textarea id="teateach" rows="3"></textarea>
									</p>
								</div>
								<div class="field">
									<div class="ui blue ribbon label">4、教学管理情况</div>
									<p style="margin: 10px">
										<textarea id="teachmanage" rows="3"></textarea>
									</p>
								</div>
								<div class="field">
									<div class="ui blue ribbon label">5、教学条件保障</div>
									<p style="margin: 10px">
										<textarea id="teachsecurity" rows="3"></textarea>
									</p>
								</div>
								<div class="field">
									<div class="ui blue ribbon label">6、其他情况</div>
									<p style="margin: 10px">
										<textarea id="other" rows="3"></textarea>
									</p>
								</div>
							</div>
						</div>
					</div>

				</div>

			</div>
			<div class="actions">
				<div class="ui black  button" id="teacherCancelModal">取消</div>
				<div class="ui green right labeled icon button"
					id="teacherSaveModal">
					保存 <i class="checkmark icon"></i>
				</div>
				<div class="ui red right labeled icon button"
					id="teacherPublishModal" data-content="发布后不可修改">
					发布 <i class="send icon"></i>
				</div>
			</div>
		</div>

		<table class="ui celled center very compact blue striped table"
			id="feedback_table">
			<thead>
				<tr class="center aligned">
					<th>巡查记录时间</th>
					<th>巡查时间区间</th>
					<th>巡查周次</th>
					<th>发布状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody id="tablepane" class="center aligned">
			</tbody>
		</table>
	</div>
	<!--这里绘制页面-->
</body>
<script>
	var SYSOBJCET =
<%=SYSOBJCET%>
	;
	var USEROBJECT =
<%=USEROBJECT%>
	;
	var teacher_no = USEROBJECT.loginname;
	var currentweek = SYSOBJCET.currentweek;
	var term_no = SYSOBJCET.term_no;
	var dep_no = USEROBJECT.userinfo.dep_no;
	var selectweek = "";
	var monthone, monthtwo, dayone, daytwo;
	loadDropdown(); //初始化下拉框和当前学期信息  
	function loadDropdown() { //提取学期   

		$
				.ajax({
					url : "do?invoke=baseReport@getTermInf",
					type : 'POST',
					dataType : 'json',
					success : function(rep) {

						var termInf = rep.data;
						for (var i = 0; i < termInf.length; i++) {
							var dom = '<div class="item termInf" name="'+termInf[i].term_no+'" id="term'+termInf[i].term_no+'">'
									+ termInf[i].term_name + '</div>';
							$(".menu.infro").append($(dom));
							if (parseInt(termInf[i].term_status) == 1) {
								loadingTable(termInf[i].term_no, teacher_no,
										dep_no);//加载表格 

								$(".default.text").text(termInf[i].term_name);
							}
						}

						$('.ui.dropdown').dropdown();

						$(".termInf").click(function() { //更换学期  
							$('#messageinf').remove();
							$('#feedback_table').show();
							$('#tablepane').empty();//清空表格					
							term_no = $(this).attr("name");
							loadingTable(term_no, teacher_no, dep_no);
						})

					}
				});
	}

	function loadingTable(term_no, teacher_no, dep_no) { //点击学期刷新表单学期  
		$
				.ajax({
					url : "do?invoke=baseReport@getReportInf",
					type : 'POST',
					dataType : 'json',
					data : {
						term_no : term_no,

						dep_no : dep_no,
						teacher_no : teacher_no,
					},
					success : function(rep) {
						if (rep.result == 0) {
							$('#feedback_table').hide();
							var dom = '<div class="ui green large message" id="messageinf">'
									+ '<i class="announcement large inverted yellow up circular icon"></i>'
									+ ' 该学期没有巡查记录！' + '</div>';

							$('#container').append($(dom));
						} else {

							//判断反馈列表是否为空  
							initTable(rep);

						}

					}
				});
	}
	function initTable(rep) {
		var temp = rep.data;

		for (var i = 0; i < temp.length; i++) {
			var dom = '<tr class="listenInf">';
			dom += '<td>' + temp[i].report_time.split(" ")[0];
			+'</td>';
			var dateone = temp[i].report_date.split("-")[0];
			var monthone = parseInt(dateone.substring(0, 2));
			var dayone = parseInt(dateone.substring(2, 4));
			var datetwo = temp[i].report_date.split("-")[1];
			var monthtwo = parseInt(datetwo.substring(0, 2));
			var daytwo = parseInt(datetwo.substring(2, 4))
			dom += '<td class="xcsjd" name="'+temp[i].report_date+'">'
					+ monthone + '月' + dayone + '日~' + monthtwo + '月' + daytwo
					+ '日' + '</td>';
			dom += '<td class="report week">' + temp[i].report_week + '</td>';
			var publish = "";
			if (temp[i].report_publish == "1") {
				publish = "已发布";
			}
			if (temp[i].report_publish == "0") {
				publish = "未发布";
			}
			dom += '<td >' + publish + '</td>';
			dom += '<td>'
					+ '<div style="margin-left:5px;" class="editT btnfirst circular ui small blue basic icon button"  data-content="详细信息">'
					+ '<i class="file blue text icon"></i>' + '</div>';
			if (temp[i].report_publish != "1") {
				dom += '<div style="margin-left:5px; margin-top:5px;" class="remove btnsecond circular ui small teal basic icon button" name="'+temp[i].report_no+'"  data-content="修改&发布">'
						+ '<i class="send teal icon"></i>' + '</div>';
				dom += '<div style="margin-left:5px; margin-top:5px;" class="remove btnthird circular ui small red basic icon button" name="'+temp[i].report_no+'"  data-content="删除">'
						+ '<i class="remove red icon"></i>' + '</div>';

			}

	/* 		if (temp[i].report_publish == "1") {
				dom += '<div style="margin-left:5px; margin-top:5px;" class="remove btnfourth circular ui small green basic icon button" name="'+temp[i].report_no+'"  data-content="导出">'
						+ '<i class="download  green icon"></i>' + '</div>';
			} */   
			dom += '</td>';

			dom += '</tr>';
			dom += '<tr id="two'+temp[i].report_no+'" class="listenxxInf">'
					+ '<td colspan=1 class="positive">学生出勤情况</td>'
					+ '<td colspan=4 class="positive xscqqk" >'
					+ temp[i].report_stuattendance
					+ '</td>'
					+ '</tr>'
					+ '<tr id="there'+temp[i].report_no+'"class="listenxxInf">'
					+ '<td colspan=1 class="positive" >学生学习情况 </td>'
					+ '<td colspan=4 class="positive xsxxqk" >'
					+ temp[i].report_stustudy
					+ '</td>'
					+ '</tr>'
					+ '<tr id="four'+temp[i].report_no+'" class="listenxxInf">'
					+ '<td colspan=1 class="positive">教师教学情况</td>'
					+ '<td colspan=4 class="positive jsjxqk" >'
					+ temp[i].report_teateach
					+ '</td>'
					+ '</tr>'
					+ '<tr id="five'+temp[i].report_no+'" class="listenxxInf">'
					+ '<td colspan=1 class="positive">教学管理情况</td>'
					+ '<td colspan=4 class="positive jxglqk">'
					+ temp[i].report_teachmanage
					+ ' </td>'
					+ '</tr>'
					+ '<tr id="six'+temp[i].report_no+'"class="listenxxInf">'
					+ '<td colspan=1 class="positive">教学条件保障</td>'
					+ '<td colspan=4 class="positive jxtjbz" >'
					+ temp[i].report_teachsecurity
					+ '</td>'
					+ '</tr>'
					+ '<tr id="seven'+temp[i].report_no+'" class="listenxxInf">'
					+ '<td colspan=1 class="positive">其他情况</td>'
					+ '<td colspan=4 class="positive qtqk" >'
					+ temp[i].report_other + '</td>' + '</tr>';
			$("#tablepane").append(dom);
		}
		$('.circular.ui.button').popup();
		$('.btnfirst.circular.ui').unbind('click').click(
				function() { //点击查看详情        
					$(this).parents(".listenInf").next().fadeToggle(500).next()
							.fadeToggle(500).next().fadeToggle(500).next()
							.fadeToggle(500).next().fadeToggle(500).next()
							.fadeToggle(500);
				});
		$('.btnsecond.circular.ui')
				.unbind('click')
				.click(

						function() { //点击修改或发布        
							$('#errInf').remove();
							var date = $(this).parents('tr').find('.xcsjd')
									.attr("name");
							var id = $(this).attr("name");
							var reportweek = $(this).parents('tr').find(
									'.report.week').text();

							$('#stuattendance_').val(
									$('#two' + id + '').find('.xscqqk').text());

							$('#stustudy').val(
									$('#there' + id + '').find('.xsxxqk')
											.text());

							$('#teateach')
									.val(
											$('#four' + id + '')
													.find('.jsjxqk').text());
							$('#teachmanage')
									.val(
											$('#five' + id + '')
													.find('.jxglqk').text());
							$('#teachsecurity').val(
									$('#six' + id + '').find('.jxtjbz').text());
							$('#other').val(
									$('#seven' + id + '').find('.qtqk').text());

							loadmodal(id, date, reportweek);

						});
		$('.btnthird.circular.ui').unbind('click').click(function() { //点击删除        
			var id = $(this).attr("name");
			$.confirm({
				msg : "确定删除该记录？",
				btnSure : '确定 ',
				btnCancel : '返回',
				sureDo : function() {
					deletereport(id);

				},
				cancelDo : function() {

				}
			});

		});
		$('.btnfourth.circular.ui').unbind('click').click(function() { //点击导出       
			var id = $(this).attr("name");
			$.confirm({
				msg : "确定导出该周次记录？",
				btnSure : '确定 ',
				btnCancel : '返回',
				sureDo : function() {
					//deletereport(id); 
					//导出业务处理
					exportReport(id);

				},
				cancelDo : function() {

				}
			});

		});

	}
	function deletereport(id) {
		$.ajax({
			url : "do?invoke=baseReport@deleteReportInf",
			type : 'POST',
			dataType : 'json',
			data : {
				id : id,

			},
			success : function(rep) {

				$('#term' + term_no + '').click();
			}
		});
	}

	$("#addBtn").unbind('click').click(function() { //点击填写 
		$('#errInf').remove();
		loadmodal("", "", "");
	});

	function showEditModal() {
		$('#newBaseTeacherModal').modal("setting", "closable", false).modal(
				"show");
	}
	function hideEditModal() {
		$('#newBaseTeacherModal').modal("setting", "closable", false).modal(
				"hide");
	}

	function loadmodal(id, date_, reportweek) {

		showEditModal();
		selectweek = currentweek;
		$('#teacherPublishModal').popup();
		$('#selectweek').empty();

		var monthone;
		var dayone;
		var monthtwo;
		var daytwo;
		if (id == "") { //修改  

			$('#other').val("");
			$('#teachsecurity').val("");
			$('#teachmanage').val("");
			$('#teateach').val("");
			$('#stustudy').val("");
			$('#stuattendance_').val("");
			// 该星期的日期范围
			var myDate = new Date();

			
			month = parseInt(myDate.getMonth()) + 1;
			if (month < 10) {
				month = "0" + month;
			}
			day = myDate.getDate();
			if (day < 10) {
				day = "0" + day;
			}
			var nowDay = myDate.getDay() - 1;
			if (nowDay == -1) {
				nowDay = 6;
			}
			if (day - nowDay <= 0) {
				if (month == 1) {
					monthone = 12;
				} else {
					monthone = month--;
				}

				switch (monthone) {
				case 1:
					dayone = 31 - (nowDay - day);
					break;
				case 2:
					if (Date.prototype.isLeapYea) { //闰年
						dayone = 29 - (nowDay - day);
					} else {
						dayone = 28 - (nowDay - day);
					}
					break;
				case 3:
					dayone = 31 - (nowDay - day);
					break;
				case 4:
					dayone = 30 - (nowDay - day);
					break;
				case 5:
					dayone = 31 - (nowDay - day);
					break;
				case 6:
					dayone = 30 - (nowDay - day);
					break;
				case 7:
					dayone = 31 - (nowDay - day);
					break;
				case 8:
					dayone = 31 - (nowDay - day);
					break;
				case 9:
					dayone = 30 - (nowDay - day);
					break;
				case 10:
					dayone = 31 - (nowDay - day);
					break;
				case 11:
					dayone = 30 - (nowDay - day);
					break;
				case 12:
					dayone = 31 - (nowDay - day);
					break;
				}

			} else {
				dayone = day - nowDay;
				monthone = month;
			}
			if (month == 1 || month == 3 || month == 5 || month == 7
					|| month == 8 || month == 10 || month == 12) {
				if (day + 6 - nowDay > 31) {
					if (month == 12) {
						monthtwo = 1;

					} else {
						monthtwo = month++;
					}
					daytwo = day + 6 - nowDay - 31;
				} else {
					daytwo = day + 6 - nowDay;
					monthtwo = month;
				}
			} else if (month == 4 || month == 6 || month == 9 || month == 11) {
				if (day + 6 - nowDay > 30) {
					monthtwo = month++;
					daytwo = day + 6 - nowDay - 30;
				} else {
					daytwo = day + 6 - nowDay;
					monthtwo = month;
				}
			} else {
				if (Date.prototype.isLeapYea) { //闰年
					if (day + 6 - nowDay > 29) {
						monthtwo = month++;
						daytwo = day + 6 - nowDay - 29;
					} else {
						daytwo = day + 6 - nowDay;
						monthtwo = month;
					}
				} else {
					if (day + 6 - nowDay > 28) {
						monthtwo = month++;
						daytwo = day + 6 - nowDay - 28;
					} else {
						daytwo = day + 6 - nowDay;
						monthtwo = month;
					}
				}
			}
			//
			var dom = '<lable>巡查周次：</lable>'
					+ '<button class="mini ui blue button week" >'
					+ currentweek + ' </button>';

			for (var i = parseInt(currentweek) - 1; i > 0; i--) {
				dom += '<button class="mini ui button other week" >' + i
						+ ' </button>';
			}
			dom += '<i class="angle double right large grey icon" id="changebtn" data-content="展开"></i>';
			$('#selectweek').append($(dom));
			$('.other.week').hide();
		} else {
			monthone = date_.split("-")[0].substring(0, 2);
			dayone = date_.split("-")[0].substring(2, 4);
			monthtwo = date_.split("-")[1].substring(0, 2);
			daytwo = date_.split("-")[1].substring(2, 4);
			var dom = '<lable>巡查周次：</lable>'
					+ '<button class="mini ui blue button week" >' + reportweek
					+ ' </button>';
			$('#selectweek').append($(dom));
		}

		jQuery(function() {
			jQuery('#datestar').datetimepicker({

				value : '' + monthone + '/' + dayone + '',
				format : 'm/d',
				lang : 'zh',
				onShow : function(ct) {
					this.setOptions({

					})
				},
				timepicker : false
			});
			jQuery('#dateend').datetimepicker({
				format : 'm/d',
				lang : 'zh',
				value : '' + monthtwo + '/' + daytwo + '',
				onShow : function(ct) {
					this.setOptions({

					})
				},
				timepicker : false
			});
		});
		$('#changebtn').popup().unbind('click').click(
				function() { //点击展开
					if ($(this).hasClass("right")) {
						$('.other.week').show();
						$(this).removeClass("right").addClass("left").attr(
								"data-content", "隐藏");
					} else {
						$('.other.week').hide();
						$(this).removeClass("left").addClass("right").attr(
								"data-content", "展开");
					}
				});
		$('.mini.ui.button.week').unbind('click').click(
				function() { //点击周次
					$('.mini.ui.button.week').removeClass('blue');
					$(this).addClass('blue');
					selectweek = $(this).text();
					//改变时间区间
					var changeWeek = parseInt(currentweek)
							- parseInt(selectweek);
					
					if (changeWeek > 0) {
						var date = new Date();

						var nowDay = date.getDay() - 1;
						if (nowDay == -1) {
							nowDay = 6;
						}
						var newDateStar = new Date(date.getTime()
								- (changeWeek * 7 + nowDay) * 86400000);
						var newDateEnd = new Date(date.getTime()
								- (changeWeek * 7 - 6 + nowDay) * 86400000);
						var monthstar, monthend, daystar, dayend;
						monthstar = parseInt(newDateStar.getMonth()) + 1;
						if (monthstar < 10) {
							monthstar = "0" + monthstar;
						}
						daystar = newDateStar.getDate();
						if (daystar < 10) {
							daystar = "0" + daystar;
						}
						monthend = parseInt(newDateEnd.getMonth()) + 1;
						if (monthend < 10) {
							monthend = "0" + monthend;
						}
						dayend = newDateEnd.getDate();
						if (dayend < 10) {
							dayend = "0" + dayend;
						}
						jQuery('#datestar').datetimepicker({

							value : '' + monthstar + '/' + daystar + ''
							
						});
						jQuery('#dateend').datetimepicker({
				
							value : '' + monthend + '/' + dayend + '',
						
						});
					}else{
						jQuery('#datestar').datetimepicker({

							value : '' + monthone + '/' + dayone + ''
							
						});
						jQuery('#dateend').datetimepicker({
				
							value : '' + monthtwo + '/' + daytwo + '',
						
						});
					}

				})
		$('#teacherSaveModal').unbind('click').click(function() { //点击保存

			postreport("0", id);

		})
		$('#teacherPublishModal').unbind('click').click(function() { //点击发布 

			postreport("1", id);

		})
		$("#teacherCancelModal").unbind('click').click(function() { //点击取消
			hideEditModal();
		});
	}
	function postreport(set, id) {

		var datestarArray = $('#datestar').val().split("/");
		var datestar = "" + datestarArray[0] + datestarArray[1];
		var dateendArray = $('#dateend').val().split("/");
		var dateend = "" + dateendArray[0] + dateendArray[1];
		var report_date = datestar + "-" + dateend;
		var report_other = $('#other').val();
		var report_teachsecurity = $('#teachsecurity').val();
		var report_teachmanage = $('#teachmanage').val();
		var report_teateach = $('#teateach').val();
		var report_stustudy = $('#stustudy').val();
		var report_stuattendance = $('#stuattendance_').val();

		$
				.ajax({
					url : "do?invoke=baseReport@postReportInf",
					type : 'POST',
					dataType : 'json',
					async : false,
					data : {
						term_no : term_no,
						dep_no : dep_no,
						teacher_no : teacher_no,
						report_publish : set,
						report_week : selectweek,
						report_date : report_date,
						report_stuattendance : report_stuattendance,
						report_stustudy : report_stustudy,
						report_teateach : report_teateach,
						report_teachmanage : report_teachmanage,
						report_teachsecurity : report_teachsecurity,
						report_other : report_other,
						id : id,

					},
					success : function(rep) {
						if (rep.result == 0) {
							$('#errInf').remove();
							var dom = '<div id="errInf" class="ui negative message"style="width:42%;margin-left:57%">'
									+ '<div class="header">该周巡查报告已经填写，不可重复添加 </div>'
									+ '</div>';
							$(".actions").append(dom);
						} else {
							if (set == "0") {
								hideEditModal();
								$('#term' + term_no + '').click();

							} else {
								hideEditModal();
								$('#term' + term_no + '').click();

							}

						}

					}
				});

	}
	function exportReport(id) {
		$.ajax({
			url : "do?invoke=baseReport@exportReport",
			type : 'POST',
			dataType : 'json',
			async : false,
			data : {
				report_no : id
			},
			success : function(rep) {

			}
		});
	}
</script>
<!--这里引用其他JS-->
</html>