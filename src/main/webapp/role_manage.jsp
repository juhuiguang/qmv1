<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>

<!--这里引用其他样式-->
<title></title>
<style>

</style>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
			<h3  class="ui header "> 
		  			<i class="unordered list icon"></i>
		  			<div class="content">系统角色管理</div>
			</h3>
		
		<div class="ui blue basic button" id="addrole" style="float: right;">
		  <i class="user icon"></i>添加角色
		</div>

		<table class="ui blue table">
		  <thead>
		    <tr>
		      <th>角色编码</th>
		      <th>角色名称</th>
		      <th>操作</th>
		    </tr>
		  </thead>
		  <tbody  id="tablepane">
		    
		  </tbody>
		</table>
		
		<div id="rolemod" class="ui modal">
			  <i class="close icon"></i>
			  <div class="header">
			    修改该角色：
			  </div>
			  <div class="content">
			  	<div class="description">
			  	
			  		<div>
						角色名称：
				  		<div class="ui mini input">
						  <input type="text" placeholder="" style="width: 417px;"  id="role_name">
						</div>
					</div>
			  	
			  	</div>			  	
			  </div>			  
			  <div class="actions">
			    <div class="ui positive right labeled icon button" id="submit">
			      提&nbsp;&nbsp;&nbsp;&nbsp;交
			      <i class="checkmark icon"></i>
			    </div>
			  </div>
		 </div>
		
		<div id="addrolemod" class="ui modal">
			  <i class="close icon"></i>
			  <div class="header">
			    添加新角色：
			  </div>
			  <div class="content">
			  	<div class="description">
			  	
			  		<div>
						角色名称：
				  		<div class="ui mini input">
						  <input type="text" placeholder="" style="width: 417px;"  id="role_nameadd">
						</div>
					</div>
			  	
			  	</div>			  	
			  </div>			  
			  <div class="actions">
			    <div class="ui positive right labeled icon button" id="submitadd">
			      提&nbsp;&nbsp;&nbsp;&nbsp;交
			      <i class="checkmark icon"></i>
			    </div>
			  </div>
		 </div>
		
	</div>

	<!--这里绘制页面-->
</body>
<script>
	$(function() {
		loaddata();
		$("#addrole").unbind("click").click(function(){
			
			showAdd();
		});
		
		//加载表格数据
		function loaddata(){
			$("#tablepane").html("");
			$.ajax({
				url:"do?invoke=roleManageOpera@getRoleManageView",
				type:'POST',
				dataType:'json',
				success:function(rep) {
					console.log(rep);
					if(rep.result == 0) {
						$.alert("列表数据获取失败！");
					} else {
						var table =rep.data;
						for(var i=0; i<table.length; i++) {
							var dom = 
								'<tr>'+
							  	  '<td>'+table[i].role_id+ '</td>'+
							  	  '<td>'+table[i].role_name+ '</td>'+
							      '<td>'+
									'<div class="btnupdate circular mini ui blue basic icon button" id="'+table[i].role_id+'" name="'+table[i].role_name+'"  data-content="修改">'+
										'<i class="edit blue large icon"></i>'+
					                 '</div>'+ 
					                 '<div class="btndelete circular mini ui red basic icon button" id="'+table[i].role_id+'" data-content="删除">'+
										'<i class="trash red large icon"></i>'+
					                 '</div>'+
				                 '</td>'+
						   	  '</tr>';
						   	  $("#tablepane").append($(dom));
						   	  $('.btnupdate').popup();
						   	  $('.btndelete').popup();
						}
						$('.btnupdate').click(function(){
							var roleid = $(this).attr("id");
							var rolename =$(this).attr("name");
							showModify(roleid,rolename);
						});
						
						$(".btndelete").click(function(){
							var roleid = $(this).attr("id");
							delRole(roleid);
						});
					}
				}
			});
		}
		
		function showAdd(){
			$('#addrolemod').modal({
				transition:'slide down',
				observeChanges:true,
				closable:false
			}).modal('show');
			$("#role_nameadd").val("");			
			$("#submitadd").unbind("click").click(function(){
				var name =$("#role_nameadd").val();
				if(name == "") {
					$.alert("'角色名称' 不能为空！");
				} else {
					saveRole({
						rolename:name
					});					
				}
			});
		}
		
		function saveRole(role){
			$.ajax({
				url:"do?invoke=roleManageOpera@getRoleManageADD",
				type:'POST',
				dataType:'json',
				data:role,
				success:function(rep){
					console.log(rep);
					if(rep.result == 0) {
						$.alert("添加新角色失败，您可以再试一次！");
					} else {						
					//	$.alert("新角色添加成功咯！");
						if(rep.message == "") {
							$.alert("该角色已经存在，不可以重复添加！");
						} else {
							$.alert("新角色添加成功！");
						}
						$("#tablepane").empty();
						loaddata();
					}
				}
			});
		}
		
		function showModify(roleid,rolename){
			$('#rolemod').modal({
				transition:'slide down',
				observeChanges:true,
				closable:false
			}).modal('show');
			$("#role_name").val(rolename);
			$("#submit").unbind("click").click(function(){
				var name = $("#role_name").val();
				var o={
						roleid:roleid,
						rolename:name,
				};
				saveModifyRole(o);
			});
		}
		
		function saveModifyRole(role){
			$.ajax({
				url:"do?invoke=roleManageOpera@getRoleManageXG",
				type:'POST',
				dataType:'json',
				data:role,
				success:function(rep) {
					if(rep.result == 0) {
						$.alert("修改信息失败，您可以再试一次！");
					} else {											
						$.alert("修改信息成功！");
						$("#tablepane").html("");
						loaddata();
					}
				}
			});
		}
		
		function delRole(roleid){
			$.confirm({
				msg          :"您确定删除该角色么？",
				btnSure     :'确定',
				btnCancel  :'取消',
				sureDo       : function(){													
										$.ajax({
											url:"do?invoke=roleManageOpera@getRoleManageSC",
											type:'POST',
											dataType:'json',
											data:{
												roleid:roleid
											},
											success:function(rep) {															
												if(rep.result == 0) {
													$.alert("删除该角色失败！");
												} else {
													$.alert("该角色删除成功！");
													$("#tablepane").html("");
													loaddata();
												}																																		
											}
										});
				}
			});
		}
	});

</script>
<!--这里引用其他JS-->
</html>