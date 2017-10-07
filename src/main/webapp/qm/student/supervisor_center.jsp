<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/commonjsp/doctype.jsp"%>
		<html>

		<head>
			<%@ include file="/commonjsp/meta.jsp"%>
				<script src="http://echarts.baidu.com/build/dist/echarts-all.js"></script>
				<!--这里引用其他样式-->
				<title>校内教学质量监控运行平台</title>
				<style>
					.title {
						width: 28%;
						height: 125px;
						margin-left: 28px;
					}
				</style>
		</head>

		<body>
			<%@ include file="/commonjsp/header.jsp"%>
				<div id="container">

					<div class="ui cards">

						<div class="ui title tall stacked  segment card" id="card_one">
							<div class="content" id="card_tkbd">
								<a href="<%=BASE_PATH %>/qm/teacher/tea_listen.jsp?module=11&menu=27">
									<div class="btnfirst circular right floated ui red basic icon button  prompt" data-content="点击可填写哦！" data-variation="small">
										<i class="file red text icon"></i>
									</div>
								</a>
								<div class=" header">填写听课表单</div>
							</div>
						</div>
						<div class="ui title tall stacked  segment card" id="card_two">
							<div class="content" id="card_tkjh">
								<a href="<%=BASE_PATH %>/qm/teacher/sup_listenplanadd.jsp?module=11&menu=28">
									<div class="btnfirst circular right floated ui orange basic icon button  prompt" data-content="点击可制定计划哦！" data-variation="small">
										<i class="file orange text icon"></i>
									</div>
								</a>
								<div class="header">制定听课计划 </div>
							</div>
						</div>

						<div class="ui title tall stacked  segment card" id="card_three">
							<div class="content" id="card_jxrw">
								<a href="<%=BASE_PATH %>/qm/teacher/sup_markadd.jsp?module=11&menu=59">
									<div class="btnfirst circular right floated ui yellow basic icon button  prompt" data-content="点击可关注老师哦！" data-variation="small">
										<i class="file yellow text icon"></i>
									</div>
								</a>
								<div class="header">我关注的教师 </div>
							</div>
						</div>

						<div class=" ui title tall stacked  segment card" id="card_four">
							<div class="content" id="card_tkjl">
								<a href="<%=BASE_PATH %>/qm/Master/MasterListen.jsp?module=11&menu=29">
									<div class="btnfirst circular right floated ui olive basic icon button  prompt" data-content="点击可查看详情哦！" data-variation="small">
										<i class="file olive text icon"></i>
									</div>
								</a>
								<div class="header">听课记录管理 </div>
							</div>
						</div>

						<div class=" ui title tall stacked  segment card" id="card_five">
							<div class="content">
								<a href="<%=BASE_PATH %>/qm/teacher/sup_config.jsp?module=11&menu=60">
									<div class="btnfirst circular right floated ui green basic icon button  prompt" data-content="点击可设置常用语哦！" data-variation="small">
										<i class="file green text icon"></i>
									</div>
								</a>
								<div class="header">我的常用语 </div>
								<div class="description">点击可以进行常用语设置哦!</div>
							</div>
						</div>

						<div class="ui title tall stacked  segment card" id="card_six">
							<div class="content" id="card_jxzl">
								<a href="<%=BASE_PATH %>/qm/Master/master_view_judge.jsp?module=11&menu=31">
									<div class="btnfirst circular right floated ui teal basic icon button  prompt" data-content="点击可查看详情哦！" data-variation="small">
										<i class="file teal text icon"></i>
									</div>
								</a>
								<div class="header">教学质量考核 </div>
							</div>
						</div>

						<div class=" ui title tall stacked  segment card" id="card_seven">
							<div class="content" id="card_khry">
								<a href="<%=BASE_PATH %>/qm/teacher/ManageTeacher.jsp?module=11&menu=30">
									<div class="btnfirst circular right floated ui blue basic icon button  prompt" data-content="点击可设置人员哦！" data-variation="small">
										<i class="file blue text icon"></i>
									</div>
								</a>
								<div class="header">设置考核人员 </div>
							</div>

						</div>
						<div class=" ui title tall stacked  segment card" id="card_eight">
							<div class="content" id="card_jspx">
								<a href="<%=BASE_PATH %>/qm/Master/checkteacherpx.jsp?module=11&menu=61">
									<div class="btnfirst circular right floated ui pink basic icon button  prompt" data-content="点击可查看评学记录哦！" data-variation="small">
										<i class="file pink text icon"></i>
									</div>
								</a>
								<div class="header">查看教师评学</div>
							</div>

						</div>
						<div class="ui title tall stacked  segment card" id="card_nine">
							<div class="content" id="card_bmsk">
								<a href="<%=BASE_PATH %>/qm/teacher/sup_viewclass.jsp?module=11&menu=61">
									<div class="btnfirst circular right floated ui purple basic icon button  prompt" data-content="点击可查看部门详情哦！" data-variation="small">
										<i class="file purple text icon"></i>
									</div>
								</a>
								<div class="header">查看部门上课质量 </div>
							</div>

						</div>

						<div class=" ui title tall stacked  segment card" id="card_ten">
							<div class="content" id="card_khry">
								<a href="<%=BASE_PATH %>/qm/Master/master_view_stu_pj.jsp?module=11&menu=33">
									<div class="btnfirst circular right floated ui violet basic icon button  prompt" data-content="点击可设置人员哦！" data-variation="small">
										<i class="file violet text icon"></i>
									</div>
								</a>
								<div class="header">查看学生评教 </div>
								<div class="description">点击可以可查看学生评教!</div>
							</div>

						</div>
						<div class=" ui title tall stacked  segment card" id="card_eleven">
							<div class="content" id="card_xnkh">
								<a href="<%=BASE_PATH %>/qm/Master/master_judge_chart.jsp?module=11&menu=66">
									<div class="btnfirst circular right floated ui brown basic icon button  prompt" data-content="点击可查看评学记录哦！" data-variation="small">
										<i class="file brown text icon"></i>
									</div>
								</a>
								<div class="header">查看学年考核</div>
							</div>

						</div>
						<div class="ui title tall stacked  segment card" id="card_twelve">
							<div class="content" id="card_bmsk">
								<a href="<%=BASE_PATH %>/qm/base/base_supvision_feedback.jsp?module=11&menu=32">
									<div class="btnfirst circular right floated ui black basic icon button  prompt" data-content="点击可查看部门详情哦！" data-variation="small">
										<i class="file black text icon"></i>
									</div>
								</a>
								<div class="header">信息员意见反馈 </div>
								<div class="description">点击可以进行意见填写哦!</div>
							</div>

						</div>
					</div>
				</div>
		</body>
		<script>
			$(function() {
				var SYSOBJCET = <%= SYSOBJCET %>;
				var USEROBJECT = <%= USEROBJECT %>;
				$('.title').hide();
				load_tkjl();
				$('.prompt').popup();

				function load_tkjl() {
					$.ajax({
						url: "do?invoke=TeacherCenter@get_supervisor_tkjl",
						type: 'POST',
						dataType: 'json',
						data: {
							teacher_no: USEROBJECT.loginname,
							term_no: SYSOBJCET.term_no
						},
						success: function(rep) {
							if (rep.result == 0) {
								var dom = '<div class="description">' + '暂时还没有去听其他老师课哦！赶紧听课吧！' + '</div>';
								$('#card_tkjl').append($(dom));
								var dom_tkbd = '<div class="meta">' + '尊敬的' + USEROBJECT.username + '督学' + '</div>';
								$('#card_tkbd').append($(dom_tkbd));
								var dom_tkbd_ = '<div class="description">' + '点击图标可以立即填写哦！' + '</div>';
								$('#card_tkbd').append($(dom_tkbd_));
							} else {
								var table_tkjl = rep.data;
								var dom_one = '<div class="meta">' + '本学期共听课' + table_tkjl.length + '次' + ' </div>';
								$('#card_tkjl').append($(dom_one));
								var dom_two = '<div class="description">' + table_tkjl[0].class_name + ',' + table_tkjl[0].course_name + '课,' + '综合得分最高!' + '</div>';
								$('#card_tkjl').append($(dom_two));
								var dom_tkbd = '<div class="meta">' + '尊敬的' + USEROBJECT.username + '督学' + '</div>';
								$('#card_tkbd').append($(dom_tkbd));
								var dom_tkbd_ = '<div class="description">' + '点击图标可以立即填写哦！' + '</div>';
								$('#card_tkbd').append($(dom_tkbd_));
							}
						}
					});
				}
				load_jxrw();

				function load_jxrw() {
					$.ajax({
						url: "do?invoke=TeacherCenter@get_supervisor_jxrw",
						type: 'POST',
						dataType: 'json',
						data: {
							master_teacher_no: USEROBJECT.loginname,
							term_no: SYSOBJCET.term_no
						},
						success: function(rep) {
							if (rep.result == 0) {
								var dom = '<div class="description">' + '暂时还没有关注任何老师哦，赶紧去关注吧！' + '</div>';
								$('#card_jxrw').append($(dom));
							} else {
								var table_jxrw = rep.data;
								var dom_one = '<div class="meta">' + '关注时间:' + table_jxrw[0].mark_time + ' </div>';
								$('#card_jxrw').append($(dom_one));
								var dom_two = '<div class="description">' + '您最近关注了--' + table_jxrw[0].teacher_name + '老师  , ' + '赶紧去听课吧！' + '</div>';
								$('#card_jxrw').append($(dom_two));
							}
						}
					});
				}
				load_tkjh();

				function load_tkjh() {
					$.ajax({
						url: "do?invoke=TeacherCenter@get_supervisor_tkjh",
						type: 'POST',
						dataType: 'json',
						data: {
							teacher_no: USEROBJECT.loginname,
							term_no: SYSOBJCET.term_no
						},
						success: function(rep) {
							if (rep.result == 0) {
								var dom = '<div class="description">' + '暂时还没有任何听课计划哦，赶紧去制定吧！' + '</div>';
								$('#card_tkjh').append($(dom));
							} else {
								var table_tkjh = rep.data;
								var dom_one = '<div class="meta">' + '最新计划:' + table_tkjh[0].plan_time + ' </div>';
								$('#card_tkjh').append($(dom_one));
								var dom_two = '<div class="description">' + '您打算在第' + table_tkjh[0].plan_week + '周' + '听' + table_tkjh[0].teacher_name + '老师的' + table_tkjh[0].course_name + '课！' + '</div>';
								$('#card_tkjh').append($(dom_two));
							}
						}
					});
				}
				load_bmsk();

				function load_bmsk() {
					$.ajax({
						url: "do?invoke=TeacherCenter@get_supervisor_bmsk",
						type: 'POST',
						dataType: 'json',
						data: {
							term_no: SYSOBJCET.term_no,
							college_no: USEROBJECT.userinfo.dep_no
						},
						success: function(rep) {
							if (rep.result == 0) {
								var dom = '<div class="description">' + '本院还没有老师被督学听课哦！' + '</div>';
								$('#card_bmsk').append($(dom));
								var dom_ = '<div class="description">' + '目前还没有老师需考核!' + ' </div>';
								$('#card_khry').append($(dom_));
							} else {
								var table_bmsk = rep.data;
								var dom_one = '<div class="meta">' + '目前有' + table_bmsk.length + '名老师被听课' + ' </div>';
								$('#card_bmsk').append($(dom_one));
								var dom_two = '<div class="description">' + table_bmsk[0].teacher_name + '的' + table_bmsk[0].course_name + '课,' + '综合得分最高!' + '</div>';
								$('#card_bmsk').append($(dom_two));
								var dom_three = '<div class="meta">' + SYSOBJCET.term_name + ' </div>';
								$('#card_khry').append($(dom_three));
								var dom_four = '<div class="description">' + '目前有' + table_bmsk.length + '名老师需考核!' + ' </div>';
								$('#card_khry').append($(dom_four));
							}
						}
					})
				}
				load_jxzl();

				function load_jxzl() {
					$.ajax({
						url: "do?invoke=TeacherCenter@get_supervisor_jxzl",
						type: 'POST',
						dataType: 'json',
						data: {
							term_no: SYSOBJCET.term_no,
							college_no: USEROBJECT.userinfo.dep_no
						},
						success: function(rep) {
							if (rep.result == 0) {
								var dom_one = '<div class="meta">' + USEROBJECT.userinfo.dep_name + ' </div>';
								$('#card_jxzl').append($(dom_one));
								var dom_two = '<div class="description">' + '目前还没有进行教学质量考核总分结算哦' + '</div>';
								$('#card_jxzl').append($(dom_two));
							} else {
								var table_jxzl = rep.data;
								var dom_one = '<div class="meta">' + USEROBJECT.userinfo.dep_name + ' </div>';
								$('#card_jxzl').append($(dom_one));
								var dom_two = '<div class="description">' + '目前,' + table_jxzl[0].teacher_name + '老师' + '教学质量最好' + '</div>';
								$('#card_jxzl').append($(dom_two));
							}
						}
					})
				}
				load_xnkh();

				function load_xnkh() {
					$.ajax({
						url: "do?invoke=TeacherCenter@get_supervisor_xnkh",
						type: 'POST',
						dataType: 'json',
						data: {
							college_no: USEROBJECT.userinfo.dep_no,
							term_no: SYSOBJCET.term_no.substring(0, 4)
						},
						success: function(rep) {
							if (rep.result == 0) {
								var dom_one = '<div class="meta">' + SYSOBJCET.term_no.substring(0, 4) + '学年' + ' </div>';
								$('#card_xnkh').append($(dom_one));
								var dom_two = '<div class="description">' + '目前还没有学年考核得分记录哦' + '</div>';
								$('#card_xnkh').append($(dom_two));
							} else {
								var table_xnkh = rep.data;
								var dom_one = '<div class="meta">' + SYSOBJCET.term_no.substring(0, 4) + '学年' + ' </div>';
								$('#card_xnkh').append($(dom_one));
								var dom_two = '<div class="description">' + '目前,' + table_xnkh[0].teacher_name + '老师' + '学年教学质量最好' + '</div>';
								$('#card_xnkh').append($(dom_two));
							}
						}
					})
				}
				load_jspx();

				function load_jspx() {
					$.ajax({
						url: "do?invoke=TeacherCenter@get_supervisor_jspx",
						type: 'POST',
						dataType: 'json',
						data: {
							term_no: SYSOBJCET.term_no,
							college_no: USEROBJECT.userinfo.dep_no
						},
						success: function(rep) {
							if (rep.result == 0) {
								var dom_one = '<div class="meta">' + USEROBJECT.userinfo.dep_name + ' </div>';
								$('#card_jspx').append($(dom_one));
								var dom_two = '<div class="description">' + '目前还没有教师进行班级评学哦！' + '</div>';
								$('#card_jspx').append($(dom_two));
							} else {
								var table_jspx = rep.data;
								var dom_one = '<div class="meta">' + table_jspx[0].class_name + ' </div>';
								$('#card_jspx').append($(dom_one));
								var dom_two = '<div class="description">' + '综合得分最高，获得老师的一致好评！' + '</div>';
								$('#card_jspx').append($(dom_two));
							}
						}
					})
				}
				loadquxian();

				function loadquxian() {
					var userobject = USEROBJECT.menu;
					var userobjectlen = userobject.length;
					for (var i = 0; i < userobjectlen; i++) {
						if (userobject[i].menu_name == "督学中心") {
							var quxian = userobject[i].menu_children;
							var quxian_len = quxian.length;
							for (var j = 0; j < quxian_len; j++) {
								if (quxian[j].menu_name == "查看教师学年考核") {
									$('#card_eleven').show();
								}
								if (quxian[j].menu_name == "查看学生评教") {
									$('#card_ten').show();
								}
								if (quxian[j].menu_name == "填写听课表") {
									$('#card_one').show();
								}
								if (quxian[j].menu_name == "制定听课计划") {
									$('#card_two').show();
								}
								if (quxian[j].menu_name == "管理听课记录") {
									$('#card_four').show();
								}
								if (quxian[j].menu_name == "部门教师维护") {
									$('#card_seven').show();
								}
								if (quxian[j].menu_name == "教学质量考核") {
									$('#card_six').show();
								}
								if (quxian[j].menu_name == "信息员意见反馈") {
									$('#card_twelve').show();
								}
								if (quxian[j].menu_name == "查看部门上课质量") {
									$('#card_nine').show();
								}
								if (quxian[j].menu_name == "我关注的教师") {
									$('#card_three').show();
								}
								if (quxian[j].menu_name == "我的常用语") {
									$('#card_five').show();
								}
								if (quxian[j].menu_name == "查看教师评学") {
									$('#card_eight').show();
								}
							}
						}
					}
				}
			});
		</script>
		<!--这里引用其他JS-->

		</html>