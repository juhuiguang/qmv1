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
					#form_text_kt {
						margin-left: 35px;
					}
					#form_text_sx {
						margin-left: 35px;
					}
					#manInput {
						margin-left: 80px;
						width: 100px;
					}
					#kqzb_three {
						width: 100px;
						margin-top: -52px;
						margin-left: 102%;
					}
					#btnsubmit {
						float: right;
					}
					.title {
						margin-bottom: 1%;
						width: 28%;
					}
					#search{
					margin-top:1%;
					}
					#user_version_xq{
					margin-top:7px;
					}
					#add_xbz{
					float:right;
					}
				</style>
		</head>

		<body>
			<%@ include file="/commonjsp/header.jsp"%>
				<div id="container">
					<div class="ui raised sac" id="title_">
						<div class="ui form">
							<div class="fields">
								<div class="field">
									<h3 class="ui header">
								<i class="list layout icon"></i>
                               <div class="content">指标管理与设置 </div>
                               </h3>
								</div> 
							</div>
						</div>
					</div>
					<div class="ui raised" id="search">
						<div class="ui form">
							<div class="fields">
								<div class=" five wide field"> 
									<select class="ui three dropdown" id="menu_condition">
									</select>
								</div>
								<div class="field">
									<button class="ui basic button" id="add_xbz"><i class="add circle icon"></i><b>&nbsp;添&nbsp;加</b></button>
								</div>

							</div>
						</div>
					</div>
				<!-- 	<h5 class="ui horizontal divider header"><i class="bar chart icon"></i> 所有版本</h5> -->
					<table class="ui compact blue table" id="form_table">
						<thead>
							<tr>
								<th>编号</th>
								<th>标准名称</th>
								<th>版本号</th>
								<th>状态</th>
								<th>管理操作</th>
								<th>详情</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
					<div class="ui form">
  <div class="three fields">
    <div class="field">
     <h3 class="ui header" id="user_version_xq">指标使用情况:</h3>
    </div>
    <div class=" field">
									<select class="ui two dropdown" id="menu_term">
										 
									</select> 
								</div>

								<div class=" field"> 
									<select class="ui three dropdown" id="menu_version">
									</select>
								</div>
								<div class="field">
									<button class="ui basic button" id="btnsubmit"><i class="send outline icon"></i><b>&nbsp;添&nbsp;加&nbsp;记&nbsp;录</b></button>
								</div>
    </div>
  </div>
  <div class="ui segments" id="version_use_xq">

