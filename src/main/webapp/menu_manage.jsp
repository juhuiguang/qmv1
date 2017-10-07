<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>

<!--这里引用其他样式-->
<title></title>
<style>
	#qy{
		color:blue!important;
	}
	#ty{
		color:red!important;
	}
	#opn3add {
		display:none;
	}
	#dropadd {
		display:none;
	}
	#attradd_hide{
		display:none;
	}
	#statusadd_hide{
		display:none;
	}
</style>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
			<h3  class="ui header "> 
		  			<i class="unordered list icon"></i>
		  			<div class="content">菜单管理</div>
			</h3>
		
		<div class="ui blue basic button" id="addmenu" style="float: right;">
		  <i class="write icon"></i>添加菜单
		</div>
		
		<table class="ui blue table">
		  <thead>
		    <tr>
		      <th>编号</th>
		      <th>菜单名称</th>
		      <th>类型</th>
		      <th>父类编码</th>
		      <th>菜单内容</th>
		      <th>菜单属性</th>
		      <th>状态</th>
		      <th>操作</th>
		    </tr>
		  </thead>
		  <tbody  id="tablepane">
		    
		  </tbody>
		</table>
		
				<div id="planmodadd" class="ui modal">
				  <div class="header">
				    添加新菜单：
				    <i class="close icon" style="float: right;"></i>
				  </div>
				  <div class="content">
				  	<div class="description">
				  	    <div>
				  	    	菜单名称：
					  		<div class="ui mini input">
							  <input type="text" placeholder="" style="width: 417px;" id="menu_nameadd">
							</div>
						</div>
						<br>
						<div>
							菜单类型：
							<div class="ui selection dropdown" id="menu_typeadd">
							  <input type="hidden" name="gender">
							  <div class="default text"></div>
							  <i class="dropdown icon"></i>
							  <div class="menu">
							    <div class="item" data-value="2" id="opn3add"></div>
							    <div class="item" data-value="1" id="opn1add">模块</div>
							    <div class="item" data-value="0" id="opn2add">子功能</div>
							  </div>
							</div>
	
	
							&nbsp;&nbsp;&nbsp;&nbsp;父类编码：
							<div class="ui selection dropdown" id="menu_pidadd">
							  <input type="hidden" name="gender">
							  <div class="default text" id="pidadd"></div>
							  <i class="dropdown icon"></i>
							  <div class="menu" id="piddrowpadd">
							    <!-- <div class="item" data-value="0" >无</div>
							    <div class="item" data-value="-1" id="dropadd"></div> -->
							  </div>
							</div>
						</div>
						<br>
						<div>
							菜单内容：
					  		<div class="ui mini input">
							  <input type="text" placeholder="" style="width: 417px;"  id="menu_contentadd">
							</div>
						</div>
						<br>
						
							<div class="ui form">
								  <div class="inline fields">
								    <label for="menu_attradd">&nbsp;菜单属性：</label>
								    <div class="field">
								      <div class="ui radio checkbox" id="attradd_fir">
								        <input type="radio" name="menu_attradd"  tabindex="0" class="hidden" value="circle">
								        <label><i class="circle icon"></i> 标题栏图标</label>
								      </div>
								    </div>
								    <div class="field">
								      <div class="ui radio checkbox" id="attradd_sec">
								        <input type="radio" name="menu_attradd"  tabindex="0" class="hidden" value="list layout">
								        <label><i class="list layout icon"></i> 侧边栏图标</label>
								      </div>
								    </div>
								    <div class="field">
								      <div class="ui radio checkbox" id="attradd_hide">
								        <input type="radio" name="menu_attradd"  tabindex="0" class="hidden" value="">
								      </div>
								    </div>
								  </div>
						 </div>
						 
						 <div class="ui form">
								  <div class="inline fields">
								  		<label for="menu_statusadd" style="margin-left: 34px;">状态：</label>								    
									    <div class="field">
									      <div class="ui radio checkbox" id="statusadd_fir">
									        <input type="radio" name="menu_statusadd"  tabindex="0" class="hidden" value="1">
									        <label>启用</label>
									      </div>
									    </div>
									    <div class="field">
									      <div class="ui radio checkbox" id="statusadd_sec">
									        <input type="radio" name="menu_statusadd"  tabindex="0" class="hidden" value="0">
									        <label>停用</label>
									      </div>
									    </div>
									    <div class="field">
									      <div class="ui radio checkbox" id="statusadd_hide">
									        <input type="radio" name="menu_statusadd"  tabindex="0" class="hidden" value="">
									      </div>
									    </div>
								  </div>
						  </div>
						 														  
				 	    <div>							
							&nbsp;&nbsp;&nbsp;排序号：
					  		<div class="ui mini input">
							  <input type="text" placeholder="" id="menu_sortadd">
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
		
		
		<div id="planmod" class="ui modal">
			  <div class="header">
			    修改该菜单内容：
			    <i class="close icon" style="float: right;"></i>            
			  </div>
			  <div class="content">
			  	<div class="description">
			  	    <div>
			  	    	菜单名称：
				  		<div class="ui mini input">
						  <input type="text" placeholder="" style="width: 417px;" id="menu_name">
						</div>
					</div>
					<br>
					<div>
						菜单类型：
						<div class="ui selection dropdown" id="menu_type">
						  <input type="hidden" name="gender">
						  <div class="default text" ></div>
						  <i class="dropdown icon"></i>
						  <div class="menu">
						    <div class="item" data-value="1" id="opn1">模块</div>
						    <div class="item" data-value="0" id="opn2">子功能</div>
						  </div>
						</div>

						&nbsp;&nbsp;&nbsp;&nbsp;父类编码：
						<div class="ui selection dropdown" id="menu_pid">
						  <input type="hidden" name="gender">
						  <div class="default text"></div>
						  <i class="dropdown icon"></i>
						  <div class="menu" id="piddrowp">
						    <!-- <div class="item" data-value="0" >无</div> -->
						    
						  </div>
						</div>
					</div>
					<br>
					<div>
						菜单内容：
				  		<div class="ui mini input">
						  <input type="text" placeholder="" style="width: 417px;"  id="menu_content">
						</div>
					</div>
					<br>
							<div class="ui form">
								  <div class="inline fields">
								    <label for="menu_attr">&nbsp;菜单属性：</label>
								    <div class="field">
								      <div class="ui radio checkbox" id="attr_fit">
								        <input type="radio" name="menu_attr"  tabindex="0" class="hidden" value="circle">
								        <label><i class="circle icon"></i> 标题栏图标</label>
								      </div>
								    </div>
								    <div class="field">
								      <div class="ui radio checkbox" id="attr_sec">
								        <input type="radio" name="menu_attr"  tabindex="0" class="hidden" value="list layout">
								        <label><i class="list layout icon"></i> 侧边栏图标</label>
								      </div>
								    </div>
								  </div>
						 </div>
						 
						 <div class="ui form">
								  <div class="inline fields">
								  		<label for="menu_statusadd" style="margin-left: 34px;">状态：</label>								    
									    <div class="field">
									      <div class="ui radio checkbox" id="status_fir">
									        <input type="radio" name="menu_status"  tabindex="0" class="hidden" value="1">
									        <label>启用</label>
									      </div>
									    </div>
									    <div class="field">
									      <div class="ui radio checkbox" id="status_sec">
									        <input type="radio" name="menu_status"  tabindex="0" class="hidden" value="0">
									        <label>停用</label>
									      </div>
									    </div>
								  </div>
						  </div>
						
					<div>
						&nbsp;&nbsp;&nbsp;&nbsp;排序号：
					  		<div class="ui mini input">
							  <input type="text" placeholder="" id="menu_sort">
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
		
    </div>
	<!--这里绘制页面-->
