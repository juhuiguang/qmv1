<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<script>
var _hmt = _hmt || [];
(function() { 
  var hm = document.createElement("script");
  hm.src = "//hm.baidu.com/hm.js?47182abb0285582bae5cb767bab0e397";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script>

<head>
<%@ include file="/commonjsp/meta.jsp"%>
<script src="script/common/datepicker/jquery.datetimepicker.js"
	type="text/javascript"></script>
<link rel="stylesheet"
	href="script/common/datepicker/jquery.datetimepicker.css" />
<title>校内教学质量监控运行平台</title>
<style>
.ui.container.segment .button {
	margin-top: 10px;
	margin-right: 10px;
}

#information {
	margin-top: 30px;
}

#checkTable {
	height: 350px;
	overflow-y: scroll;
	margin-top: 20px;
}

.stuinf.qj {
	margin-left: 7%;
}

.ui.cards {
	width: 22%;
	cursor: pointer;
	float: left;
	margin-left: 1.5%;
	margin-right: 1.5%;
}

#stucard0 {
	margin-top: 12px;
}

.ui.attached.segment.top {
	margin-top: 10px;
}

.ui.attached.segment {
	width: 100%;
}

.ui.grey.basic.button {
	margin-top: 8px;
}

#weekbtn {
	margin-left: 13%;
	margin-top: 15px;
}

.header.week, .item.Kq, .checkmark.large.icon {
	cursor: pointer;
}

.ui.fluid.selection.dropdown.course {
	width: 80%;
	margin-left: 14%;
}

.ui.fluid.selection.dropdown.checkModal {
	width: 70%; 
}
.ui.horizontal.divider {
	width: 80%;
	margin-left: 10%;
}

.ui.horizontal.segments {
	width: 90%;
	margin-left: 5%;
}


.sche_no.inf {
	display: none;
}


.stu_no {
	display: none;
}

.ui.horizontal.divided.list {
	margin-left: 2%;
}

.ui.horizontal.divided.list, #weekbtn, .ui.definition.table {
	display: none;
}

#tabletitle {
	color: black;
}

#kqkc {
	float: left;
}

#allstucards {
	overflow: hidden;
	margin-bottom: 30px;
	padding: 5px;
}

.ui.teal.basic.button {
	width: 13%;
}

#submitdiv {
	display: none;
	position: fixed;
	right: 0px;
	top: 280px;  
	z-index: 999;
	width: 120px;
	height: 120px;
	text-align: center;
	background: rgba(255, 255, 255, 0.2);
	border: 2px solid #00b5ad;
	border-radius: 5px;
	cursor: pointer;
}

#submitdiv:hover {
	background: rgba(0, 156, 149, 0.2);
}

#submitdiv .button {
	width: 100%;
	position: absolute;
	bottom: 0;
	left: 0;
}
 
#recordInfo {
	position: absolute;
	top: 105px; 
	left: 82%;
}
#container{   
		padding-top:110px !important; 
	}
</style>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
		<h3 class="ui header" id="ktkq">
			<i class="student icon"></i>
			<div class="content">课堂考勤</div>

			<button class="ui blue button" id="recordInfo">
				<i class="search  icon"></i> 考勤记录
			</button>

		</h3>
		<div id="submitdiv" class="ui save" data-content="忘记提交,考勤信息也不会丢失">
			<div id="submitflag">
				<i class="huge send teal outline  icon"></i>
			</div>
			<div id="submittext" class="ui small teal button">完成考勤</div>

		</div>

		<div id="kqselect">
			<div class="ui top attached segment">
				<lable class="item Kq " id="kqkc"> &nbsp;考 勤 课 程 : &nbsp; </lable>

				<div class="ui fluid selection course dropdown">
					<i class="dropdown icon"></i> <span class="default text">请先选择课程</span>
					<div class="menu infro"></div>
				</div>
				<table class="ui definition table">

					<thead>
						<tr>
							<th width="17%;" id='tabletitle'>请选择考勤节次</th>
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
			<div class="ui attached segment week">
				<lable class="item Kq "> &nbsp;考 勤 周 次 : &nbsp; </lable>
				
				

				<div class="ui horizontal divided list"></div>

				<div id="weekbtn"></div>

			</div>
		</div>

		<div class="ui small very relaxed horizontal list" id="information">
			<div class="item">
				<i class="tasks large icon"></i>
				<div class="content">
					<div>
						考勤班级: <i id="kqbj"></i>
					</div>
				</div>
			</div>
			<div class="item">
				<i class="user large icon"></i>
				<div class="content">
					<div>
						班级人数： <i id="bjrs"></i>
					</div>
				</div>
			</div>
			<div class="item">
				<i class="wait large icon"></i>
				<div class="content">
					<div>
						考勤时间： <i id="kqsj"></i>
					</div>
				</div>
			</div>
			<div class="item">
				<i class="table large icon"></i>
				<div class="content">
					<div>
						当前周次： <i id="dqzd"></i>
					</div>
				</div>
			</div>
		</div>

		<h4 class="ui horizontal divider  header">
			<i class="tag icon"></i> 开始考勤
		</h4>

		<div class="ui horizontal segments">
			<div class="ui segment">
				旷课：&nbsp;<i id="kkrs">0</i>
			</div>
			<div class="ui segment">
				早退：&nbsp;<i id="ztrs">0</i>
			</div>
			<div class="ui segment">
				迟到：&nbsp;<i id="cdrs">0</i>
			</div>
			<div class="ui segment">
				请假：&nbsp;<i id="qjrs">0</i>
			</div>
		</div>

		<div id="allstucards"></div>


		<!--弹出层-->
		<div class="ui large modal" id="checkModal">
			<i class="close icon"></i>
			<div class="header">我的考勤记录</div>
			<div class="content">
				<div class="ui fluid selection checkModal dropdown" >
					<i class="dropdown icon"></i> <span class="default text">请先选择课程</span>
					<div class="menu checkSelect"></div> 
				</div> 
				<button class="ui right  recordCheck green button"style="position:absolute;top:100px;margin-left:80%;">进入考勤</button>
				<div id="checkTable">
					<table class="ui compact celled table check">
						<thead>
							<tr>
								<th class="center aligned">周次</th>
								<th class="center aligned">节次</th>
								<th class="center aligned">考勤时间</th>
								<th class="center aligned">旷课</th>
								<th class="center aligned">早退</th>
								<th class="center aligned">迟到</th>
								<th class="center aligned">请假</th>
								<th class="center aligned">班级人数</th>
								<th class="center aligned">出勤率</th>
								<th class="center aligned">是否提交</th>
								
							</tr>
						</thead>
						<tbody>


						</tbody>
					</table>
				</div>

			</div>

		</div>

	</div>
	<!--这里绘制页面-->
