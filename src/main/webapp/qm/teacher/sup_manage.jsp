<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>
<script src="qm/js/addSup.js" type="text/javascript"></script>
<!--这里引用其他样式-->
<title></title>
<style>
#depdiv .label {
	margin-bottom: 10px;
}
#addsup
{
float:right;

}
#no{
margin-top:6%;}
#depdiv{
margin-top:2%;
}
</style>
</head> 
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
			<h3  class="ui header "> 
		  			<i class="unordered list icon"></i>
		  				督学管理
			</h3>
			<div id="depdiv">
		    <a class="ui blue label" id="all" >全&nbsp;&nbsp;&nbsp;&nbsp;部</a>
			<a class="ui gray label" id="sch" >校级督学</a>
		</div>
		<div class="ui blue basic button" id="addsup">
		  <i class="write icon"></i>添加督学
		</div>

		<table class="ui compact blue table" id="tablepane">
		  <thead>
		    <tr>
		      <th>姓名</th>
		      <th>类型</th>
		      <th>工号</th>
		      <th>部门</th>
		      <th>状态</th>
		      <th>删除</th>
		    </tr>
		  </thead>
		  <tbody id="tablepane_"  >
		    
		  </tbody>
		</table>
	</div>

	<!--这里绘制页面-->
</body>
<script>
	$(function() {
		var SYSOBJCET=<%=SYSOBJCET%>;  
		var USEROBJECT=<%=USEROBJECT%>;
		var dep_no="all"; 
		if(USEROBJECT.userpurview=="ALL"){
			$('#addsup').click(function(){
				var modal=new addSup();
				modal.showModal(dep_no); 	  
			});  
			viewDep();
			function viewDep(){ 
				var deps=SYSOBJECT.departments;
				$("#depdiv .dep").remove();
	    		for(var i=0;i<SYSOBJECT.departments.length;i++){
					if (deps[i].dep_type!="行政") {
	    			var depdiv=$('<a class="dep ui gray label"" id="'+deps[i].dep_no+'">'+deps[i].dep_name+'</a>');
	    			$("#depdiv").append(depdiv);
					}
	    		}
	    		$("#depdiv").fadeIn();
	    		$("#depdiv .label").click(function(){
	    			$("#depdiv .blue").removeClass("blue");
	    			$(this).addClass("blue");
	    			 dep_no=this.id;
	    			loadallcollege(dep_no);
	    		});
			}
		}
		else{
			$('#depdiv').remove();
			$('#addsup').click(function(){
				var modal=new addSup();
				modal.showModal(dep_no); 	  
			});  
			dep_no=USEROBJECT.userinfo.dep_no;
			loadallcollege( USEROBJECT.userinfo.dep_no);
		}
			
			
			loadallcollege(dep_no);
				function loadallcollege(dep_no){
					$.ajax({
						url:"do?invoke=supervisorManage@loadallcollege",
						type:'POST',
						dataType:'json',
						data:{
							    dep_no:dep_no
							},
						success:function(rep) {
							if(rep.result == 0) {
								$('#no').remove();
								$('#tablepane').hide();
								$('#tablepane tr:gt(0)').remove(); 
								var dom='<div class="ui green large message" id="no" >'+
								'<i class="frown large inverted yellow circular icon"></i> 抱歉!暂时还没有哦！赶紧去添加吧！'+
								'</div>'  
								$('#container').append($(dom)); 
							} else {
								$('#tablepane tr:gt(0)').remove();
								$('#no').remove();
								$('#tablepane').show(); 
								var table =rep.data;
								for(var i=0; i<table.length; i++) {
									
									if(table[i].master_status==1)
										{
										var dom = '<tr>' +
										'<td>' + table[i].teacher_name + '</td>' +
										'<td>' + table[i].master_type + '</td>' +
										'<td>' + table[i].teacher_no + '</td>' +
										'<td>' + table[i].dep_name + '</td>' +
										'<td>' +
										'<div class="change circular mini ui blue basic icon button" teacher_no="' + table[i].teacher_no + '"'+'zt="'+table[i].master_status+'"'+'master_type="'+table[i].master_type+'">' +
										'<i class=" checkmark blue large icon"></i>' +
										'</div>' +
										'</td>' +
										'<td>' +
										'<div class="delete circular mini ui red trash basic icon button" teacher_no="' + table[i].teacher_no + '"'+'zt="'+table[i].master_status+'"'+'master_type="'+table[i].master_type+'">' +
										'<i class="trash red large icon"></i>' +
										'</div>' +
										'</td>' +
										'</tr>';
										$('#tablepane').append($(dom));
										}
									else
										{
										var dom = '<tr>' +
										'<td>' + table[i].teacher_name + '</td>' +
										'<td>' + table[i].master_type + '</td>' +
										'<td>' + table[i].teacher_no + '</td>' +
										'<td>' + table[i].dep_name + '</td>' +
										'<td>' +
										'<div class="change circular mini ui red basic icon button" teacher_no="' + table[i].teacher_no + '"'+'zt="'+table[i].master_status+'"'+'master_type="'+table[i].master_type+'">' +
										'<i class=" remove red large icon"></i>' +
										'</div>' +
										'</td>' +
										'<td>' +
										'<div class="delete circular mini ui red trash basic icon button" teacher_no="'+ table[i].teacher_no + '"'+'zt="'+table[i].master_status+'"'+'master_type="'+table[i].master_type+'">' +
										'<i class="trash red large icon"></i>' +
										'</div>' +
										'</td>' +
										'</tr>';
										$('#tablepane').append($(dom));
										}
										
								}
								$('.change').click(function(){
									var teacher_no=$(this).attr("teacher_no");
									var master_status=$(this).attr("zt");
									console.log("123")
									loadchange(teacher_no,master_status);	
								});
								
								$('.delete').click(function(){
									var teacher_no=$(this).attr("teacher_no");
									var master_type=$(this).attr("master_type");
									loaddelete(teacher_no,master_type);	
									console.log("123")
								});
								
							}
						}
					});
			}
				function loadchange(teacher_no,master_status) { //改变每个标准的状态
					$.ajax({
						url: "do?invoke=supervisorManage@loadchange",
						type: 'POST',
						dataType: 'json',
						data: {
							teacher_no: teacher_no,
							master_status:master_status
						},
						success: function(rep) {
							loadallcollege(dep_no);
						}
					});
				}
				function loaddelete(teacher_no,master_type) { //改变每个标准的状态
					$.confirm({
						msg          :'您确定要删除此位督学么？',       
						btnSure     :'确定',
						btnCancel  :'取消',   
						sureDo       : function(){
							$.ajax({
								url: "do?invoke=supervisorManage@loaddelete",
								type: 'POST',
								dataType: 'json',
								data: {
									teacher_no: teacher_no,
									master_type:master_type
								},
								success: function(rep) {
									loadallcollege(dep_no);
								}
							});
						},
						cancelDo:function(){
							
						}
					});
				}	
	});
</script>
<!--这里引用其他JS-->
</html>