</body>
<script>
	$(function() {
		var modbj = "";
		loaddata();		
		$('.ui.radio.checkbox').checkbox();		
		$("#addmenu").unbind("click").click(function(){
			showAdd();
		});
		
		//加载表格数据
		function loaddata(){
			$("#tablepane").html("");
			$.ajax({
				url:"do?invoke=menuManageOpera@getMenuManageView",
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
							  	  '<td>'+table[i].menu_id+ '</td>'+
							  	  '<td>'+table[i].menu_name+ '</td>'+
							  	  '<td>'+table[i].menu_type + '</td>'+
								  '<td>'+table[i].menu_pid + '</td>'+
								  '<td>'+table[i].menu_content + '</td>'+
								  '<td>'+table[i].menu_attr  + '</td>';
								  
								  if(table[i].menu_status == "1") {
								  	  dom+= '<td id="qy">启用</td>';									  
								  } else if(table[i].menu_status == "0") {
									  dom+= '<td id="ty">停用</td>';
								  }else {
									  dom+= '<td id="ty"></td>';
								  }
								  dom+=
							     '<td>'+
									'<div class="btnupdate circular mini ui blue basic icon button" id="'+table[i].menu_id+'" name="'+table[i].menu_name+'" type="'+table[i].menu_type+'" pid="'+table[i].menu_pid+'" content="'+table[i].menu_content+'" attr="'+table[i].menu_attr+'" status="'+table[i].menu_status+'" sort="'+ table[i].menu_sort+'" data-content="修改">'+
										'<i class="edit blue large icon"></i>'+
					                 '</div>'+ 
					                 '<div class="btndelete circular mini ui red basic icon button" id="'+table[i].menu_id+'" name="'+table[i].menu_type+'" data-content="删除">'+
										'<i class="trash red large icon"></i>'+
					                 '</div>'+
				                 '</td>'+
						   	  '</tr>';
						   	  $("#tablepane").append($(dom));
						   	  $('.btnupdate').popup();
						   	  $('.btndelete').popup();
						}
						$('.btnupdate').click(function(){
							var menuid = $(this).attr("id");
							var menuname =$(this).attr("name");
							var menutype =$(this).attr("type");
							var menupid =$(this).attr("pid");
							var menucontent =$(this).attr("content");
							var menuattr =$(this).attr("attr");
							var menustatus =$(this).attr("status");
							var menusort =$(this).attr("sort");
							showModify(menuid,menuname,menutype,menupid,menucontent,menuattr,menustatus,menusort);
						});
						
						$('.btndelete').click(function(){
							var menuid = $(this).attr("id");
							var menutype = $(this).attr("name");
							delMenu(menuid,menutype);
						});
					}
				}
			});
		}
		
		
		
		function showAdd() {
			modbj = "add";
			$("#menu_nameadd").val("");
			$("#menu_typeadd").dropdown("set value","2");
			$("#menu_pidadd").dropdown("set value","-1");
			$("#attradd_hide").checkbox("set checked","");
			$("#statusadd_hide").checkbox("set checked","");
			$("#menu_contentadd").val("");
			$("#menu_sortadd").val("");
			
			$('#planmodadd').modal({
				transition:'slide down',
				observeChanges:true,
				closable:false
			}).modal('show');
			
			showDropdown(function(){
				$("#submitadd").unbind("click").click(function(){
					var name =$("#menu_nameadd").val();
					var type =$("#menu_typeadd").dropdown("get value");
					var pid = $("#menu_pidadd").dropdown("get value");
					var content =$("#menu_contentadd").val();			
					var attr =$("input[name='menu_attradd'][type='radio']:checked").val();
					var status =$("input[name='menu_statusadd'][type='radio']:checked").val();
					var sort =$("#menu_sortadd").val();
					if(name == "" || type == "" || pid == "-1" || content == "" || attr == "" || status == "") {
						$.alert("选项没有填写完整，不能添加新菜单");
					} else {
						saveMenu({
							menuname:name,
							menutype:type,
							menupid:pid,
							menucontent:content,
							menuattr:attr,
							menustatus:status,
							menusort:sort
						});
					}
				});
			
			});
		}
		
		
		
		function saveMenu(menu) {
			$.ajax({
				url:"do?invoke=menuManageOpera@getMenuManageADD",
				type:'POST',
				dataType:'json',
				data:menu,
				success:function(rep) {
					if(rep.result == 0) {
						$.alert("添加新菜单失败，您可以再试一次！");
					} else {	
						if(rep.message == "") {
							$.alert("该菜单已经存在，不可以重复添加！");
						} else {
							$.alert("新菜单添加成功！");						
						}
						$("#tablepane").html("");
						loaddata();
					}
				}
			});
		}
		
		function showModify(menuid,menuname,menutype,menupid,menucontent,menuattr,menustatus,menusort){
			$('#planmod').modal({
				transition:'slide down',
				observeChanges:true,
				closable:false
			}).modal('show');
			console.log(menupid);
			modbj = "upd";
			showDropdown(function(){
				$("#menu_name").val(menuname);
				var a=$("#opn1").text();
				if(menutype == a) {
					$("#menu_type").dropdown("set selected","1");
				} else {
					$("#menu_type").dropdown("set selected","0");
				}
				
				if(menupid == ""){
					$("#menu_pid").dropdown("set selected" ,"0");
				} else{
					$("#menu_pid").dropdown("set selected" ,menupid);					
				}
				
				$("#menu_content").val(menucontent);				
				$("#menu_attr").checkbox("set checked",menuattr);
				$("#menu_status").checkbox("set checked",menustatus);
				$("#menu_sort").val(menusort);
				
				$("#submit").unbind("click").click(function(){
					var name =$("#menu_name").val();
					var type =$("#menu_type").dropdown("get value");
					var pid = $("#menu_pid").dropdown("get value");
					var content =$("#menu_content").val();					
					var attr =$("input[name='menu_attr'][type='radio']:checked").val();
					var status =$("input[name='menu_status'][type='radio']:checked").val();
					var sort = $("#menu_sort").val();
					var o={
							menuid:menuid,
							menuname:name,
							menutype:type,
							menupid:pid,
							menucontent:content,
							menuattr:attr,
							menustatus:status,
							menusort:sort
					};
						saveModifyMenu(o);
				});
			
			});
			
		}
		
		function saveModifyMenu(menu){
			$.ajax({
				url:"do?invoke=menuManageOpera@getMenuManageXG",
				type:'POST',
				dataType:'json',
				data:menu,
				success:function(rep) {
					console.log(rep);
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
		
		function showDropdown(callback){
			$("#piddrowp").find(".item").remove();
			$("#piddrowpadd").find(".item").remove();
			$.ajax({
				url:"do?invoke=menuManageOpera@getMenuManageDropdown",
				type:'POST',
				dataType:'json',
				success:function(rep) {
					if(rep.result == 0) {
						$.alert("下拉列表数据获取失败！");
					} else {
						var table =rep.data;
						var dom1 = '<div class="item" data-value="0" >无</div>';
						var dom2 = '<div class="item" data-value="0" >无</div><div class="item" data-value="-1" id="dropadd"></div>';
						for(var i=1; i<table.length; i++) {
							if(modbj == "upd") {
								dom1 +=
									'<div class="item" data-value="'+table[i].menu_id+'" >'+table[i].menu_name+'</div>';
							} else {
								dom2 +=
									'<div class="item" data-value="'+table[i].menu_id+'" >'+table[i].menu_name+'</div>';
							}
						}
						$("#piddrowp").append($(dom1));
						$("#piddrowpadd").append($(dom2));
						
						$("#menu_type").dropdown();
						$("#menu_typeadd").dropdown();
						$("#menu_pid").dropdown();
						$("#menu_pidadd").dropdown();
						if(callback){
							callback();
						}
						
					}
				}
			});
		}
		
		function delMenu(menuid,menutype) {
			$.confirm({
				msg          :"您确定删除该菜单么？",
				btnSure     :'确定',
				btnCancel  :'取消',
				sureDo       : function(){													
										$.ajax({
											url:"do?invoke=menuManageOpera@getMenuManageSC",
											type:'POST',
											dataType:'json',
											data:{
												menuid:menuid,
												menutype:menutype
											},
											success:function(rep) {
												console.log(rep);																
												if(rep.result == 0) {
													$.alert("删除该菜单失败！");
												} else {
													$.alert("该菜单删除成功！");
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