</body>
<script>
	$(function() {
		var SYSOBJCET =
<%=SYSOBJCET%>
	;
		var USEROBJECT =
<%=USEROBJECT%>
	;
		var term_no = SYSOBJCET.term_no;
		var tea_no = USEROBJECT.loginname;
		var currentweek = SYSOBJCET.currentweek;

		var mainid = "";
		var term_no = SYSOBJCET.term_no;
		var check_sx = "";
		var weekend = "";
		var weekstar = "";
		var selectweek = "";
		var course_classtime = null;
		var sche_no = "";
		var course_type="";
		var everyweekstatus = "";
		var switchFlag = true; 
		loadSwitch();
		function loadSwitch(){
			$.ajax({
				url : "do?invoke=studentCheck@loadSwitch",
				type : 'POST', 
				dataType : 'json',
				data : {
					term_no : term_no,
				},
				success : function(rep) {
					if(rep.result ==0){
						$.alert("获得学年学期信息失败");
					}else{
						if(rep.data[0].term_kq == "1"){
							
							switchFlag = false;
						}
					}
				}
			 
	    	});
		}
		loadcheckinf();
		 

		//点击查看考勤记录
		$('#recordInfo').unbind('click').click(function() {

			$('.checkModal.item').unbind('click').click(function() {

				var index = $(this).text();

				//清除表格内容
				$('.check.tr').remove();
				//得到参数
				var check_sche_no = $(this).find('.check.sche_no.inf').text();
				//发送AJAX请求
				getCheckRecord(check_sche_no, index);
			});

			$('.checkModal.item').eq(0).trigger("click");

		});

		function loadcheckinf() {

			$
					.ajax({
						url : "do?invoke=studentCheck@getStuCheckInf",
						type : 'POST', 
						dataType : 'json',
						data : {
							term_no : term_no,
							tea_no : tea_no,
						},
						success : function(rep) {
							if (rep.result == 0) {
								$.alert("", rep.message);
							} else {

								var infor = rep.data;

								for (var i = 0; i < infor.length; i++) {
									var classtime = infor[i].sche_set;
									var classweektime = "";
									if (classtime != "" && classtime.trim() != "K99" &&classtime!=null) {
										var week = parseInt(classtime
												.substring(1, 2));
										var Week = "";
										switch (week) {
										case 1:
											Week = "——星期一";
											break;
										case 2:
											Week = "——星期二";
											break;
										case 3:
											Week = "——星期三";
											break;
										case 4:
											Week = "——星期四";
											break;
										case 5:
											Week = "——星期五";
											break;
										case 6:
											Week = "——星期六";
											break;
										case 7:
											Week = "——星期天";
											break;
										}
										var time = parseInt(classtime
												.substring(2, 3));
										var Time = "";
										switch (time) {
										case 1:
											Time = "/一二节";
											break;
										case 2:
											Time = "/三四节";
											break;
										case 3:
											Time = "/五六节";
											break;
										case 4:
											Time = "/七八节";
											break;
										case 5:
											Time = "/九十节";
											break;
										}
										classweektime = Week + Time;
									}
									var dom = '<div class="item classinf">'
											+ '<i class="sche_no inf">'
											+ infor[i].sche_no + '</i>'
											+ (i + 1) + '、'
											+ infor[i].course_name + '——'
											+ infor[i].course_type + '——'
											+ infor[i].class_name
											+ classweektime + '</div>';

									$(".menu.infro").append($(dom));

									dom = '<div class="item checkModal">'
											+ '<i class="check sche_no inf">'
											+ infor[i].sche_no + '</i>'
											+ (i + 1) + '、'
											+ infor[i].course_name + '——'
											+ infor[i].course_type + '——'
											+ infor[i].class_name
											+ classweektime + '</div>';

									$(".menu.checkSelect").append($(dom));

								}//初始化课程列表 

								$(".item.classinf")
										.click(
												function() { //点击选课

													mainid = "";
													term_no = SYSOBJCET.term_no;
													check_sx = "";
													weekend = "";
													weekstar = "";
													sche_no = "";
													selectweek = "";
													everyweekstatus = "";
													$('.ui.definition.table').css('display','none');
													$("#cdrs").text("0");
													$("#ztrs").text("0");
													$("#kkrs").text("0");
													$("#qjrs").text("0");
													$(
															".ui.horizontal.divided.list")
															.empty();
													$("#submitdiv").css(
															"display", "none");
													
													
													$("#weekbtn").css(
															"display", "none");
													$(
															".ui.horizontal.divided.list")
															.css("display",
																	"none");
													sche_no = $(this).find(
															".sche_no.inf")
															.text(); 
													var inf = $(this).text();
													var totalinf = inf
															.split("、");
													var totalInf = totalinf[1];
													var everyinf = totalInf
															.split("——");
													course_type = everyinf[1];
													course_classtime = null; 
													if (everyinf.length > 3) {
														course_classtime = everyinf[3];
													}
													var class_name = everyinf[2];

													$
															.ajax({
																url : "do?invoke=studentCheck@getStuCheckClassInf",
																type : 'POST',
																dataType : 'json',
																data : {
																	sche_no : sche_no,
																	term_no : term_no,
																	course_type : course_type,
																},
																success : function(
																		infrep) {

																	if (infrep.result == 0) {
																		$
																				.alert(
																						"",
																						infrep.message);
																	} else {

																		var infClass = infrep.data;
																		var weeklimit = infClass[0].course_week;//*************************
																		var weeksegment = weeklimit
																				.split(",");
																		for (var i = 0; i < weeksegment.length; i++) {
																			if (i == 0) {
																				weekstar = weeksegment[i]
																						.split("-")[0];
																			}
																			if (i == weeksegment.length - 1) {
																				if (weeksegment[i]
																						.split("-").length > 1) {
																					weekend = weeksegment[i]
																							.split("-")[1];
																				} else {
																					weekend = weeksegment[i]
																							.split("-")[0];
																				}
																			}

																		}

																		$(
																				'.ui.cards')
																				.remove();

																		for (var i = 0; i < infClass.length; i++) {
																			var card = '<div class="ui cards " id="stucard'+i+'" >'
																					+ '<div class="card" id="stucard'+infClass[i].stu_no+'" >'
																					+ '<a class="ui green right corner label">'
																					+ ' <i class="checkmark icon"></i>'
																					+ '</a>'
																					+ '<div class="content">'
																					+ '<div class="stu_no">'
																					+ infClass[i].stu_no
																					+ '</div>'
																					+ '<div class="header">'
																					+ infClass[i].stu_name
																					+ " "
																					+ '<i>'
																					+ ' '
																					+ infClass[i].stu_no
																							.substring(
																									infClass[i].stu_no.length - 2,
																									infClass[i].stu_no.length)
																					+ '</i>'
																					+ '号</div>'
																					+ '<div class="ui divider"></div>'
																					+

																					' <a class="stuinf" data-content="旷课"><i class="remove red large icon  "></i></a>'
																					+ '<a class="stuinf" data-content="早退"><i class="warning orange large icon "></i></a>'
																					+ ' <a class="stuinf" data-content="迟到"><i class="wait yellow large icon"></i></a>'
																					+ '<a class="stuinf qj" data-content="请假"><i class="doctor blue large icon "></i></a>'
																					+ '</div>'
																					+ '</div> '
																					+ '</div>';
																			$(
																					"#allstucards")
																					.append(
																							$(card));
																		}//初始化卡片

																		if (course_classtime == null) {

																			$(
																					".checkmark.large.icon")
																					.removeClass(
																							"green");
																			$(
																					".ui.definition.table")
																					.show(
																							500);
																			$(
																					"#nowweek")
																					.text(
																							currentweek
																									+ ' 周');

																			$(
																					".checkmark.large.icon")
																					.unbind(
																							"click")
																					.click(
																							function() { //实训点击选节次 
																								$( 
																										'#weekmenu' 
																												+ (parseInt((parseInt(currentweek) - 1) / 5) * 5 + 1)
																												+ '') 
																										.trigger(
																												'click'); //模拟点击该周菜单
																												$(
																														'#weekbtn'
																																+ parseInt(currentweek)
																																+ '')
																														.addClass( 
																																"active"); //选中该周     
																								$(
																										"#cdrs")
																										.text(
																												"0");
																								$(
																										"#ztrs")
																										.text(
																												"0");
																								$(
																										"#kkrs")
																										.text(
																												"0");
																								$(
																										"#qjrs")
																										.text(
																												"0");
																								for (var i = 0; i < infClass.length; i++)//把卡片还原
																								{
																									$(
																											'#stucard'
																													+ i
																													+ '')
																											.find(
																													".ui.right.corner.label")
																											.attr(
																													"class",
																													"ui green right corner label");
																									$(
																											'#stucard'
																													+ i
																													+ '')
																											.find(
																													".ui.right.corner.label")
																											.find(
																													".icon")
																											.attr(
																													"class",
																													"checkmark icon");

																								}
																								$(
																										".checkmark.large.icon")
																										.removeClass(
																												"green");
																								$(
																										this)
																										.addClass(
																												"green");
																								var howweek = $(
																										this)
																										.parent(
																												"td")
																										.attr(
																												"class")
																										.substring(
																												1,
																												2);
																								var howtime = $(
																										this)
																										.parents(
																												"tr")
																										.attr(
																												"id")
																										.substring(
																												1,
																												2);

																								check_sx = "K"
																										+ howweek
																										+ howtime;

																								sxstustatus(
																										sche_no,
																										currentweek,
																										term_no,
																										check_sx,
																										weekend);// 首先刷出当前周班级整体信息  （排除当前周出界）
																								/* $(
																										".ui.definition.table")
																										.hide(
																												500); */
																								if (parseInt(currentweek) <= parseInt(weekend))//提交按钮出现 //****************************等于上课周次
																								{
																									$(
																											'#submitdiv')
																											.show(
																													'slow');
																									/*  var t = setTimeout(
																											"window.scrollTo(0,290)",
																											1000);  */
																								}

																								getsxweeksSta( 
																										sche_no,
																										term_no,
																										check_sx); //拿到每周考勤状态   

																								

																							})//拿到实训节次

																		} else {
																			$(
																					".checkmark.large.icon")
																					.removeClass(
																							"green");
																			/* $(
																					".ui.definition.table")
																					.hide(
																							500); */

																			stustatus(
																					sche_no,
																					currentweek,
																					term_no,
																					weekend);// 首先 刷出当前周 班级整体信息 （排除当前周出界）

																			if (parseInt(currentweek) <= parseInt(weekend))//提交按钮出现//***************************
																			{
																				  
																				$( 
																						'#submitdiv')
																						.show(
																								'slow');
																				/*  var t = setTimeout(
																						"window.scrollTo(0,290)",
																						1000);  */
																			}
																			getweeksSta(
																					sche_no,
																					term_no);//拿到每周考勤状态 

																			$(
																					"#nowweek")
																					.text(
																							currentweek
																									+ ' 周');
																			if (everyweekstatus.length > 0)//当前周考勤状态 
																			{
																				for (var i = 0; i < everyweekstatus.length; i++) {
																					if (parseInt(currentweek) == parseInt(everyweekstatus[i].check_week)) {
																						break;
																					}
																					if (i == everyweekstatus.length - 1) {
																						var dom = '<i class="upload red icon"></i>';//parseInt(everyweekstatus[i].check_week)
																						$(
																								"#nowweek")
																								.attr(
																										"data-content",
																										"尚未提交")
																								.prepend(
																										$(dom)); //改变当前周的图标 
																					}
																				}
																			} else {
																				var dom = '<i class="upload red icon"></i>';//parseInt(everyweekstatus[i].check_week)
																				$(
																						"#nowweek")
																						.attr(
																								"data-content",
																								"尚未提交")
																						.prepend(
																								$(dom)); //改变当前周的图标 
																			}

																		}

																		$(
																				".stuinf")
																				.click(
																						function(
																								event) { //点击小图标改变缺勤状态
																							event
																									.stopPropagation();
																							if( course_classtime== null && check_sx == ""){
																								$.alert("请先选择实训考勤节次");
																								return;
																							}
																						
																								if(selectweek == "" && parseInt(currentweek) > parseInt(weekend)){
																									$.alert("课程已结束，请先选择修改考勤周次");
																									return;
																								}
																								
																								if((selectweek!=""&&(parseInt(currentweek)-parseInt(selectweek)>1))&&switchFlag){
																									$.alert("已超出考勤周期，不可以继续考勤");
																									return;
																								}
																							if ($(
																									".stuinf")
																									.hasClass(
																											"loading")
																									|| $(
																											".ui.cards")
																											.hasClass(
																													"loading"))
																								return;
																							$(
																									".stuinf")
																									.addClass(
																											"loading");
																							$(
																									".ui.cards")
																									.addClass(
																											"loading");
																							if ($(
																									this)
																									.find(
																											".large.icon")
																									.hasClass(
																											"yellow")) {
																								if ($(
																										this)
																										.parent()
																										.prevAll(
																												".ui.right.corner.label")
																										.hasClass(
																												"yellow")) {
																									$(
																											".stuinf")
																											.removeClass(
																													"loading");
																									$(
																											".ui.cards")
																											.removeClass(
																													"loading");
																								} else {
																									$(
																											"#cdrs")
																											.text(
																													parseInt($(
																															"#cdrs")
																															.text()) + 1);
																									if ($(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.hasClass(
																													"orange")) {
																										$(
																												"#ztrs")
																												.text(
																														parseInt($(
																																"#ztrs")
																																.text()) - 1);
																										stu_no = $(
																												this)
																												.prevAll(
																														".stu_no")
																												.text();
																										changestatus(
																												mainid,
																												stu_no,
																												"迟到",
																												"早退");
																										//ajax修改
																									}
																									if ($(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.hasClass(
																													"blue")) {
																										$(
																												"#qjrs")
																												.text(
																														parseInt($(
																																"#qjrs")
																																.text()) - 1);
																										stu_no = $(
																												this)
																												.prevAll(
																														".stu_no")
																												.text();
																										changestatus(
																												mainid,
																												stu_no,
																												"迟到",
																												"请假");
																									}
																									if ($(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.hasClass(
																													"red")) {
																										$(
																												"#kkrs")
																												.text(
																														parseInt($(
																																"#kkrs")
																																.text()) - 1);
																										stu_no = $(
																												this)
																												.prevAll(
																														".stu_no")
																												.text();
																										changestatus(
																												mainid,
																												stu_no,
																												"迟到",
																												"旷课");
																									}
																									if ($(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.hasClass(
																													"green")) {
																										stu_no = $(
																												this)
																												.prevAll(
																														".stu_no")
																												.text();
																										savestatus(
																												mainid,
																												stu_no,
																												"迟到");
																									}

																									$(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.attr(
																													"class",
																													"ui yellow right corner label");
																									$(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.find(
																													".icon")
																											.attr(
																													"class",
																													"wait icon");
																								}
																							}
																							if ($(
																									this)
																									.find(
																											".large.icon")
																									.hasClass(
																											"orange")) {
																								if ($(
																										this)
																										.parent()
																										.prevAll(
																												".ui.right.corner.label")
																										.hasClass(
																												"orange")) {
																									$(
																											".stuinf")
																											.removeClass(
																													"loading");
																									$(
																											".ui.cards")
																											.removeClass(
																													"loading");
																								} else {
																									if ($(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.hasClass(
																													"yellow")) {
																										$(
																												"#cdrs")
																												.text(
																														parseInt($(
																																"#cdrs")
																																.text()) - 1);
																										stu_no = $(
																												this)
																												.prevAll(
																														".stu_no")
																												.text();
																										changestatus(
																												mainid,
																												stu_no,
																												"早退",
																												"迟到");
																									}
																									if ($(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.hasClass(
																													"blue")) {
																										$(
																												"#qjrs")
																												.text(
																														parseInt($(
																																"#qjrs")
																																.text()) - 1);
																										stu_no = $(
																												this)
																												.prevAll(
																														".stu_no")
																												.text();
																										changestatus(
																												mainid,
																												stu_no,
																												"早退",
																												"请假");
																									}
																									if ($(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.hasClass(
																													"red")) {
																										$(
																												"#kkrs")
																												.text(
																														parseInt($(
																																"#kkrs")
																																.text()) - 1);
																										stu_no = $(
																												this)
																												.prevAll(
																														".stu_no")
																												.text();
																										changestatus(
																												mainid,
																												stu_no,
																												"早退",
																												"旷课");
																									}
																									if ($(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.hasClass(
																													"green")) {
																										stu_no = $(
																												this)
																												.prevAll(
																														".stu_no")
																												.text();
																										savestatus(
																												mainid,
																												stu_no,
																												"早退");
																									}
																									$(
																											"#ztrs")
																											.text(
																													parseInt($(
																															"#ztrs")
																															.text()) + 1);
																									$(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.attr(
																													"class",
																													"ui orange right corner label");
																									$(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.find(
																													".icon")
																											.attr(
																													"class",
																													"warning icon");
																								}
																							}
																							if ($(
																									this)
																									.find(
																											".large.icon")
																									.hasClass(
																											"red")) {
																								if ($(
																										this)
																										.parent()
																										.prevAll(
																												".ui.right.corner.label")
																										.hasClass(
																												"red")) {
																									$(
																											".stuinf")
																											.removeClass(
																													"loading");
																									$(
																											".ui.cards")
																											.removeClass(
																													"loading");
																								} else {
																									if ($(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.hasClass(
																													"yellow")) {
																										$(
																												"#cdrs")
																												.text(
																														parseInt($(
																																"#cdrs")
																																.text()) - 1);
																										stu_no = $(
																												this)
																												.prevAll(
																														".stu_no")
																												.text();
																										changestatus(
																												mainid,
																												stu_no,
																												"旷课",
																												"迟到");
																									}
																									if ($(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.hasClass(
																													"blue")) {
																										$(
																												"#qjrs")
																												.text(
																														parseInt($(
																																"#qjrs")
																																.text()) - 1);
																										stu_no = $(
																												this)
																												.prevAll(
																														".stu_no")
																												.text();
																										changestatus(
																												mainid,
																												stu_no,
																												"旷课",
																												"请假");
																									}
																									if ($(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.hasClass(
																													"orange")) {
																										$(
																												"#ztrs")
																												.text(
																														parseInt($(
																																"#ztrs")
																																.text()) - 1);
																										stu_no = $(
																												this)
																												.prevAll(
																														".stu_no")
																												.text();
																										changestatus(
																												mainid,
																												stu_no,
																												"旷课",
																												"早退");
																									}
																									if ($(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.hasClass(
																													"green")) {
																										stu_no = $(
																												this)
																												.prevAll(
																														".stu_no")
																												.text();
																										savestatus(
																												mainid,
																												stu_no,
																												"旷课");
																									}
																									$(
																											"#kkrs")
																											.text(
																													parseInt($(
																															"#kkrs")
																															.text()) + 1);
																									$(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.attr(
																													"class",
																													"ui red right corner label");
																									$(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.find(
																													".icon")
																											.attr(
																													"class",
																													"remove icon");
																								}
																							}
																							if ($(
																									this)
																									.find(
																											".large.icon")
																									.hasClass(
																											"blue")) {
																								if ($(
																										this)
																										.parent()
																										.prevAll(
																												".ui.right.corner.label")
																										.hasClass(
																												"blue")) {
																									$(
																											".stuinf")
																											.removeClass(
																													"loading");
																									$(
																											".ui.cards")
																											.removeClass(
																													"loading");
																								} else {
																									if ($(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.hasClass(
																													"yellow")) {
																										$(
																												"#cdrs")
																												.text(
																														parseInt($(
																																"#cdrs")
																																.text()) - 1);
																										stu_no = $(
																												this)
																												.prevAll(
																														".stu_no")
																												.text();
																										changestatus(
																												mainid,
																												stu_no,
																												"请假",
																												"迟到");
																									}
																									if ($(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.hasClass(
																													"red")) {
																										$(
																												"#kkrs")
																												.text(
																														parseInt($(
																																"#kkrs")
																																.text()) - 1);
																										stu_no = $(
																												this)
																												.prevAll(
																														".stu_no")
																												.text();
																										changestatus(
																												mainid,
																												stu_no,
																												"请假",
																												"旷课");
																									}
																									if ($(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.hasClass(
																													"orange")) {
																										$(
																												"#ztrs")
																												.text(
																														parseInt($(
																																"#ztrs")
																																.text()) - 1);
																										stu_no = $(
																												this)
																												.prevAll(
																														".stu_no")
																												.text();
																										changestatus(
																												mainid,
																												stu_no,
																												"请假",
																												"早退");
																									}
																									if ($(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.hasClass(
																													"green")) {
																										stu_no = $(
																												this)
																												.prevAll(
																														".stu_no")
																												.text();
																										savestatus(
																												mainid,
																												stu_no,
																												"请假");
																									}
																									$(
																											"#qjrs")
																											.text(
																													parseInt($(
																															"#qjrs")
																															.text()) + 1);
																									$(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.attr(
																													"class",
																													"ui blue right corner label");
																									$(
																											this)
																											.parent()
																											.prevAll(
																													".ui.right.corner.label")
																											.find(
																													".icon")
																											.attr(
																													"class",
																													"doctor icon");
																								}
																							}
																						})

																		$(
																				'.ui.cards')
																				.click(
																						function(
																								event) { //点击卡片改变缺勤状态
																							event
																									.stopPropagation(); 
																							if( course_classtime== null && check_sx == ""){
																								$.alert("请先选择实训考勤节次");
																								return;
																							}
																							if(selectweek == "" && parseInt(currentweek) > parseInt(weekend)){
																								$.alert("课程已结束，请先选择修改考勤周次");
																								return; 
																							}
																							if((selectweek!=""&&(parseInt(currentweek)-parseInt(selectweek)>1))&&switchFlag){
																								$.alert("已超出考勤周期，不可以继续考勤");
																								return;
																							}
																							if ($(
																									".ui.cards")
																									.hasClass(
																											"loading")
																									|| $(
																											".stuinf")
																											.hasClass(
																													"loading"))
																								return;

																							$(
																									".ui.cards")
																									.addClass(
																											"loading")
																							$(
																									".stuinf")
																									.addClass(
																											"loading");

																							if ($(
																									this)
																									.find(
																											'.ui.right.corner.label')
																									.hasClass(
																											"green")) {
																								$(
																										"#kkrs")
																										.text(
																												parseInt($(
																														"#kkrs")
																														.text()) + 1);
																								$(
																										this)
																										.find(
																												".ui.right.corner.label")
																										.attr(
																												"class",
																												"ui red right corner label");
																								$(
																										this)
																										.find(
																												".ui.right.corner.label")
																										.find(
																												".icon")
																										.attr(
																												"class",
																												"remove icon");
																								stu_no = $(
																										this)
																										.find(
																												".stu_no")
																										.text();
																								savestatus(
																										mainid,
																										stu_no,
																										"旷课");
																							} else {
																								if ($(
																										this)
																										.find(
																												'.ui.right.corner.label')
																										.hasClass(
																												"yellow")) {
																									$(
																											"#cdrs")
																											.text(
																													parseInt($(
																															"#cdrs")
																															.text()) - 1);
																									$(
																											this)
																											.find(
																													".ui.right.corner.label")
																											.attr(
																													"class",
																													"ui green right corner label");
																									$(
																											this)
																											.find(
																													".ui.right.corner.label")
																											.find(
																													".icon")
																											.attr(
																													"class",
																													"checkmark icon");
																									stu_no = $(
																											this)
																											.find(
																													".stu_no")
																											.text();
																									removestatus(
																											mainid,
																											stu_no,
																											"迟到");
																								}
																								if ($(
																										this)
																										.find(
																												'.ui.right.corner.label')
																										.hasClass(
																												"orange")) {
																									$(
																											"#ztrs")
																											.text(
																													parseInt($(
																															"#ztrs")
																															.text()) - 1);
																									$(
																											this)
																											.find(
																													".ui.right.corner.label")
																											.attr(
																													"class",
																													"ui green right corner label");
																									$(
																											this)
																											.find(
																													".ui.right.corner.label")
																											.find(
																													".icon")
																											.attr(
																													"class",
																													"checkmark icon");
																									stu_no = $(
																											this)
																											.find(
																													".stu_no")
																											.text();
																									removestatus(
																											mainid,
																											stu_no,
																											"早退");
																								}
																								if ($(
																										this)
																										.find(
																												'.ui.right.corner.label')
																										.hasClass(
																												"red")) {
																									$(
																											"#kkrs")
																											.text(
																													parseInt($(
																															"#kkrs")
																															.text()) - 1);
																									$(
																											this)
																											.find(
																													".ui.right.corner.label")
																											.attr(
																													"class",
																													"ui green right corner label");
																									$(
																											this)
																											.find(
																													".ui.right.corner.label")
																											.find(
																													".icon")
																											.attr(
																													"class",
																													"checkmark icon");
																									stu_no = $(
																											this)
																											.find(
																													".stu_no")
																											.text();
																									removestatus(
																											mainid,
																											stu_no,
																											"旷课");
																								}
																								if ($(
																										this)
																										.find(
																												'.ui.right.corner.label')
																										.hasClass(
																												"blue")) {
																									$(
																											"#qjrs")
																											.text(
																													parseInt($(
																															"#qjrs")
																															.text()) - 1);
																									$(
																											this)
																											.find(
																													".ui.right.corner.label")
																											.attr(
																													"class",
																													"ui green right corner label");
																									$(
																											this)
																											.find(
																													".ui.right.corner.label")
																											.find(
																													".icon")
																											.attr(
																													"class",
																													"checkmark icon");
																									stu_no = $(
																											this)
																											.find(
																													".stu_no")
																											.text();
																									removestatus(
																											mainid,
																											stu_no,
																											"请假");
																								}
																							}
																						})

																		$(
																				'.stuinf')
																				.popup();

																		$(
																				"#bjrs")
																				.text(
																						infClass.length);
																		$(
																				"#kqbj")
																				.text(
																						class_name);
																		var Date_ = new Date();
																		var nowDate = Date_
																				.toLocaleDateString();
																		$(
																				"#kqsj")
																				.text(
																						nowDate);
																		$(
																				"#dqzd")
																				.text(
																						currentweek
																								+ ' 周');

																		$(
																				".ui.mini.horizontal.divided.list")
																				.empty();
																		$(
																				"#weekbtn")
																				.empty();

																		$(
																				'.ui.basic.button')
																				.popup();
																		judgeweekSta(
																				currentweek,
																				weekend);//画选周菜单  

																		if (parseInt(currentweek) <= parseInt(weekend) && course_classtime != null) //选周栏整体状态//*********************
																		{
																			$(
																			"#weekbtn")
																			.css(
																					"display",
																					"block");
																			$(
																			".ui.horizontal.divided.list")
																			.css(
																					"display",
																					"inline"); 
																			$(
																			".header.week")
																			.css(
																					"color",
																					"");
																			$(
																			"body")
																			.mousemove(
																					function(){
																						$(
																								'#weekmenu'
																										+ (parseInt((parseInt(currentweek) - 1) / 5) * 5 + 1)
																										+ '')
																								.trigger(
																										'click'); //模拟点击该周菜单
																										$(
																												'#weekbtn'
																														+ parseInt(currentweek)
																														+ '')
																												.addClass( 
																														"active"); //选中该周     
																						$(
																								"body")
																								.unbind(
																										"mousemove");
																					})
																			
																			
																		} else {  
																			if (course_classtime == null) {
																				$(
																						".checkmark.large.icon")
																						.click(
																								function() {

																									$(
																											"#weekbtn")
																											.css(
																													"display",
																													"block");
																									$(
																											".ui.horizontal.divided.list")
																											.css(
																													"display",
																													"inline");
																									$(
																											'#weekmenu'
																													+ (parseInt((parseInt(weekend) - 1) / 5) * 5 + 1)
																													+ '')
																											.trigger('click'); //模拟点击该周菜单
																								})
																			} else {

																				$(
																						"#weekbtn")
																						.css(
																								"display",
																								"block");
																				$(
																						".ui.horizontal.divided.list")
																						.css(
																								"display",
																								"inline");
																				$(
																						"body")
																						.mousemove(
																								function() {
																									$(
																											'#weekmenu'
																													+ (parseInt((parseInt(weekend) - 1) / 5) * 5 + 1)
																													+ '')
																											.trigger(
																													'click'); //模拟点击该周菜单
																									$(
																											"body")
																											.unbind(
																													"mousemove");
																								})

																			}

																		}

																		$(
																				".header.week")
																				.unbind(
																						'click')
																				.click(
																						function() { //点击选周菜单 //***************
																							$(
																									".header.week")
																									.css(
																											"color",
																											"");
																							$(
																									this)
																									.css(
																											"color",
																											"teal");
																							$(
																									"#weekbtn")
																									.empty();
																							var weeknear = $(
																									this)
																									.text();
																							var weekNear = weeknear
																									.split("-");
																							var weeklast = weekNear[0];
																							var weekbegin = weekNear[1];

																							if (weekbegin == null) {
																								if (everyweekstatus.length > 0) {
																									for (var m = 0; m < everyweekstatus.length; m++) {
																										if (parseInt(weeklast) == parseInt(everyweekstatus[m].check_week)) {
																											var button = '<button class="ui teal basic button "id="weekbtn'
																													+ parseInt(weeklast)
																													+ '" >'
																													+ " "
																													+ parseInt(weeklast)
																													+ " "
																													+ '</button>';
																											$(
																													"#weekbtn")
																													.prepend(
																															$(button));
																											break;
																										}
																										if (m == everyweekstatus.length - 1) {
																											var button = '<button class="ui teal basic button"id="weekbtn'
																													+ parseInt(weeklast)
																													+ '" data-content="尚未提交" >'
																													+ '<i class="upload red icon"></i>'
																													+ parseInt(weeklast)
																													+ '</button>';
																											$(
																													"#weekbtn")
																													.prepend(
																															$(button));
																										}
																									}
																								} else {
																									var button = '<button class="ui teal basic button"id="weekbtn'
																											+ parseInt(weeklast)
																											+ '" data-content="尚未提交" >'
																											+ '<i class="upload red icon"></i>'
																											+ parseInt(weeklast)
																											+ '</button>';
																									$(
																											"#weekbtn")
																											.prepend(
																													$(button));
																								}
																							} else {
																								var weekStar = parseInt(weekbegin);
																								var weekEnd = parseInt(weeklast);

																								var btntimes = weekEnd
																										- weekStar
																										+ 1;
																								for (var j = 0; j < btntimes; j++) {
																									if (everyweekstatus.length > 0) {
																										for (var m = 0; m < everyweekstatus.length; m++) {
																											if ((weekStar + j) == parseInt(everyweekstatus[m].check_week)) {
																												var button = '<button class="ui teal basic button"id="weekbtn'
																														+ (weekStar + j)
																														+ '">'
																														+ (weekStar + j)
																														+ '</button>';
																												$(
																														"#weekbtn")
																														.prepend(
																																$(button));
																												break;
																											}
																											if (m == everyweekstatus.length - 1) {
																												var button = '<button class="ui teal basic button"id="weekbtn'
																														+ (weekStar + j)
																														+ '" data-content="尚未提交" >'
																														+ '<i class="upload red icon"></i>'
																														+ (weekStar + j)
																														+ '</button>';
																												$(
																														"#weekbtn")
																														.prepend(
																																$(button));
																											}
																										}
																									} else {
																										var button = '<button class="ui teal basic button" id="weekbtn'
																												+ (weekStar + j)
																												+ '"data-content="尚未提交" >'
																												+ '<i class="upload red icon"></i>'
																												+ (weekStar + j)
																												+ '</button>';
																										$(
																												"#weekbtn")
																												.prepend(
																														$(button));
																									}
																								}
																							}
																							$(
																									'.ui.teal.basic.button')
																									.popup();
																							$(
																									".ui.teal.basic.button")
																									.unbind(
																											'click')
																									.click(
																											function() {
																												$(
																														".ui.teal.basic.button")
																														.removeClass(
																																"active");
																												$(
																														this)
																														.addClass(
																																"active");
																												selectweek = "";
																												selectweek = $(
																														this)
																														.text(); 
																												$('#dqzd').text(selectweek+"周");
																												$(
																														"#cdrs")  
																														.text(
																																"0");
																												$(
																														"#ztrs")
																														.text(
																																"0");
																												$(
																														"#kkrs")
																														.text(
																																"0");
																												$(
																														"#qjrs")
																														.text(
																																"0");
																												for (var i = 0; i < infClass.length; i++)//把卡片还原
																												{
																													$(
																															'#stucard'
																																	+ i
																																	+ '')
																															.find(
																																	".ui.right.corner.label")
																															.attr(
																																	"class",
																																	"ui green right corner label");
																													$(
																															'#stucard'
																																	+ i
																																	+ '')
																															.find(
																																	".ui.right.corner.label")
																															.find(
																																	".icon")
																															.attr(
																																	"class",
																																	"checkmark icon");

																												}
																												if (course_classtime == null)//提交按钮出现//点击选周后
																												{
																													if (check_sx != "") {
																														$(
																																'#submitdiv')
																																.show(
																																		'slow');
																														sxstustatus(
																																sche_no,
																																selectweek,
																																term_no,
																																check_sx,
																																weekend);
																													}

																												} else {
																													$(
																															'#submitdiv')
																															.show(
																																	'slow');
																													stustatus(
																															sche_no,
																															selectweek,
																															term_no,
																															weekend);
																												}
																											})
																						})
																		$(
																				".ui.teal.basic.button")
																				.unbind(
																						'click')
																				.click(
																						function() { //点击选周按钮
																							$(
																									".ui.teal.basic.button")
																									.removeClass(
																											"active");
																							$(
																									this)
																									.addClass(
																											"active");
																							selectweek = "";
																							selectweek = $(
																									this)
																									.text();
																							$('#dqzd').text(selectweek+"周");
																							$(
																									"#cdrs")
																									.text(
																											"0");
																							$(
																									"#ztrs")
																									.text(
																											"0");
																							$(
																									"#kkrs")
																									.text(
																											"0");
																							$(
																									"#qjrs")
																									.text(
																											"0");
																							for (var i = 0; i < infClass.length; i++)//把卡片还原
																							{
																								$(
																										'#stucard'
																												+ i
																												+ '')
																										.find(
																												".ui.right.corner.label")
																										.attr(
																												"class",
																												"ui green right corner label");
																								$(
																										'#stucard'
																												+ i
																												+ '')
																										.find(
																												".ui.right.corner.label")
																										.find(
																												".icon")
																										.attr(
																												"class",
																												"checkmark icon");

																							}
																							if (course_classtime == null)//提交按钮出现//点击选周后
																							{
																								if (check_sx != "") {
																									$(
																											'#submitdiv')
																											.show(
																													'slow');
																									sxstustatus(
																											sche_no,
																											selectweek,
																											term_no,
																											check_sx,
																											weekend);
																								}
																							} else {
																								$(
																										'#submitdiv')
																										.show(
																												'slow');
																								stustatus(
																										sche_no,
																										selectweek,
																										term_no,
																										weekend);
																							}

																						})
																		$(
																				"#submitdiv")
																				.click(
																						function() { //点击提交按钮
																							
																							if((selectweek!=""&&(parseInt(currentweek)-parseInt(selectweek)>1))&&switchFlag){
																								$.alert("已超出考勤周期，不可以继续考勤"); 
																								return;
																							} 
																						
																							if ($(
																									this)
																									.hasClass(
																											"loading"))
																								return;
																							$(
																									"#submitdiv")
																									.addClass(
																											"loading");
																							var subweek = "";
																							var check_kk = $(
																									"#kkrs")
																									.text();
																							var check_cd = $(
																									"#cdrs")
																									.text();
																							var check_zt = $(
																									"#ztrs")
																									.text();
																							var check_qj = $(
																									"#qjrs")
																									.text();
																							var stu_count = $(
																									"#bjrs")
																									.text();
																							var ratio_ = ratio();
																							if (selectweek != "") {
																								subweek = selectweek;
																							} else {
																								subweek = currentweek;
																							}
																							if (course_classtime == null) {
																								$.ajax({
																											url : "do?invoke=studentCheck@postsxStuStatus",
																											type : 'POST',
																											dataType : 'json',
																											data : {
																												sche_no : sche_no,
																												currentweek : subweek,
																												term_no : term_no,
																												check_sx : check_sx,
																												check_kk : check_kk,
																												check_zt : check_zt,
																												check_cd : check_cd,
																												check_qj : check_qj,
																												stu_count : stu_count,
																												check_ratio : ratio_
																											},
																											success : function(
																													rep) {
																												if (parseInt(subweek) == parseInt(currentweek)) {
																													$(
																															"#nowweek")
																															.attr(
																																	"data-content",
																																	"")
																															.find(
																																	".icon")
																															.remove();
																												}
																												$(
																														'#weekbtn'
																																+ parseInt(subweek)
																																+ '')
																														.attr(
																																"data-content",
																																"")
																														.find(
																																".icon")
																														.remove(); //提交后去除未提交状态
																												getsxweeksSta(
																														sche_no,
																														term_no,
																														check_sx); //重新提取每周状态 
																												$
																														.alert({

																															msg : rep.message,
																															type : 'info',
																															btnText : '我知道啦',
																														});
																												$(
																														"#submitdiv")
																														.removeClass(
																																"loading");

																											}

																										});
																							} else {
																								$.ajax({
																											url : "do?invoke=studentCheck@postStuStatus",
																											type : 'POST',
																											dataType : 'json',
																											data : {
																												sche_no : sche_no,
																												currentweek : subweek,
																												term_no : term_no,
																												check_sx : check_sx,
																												check_kk : check_kk,
																												check_zt : check_zt,
																												check_cd : check_cd,
																												check_qj : check_qj,
																												stu_count : stu_count,
																												check_ratio : ratio_
																											},
																											success : function(
																													rep) {
																												if (parseInt(subweek) == parseInt(currentweek)) {
																													$(
																															"#nowweek")
																															.attr(
																																	"data-content",
																																	"")
																															.find(
																																	".icon")
																															.remove();
																												}
																												$(
																														'#weekbtn'
																																+ parseInt(subweek)
																																+ '')
																														.attr(
																																"data-content",
																																"")
																														.find(
																																".icon")
																														.remove(); //提交后去除未提交状态
																												getweeksSta(
																														sche_no,
																														term_no); //重新提取每周状态 
																												$
																														.alert({

																															msg : rep.message,
																															type : 'info',
																															btnText : '我知道啦',
																														});
																												$(
																														"#submitdiv")
																														.removeClass(
																																"loading");

																											}

																										});
																							}

																						})
																	}//success-else
																}//success
															});//提取班级信息 

													//-------


												})//点击选课

							}
						}
					}); //ajax

			$('.ui.accordion').accordion();

			$('.ui.dropdown').dropdown();

			$('#submitdiv').popup();

		}//初始化function
		function ratio() { //计算出勤率
			var scount = parseInt($("#bjrs").text());
			var qqcount = parseInt($("#kkrs").text())
					+ parseInt($("#ztrs").text()) + parseInt($("#cdrs").text());
			var qqratio = ((scount - qqcount) / scount * 100).toFixed(2);
			return qqratio;
		}
		function changestatus(mainid, stu_no, status, agostatus) {
			$
					.ajax({
						url : "do?invoke=studentCheck@changeStuStatus",
						type : 'POST',
						dataType : 'json',
						data : {
							mainid : mainid,
							stu_no : stu_no,
							check_status : status,
							old_check_status : agostatus,
						},
						success : function(stustatus) {
							$(".stuinf").removeClass("loading");
							$(".ui.cards").removeClass("loading");
							/* if (selectweek != "") //改变考勤状态的时候 变提交为提交
							{
								for (var i = 0; i < everyweekstatus.length; i++)//改变everyweekstatus[].check_status
								{
									if (parseInt(selectweek) == parseInt(everyweekstatus[i].check_week)) {

										if ($(
												"#weekbtn"
														+ parseInt(everyweekstatus[i].check_week)
														+ "").attr(
												"data-content") != "尚未提交") {
											var dom = '<i class="upload red icon"></i>';//parseInt(everyweekstatus[i].check_week)
											$(
													"#weekbtn"
															+ parseInt(everyweekstatus[i].check_week)
															+ "").attr(
													"data-content", "尚未提交")
													.prepend($(dom)); //改变当前周的图标
										}
										everyweekstatus.splice(i, 1);//删除everyweekstatus[i]
										break;
									}
								}

							} else {
								for (var i = 0; i < everyweekstatus.length; i++)//改变everyweekstatus[].check_status
								{
									if (parseInt(currentweek) == parseInt(everyweekstatus[i].check_week)) {

										if ($(
												"#weekbtn"
														+ parseInt(everyweekstatus[i].check_week)
														+ "").attr(
												"data-content") != "尚未提交") {
											var dom = '<i class="upload red icon"></i>';//parseInt(everyweekstatus[i].check_week)
											$(
													"#weekbtn"
															+ parseInt(everyweekstatus[i].check_week)
															+ "").attr(
													"data-content", "尚未提交")
													.prepend($(dom)); //改变当前周的图标
										}
										if ($("#nowweek").attr("data-content") != "尚未提交") {
											var dom = '<i class="upload red icon"></i>';//parseInt(everyweekstatus[i].check_week)
											$("#nowweek").attr("data-content",
													"尚未提交").prepend($(dom)); //改变当前周的图标
										}
										everyweekstatus.splice(i, 1);//删除everyweekstatus[i]
										break;
									}
								}
							} */
						}
					});
		}
		function savestatus(mainid, stu_no, status) { //提交
			$
					.ajax({
						url : "do?invoke=studentCheck@saveStuStatus",
						type : 'POST',
						dataType : 'json',
						data : {
							mainid : mainid,
							stu_no : stu_no,
							check_status : status,
						},
						success : function(stustatus) {
							$(".stuinf").removeClass("loading");
							$(".ui.cards").removeClass("loading");
							
						}
					});
		}
		function removestatus(mainid, stu_no, status) {
			$
					.ajax({
						url : "do?invoke=studentCheck@removeStuStatus",
						type : 'POST',
						dataType : 'json',
						data : {
							mainid : mainid,
							stu_no : stu_no,
							check_status : status,
						},
						success : function(stustatus) {
							$(".stuinf").removeClass("loading");
							$(".ui.cards").removeClass("loading");
						
						}
					});
		}
		function getsxweeksSta(sche_no, term_no, check_sx) { //提取每周考勤状态（实训）
			$.ajax({
				url : "do?invoke=studentCheck@getsxweeksSta",
				type : 'POST',
				dataType : 'json',
				async : false,
				data : {
					check_sx : check_sx,
					sche_no : sche_no,
					term_no : term_no,
				},
				success : function(sxweeksSta) {
					everyweekstatus = sxweeksSta.data;
				}
			});
		}
		function getweeksSta(sche_no, term_no) { //提取每周考勤状态
			$.ajax({
				url : "do?invoke=studentCheck@getweeksSta",
				type : 'POST',
				dataType : 'json',
				async : false,
				data : {
					sche_no : sche_no,
					term_no : term_no,
				},
				success : function(weeksSta) {
					everyweekstatus = weeksSta.data;
				}
			});
		}
		function stustatus(sche_no, currentweek, term_no, weekend) {
			if (parseInt(currentweek) > parseInt(weekend)) {
				return;
			}
			$.ajax({
				url : "do?invoke=studentCheck@getStuStatus",
				type : 'POST',
				dataType : 'json',
				data : {
					sche_no : sche_no,
					currentweek : currentweek,
					term_no : term_no,
				},
				success : function(stustatus) {
					if (stustatus.result == 0) {
						$.alert("", stustatus.message);
					} else {

						info = stustatus.data[0];
						mainid = info.mainid;
						for (var i = 0; i < info.checklist.length; i++) {
							if (info.checklist[i].check_status == "迟到") {
								$("#cdrs")
										.text(parseInt($("#cdrs").text()) + 1);
								$('#stucard' + info.checklist[i].stu_no + '')
										.find('.ui.green.right.corner.label')
										.find(".icon").attr("class",
												"wait icon");
								$('#stucard' + info.checklist[i].stu_no + '')
										.find('.ui.green.right.corner.label')
										.removeClass("green")
										.addClass("yellow");
							}
							if (info.checklist[i].check_status == "早退") {
								$("#ztrs")
										.text(parseInt($("#ztrs").text()) + 1);
								$('#stucard' + info.checklist[i].stu_no + '')
										.find('.ui.green.right.corner.label')
										.find(".icon").attr("class",
												"warning icon");
								$('#stucard' + info.checklist[i].stu_no + '')
										.find('.ui.green.right.corner.label')
										.removeClass("green")
										.addClass("orange");
							}
							if (info.checklist[i].check_status == "旷课") {
								$("#kkrs")
										.text(parseInt($("#kkrs").text()) + 1);
								$('#stucard' + info.checklist[i].stu_no + '')
										.find('.ui.green.right.corner.label')
										.find(".icon").attr("class",
												"remove icon");
								$('#stucard' + info.checklist[i].stu_no + '')
										.find('.ui.green.right.corner.label')
										.removeClass("green").addClass("red");
							}
							if (info.checklist[i].check_status == "请假") {
								$("#qjrs")
										.text(parseInt($("#qjrs").text()) + 1);
								$('#stucard' + info.checklist[i].stu_no + '')
										.find('.ui.green.right.corner.label')
										.find(".icon").attr("class",
												"doctor icon");
								$('#stucard' + info.checklist[i].stu_no + '')
										.find('.ui.green.right.corner.label')
										.removeClass("green").addClass("blue");
							}
						}
					}
				}
			});
		}

		function sxstustatus(sche_no, currentweek, term_no, check_sx, weekend) {
			if (parseInt(currentweek) > parseInt(weekend)) {
				return;
			}

			$.ajax({
				url : "do?invoke=studentCheck@getsxStuStatus",
				type : 'POST',
				dataType : 'json',
				data : {
					sche_no : sche_no,
					currentweek : currentweek,
					term_no : term_no,
					check_sx : check_sx,
				},
				success : function(sxstustatus) {
					if (sxstustatus.result == 0) {
						$.alert("", sxstustatus.message);
					} else {

						info = sxstustatus.data[0];
						mainid = info.mainid;
						for (var i = 0; i < info.checklist.length; i++) {
							if (info.checklist[i].check_status == "迟到") {
								$("#cdrs")
										.text(parseInt($("#cdrs").text()) + 1);
								$('#stucard' + info.checklist[i].stu_no + '')
										.find('.ui.green.right.corner.label')
										.find(".icon").attr("class",
												"wait icon");
								$('#stucard' + info.checklist[i].stu_no + '')
										.find('.ui.green.right.corner.label')
										.removeClass("green")
										.addClass("yellow");
							}
							if (info.checklist[i].check_status == "早退") {
								$("#ztrs")
										.text(parseInt($("#ztrs").text()) + 1);
								$('#stucard' + info.checklist[i].stu_no + '')
										.find('.ui.green.right.corner.label')
										.find(".icon").attr("class",
												"warning icon");
								$('#stucard' + info.checklist[i].stu_no + '')
										.find('.ui.green.right.corner.label')
										.removeClass("green")
										.addClass("orange");
							}
							if (info.checklist[i].check_status == "旷课") {
								$("#kkrs")
										.text(parseInt($("#kkrs").text()) + 1);
								$('#stucard' + info.checklist[i].stu_no + '')
										.find('.ui.green.right.corner.label')
										.find(".icon").attr("class",
												"remove icon");
								$('#stucard' + info.checklist[i].stu_no + '')
										.find('.ui.green.right.corner.label')
										.removeClass("green").addClass("red");
							}
							if (info.checklist[i].check_status == "请假") {
								$("#qjrs")
										.text(parseInt($("#qjrs").text()) + 1);
								$('#stucard' + info.checklist[i].stu_no + '')
										.find('.ui.green.right.corner.label')
										.find(".icon").attr("class",
												"doctor icon");
								$('#stucard' + info.checklist[i].stu_no + '')
										.find('.ui.green.right.corner.label')
										.removeClass("green").addClass("blue");
							}
						}
					}
				}
			});
		}
		function judgeweekSta(currentweek, weekend) { //****************************

			if (parseInt(currentweek) <= parseInt(weekend)) {

				var weektimes = parseInt((parseInt(currentweek) - 1) / 5) + 1;
				for (var i = 0; i < weektimes; i++) {
					if (i == weektimes - 1) {

						if ((parseInt(currentweek) - 1) % 5 == 0) {

							var list_ = '<div class="item">'
									+ '<div class="content">'
									+ '<i class="header week" id="weekmenu'
									+ (i * 5 + 1) + '"> ' + " " + " "
									+ (i * 5 + 1) + " " + " " + '</i>'
									+ '</div>' + '</div>';
							$(".ui.horizontal.divided.list").prepend($(list_));
							console.log(i * 5 + 1);
							if (everyweekstatus.length > 0) {
								for (var m = 0; m < everyweekstatus.length; m++) {
									if (parseInt(currentweek) == parseInt(everyweekstatus[m].check_week)) {
										var button_ = '<button class="ui teal basic button" id="weekbtn'
												+ (i * 5 + 1)
												+ '" >'
												+ (i * 5 + 1) + '</button>';
										$("#weekbtn").prepend($(button_));
										break;
									}
									if (m == everyweekstatus.length - 1) {
										var button_ = '<button class="ui teal basic button" id="weekbtn'
												+ (i * 5 + 1)
												+ '" data-content="尚未提交" >'
												+ '<i class="red upload icon"></i>'
												+ (i * 5 + 1) + '</button>';
										$("#weekbtn").append($(button_));

									}
								}
							} else {

								var button_ = '<button class="ui teal basic button"id="weekbtn'
										+ (i * 5 + 1)
										+ '" data-content="尚未提交" >'
										+ '<i class="red upload icon"></i>'
										+ (i * 5 + 1) + '</button>';
								$("#weekbtn").append($(button_));
							}
							break;
						}

						var list_ = '<div class="item">'
								+ '<div class="content">'
								+ '<i class="header week" id="weekmenu'
								+ (i * 5 + 1) + '"> ' + currentweek + " " + "-"
								+ " " + (i * 5 + 1) + ' </i>' + '</div>'
								+ '</div>';
						$(".ui.horizontal.divided.list").prepend($(list_));

						var btntimes = currentweek - (i * 5 + 1) + 1;

						for (var j = 0; j < btntimes; j++) {
							if (everyweekstatus.length > 0) {
								for (var m = 0; m < everyweekstatus.length; m++) {
									if (i * 5 + 1 + j == parseInt(everyweekstatus[m].check_week)) {
										var button_ = '<button class="ui teal basic button"id="weekbtn'
												+ (i * 5 + 1 + j)
												+ '"  >'
												+ (i * 5 + 1 + j) + '</button>';
										$("#weekbtn").prepend($(button_));
										break;
									}
									if (m == everyweekstatus.length - 1) {

										var button_ = '<button class="ui teal basic button"id="weekbtn'
												+ (i * 5 + 1 + j)
												+ '"  data-content="尚未提交" >'
												+ '<i class="red upload icon"></i>'
												+ (i * 5 + 1 + j) + '</button>';
										$("#weekbtn").prepend($(button_));
									}
								}
							} else {
								var button_ = '<button class="ui teal basic button" id="weekbtn'
										+ (i * 5 + 1 + j)
										+ '" data-content="尚未提交" >'
										+ '<i class="red upload icon"></i>'
										+ (i * 5 + 1 + j) + '</button>';
								$("#weekbtn").prepend($(button_));
							}
						}
						break;
					}
					var list = '<div class="item">' + '<div class="content">'
							+ '<i class="header week"id="weekmenu'
							+ (i * 5 + 1) + '" > ' + " " + (i * 5 + 5) + " "
							+ "-" + " " + (i * 5 + 1) + " " + ' </i>'
							+ '</div>' + '</div>';
					$(".ui.horizontal.divided.list").prepend($(list));
				}
			} else {

				var weektimes = parseInt((parseInt(weekend) - 1) / 5) + 1;
				for (var i = 0; i < weektimes; i++) {
					if (i == weektimes - 1) {
						if ((parseInt(weekend) - 1) % 5 == 0) {

							var list_ = '<div class="item">' 
									+ '<div class="content">'
									+ '<i class="header week"id="weekmenu'
									+ (i * 5 + 1) + '" > ' + " " + " "
									+ (i * 5 + 1) + " " + " " + '</i>'
									+ '</div>' + '</div>';
							$(".ui.horizontal.divided.list").prepend($(list_));
							if (everyweekstatus.length > 0) {
								for (var m = 0; m < everyweekstatus.length; m++) {
									if (parseInt(weekend) == parseInt(everyweekstatus[m].check_week)) {
										var button_ = '<button class="ui teal basic button" id="weekbtn'
												+ (i * 5 + 1)
												+ '"  >'
												+ (i * 5 + 1) + '</button>';
										$("#weekbtn").append($(button_));
										break;
									}
									if (m == everyweekstatus.length - 1) {

										var button_ = '<button class="ui teal basic button" id="weekbtn'
												+ (i * 5 + 1)
												+ '" data-content="尚未提交" >'
												+ '<i class="red upload icon"></i>'
												+ (i * 5 + 1) + '</button>';
										$("#weekbtn").append($(button_));
									}
								}
							} else {
								var button_ = '<button class="ui teal basic button" id="weekbtn'
										+ (i * 5 + 1)
										+ '" data-content="尚未提交" >'
										+ '<i class="red upload icon"></i>'
										+ (i * 5 + 1) + '</button>';
								$("#weekbtn").append($(button_));
							}

							break;
						}

						var list_ = '<div class="item">'
								+ '<div class="content">'
								+ '<i class="header week"id="weekmenu'
								+ (i * 5 + 1) + '" > ' + weekend + ' ' + " "
								+ '-' + " " + ' ' + (i * 5 + 1) + ' </i>'
								+ '</div>' + '</div>';
						$(".ui.horizontal.divided.list").prepend($(list_));
						var btntimes = weekend - (i * 5 + 1) + 1;
						for (var j = 0; j < btntimes; j++) {
							if (everyweekstatus.length > 0) {
								for (var m = 0; m < everyweekstatus.length; m++) {

									if (i * 5 + 1 + j == parseInt(everyweekstatus[m].check_week)) {
										var button_ = '<button class="ui teal basic button" id="weekbtn'
												+ (i * 5 + 1 + j)
												+ '"  >'
												+ (i * 5 + 1 + j) + '</button>';
										$("#weekbtn").prepend($(button_));
										break;
									}
									if (m == everyweekstatus.length - 1) {

										var button_ = '<button class="ui teal basic button"id="weekbtn'
												+ (i * 5 + 1 + j)
												+ '"  data-content="尚未提交" >'
												+ '<i class="red upload icon"></i>'
												+ (i * 5 + 1 + j) + '</button>';
										$("#weekbtn").prepend($(button_));
									}
								}
							} else {

								var button_ = '<button class="ui teal basic button" id="weekbtn'
										+ (i * 5 + 1 + j)
										+ '" data-content="尚未提交" >'
										+ '<i class="red upload icon"></i>'
										+ (i * 5 + 1 + j) + '</button>';
								$("#weekbtn").prepend($(button_));
							}
						}
						break;
					}
					var list = '<div class="item">' + '<div class="content">'
							+ '<i class="header week" id="weekmenu'
							+ (i * 5 + 1) + '"> ' + " " + (i * 5 + 5) + " "
							+ "-" + " " + (i * 5 + 1) + " " + ' </i>'
							+ '</div>' + '</div>';
					$(".ui.horizontal.divided.list").prepend($(list));
				}

			}//周次 
			$('.ui.basic.button').popup();
		}
		function getCheckRecord(check_sche_no, index){
			$.ajax({
						url : "do?invoke=studentCheck@getCheckRecord",
						type : 'POST',
						dataType : 'json',
						data : {
							check_sche_no : check_sche_no
						},
						success : function(rep) {
							console.log(rep)
							if (rep.result == 0) {
								var dom = '<tr class="tr check">'
										+ '<td colspan="10" class="center aligned" >该课次暂无考勤记录</td>'
										+ '</tr>';
								$('.ui.compact.celled.table.check tbody')
										.append(dom);
							} else {
								var checkRecord = rep.data;
								for (var i = 0; i < checkRecord.length; i++) {
									var dom = '<tr class="tr check index'+i+'">'
											+ '<td class="center aligned week check">'
											+ checkRecord[i].check_week 
											+ '</td>';
											if(checkRecord[i].check_sx == "" ||checkRecord[i].check_sx ==null){
												dom+='<td class="center aligned">' 
													+ index.split("——")[3];
													+ '</td>';  
											}else{
												var weekArray = ["星期一/","星期二/","星期三/","星期四/","星期五/","星期六/","星期天/"];
												var courseArray = ["一二节","三四节","五六节","七八节","九十节"];
												dom+='<td class="center aligned">'  
													+ weekArray[parseInt(checkRecord[i].check_sx.substring(1,2))-1]+courseArray[parseInt(checkRecord[i].check_sx.substring(2,3))-1]
													+ '</td>';  
											}
											+ '<td class="center aligned">'
											+ checkRecord[i].check_week 
											+ '</td>'
											dom+='<td class="center aligned">'
											+ checkRecord[i].check_time
													.substring(0, 10) + '</td>';
									if (checkRecord[i].check_kk == null
											|| checkRecord[i].check_kk == "") {
										dom += '<td class="center aligned"> </td>';
									} else {
										dom += '<td class="center aligned">'
												+ checkRecord[i].check_kk
												+ '</td>';
									}
									if (checkRecord[i].check_zt == null
											|| checkRecord[i].check_zt == "") {
										dom += '<td class="center aligned"> </td>';
									} else {
										dom += '<td class="center aligned">'
												+ checkRecord[i].check_zt
												+ '</td>';
									}
									if (checkRecord[i].check_cd == null
											|| checkRecord[i].check_cd == "") {
										dom += '<td class="center aligned"> </td>';
									} else {
										dom += '<td class="center aligned">'
												+ checkRecord[i].check_cd
												+ '</td>';
									}
									if (checkRecord[i].check_qj == null
											|| checkRecord[i].check_qj == "") {
										dom += '<td class="center aligned"> </td>';
									} else {
										dom += '<td class="center aligned">'
												+ checkRecord[i].check_qj
												+ '</td>';
									}
									if (checkRecord[i].check_count == null
											|| checkRecord[i].check_count == "") {
										dom += '<td class="center aligned"> </td>';
									} else {
										dom += '<td class="center aligned">'
												+ checkRecord[i].check_count
												+ '</td>';
									}
									if (checkRecord[i].check_ratio == null
											|| checkRecord[i].check_ratio == "") {
										dom += '<td class="center aligned"> </td>';
									} else {
										dom += '<td class="center aligned">'
												+ checkRecord[i].check_ratio
												+ '</td>';
									}
									if (checkRecord[i].check_main_status == '0') {
										dom += '<td class="center aligned">未提交</td>';
									
									} else { 
										dom += '<td class="center aligned">已提交</td>';
									
									}
									'</tr>';
								
									$('.ui.compact.celled.table.check tbody') 
											.append(dom);
									if (checkRecord[i].check_main_status == '0') {
										$('.tr.check.index'+i+'').find('td').addClass('negative');
									
									} else { 
										$('.tr.check.index'+i+'').find('td').addClass('positive');
									
									}

								}
								//点击进入考勤
								$('.recordCheck.button')
										.unbind('click')
										.click(
												function() {
													$('#checkModal').modal(
															'hide');

													$('.item.classinf')
															.each(
																	function(
																			index_,
																			value) {
																		if ($(
																				'.item.classinf')
																				.eq(
																						index_)
																				.text()
																				.trim() == index
																				.trim()) { 
																			$('.item.classinf').eq(index_).trigger("click");
																		}
																	}) 
																
												});
							}
							$('#checkModal').modal('show');
						}
					});
		}

	});//JQ
	//--------------------------
</script>
<!--这里引用其他JS-->
</html>