</div>
</div>
					<div class="ui modal" id="add">
						<i class="close icon"></i>
						<div class="header">详细数据</div>
						<div class="image content">
							<div class="description">
								<div class="ui form" id="form_text_kt">
								</div>
							</div>
						</div>
					</div>

					<div class="ui one modal" id="xbz">
						<i class="close icon"></i>
						<div class="header">添加新标准</div>
						<div class="image content">
							<div class="description">
								<div class="ui raised segment">
									<div class="ui form">
										<div class="fields">

											<div class="field">
												<select class="ui three dropdown" id="menu_bz">
												</select>
											</div>

											<div class="  field">
												<button class="ui basic button" id="add_numble"><i class="add circle icon"></i><b>点击添加标准数</b></button>
											</div>

											<div class="field">
												<button class="ui basic button" id="btnsubmit_add"><i class="add circle icon"></i><b>添&nbsp;加</b></button>
											</div>

										</div>
									</div>

								</div>
								<div class="ui form" id="form_text_pj">
									<div class="field">
										<div class=" ui title input ">
											<input type="text" placeholder="标题" id="bt">
										</div>
										<textarea id="nr" rows="2" placeholder="内容"></textarea>
										<div class="ui input" id="kqzb_three">
											<input type="text" placeholder="分值" id="fz">
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
				var version_no = 1;
				var rule_type_use = '';
				var i = 1;
				var max = []; 
				max[0] = "1";
				max[1] = "2"
					var term_no=<%=SYSOBJCET%>.term_no; 
					 var year=parseInt(term_no.substring(0,4));
					for(var num=0;num<4;num++){ 
						 
						if(num%2==0){     
							var dom='<option value="'+year+'0" id="term'+year+'1">'+year+'学年第一学期</option>';
						}else{   
							var dom='<option value="'+year+'1" id="term'+year+'1">'+year+'学年第二学期</option>';
							year++; 
						}  
						$("#menu_term").append($(dom));  
						   
					}
					$('#term'+term_no+'').attr("selected","selected");
				$('#add_numble').click(function() { //点击添加标准数量
					if (i <= 9) {
						var dom = '<div class="field add_title" >' +
							'<div class="ui title input " id="title' + i + '">' +
							' <input type="text" placeholder="标题" id="bt' + i + '">' +
							'</div>' +
							'<textarea id="nr' + i + '"' + ' rows="2" placeholder="内容"></textarea>' +
							'<div class="ui input " id="kqzb_three">' +
							' <input type="text" placeholder="分值"  id="fz' + i + '" >' +
							' </div>' +
							'</div>';
						$('#form_text_pj').append($(dom));
						i++;
					}
				});
				$("#menu_bz").change(function() {
					i = 1;
				});
				$('#btnsubmit_add').click(function() { //点击启动每个年份不同的标准
					if ($(this).hasClass("loading")) return;
					$("#btnsubmit_add").addClass("loading");
					if (i >= 5) {
						postFormData_bz();
					} else {
						$.alert("标准数不可低于五个哦！");
						$("#btnsubmit_add").removeClass("loading");
					}
				});

				function postFormData_bz() {
					var rule_table = $('#menu_bz > option:selected').attr("table");
					var rule_version_title = $('#menu_bz > option:selected').text();
					var rule_version_flag = $('#menu_bz > option:selected').val();
					var rule_version = version_no;
					var s = {
						numble: i,
						rule_version_title: rule_version_title,
						rule_version_flag: rule_version_flag,
						rule_version: version_no,
						rule_content_one: "",
						rule_content_two: "",
						rule_content_three: "",
						rule_content_four: "",
						rule_content_five: "",
						rule_content_six: "",
						rule_content_seven: "",
						rule_content_eight: "",
						rule_content_nine: "",
						rule_content_ten: "",
						rule_goal_one: "",
						rule_goal_two: "",
						rule_goal_three: "",
						rule_goal_four: "",
						rule_goal_five: "",
						rule_goal_six: "",
						rule_goal_seven: "",
						rule_goal_eight: "",
						rule_goal_nine: "",
						rule_goal_ten: "",
						rule_title_one: "",
						rule_title_two: "",
						rule_title_three: "",
						rule_title_four: "",
						rule_title_five: "",
						rule_title_six: "",
						rule_title_seven: "",
						rule_title_eight: "",
						rule_title_nine: "",
						rule_title_ten: "",
						rule_status: "0",
						rule_table: rule_table,
						rule_field_one: "PER11",
						rule_field_two: "PER12",
						rule_field_three: "PER13",
						rule_field_four: "PER14",
						rule_field_five: "PER15",
						rule_field_six: "PER16",
						rule_field_seven: "PER17",
						rule_field_eight: "PER18",
						rule_field_nine: "PER19",
						rule_field_ten: "PER10"
					}
					s.rule_content_one = $('#nr').val();
					s.rule_content_two = $('#nr1').val();
					s.rule_content_three = $('#nr2').val();
					s.rule_content_four = $('#nr3').val();
					s.rule_content_five = $('#nr4').val();
					s.rule_content_six = $('#nr5').val();
					s.rule_content_seven = $('#nr6').val();
					s.rule_content_eight = $('#nr7').val();
					s.rule_content_nine = $('#nr8').val();
					s.rule_content_ten = $('#nr9').val();
					s.rule_title_one = $('#bt').val();
					s.rule_title_two = $('#bt1').val();
					s.rule_title_three = $('#bt2').val();
					s.rule_title_four = $('#bt3').val();
					s.rule_title_five = $('#bt4').val();
					s.rule_title_six = $('#bt5').val();
					s.rule_title_seven = $('#bt6').val();
					s.rule_title_eight = $('#bt7').val();
					s.rule_title_nine = $('#bt8').val();
					s.rule_title_ten = $('#bt9').val();
					s.rule_goal_one = $('#fz').val();
					s.rule_goal_two = $('#fz1').val();
					s.rule_goal_three = $('#fz2').val();
					s.rule_goal_four = $('#fz3').val();
					s.rule_goal_five = $('#fz4').val();
					s.rule_goal_six = $('#fz5').val();
					s.rule_goal_seven = $('#fz6').val();
					s.rule_goal_eight = $('#fz7').val();
					s.rule_goal_nine = $('#fz8').val();
					s.rule_goal_ten = $('#kfz9').val();
					if(s.rule_content_one==""||s.rule_title_one==""||s.rule_goal_one==""||s.rule_content_two==""||s.rule_title_two==""||s.rule_goal_two==""||s.rule_content_three==""||s.rule_title_three==""||s.rule_goal_three==""||s.rule_content_four==""||s.rule_title_four==""||s.rule_goal_four==""||s.rule_content_five==""||s.rule_title_five==""||s.rule_goal_five==""){
						$.alert(" 抱歉！您有一些空没有填哦，请再检查一下。");
						$("#btnsubmit_add").removeClass("loading");
					}
					else{
						postdata_xbz(s);
					}
				}

				function postdata_xbz(s) {
					$.ajax({
						url: "do?invoke=Mass@postdata_xbz",
						type: 'POST',
						dataType: 'json',
						data: s,
						success: function(rep) {
							$.alert("", rep.message);
							$("#btnsubmit").removeClass("loading");
							window.location.reload();
						}
					});
				}
				$('#btnsubmit').click(function() { //点击启动每个年份不同的标准
					if ($(this).hasClass("loading")) return;
					$("#btnsubmit").addClass("loading");
					postdata_bz();
					
				});
				$('#add_xbz').click(function() {
					$('#xbz').modal({
							transition: 'vertical flip',
							observeChanges: true,
							closable: false
						})
						.modal('show');
				});
				$('#menu_term')
					.dropdown();

				function load_listen(rule_version_flag, rule_version) //获取每个标准的不同内容并显示
					{
						$.ajax({
							url: "do?invoke=Mass@load_listen",
							type: 'POST',
							dataType: 'json',
							data: {
								rule_version_flag: rule_version_flag,
								rule_version: rule_version
							},
							success: function(rep) {
								if (rep.result == 0) {
									version_no = 1;
								} else {
									$('#form_text_kt').find('.field').remove();
									var version_table = rep.data;
									for (var i = 0; i < version_table.length; i++) {
										var dom = '<div class="field">' +
											'<div class="ui blue ribbon label" id="kqzb_one">' + (i + 1) + ',' + version_table[i].rule_title + ' </div>' +
											'<textarea id="kqzb_two"" rows="2" >' + version_table[i].rule_content + '</textarea>' +
											'<div class="ui input " id="kqzb_three">' +
											'<input type="text" placeholder="分值"id="kqzb_three_" ' + 'value=' + '"' + version_table[i].rule_goal + '"' + '>' +
											' </div>' +
											' </div>';
										$('#form_text_kt').append($(dom));
									}
								}
							}
						});
					}

				function loadstu_all_(rule_version_flag) { //根据不同的rule_version_flag获取不同的版本和状态
					$.ajax({
						url: "do?invoke=Mass@load_bb",
						type: 'POST',
						dataType: 'json',
						data: {
							rule_version_flag: rule_version_flag
						},
						success: function(rep) {
							if (rep.result == 0) {
								$.alert("抱歉！还没听课指标哦，赶紧去设置吧！");
							} else {
								table = rep.data;
								$('#form_table tr:gt(0)').remove();
								for (var i = 0; i < table.length; i++) {
									if (table[i].rule_status == 1) {
										var dom_stu = '<tr>' +
											'<td>' + (i + 1) + '</td>' +
											'<td>' + table[i].rule_version_title + '</td>' +
											'<td>' + table[i].rule_version + '</td>' +
											'<td>' + '启用' + '</td>' +
											'<td>' +
											'<div class="start circular mini ui blue basic icon button" name="' + table[i].rule_version_flag + '"  bbh="' + table[i].rule_version + '" zt="' + table[i].rule_status + '" >' +
											'<i class=" checkmark blue large icon"></i>' +
											'</div>' +
											'</td>' +
											'<td>' +
											'<div class="look circular mini ui teal basic icon button" name="' + table[i].rule_version_flag + '" bbh="' + table[i].rule_version + '" zt="' + table[i].rule_status + '" data-content="查看详情">' +
											'<i class="search teal large icon"></i>' +
											'</div>' +
											'</td>' +
											'</tr>';
										$('#form_table').append($(dom_stu));
									} else {
										var dom_stu = '<tr>' +
											'<td>' + (i + 1) + '</td>' +
											'<td>' + table[i].rule_version_title + '</td>' +
											'<td>' + table[i].rule_version + '</td>' +
											'<td>' + '停用' + '</td>' +
											'<td>' +
											'<div class="start circular mini ui red basic icon button" name="' + table[i].rule_version_flag + '" bbh="' + table[i].rule_version + '" zt="' + table[i].rule_status + '" >' +
											'<i class=" remove red large icon"></i>' +
											'</div>' +
											'</td>' +
											'<td>' +
											'<div class="look circular mini ui teal basic icon button" name="' + table[i].rule_version_flag + '" bbh="' + table[i].rule_version + '" zt="' + table[i].rule_status + '"  data-content="查看详情">' +
											'<i class="search teal large icon"></i>' +
											'</div>' +
											'</td>' +
											'</tr>';
										$('#form_table').append($(dom_stu));
									}							
								}
								$('.look').popup();
								//点击事件分别做额事情
								$('.start').click(function() { //点击改变版本状态
									var name = $(this).attr("name");
									var bbh = $(this).attr("bbh");
									var zt = $(this).attr("zt");
									loadchange(name, bbh, zt);
								});
								$('.look').click(function() { //点击查看详情
									var name = $(this).attr("name");
									var bbh = $(this).attr("bbh");
									load_listen(name, bbh);
									$('#add').modal({
											transition: 'vertical flip',
											observeChanges: true,
											closable: false
										})
										.modal('show');
								});
							}
						}
					});
				}
				load_all();

				function load_all() { //获取所有的标准名称
					$.ajax({
						url: "do?invoke=Mass@load_all",
						type: 'POST',
						dataType: 'json',
						success: function(rep) {
							var table = rep.data;
							console.log(rep);
							for (var i = 0; i < table.length; i++) {
								if (i == 0) {
									var dom_one = '<option selected="selected" value="' + table[i].rule_version_flag + '"' + "table=" + '"' + table[i].rule_table + '"' + '>' + table[i].rule_version_title + '</option>';
									$('#menu_condition').append($(dom_one));
									$('#menu_bz').append($(dom_one));
								} else {
									var dom_two = '<option value="' + table[i].rule_version_flag + '"' + "table=" + '"' + table[i].rule_table + '"' + '>' + table[i].rule_version_title + '</option>';
									$('#menu_condition').append($(dom_two));
									$('#menu_bz').append($(dom_two));
								}
							}
							var data = ($("#menu_condition > option:selected").val());
							rule_type_use = data;
							loadversionuse();
							load_listen(data);
							loadversion(data);
							loadstu_all_(data);
							$("#menu_condition")
								.dropdown({
									onChange: function(value, text, $selectedItem) {
										data = value;
										rule_type_use = data;
										loadversionuse();
										load_listen(data);
										loadversion(data);
										loadstu_all_(data);
										loadversion_(data);
									}
								});
							//弹出层里面的标准名称
							var rule_version_flag = ($("#menu_bz > option:selected").val());
							loadversion_(rule_version_flag);
							$("#menu_bz")
								.dropdown({
									onChange: function(value, text, $selectedItem) {
										rule_version_flag = value;
										$('.add_title').remove();
										$('#bt').val("");
										$('#nr').val("");
										$('#fz').val("");
										loadversion_(rule_version_flag);
									}
								});
						}
					});
				}

				function loadversion(data) { //点击获取每个标准有几个版本
					$.ajax({
						url: "do?invoke=Mass@loadversion",
						type: 'POST',
						dataType: 'json',
						data: {
							rule_version: data
						},
						success: function(rep) {
							if (rep.result == 0) {
								version_no = 1;
							} else {
								$('#menu_version').find("option").remove();
								var version_table = rep.data;
								for (var i = 0; i < version_table.length; i++) {
									if (i == 0) {
										var dom_two = '<option selected="selected" value="' + version_table[i].rule_version + '">' +"版本号："+ version_table[i].rule_version + '</option>';
										$('#menu_version').append($(dom_two));
									} else {
										var dom_two = '<option value="' + version_table[i].rule_version + '">' +"版本号："+ version_table[i].rule_version + '</option>';
										$('#menu_version').append($(dom_two));
									}
								}
								$('#menu_version')
									.dropdown();
								//version_no=parseInt(version_table[0].rule_version)+1;
							}
						}
					});
				}

				function postdata_bz() { //在哪年启动哪个标准
					var term_no = $('#menu_term > option:selected').val();
					var rule_type = $('#menu_condition > option:selected').val();
					var rule_version = $('#menu_version > option:selected').val();
					$.ajax({
						url: "do?invoke=Mass@postdata_bz_",
						type: 'POST',
						dataType: 'json',
						data: {
							term_no: term_no,
							rule_type: rule_type,
							rule_version: rule_version
						},
						success: function(rep) {
							$.alert("", rep.message);
							$("#btnsubmit").removeClass("loading");
							loadversionuse();
						}
					});
				}

				function loadchange(name, bbh, zt) { //改变每个标准的状态
					$.ajax({
						url: "do?invoke=Mass@loadchange",
						type: 'POST',
						dataType: 'json',
						data: {
							rule_version_flag: name,
							rule_version: bbh,
							rule_status: zt
						},
						success: function(rep) {
							var data = ($("#menu_condition > option:selected").val());
							loadstu_all_(data);
						}
					});
				}

				function loadversion_(rule_version_flag) { //获取标准的版本号，如果添加就+1
					$.ajax({
						url: "do?invoke=Mass@loadversion",
						type: 'POST',
						dataType: 'json',
						data: {
							rule_version: rule_version_flag
						},
						success: function(rep) {
							if (rep.result == 0) {
								version_no = 1;
							} else {
								var version_table = rep.data;
								version_no = parseInt(version_table[0].rule_version) + 1;
							}
						}
					});
				}
				
				function loadversionuse() { //获取标准的版本号，如果添加就+1
					$.ajax({
						url: "do?invoke=Mass@loadversionuse",
						type: 'POST',
						dataType: 'json',
						data: {
							rule_type: rule_type_use
						},
						success: function(rep) {
							var use_data = rep.data;
							var use_data_len = use_data.length;
							var dom ='';
							$('#version_use_xq').empty();
							for(var i = 0 ; i< use_data_len ; i++){
								 dom += '  <div class="ui segment">'+
								   '<p>'+use_data[i].term_no.substring(0,4)+'年第'+(parseInt(use_data[i].term_no.substring(4,5))+1)+'学期，使用第'+use_data[i].rule_version+'版本</p>'+
								   ' </div>';
							}
							$('#version_use_xq').append(dom);
						}
					});
				}
			});
		</script>
		<!--这里引用其他JS-->

		</html>