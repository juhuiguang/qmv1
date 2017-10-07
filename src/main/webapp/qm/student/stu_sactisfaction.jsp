<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/commonjsp/doctype.jsp"%>
		<html>

		<head>
			<%@ include file="/commonjsp/meta.jsp"%>
				<script src="script/common/echarts/echarts-all.js"></script>
				<!--这里引用其他样式-->
				<title>校内教学质量监控运行平台</title>
				<style>
					.sac_sur {
						margin-top: 10px;
					}
					
					#sac_title1 {
						margin-top: 10px;
					}
					
					#sac_title2 {
						margin-top: 10px;
					}
					
					#main {
						width: 640px;
						height: 290px;
						margin-left: 15%;
					}
					
					#sac_button {
						margin-left: 85%;
						margin-top: -45%;
					}
					
					#total {
						height: 500px;
					}
				</style>
		</head>

		<body>
			<%@ include file="/commonjsp/header.jsp"%>
				<!--这里绘制页面-->
				<div id="container">
					<div id="total">
						<h3 class="ui header">
								<i class="list layout icon"></i>
                               <div class="content">满意度调查 </div>
                               </h3>
						<div>
							<h4 class="ui header " id="sac_title1">专业课程设置满意度调查</h4>
						</div>
						<div class="ui form sac_sur" id="table1">
							<div class="inline fields">
								<div class="field">
									<div class="ui radio checkbox">
										<input type="radio" name="item1" checked="checked" value="满意" />
										<label><i class=" smile large icon sac" data-content="满意"></i></label>
									</div>
								</div>
								<div class="field">
									<div class="ui radio checkbox">
										<input type="radio" name="item1" value="基本满意" />
										<label><i class=" meh large icon sac" data-content="基本满意"></i></label>
									</div>
								</div>
								<div class="field">
									<div class="ui radio checkbox">
										<input type="radio" name="item1" value="不满意" />
										<label><i class=" frown large icon sac" data-content="不满意"></i></label>
									</div>
								</div>
							</div>
						</div>
						<div>
							<h4 class="ui header" id="sac_title2">本专业课程教学满意度调查</h4>
						</div>
						<div class="ui form sac_sur" id="table2">
							<div class="inline fields">
								<div class="field">
									<div class="ui radio checkbox">
										<input type="radio" name="item2" checked="checked" class="item" value="满意" />
										<label><i class=" smile large icon sac" data-content="满意"></i></label>
									</div>
								</div>
								<div class="field">
									<div class="ui radio checkbox">
										<input type="radio" name="item2" class="item" value="基本满意" />
										<label><i class=" meh large icon sac" data-content="基本满意"></i></label>
									</div>
								</div>
								<div class="field">
									<div class="ui radio checkbox">
										<input type="radio" name="item2" value="不满意" />
										<label><i class=" frown large icon sac" data-content="不满意"></i></label>
									</div>
								</div>
							</div>
						</div>
						<div id="sac_result">
							<h3 class="ui center aligned icon header"> 满意度调查结果</h3>
						</div>
						<div id="main"></div>
						<div id="sac_button">
							<button class="ui labeled icon button teal" id="btnsubmit"><i class="send outline icon"></i> 提交
						</div>
					</div>
				</div>
				<!-- ECharts单文件引入 -->
				<script>
					$(function() {
						var SYSOBJCET = <%= SYSOBJCET %>;
						var USEROBJECT = <%= USEROBJECT %>;
						var table;
						var purview;
						$('.sac').popup();
						loadtable();

						function loadtable() {
							$.ajax({
								url: "do?invoke=student_sac@getStuTable",
								type: 'POST',
								dataType: 'json',
								data: {
									termno: SYSOBJCET.term_no
								},
								success: function(rep) {
									table = rep.data;
									var b_good_sac = 0;
									var b_sac = 0;
									var b_no_sac = 0;
									var good_sac = 0;
									var sac = 0;
									var no_sac = 0;
									for (var i = 0; i < table.length; i++) {
										if (table[i].survey_name == "专业课程设置满意度调查") {
											if (table[i].survey_result == "满意") {
												good_sac = table[i].total;
											}
											if (table[i].survey_result == "基本满意") {
												sac = table[i].total;
											}
											if (table[i].survey_result == "不满意") {
												no_sac = table[i].total;
											}
										}
										if (table[i].survey_name == "本专业课程教学满意度调查") {
											if (table[i].survey_result == "满意") {
												b_good_sac = table[i].total;
											}
											if (table[i].survey_result == "基本满意") {
												b_sac = table[i].total;
											}
											if (table[i].survey_result == "不满意") {
												b_no_sac = table[i].total;
											}
										}
									}
									var myChart = echarts.init(document.getElementById('main'));
									var option = {
										tooltip: {
											trigger: 'axis',
											borderRadius: '6',
											backgroundColor: 'rgba(76,203,197)',
											axisPointer: {
												type: 'shadow'
											}
										},
										legend: {
											x: 'right',
											itemGap: 15,
											data: ['满意', '基本满意', '不满意']
										},
										grid: {
											y: 30,
											y2: 70,
											x2: 20,
											borderWidth: '#ffffff'
										},
										xAxis: [{
											type: 'category',
											splitLine: {
												show: false
											},
											data: ['专业课程设置满意度调查', '本专业课程教学满意度调查']
										}, {
											type: 'category',
											axisLine: {
												show: false
											},
											axisTick: {
												show: false
											},
											axisLabel: {
												show: false
											},
											splitLine: {
												show: false
											},
											data: ['专业课程设置满意度调查', '本专业课程教学满意度调查']
										}],
										yAxis: [{
											type: 'value',
											axisLabel: {
												formatter: '{value}'
											},
											splitLine: {
												show: false
											}
										}],
										series: [{
											name: '满意',
											type: 'bar',
											itemStyle: {
												normal: {
													color: '#fea891',
													label: {
														show: true,
														textStyle: {
															color: '#000000'
														}
													}
												}
											},
											data: [good_sac, b_good_sac]
										}, {
											name: '基本满意',
											type: 'bar',
											itemStyle: {
												normal: {
													color: '#b9d991',
													label: {
														show: true,
														textStyle: {
															color: '#000000'
														}
													}
												}
											},
											data: [sac, b_sac]
										}, {
											name: '不满意',
											type: 'bar',
											itemStyle: {
												normal: {
													color: '#f6bf75',
													label: {
														show: true,
														textStyle: {
															color: '#000000'
														}
													}
												}
											},
											data: [no_sac, b_no_sac]
										}]
									};
									myChart.setOption(option);
								}
							});
						}

						function postFormData() {
							var o = {
								result_one: "",
								result_two: "",
								term_no: SYSOBJCET.term_no,
								stu_no: USEROBJECT.loginname,
								survey_name_one: " ",
								survey_name_two: " "
							}
							o.result_one = $("input[name='item1'][type='radio']:checked").val();
							o.result_two = $("input[name='item2'][type='radio']:checked").val();
							o.survey_name_one = $("#sac_title1").text();
							o.survey_name_two = $("#sac_title2").text();
							$.confirm({
								msg: '您确定要提交你的结果吗',
								btnSure: '确认提交 ',
								btnCancel: '重新选择',
								sureDo: function() {
									postdata(o);
									loadtable();
								},
								cancelDo: function() {
									$("#btnsubmit").removeClass("loading");
									loadtable();
								}
							});
						}

						function postdata(o) {
							$.ajax({
								url: "do?invoke=student_sac@postListen",
								type: 'POST',
								dataType: 'json',
								data: o,
								success: function(rep) {
									$("#btnsubmit").removeClass("loading");
									/* window.location.reload(); */
									loadtable();
									judgedata();
								}
							});
						}
						judgedata();
						function judgedata() {
							$.ajax({
								url: "do?invoke=student_sac@judgedata",
								type: 'POST',
								dataType: 'json',
								data: {
									term_no: SYSOBJCET.term_no,
									stu_no: USEROBJECT.loginname,
								},
								success: function(rep) {
									console.log(rep)
									purview = rep.result;
								}
							});
						}
						$("#btnsubmit").click(function() {
							if (purview == 1) {
								$.alert("您已提交过，感谢您的积极参与")
							} else {
								if ($(this).hasClass("loading")) return;
								$("#btnsubmit").addClass("loading");
								postFormData();
							}
						});
					});
				</script>
		</body>
		<!--这里引用其他JS-->

		</html>