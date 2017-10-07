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
						width: 140px;
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
					#khgl{
					margin-top:2%;
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
					<div class="ui raised sac">
						<div class="ui form">
							<div class="fields">
								<div class="field">
									<h3 class="ui header">
								<i class="list layout icon"></i>
                               <div class="content">考核管理与设置 </div>
                               </h3>
								</div>
							</div>
						</div>
					</div>
					<div class="ui raised" id="khgl">
						<div class="ui form">
							<div class="fields">
								<div class="eight wide  field"> 
									<select class="ui three dropdown" id="menu_condition">
									</select>
								</div>
								<div class="field">
									<button class="ui basic button" id="add_xbz"><i class="add circle icon"></i><b>&nbsp;添&nbsp;加</b></button>
								</div>

							</div>
						</div>
					</div>
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
									<button class="ui basic button" id="btnsubmit"><i class="add circle icon"></i><b>&nbsp;启&nbsp;用</b></button>
								</div>
    </div>
  </div>
 <div class="ui segments" id="version_use_xq_">

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
									<div class="ui form ">
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
										<textarea id="nr" rows="2" placeholder="内容(可以不填哦！)"></textarea>
										<div class="ui input" id="kqzb_three">
											<input type="text" placeholder="分值（百分比）" id="fz">
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
				var version_no = 1;
				$('#add_numble').click(function() { //点击添加标准数量
					if (i <= 4) {
						var dom = '<div class="field add_title" >' +
							'<div class="ui title input " id="title' + i + '">' +
							' <input type="text" placeholder="标题" id="bt' + i + '">' +
							'</div>' +
							'<textarea id="nr' + i + '"' + ' rows="2" placeholder="内容(可以不填哦！)"></textarea>' +
							'<div class="ui input " id="kqzb_three">' +
							' <input type="text" placeholder="分值(百分比)"  id="fz' + i + '" >' +
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
					if (i >= 2) {
						postFormData_bz();
					} else {
						$.alert("标准数不能低于2个哦！");
						$("#btnsubmit_add").removeClass("loading");
					}
				});

				function postFormData_bz() {
					var rule_title = $('#menu_bz > option:selected').text();
					var rule_version = version_no;
					var s = {
						numble: i,
						rule_title: rule_title,
						rule_item_title_one: "",
						rule_item_title_two: "",
						rule_item_title_three: "",
						rule_item_title_four: "",
						rule_item_title_five: "",
						rule_version: version_no,
						rule_table: 'qm_teacher_judge',
						rule_item_field_one: "ddtk",
						rule_item_field_two: "xspj",
						rule_item_field_three: "per11",
						rule_item_field_four: "per12",
						rule_item_field_five: "per13",
						rule_item_formula_one: "",
						rule_item_formula_two: "",
						rule_item_formula_three: "",
						rule_item_formula_four: "",
						rule_item_formula_five: "",
						rule_item_content_one: "",
						rule_item_content_two: "",
						rule_item_content_three: "",
						rule_item_content_four: "",
						rule_item_content_five: "",
						rule_status: "0",
					}
					s.rule_item_content_one = $('#nr').val();
					s.rule_item_content_two = $('#nr1').val();
					s.rule_item_content_three = $('#nr2').val();
					s.rule_item_content_four = $('#nr3').val();
					s.rule_item_content_five = $('#nr4').val();
					s.rule_item_title_one = $('#bt').val();
					s.rule_item_title_two = $('#bt1').val();
					s.rule_item_title_three = $('#bt2').val();
					s.rule_item_title_four = $('#bt3').val();
					s.rule_item_title_five = $('#bt4').val();
					s.rule_item_formula_one = $('#fz').val();
					s.rule_item_formula_two = $('#fz1').val();
					s.rule_item_formula_three = $('#fz2').val();
					s.rule_item_formula_four = $('#fz3').val();
					s.rule_item_formula_five = $('#fz4').val();
					if(s.rule_item_content_one==""||s.rule_item_title_one==""||s.rule_item_formula_one==""||s.rule_item_content_two==""||s.rule_item_title_two==""||s.rule_item_formula_two==""){
						$.alert(" 抱歉！您有一些空没有填哦，请再检查一下。");
						$("#btnsubmit_add").removeClass("loading");
					}
					else{
						postdata_xkh(s);
					}
				}

				function postdata_xkh(s) {
					$.ajax({
						url: "do?invoke=Mass@postdata_xkh",
						type: 'POST',
						dataType: 'json',
						data: s,
						success: function(rep) {
							$.alert("", rep.message);
							$("#btnsubmit_add").removeClass("loading");
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

				function load_listen(rule_title, rule_version) //获取每个标准的不同内容并显示
					{
						$.ajax({
							url: "do?invoke=Mass@load_listenkh",
							type: 'POST',
							dataType: 'json',
							data: {
								rule_title: rule_title,
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
											'<textarea id="kqzb_two"" rows="2" >' + version_table[i].rule_item_title + '</textarea>' +
											'<div class="ui input " id="kqzb_three">' +
											'<input type="text" placeholder="分值"id="kqzb_three_" ' + 'value=' + '"' + version_table[i].rule_item_formula + '%' + '"' + '>' +
											' </div>' +
											' </div>';
										$('#form_text_kt').append($(dom));
									}
								}
							}
						});
					}

				function loadstu_all_(rule_title) { //根据不同的rule_version_flag获取不同的版本和状态
					$.ajax({
						url: "do?invoke=Mass@load_kh",
						type: 'POST',
						dataType: 'json',
						data: {
							rule_title: rule_title
						},
						success: function(rep) {
							if (rep.result == 0) {} else {
								table = rep.data;
								$('#form_table tr:gt(0)').remove();
								for (var i = 0; i < table.length; i++) {
									if (table[i].rule_status == 1) {
										var dom_stu = '<tr>' +
											'<td>' + (i + 1) + '</td>' +
											'<td>' + table[i].rule_title + '</td>' +
											'<td>' + table[i].rule_version + '</td>' +
											'<td>' + '启用' + '</td>' +
											'<td>' +
											'<div class="start circular mini ui blue basic icon button" name="' + table[i].rule_title + '"  bbh="' + table[i].rule_version + '" zt="' + table[i].rule_status + '" >' +
											'<i class=" checkmark blue large icon"></i>' +
											'</div>' +
											'</td>' +
											'<td>' +
											'<div class="look circular mini ui teal basic icon button" name="' + table[i].rule_title + '" bbh="' + table[i].rule_version + '" zt="' + table[i].rule_status + '" data-content="查看详情">' +
											'<i class="search teal large icon"></i>' +
											'</div>' +
											'</td>' +
											'</tr>';
										$('#form_table').append($(dom_stu));
									} else {
										var dom_stu = '<tr>' +
											'<td>' + (i + 1) + '</td>' +
											'<td>' + table[i].rule_title + '</td>' +
											'<td>' + table[i].rule_version + '</td>' +
											'<td>' + '停用' + '</td>' +
											'<td>' +
											'<div class="start circular mini ui red basic icon button" name="' + table[i].rule_title + '" bbh="' + table[i].rule_version + '" zt="' + table[i].rule_status + '" >' +
											'<i class=" remove red large icon"></i>' +
											'</div>' +
											'</td>' +
											'<td>' +
											'<div class="look circular mini ui teal basic icon button" name="' + table[i].rule_title + '" bbh="' + table[i].rule_version + '" zt="' + table[i].rule_status + '"  data-content="查看详情">' +
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
											blurring: true
										}).modal({
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
						url: "do?invoke=Mass@loadkh",
						type: 'POST',
						dataType: 'json',
						success: function(rep) {
							var table = rep.data;
							console.log(rep);
							for (var i = 0; i < table.length; i++) {
								if (i == 0) {
									var dom_one = '<option selected="selected" value="' + table[i].rule_table + '"' + "table=" + '"' + table[i].rule_table + '"' + '>' + table[i].rule_title + '</option>';
									$('#menu_condition').append($(dom_one));
									$('#menu_bz').append($(dom_one));
								} else {
									var dom_two = '<option value="' + table[i].rule_table + '"' + "table=" + '"' + table[i].rule_table + '"' + '>' + table[i].rule_title + '</option>';
									$('#menu_condition').append($(dom_two));
									$('#menu_bz').append($(dom_two));
								}
							}
							var data = ($("#menu_condition > option:selected").text());
							load_listen(data);
							loadversion(data);
							loadstu_all_(data);
							$("#menu_condition")
								.dropdown({
									onChange: function(value, text, $selectedItem) {
										data = value;
										load_listen(data);
										loadversion(data);
										loadstu_all_(data);
										loadversion_(data);
									}
								});
							//弹出层里面的标准名称
							var rule_title = ($("#menu_bz > option:selected").text());
							loadversion(rule_title);
							$("#menu_bz")
								.dropdown({
									onChange: function(value, text, $selectedItem) {
										rule_title = text;
										$('.add_title').remove();
										$('#bt').val("");
										$('#nr').val("");
										$('#fz').val("");
										loadversion(rule_title);
									}
								});
						}
					});
				}

				function loadversion(title) { //点击获取每个标准有几个版本
					$.ajax({
						url: "do?invoke=Mass@loadversionkh",
						type: 'POST',
						dataType: 'json',
						data: {
							rule_title: title
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
								version_no = parseInt(version_table[0].rule_version) + 1;
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
					console.log(term_no)
					console.log(rule_type)
					console.log(rule_version)
					$.ajax({
						url: "do?invoke=Mass@postdata_bz",
						type: 'POST',
						dataType: 'json',
						data: {
							term_no: term_no,
							rule_type: rule_type,
							rule_version: rule_version
						},
						success: function(rep) {
							$.alert("", rep.message);
							loadversionuse();
							$("#btnsubmit").removeClass("loading");
						}
					});
				}

				function loadchange(name, bbh, zt) { //改变每个标准的状态
					$.ajax({
						url: "do?invoke=Mass@loadchangekh",
						type: 'POST',
						dataType: 'json',
						data: {
							rule_title: name,
							rule_version: bbh,
							rule_status: zt
						},
						success: function(rep) {
							var data = ($("#menu_condition > option:selected").text());
							loadstu_all_(data);
						}
					});
				}
				loadversionuse();
				function loadversionuse() { 
					$.ajax({
						url: "do?invoke=Mass@loadversionuse",
						type: 'POST',
						dataType: 'json',
						data: {
							rule_type: 'judge',
						},
						success: function(rep) {
							var use_data = rep.data;
							var use_data_len = use_data.length;
							var dom ='';
							$('#version_use_xq_').empty();
							for(var i = 0 ; i< use_data_len ; i++){
								 dom += '  <div class="ui segment">'+
								   '<p>'+use_data[i].term_no.substring(0,4)+'年第'+(parseInt(use_data[i].term_no.substring(4,5))+1)+'学期，使用第'+use_data[i].rule_version+'版本</p>'+
								   ' </div>';
							}
							$('#version_use_xq_').append(dom);
						}
					});
				}
			});
		</script>
		<!--这里引用其他JS-->

		</html>