<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/commonjsp/doctype.jsp"%>
		<html>

		<head>
			<%@ include file="/commonjsp/meta.jsp"%>
				<!--这里引用其他样式-->
				<title>校内教学质量监控运行平台</title>
				<style>
					.field {
						width: 80%;
						height: 30%;
					}
					
					#manInput {
						margin-left: 80px;
						width: 100px;
					}
					
					#kqzb_three {
						width: 140px;
						margin-top: -52px;
						margin-left: 102%;
					}
					
					#add_xnkh {
						margin-left: 40%;
					}
					
					#btnsubmit {
						float: right;
					}
					
					#add_xbz {
						margin-left: 40%;
					}
					
					.title {
						margin-bottom: 1%;
						width: 28%;
					}
					
					#submit_add {
						margin-left: 40%;
					}
					
					#term_ {
						margin-top: 1%;
					}
					
					#btnsubmit_add {
						margin-top: 1%;
						margin-left: 40%;
					}
				</style>
		</head>

		<body>
			<%@ include file="/commonjsp/header.jsp"%>
				<div id="container">
					<div class="ui raised">
						<div class="ui form">
							<div class="fields">
								<div class="field">
									<h3 class="ui header">
								<i class="list layout icon"></i>
                               <div class="content">学年考核指标设置 </div>
                               </h3>
								</div>
							</div>
						</div>
					</div>
					<div class="ui raised ">
						<div class="ui form">
							<div class="fields">
								<div class=" three wide field" id="term_">
									<select class="ui three dropdown" id="menu_condition">
									</select>
								</div>
								<div class="field" id="btnsubmit_add">
									<button class="ui blue labeled icon button" id="add_xnkh"><i class="plus icon"></i> 设置学年指标</button>
								</div>
							</div>
						</div>
					</div>
					<table class="ui compact blue table" id="form_table">
						<thead>
							<tr>
								<th>编号</th>
								<th>评判标准</th>
								<th>优秀线</th>
								<th>良好线</th>
								<th>状态</th>
								<th>管理操作</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>

					<div class="ui one modal" id="xbz">
						<i class="close icon"></i>
						<div class="header">添加新标准</div>
						<div class="image content">
							<div class="description">
								<div class="ui raised segment">
									<div class="ui form">
										<div class="fields">

											<div class="four wide field">
												<select class="ui dropdown" id="menu_term">
												</select>
											</div>

											<div class="field">
												<button class="ui basic button" id="submit_add"><i class="add circle icon"></i><b>添&nbsp;加</b></button>
											</div>

										</div>
									</div>

								</div>
								<div>
									<h3 class="ui header">分值标准：</h3> 优秀分数线：
									<div class="ui input">
										<input placeholder="分值" type="text" id="yx_fz" value="">
									</div>
									&nbsp;&nbsp;良好分数线：
									<div class="ui input">
										<input placeholder="分值" type="text" id="lh_fz" value="">
									</div>
								</div>
								<br>
								<div>
									<h3 class="ui header">百分比标准：</h3> 优秀百分比：
									<div class="ui input">
										<input placeholder="不加百分号哦！" type="text" id="yx_bfb" value="">
									</div>
									&nbsp;&nbsp;良好百分比：
									<div class="ui input">
										<input placeholder="不加百分号哦！" type="text" id="lh_bfb" value="">
									</div>
								</div>

							</div>
						</div>
					</div>

				</div>
		</body>
		<script>
			$(function() {
				var SYSOBJCET = <%= SYSOBJCET %>;
				var USEROBJECT = <%= USEROBJECT %>;
				var year = parseInt(SYSOBJCET.term_no.substring(0, 4));
				for (var num = 0; num < 6; num++) {
					if (num == 1) {
						var dom = '<option value="' + year + '">' + year + '学年' + '</option>';
						$("#menu_term").append($(dom));
						year++;
					} else {
						var dom = '<option value="' + year + '">' + year + '学年</option>';
						$("#menu_term").append($(dom));
						year++;
					}
				}
				$('#submit_add').click(function() { //点击启动每个年份不同的标准
					if ($(this).hasClass("loading")) return;
					$("#btnsubmit_add").addClass("loading");
					postFormData_xnkh();
				});

				function postFormData_xnkh() {
					var year_no = $('#menu_term > option:selected').val();
					var s = {
						year_no: year_no,
						judge_type_score: 'score',
						judge_type_percent: 'percent',
						judge_youxiu_fz: '',
						judge_youxiu_bfb: '',
						judge_lianghao_fz: '',
						judge_lianghao_bfb: '',
						judge_set_score: '0',
						judge_set_percent: '1'
					}
					s.judge_youxiu_fz = $('#yx_fz').val();
					s.judge_youxiu_bfb = $('#yx_bfb').val();
					s.judge_lianghao_fz = $('#lh_fz').val();
					s.judge_lianghao_bfb = $('#lh_bfb').val();
					console.log(s.judge_lianghao_fz);
					console.log(s.judge_lianghao_bfb)
					postdata_xnkh(s);
				}

				function postdata_xnkh(s) {
					$.ajax({
						url: "do?invoke=Mass@postdata_xnkh",
						type: 'POST',
						dataType: 'json',
						data: s,
						success: function(rep) {
							$.alert("", rep.message);
							$("#btnsubmit_add").removeClass("loading");
							$('#yx_fz').val("");
							$('#yx_bfb').val("");
							$('#lh_fz').val("");
							$('#lh_bfb').val("");
							load_term();
						}
					});
				}
				$('#add_xnkh').click(function() {
					$('#xbz').modal({
							transition: 'vertical flip',
							observeChanges: true,
							closable: false
						})
						.modal('show');
				});
				$('#menu_term')
					.dropdown();

				function load_all(year_no) { //根据不同的rule_version_flag获取不同的版本和状态
					$.ajax({
						url: "do?invoke=Mass@loadxnkhxq",
						type: 'POST',
						dataType: 'json',
						data: {
							year_no: year_no
						},
						success: function(rep) {
							if (rep.result == 0) {
								$.alert("抱歉！目前还没有学年考核的标准哦,赶紧去设置吧");
							} else {
								table = rep.data;
								$('#form_table tr:gt(0)').remove();
								for (var i = 0; i < table.length; i++) {
									if (table[i].judge_set == 1) {
										if (table[i].judge_type == "score") {
											var dom = '<tr>' +
												'<td>' + (i + 1) + '</td>' +
												'<td>' + '分值' + '</td>' +
												'<td>' + table[i].judge_youxiu + '分' + '</td>' +
												'<td>' + table[i].judge_lianghao + '分' + '</td>' +
												'<td>' + '启用' + '</td>' +
												'<td>' +
												'<div class="start circular mini ui blue basic icon button" year="' + table[i].year_no + '"  type="' + table[i].judge_type + '" zt="' + table[i].judge_set + '" >' +
												'<i class=" checkmark blue large icon"></i>' +
												'</div>' +
												'</td>' +
												'</tr>';
											$('#form_table').append($(dom));
										} else {
											var dom = '<tr>' +
												'<td>' + (i + 1) + '</td>' +
												'<td>' + '百分比' + '</td>' +
												'<td>' + table[i].judge_youxiu + '%' + '</td>' +
												'<td>' + table[i].judge_lianghao + '%' + '</td>' +
												'<td>' + '启用' + '</td>' +
												'<td>' +
												'<div class="start circular mini ui blue basic icon button" year="' + table[i].year_no + '"  type="' + table[i].judge_type + '" zt="' + table[i].judge_set + '" >' +
												'<i class=" checkmark blue large icon"></i>' +
												'</div>' +
												'</td>' +
												'</tr>';
											$('#form_table').append($(dom));
										}
									} else {
										if (table[i].judge_type == "score") {
											var dom = '<tr>' +
												'<td>' + (i + 1) + '</td>' +
												'<td>' + '分值' + '</td>' +
												'<td>' + table[i].judge_youxiu + '分' + '</td>' +
												'<td>' + table[i].judge_lianghao + '分' + '</td>' +
												'<td>' + '停用' + '</td>' +
												'<td>' +
												'<div class="start circular mini ui red basic icon button" year="' + table[i].year_no + '"  type="' + table[i].judge_type + '" zt="' + table[i].judge_set + '" >' +
												'<i class=" remove red large icon"></i>' +
												'</div>' +
												'</td>' +
												'</tr>';
											$('#form_table').append($(dom));
										} else {
											var dom = '<tr>' +
												'<td>' + (i + 1) + '</td>' +
												'<td>' + '百分比' + '</td>' +
												'<td>' + table[i].judge_youxiu + '%' + '</td>' +
												'<td>' + table[i].judge_lianghao + '%' + '</td>' +
												'<td>' + '停用' + '</td>' +
												'<td>' +
												'<div class="start circular mini ui red basic icon button" year="' + table[i].year_no + '"  type="' + table[i].judge_type + '" zt="' + table[i].judge_set + '" >' +
												'<i class=" remove red large icon"></i>' +
												'</div>' +
												'</td>' +
												'</tr>';
											$('#form_table').append($(dom));
										}
									}
								}
							}
							//点击事件分别做额事情
							$('.start').click(function() { //点击改变版本状态
								var year = $(this).attr("year");
								var type = $(this).attr("type");
								var zt = $(this).attr("zt");
								loadchangexnkh(year, type, zt);
							});
						}
					});
				}
				load_term();

				function load_term() { //获取所有的标准名称
					$.ajax({
						url: "do?invoke=Mass@loadxnkh",
						type: 'POST',
						dataType: 'json',
						success: function(rep) {
							$('#menu_condition').find("option").remove();
							var table = rep.data;
							console.log(rep);
							for (var i = 0; i < table.length; i++) {
								if (i == 0) {
									var dom_one = '<option selected="selected" value="' + table[i].year_no + '">' + table[i].year_no + '</option>';
									$('#menu_condition').append($(dom_one));
								} else {
									var dom_two = '<option value="' + table[i].year_no + '">' + table[i].year_no + '</option>';
									$('#menu_condition').append($(dom_two));
								}
							}
							var year_no = ($("#menu_condition > option:selected").val());
							load_all(year_no);
							$("#menu_condition")
								.dropdown({
									onChange: function(value, text, $selectedItem) {
										year_no = value;
										load_all(year_no);
									}
								});
						}
					});
				}

				function loadchangexnkh(year, type, zt) { //改变每个标准的状态
					$.ajax({
						url: "do?invoke=Mass@loadchangexnkh",
						type: 'POST',
						dataType: 'json',
						data: {
							year_no: year,
							judge_type: type,
							judge_set: zt
						},
						success: function(rep) {
							var year_no = ($("#menu_condition > option:selected").val());
							load_all(year_no);
						}
					});
				}
			});
		</script>
		<!--这里引用其他JS-->

		</html>