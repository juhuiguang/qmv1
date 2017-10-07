<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@include file="/commonjsp/meta.jsp"%>
<!--这里引用其他样式-->
<title>欢迎使用-首页</title>
<style>
#btnsubmit {
	width: 100%;
	margin: 10px auto;
}

textarea {
	width: 100%;
	margin-top: 10px;
}

#tableinfo .header {
	font-size: 100%;
	font-weight: 200;
}

#taskgrid {
	margin-top: 2px;
	height: 400px;
	overflow-y: scroll;
}

#taskgrid .card {
	cursor: pointer;
	width: 200px;
	overflow-y: scroll;
}

#taskgrid a {
	cursor: pointer;
}
</style>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<!--这里绘制页面-->
	<div id="container" class="ui grid">
		<div id="leftpanel" class="sixteen wide column">
			<div class="ui top attached tabular menu" id="datatype">
				<a class="item" data-tab="first">我的反馈</a> <a class="item"
					data-tab="second">添加反馈情况</a>
			</div>
			<div class="ui bottom attached tab segment active" data-tab="first"
				id="myplan"></div>

			<div class="ui bottom attached tab segment" data-tab="second"
				id="alltask">
				<div>
					<h4 class="ui  center aligned horizontal divider header">
						<i class="file word outline icon"></i> 督学第十五周巡查记录表
					</h4>

					<div class="ui horizontal segments ">
						<div class="ui left aligned segment">
							<p>时间：6月8日至6月12日</p>
						</div>
						<div class="ui right aligned segment">
							<p>质量监控与评估处</p>
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
								<div class="ui blue ribbon label" id="aaa">1、学生出勤情况</div>
								<p style="margin: 10px">
									<textarea id="txtjxpj" rows="3"></textarea>
								</p>
							</div>

							<div class="field">
								<div class="ui blue ribbon label">2、学生学习情况</div>
								<p style="margin: 10px">
									<textarea id="txtjxjy" rows="3"></textarea>
								</p>
							</div>
							<div class="field">
								<div class="ui blue ribbon label">3、教师教学情况</div>
								<p style="margin: 10px">
									<textarea id="txtjxjy" rows="3"></textarea>
								</p>
							</div>
							<div class="field">
								<div class="ui blue ribbon label">4、教学管理情况</div>
								<p style="margin: 10px">
									<textarea id="txtjxjy" rows="3"></textarea>
								</p>
							</div>
							<div class="field">
								<div class="ui blue ribbon label">5、教学条件保障</div>
								<p style="margin: 10px">
									<textarea id="txtjxjy" rows="3"></textarea>
								</p>
							</div>
							<div class="field">
								<div class="ui blue ribbon label">6、其他情况</div>
								<p style="margin: 10px">
									<textarea id="txtjxjy" rows="3"></textarea>
								</p>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
</body>

