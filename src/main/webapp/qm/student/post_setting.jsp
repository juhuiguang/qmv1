<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/commonjsp/doctype.jsp"%>
		<html>

		<head>
			<%@ include file="/commonjsp/meta.jsp"%>
				<!--这里引用其他样式-->
				<title>校内教学质量监控运行平台</title>
				<style>
					#add_xpost{
						margin-left:50%;
					}
					#button{
					margin-left:12%;
					}
					#text{
					margin-left:12%;
					}
					#post_{
					margin-top:1%;
					}
					#add_xpost{
					margin-top:1%;
					}
				</style>
		</head>
		<body>
			<%@ include file="/commonjsp/header.jsp"%>
				<div id="container">
					<div class="ui raised ">
						<div class="ui form">
							<div class="fields">
								<div class="field">
									<h3 class="ui header">
								<i class="list layout icon"></i>
                               <div class="content">岗位管理与设置 </div>
                               </h3>
								</div>

							</div>
						</div>
					</div>
					<div class="ui raised">
						<div class="ui form">
							<div class="fields">
								<div class="field" id="post_"> 
									<select class="ui three dropdown" id="menu_post">
									</select>
								</div>
								<div class="field" id="add_xpost">
									<button class="ui blue labeled icon button" id="add_post"><i class="plus icon"></i> 添加新岗位</button>
								</div>
							</div>
						</div>
					</div>
					<table class="ui compact blue table" id="form_table">
						<thead>
							<tr>
								<th>编号</th>
								<th>岗位名称</th>
								<th>岗位类型</th>
								<th>是否计分</th>
								<th>管理操作</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="ui one modal" id="xpost">
						<i class="close icon"></i>
						<div class="header">添加新岗位</div>
						<div class="image content">
							<div class="description">
								<div class="ui raised segment">
									<div class="ui form">
										<div class="fields">

											<div class="field" >
												<select class="ui three dropdown" id="menu_post_">
												<option selected="selected">行政岗位</option>
									            <option selected="selected">教学岗位</option>
												</select>
											</div>
											<div class="field" id="text">
                                                  <input type="text" placeholder="岗位名称" id="postname">
											</div>
											<div class="field" id="button">
												<button class="ui basic button" id="btnsubmit_add"><i class="add circle icon"></i><b>添&nbsp;加</b></button>
											</div>
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
				$('#add_xpost').click(function(){
					$('#xpost').modal({
						transition: 'vertical flip',
						observeChanges: true,
						closable: false
					})
					.modal('show');
					$('#postname').val("");
				});
				$('#btnsubmit_add').click(function(){
					loadadd();
				});
				
				
				loadposttype();
				function loadposttype(){
					$.ajax({
						url: "do?invoke=postsetting@loadposttype",
						type: 'POST',
						dataType: 'json',
						success: function(rep) {
							if (rep.result == 0) {
								console.log(rep)
							} else {
								console.log(rep)
								var table = rep.data;
								  for (var i = 0; i < table.length; i++) {
									if (i == 0) {
										var dom = '<option selected="selected">' + table[i].job_type + '</option>';
										$('#menu_post').append($(dom));
										$('#menu_post_').append($(dom));
									} else {
										var dom = '<option>' + table[i].job_type + '</option>';
										$('#menu_post').append($(dom));
										$('#menu_post_').append($(dom));
									}
								}  
								loadpost($('#menu_post >option:selected').text());
								$("#menu_post")
								.dropdown({
									onChange: function(value, text, $selectedItem) {
										loadpost(text);
									}
								});
								$('#menu_post_').dropdown();
								$('#menu_post_').change(function(){
									$('#postname').val("");
								});
							}
						}
					});
				}
				
				function loadpost(text){
					$.ajax({
						url: "do?invoke=postsetting@loadpost",
						type: 'POST',
						dataType: 'json',
						data:{
							job_type:text
						},
						success: function(rep) {
							if (rep.result == 0) {
								$('#form_table tr:gt(0)').remove();
							} else {
								$('#form_table tr:gt(0)').remove();
								var table = rep.data;
								for (var i = 0; i < table.length; i++) {
									if (table[i].job_kh == 1) {
										var dom = '<tr>' +
											'<td>' + (i + 1) + '</td>' +
											'<td>' + table[i].job_name + '</td>' +
											'<td>' + table[i].job_type + '</td>' +
											'<td>' +
											'<div class="start circular mini ui blue basic icon button" job_name="' + table[i].job_name + '"  job_type="' + table[i].job_type + '" job_kh="' + table[i].job_kh + '" >' +
											'<i class=" checkmark blue large icon"></i>' +
											'</div>' +
											'</td>' +
											'<td>' +
											'<div class="remove circular mini ui red basic icon button" job_name="' + table[i].job_name + '" job_type="' + table[i].job_type + '" job_kh="' + table[i].job_kh + '" data-content="点击可直接删除哦！" >' +
											'<i class="trash icon red large icon"></i>' +
											'</div>' +
											'</td>' +
											'</tr>';
										$('#form_table').append($(dom));
									} else {
										var dom = '<tr>' +
										'<td>' + (i + 1) + '</td>' +
										'<td>' + table[i].job_name + '</td>' +
										'<td>' + table[i].job_type + '</td>' +
										'<td>' +
										'<div class="start circular mini ui red basic icon button" job_name="' + table[i].job_name + '"  job_type="' + table[i].job_type + '" job_kh="' + table[i].job_kh + '" >' +
										'<i class=" remove  red large icon"></i>' +
										'</div>' +
										'</td>' +
										'<td>' +
										'<div class="remove circular mini ui red basic icon button" job_name="' + table[i].job_name + '" job_type="' + table[i].job_type + '" job_kh="' + table[i].job_kh + '" data-content="点击可直接删除哦！" >' +
										'<i class="trash icon red large icon"></i>' +
										'</div>' +
										'</td>' +
										'</tr>';
									$('#form_table').append($(dom));
									}
								}
								$('.look').popup();
								//点击事件分别做额事情
								$('.start').click(function() { //点击改变版本状态
									var job_name = $(this).attr("job_name");
									var job_type = $(this).attr("job_type");
									var job_kh = $(this).attr("job_kh");
									loadchange(job_type, job_name, job_kh);
									console.log(job_name)
								});
								$('.remove').click(function() { //点击查看详情
									var job_name = $(this).attr("job_name");
									var job_type = $(this).attr("job_type");
									loaddelete(job_type, job_name);
								});
							}
						}
					});
				}
				function loadchange(job_type,job_name,job_kh){
					$.ajax({
						url: "do?invoke=postsetting@loadchange",
						type: 'POST',
						dataType: 'json',
						data:{
							job_type:job_type,
							job_name:job_name,
							job_kh:job_kh
						},
						success:function(rep){
							loadpost($('#menu_post >option:selected').text());    
						}
				});
			}
				function loaddelete(job_type,job_name){
					$.ajax({
						url: "do?invoke=postsetting@loaddelete",
						type: 'POST',
						dataType: 'json',
						data:{
							job_type:job_type,
							job_name:job_name,
						},
						success:function(rep){
							loadpost($('#menu_post >option:selected').text());    
						}
				});
			}
				
				function loadadd(job_type,job_name){
					var job_type=$('#menu_post_>option:selected').text();
					var job_name=$('#postname').val();
					console.log(job_type)
					console.log(job_name)
					$.ajax({
						url: "do?invoke=postsetting@loadadd",
						type: 'POST',
						dataType: 'json',
						data:{
							job_type:job_type,
							job_name:job_name,
						},
						success:function(rep){
							$.alert("", rep.message);
							$('#postname').val("");
							loadpost($('#menu_post >option:selected').text());
						}
				});
			}
				
			});
		</script>
		<!--这里引用其他JS-->

		</html>