<script>
	$(function() {
		$('#datatype .item,#searchtab .item').tab();
		var curr_rule_flag = "";
		var userProperties = {
			mark : null,
			plan : null
		}

		//获取个人听课计划
		getMyPlan(function(plan) {
			if (plan != null) {//如果存在个人计划，初始化个人计划面板
				userProperties.plan = plan;
				initPlanPnl();
			} else {//不存在个人计划，就查询个人关注
				getMyMark(function(mark) {
					if (mark != null) {//如果存在关注，初始化个人关注面板
						userProperties.mark = mark;
						initMarkPnl();
					} else {//前两者都不存在，进入全部教学任务面板
						initAllTaskPnl();
					}
				});
			}
		});

		function changeDataTypePnl(tabname) {
			$("#datatype .item.active").removeClass("active");
			$("#datatype .item[data-tab='" + tabname + "']").addClass("active");
			$.tab('change tab', tabname);
		}

		//初始化全部教学任务面板
		function initAllTaskPnl() {
			//切换至全部教学任务pnl
			changeDataTypePnl("first");

			$.ajax({
				url : 'do?invoke=ListenAction@getTeachers',
				dataType : "JSON",
				type : "POST",
				success : function(data) {
					$('#teachernamesrch').search({
						source : data,
						searchFields : [ 'title' ],
						searchFullText : false,
						onSelect : function(result, response) {
							getTasks("teacher", result.title, function(data) {
								drawTask(data.data, "taskgrid");
							});
						}

					});
				}
			});

			//如果是校级督学，跳转至按姓名查找
			if (false && USEROBJECT.userpurview == "ALL") {
				$("#searpnl .item.active").removeClass("active");
				$("#searpnl .item[data-tab='searchname']").addClass("active");
				$.tab('change tab', 'searchname');
			} else {//部门督学跳转至按周次查找
				$("#searpnl .item.active").removeClass("active");
				$("#searpnl .item[data-tab='searchweek']").addClass("active");
				$.tab('change tab', 'searchweek');
				var curweekday = new Date().getDay();
				if (curweekday == 0)
					curweekday = 7;
				$("#srchweek_" + curweekday).addClass("blue selected");
				//初始化获取
				getTasks("week", curweekday, function(data) {
					drawTask(data.data, "taskgrid");
				});
			}

			//绑定周选择按钮
			$("#weeksearch .label").unbind("click").click(function() {
				$("#weeksearch .selected").removeClass("blue selected");
				$(this).addClass("blue selected");
				var selectedweek = this.id.split("_")[1];
				getTasks("week", selectedweek, function(data) {
					drawTask(data.data, "taskgrid");
				});
			});
		}

		//初始化周计划面板
		function initPlanPnl() {

		}

		//初始化关注的人面板
		function initMarkPnl() {

		}

		//开始听课
		function beginListen(rule_flag, task_no) {
			$("#leftpanel").attr("class", "nine wide column");
			loadtable();
			$("#rightpanel").transition("fly left in");
		}

		//获得我的听课计划
		function getMyPlan(callback) {
			var myplan = null;
			if (callback) {
				callback(myplan);
			}
		}

		//获得我关注的教学任务
		function getMyMark(callback) {
			var mymark = null;
			if (callback) {
				callback(mymark);
			}
		}

		function getTasks(type, keywords, callback) {
			$.ajax({
				url : "do?invoke=ListenAction@getTasks",
				type : 'POST',
				dataType : 'json',
				data : {
					dep_no : USEROBJECT.userpurview,
					type : type,
					keywords : keywords
				},
				success : function(rep) {
					if (callback) {
						callback(rep);
					}
				}
			})
		}

		//渲染教学任务
		function drawTask(data, containerid) {
			console.log($("#" + containerid));
			$("#" + containerid).children().remove();
			for (var i = 0; i < data.length; i++) {
				var task = data[i];
				var dom = '<div class="blue card">'
						+ '<div class="content firstpage">'
						+ '<div class="header">' + task.teacher_name + '</div>'
						+ '<div class="meta">' + task.course_type + '</div>'
						+ '<div class="description">' + task.course_name
						+ '</div>' + '</div>';
				if (task.classes && task.classes.length > 0) {
					dom += '<div class="content secondpage" style="display:none;">'
							+ '<div class="description">'
							+ '<div class="ui middle aligned selection list">';
					for (var j = 0; j < task.classes.length; j++) {
						var taskclass = task.classes[j];
						var taskjc = "";
						if (taskclass.sches && taskclass.sches.length > 0) {
							for (var k = 0; k < taskclass.sches.length; k++) {
								var jcz = taskclass.sches[k];
								var zc = jcz.sche_set.substring(1, 2);
								var jc = jcz.sche_set.substring(2, 3);
								taskjc += WEEK[zc] + " " + COURSE_JC[jc] + " "
										+ jcz.sche_addr + ";<br/>";
							}
						}
						dom += '<div class="task item" id="task_'+taskclass.task_no+'">'
								+ '<div class="content">'
								+ '<div class="header"><a href=javascript:void(0);>'
								+ taskclass.class_name
								+ '</a></div>'
								+ taskjc
								+ '</div>' + '</div>';
					}
					dom += '</div>' + '</div>' + '</div>';
				}
				dom += '</div>';
				$("#" + containerid).append($(dom));
			}
			bindcardclick(containerid);
		}

		//绑定卡片点击事件
		function bindcardclick(containerid) {
			$("#" + containerid + " .card").unbind("click").click(function() {
				if ($(this).hasClass("red")) {
					$(this).removeClass("red");
					$(this).addClass("blue");
				} else {
					$(this).removeClass("blue");
					$(this).addClass("red");
				}
				$(this).children(".firstpage").transition('slide down');
				$(this).children(".secondpage").transition('slide up');
			});

			$("#" + containerid + " .task a").unbind("click").click(
					function(e) {
						e.stopPropagation();
						var task_no = this.id.split("_")[1];
						var course_type = $(this).parents(".card").children(
								".firstpage").children(".meta").text();
						//开始填写听课记录
						if (course_type == "讲授课") {
							course_type = "TK_JS";
						} else {
							course_type = "TK_SX";
						}
						beginListen(course_type, task_no);
						e.startPropagation();
					});

		}

		function loadtable() {
			$
					.ajax({
						url : "do?invoke=teacherListen@getTeaListenTable",
						type : 'POST',
						dataType : 'json',
						data : {
							flag : 'TK_JS'
						},
						success : function(rep) {
							if (rep.result == 0) {
								$.alert("", rep.message);
							} else {
								$("#tableheader").text(
										rep.data[0].rule_version_title);
								$("#tableheader").attr("tablename",
										rep.data[0].rule_table)
								var table = rep.data;
								$("#tableinfo .repeat").remove();
								for (var i = table.length - 1; i >= 0; i--) {
									var grade = [];
									var maxgrade = table[i].rule_goal;
									var div = parseInt(maxgrade) / 5;
									for (var j = 0; j < 5; j++) {
										grade[j] = parseInt(maxgrade)
												- (j * div);
									}
									var dom = '<div class="repeat item" rownumber="'+i+'" fieldname="'+table[i].rule_field+'"> '
											+ '<div class="ui raised content"> '
											+ '<div class="header">'
											+ '<i class="grid layout icon"></i>'
											+ (i + 1)
											+ '、'
											+ table[i].rule_title
											+ '<input class="middle aligned" type="range" name="item'+i+'" step=1 value=0 min="0" max="'+grade[0]+'" style="margin-left:20px;" />'
											+ '</div> ' +

											'</div>'
									'</div>';
									$("#tableinfo").prepend($(dom));
								}
							}
						}
					});
		}

		function postFormData() {
			var o = {
				fields : "",
				total : 0,
				tkpj : "",
				jxjy : ""
			};

			var items = $(".ruleitem");

			for (var i = 0; i < items.length; i++) {
				var item = items[i];
				var radios = $(item).find(":radio");
				for (var j = 0; j < radios.length; j++) {
					var c = $(radios[j])[0].checked;
					if (c) {
						var rowfield = $(items[i]).attr("fieldname");
						if (o.fields == "") {
							o.fields += rowfield;
						} else {
							o.fields += "," + rowfield;
						}
						o[rowfield] = $(radios[j]).attr("grade");
						o.total += parseInt($(radios[j]).attr("grade"));
					}
				}
			}
			o.tkpj = $("#txttkpj").val();
			o.jxjy = $("#txtjxjy").val();
			o.tablename = $("#tableheader").attr("tablename");
			if (o.tkpj == "" || o.jxjy == "") {
				$.confirm({
					msg : "您没有填写听课评价或教学建议，确认给该老师评 <b>" + o.total + "</b> 分吗？",
					btnSure : '确认提交 ',
					btnCancel : '继续填写',
					sureDo : function() {
						postdata(o);
					},
					cancelDo : function() {
						$("#btnsubmit").removeClass("loading");
					}
				});
				return;
			} else {
				$.confirm({
					msg : "您确定要给该老师评 " + o.total + " 分吗？",
					btnSure : '确认提交 ',
					btnCancel : '重新填写',
					sureDo : function() {
						postdata(o);
					},
					cancelDo : function() {
						$("#btnsubmit").removeClass("loading");
					}
				});
			}

		}

		function postdata(o) {
			$.ajax({
				url : "do?invoke=teacherListen@postListen",
				type : 'POST',
				dataType : 'json',
				data : o,
				success : function(rep) {
					$.alert("", rep.message);
					$("#btnsubmit").removeClass("loading");
				}
			});
		}

		$("#btnsubmit").click(function() {
			if ($(this).hasClass("loading"))
				return;
			$("#btnsubmit").addClass("loading");
			postFormData();
		});

	});
</script>
<!--这里引用其他JS-->
</html>