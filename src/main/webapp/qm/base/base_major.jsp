<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>
<%@ include file="/commonjsp/jgxgridtable.jsp"%>
<script src="script/common/datepicker/jquery.datetimepicker.js"
	type="text/javascript"></script>
<link rel="stylesheet"
	href="script/common/datepicker/jquery.datetimepicker.css" />
<!--这里引用其他样式-->
<title>校内教学质量监控运行平台</title>

<style>
		#add{
	float:right;
	}
	.results{
		overflow-y:scroll;
		height:300px;  
	} 
</style>
<!-- 这里是css语句 -->



</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<!--这里绘制页面-->
	
	
	<div id="container">
		<h3 class="ui header" id="major"> 
		  <i class="home icon"></i>
  	<div class="content">专业管理 </div>   
		</h3> 

		 <div class="ui small search" >   
		  <div class="ui icon input">
		    <input class="prompt" type="text" placeholder="專業d..."> 
		    <i class="search icon"></i>
		  </div>
		  <div class="results"></div>
				 
		</div> 

	<div class="ui small teal button addAward" id="add" >
							<i class="plus icon"></i> 添加专业
	</div>
	
	
<table class="ui compact blue table" >
  <thead>
    <tr>
      <th>专业代码</th>
      <th>专业名称</th>
      <th>删除</th>
    </tr>
  </thead>
  
  <tbody id="tablepane">
  </tbody>
  
  
</table>
<div class="ui modal" data-unuse="1" id="kuang">
 <i class="close icon"></i>
  <div class="header" data-unuse="1">
    添加专业
  </div>
    <div class="description" data-unuse="1">
    
    	<div>
			专业代码：
	  		<div class="ui mini input">
			  <input type="text" placeholder="" style="width: 417px;"  id="major_no">
			</div>
		</div>
		
		<div>
			专业名称：
	  		<div class="ui mini input">
			  <input type="text" placeholder="" style="width: 417px;"  id="major_name">
			</div>
		</div>
    </div>
  <div class="actions" data-unuse="1">
    
    <div class="ui positive right labeled icon button" data-unuse="1" id="add_but">
     	确定
    </div>
  </div>
</div>
</div>
</body>

<script type="text/javascript">
/* 所有的jq语句 需放在 $(function (){});中*/
	$(function (){
		major();
		$("#add").unbind("click").click(function(){
			showMajorTable();
		});
		/* 显示表格  */
		function showMajorTable() {
				$('#kuang').modal('show');
				$("#add_but").unbind("click").click(function(){
					var majorno=$("#major_no").val();
					var majorna=$("#major_name").val();
					if(majorno==null||majorna==null){
						alert("输入的值不合理");
					}else if(majorno.length!=6||majorna.length!=4){
						alert("专业代码有误，请重新输入");
					}
					$.ajax({
						url:"do?invoke=mymajor@insetdb_add",
						type:'POST',
						dataType:'json',
						data:{
							reqmajorno:majorno,
							reqmajorna:majorna
						},
						success:function(rep){
							console.log(rep);
							if(rep.result==0){
								alert("插入没成功");
								return;
							}else{
							    $("#tablepane").empty();
								major();
							}
						}
						
					});	
				});
				
		}
		
		function major(){
			$.ajax({
				url:"do?invoke=mymajor@getbase_major",
				type:'POST',
				dataType:'json',
				success:function(rep){
					/* 打印rep传入的元素  */
					console.log(rep);
					if(rep.result==0){
						$.alert("对不起，你没取得与专业相关的内容");
						return;
						$('#tablepane').hide();
						$('#tablepane tr:gt(0)').remove(); 
					}else{
						var table=rep.data;
						var content=[];//
						for(var i=0;i<table.length;i++){
							content[i]={title:table[i].major_name,price:table[i].major_no};//
							var dom =
								'<tr id="major'+table[i].major_no+table[i].major_name+'">'+
									'<td >'+table[i].major_no+'</td>'+					 
									'<td >'+table[i].major_name+'</td>'+'<td>' +
									'<div class="delete circular mini ui red trash basic icon button" major_no="'+table[i].major_no+'" major_name="' +table[i].major_name+'"'+
									'>' +
									'<i class="trash red large icon"></i>' +
									'</div>' +
									'</td>' +
								'</tr>';
							$("#tablepane").append($(dom));
						}
						$('.ui.search').search(
								{source: content,
									maxResults:10000,   
									 searchFields   : [
									                   'title',
									                   'price'
									                 ],
									 onSelect:function(content,response){ 
										 
									    	$('#tablepane').empty();//表格清空
									    	//放入查詢結果
										 var dom =
												'<tr id="major'+content.price+ content.title+'">'+
													'<td >'+content.price+'</td>'+					 
													'<td >'+content.title+'</td>'+'<td>' +
													'<div class="delete circular mini ui red trash basic icon button" major_no="'+content.price+'" major_name="' +content.title+'"'+
													'>' +
													'<i class="trash red large icon"></i>' +
													'</div>' +
													'</td>' +
												'</tr>';
										 $('#tablepane').append($(dom));
										 
										 $('.delete').unbind('click').click(function(){
												var major_no=$(this).attr("major_no");
												var major_na=$(this).attr("major_name");
												loaddelete(major_no,major_na);	
												
											});
									    }
									}
								);//初始化搜索
						
						$('.delete').unbind('click').click(function(){
							var major_no=$(this).attr("major_no");
							var major_na=$(this).attr("major_name");
							loaddelete(major_no,major_na);	
							
						});
					}
				}
			});
		}
		
		function loaddelete(major_no,major_na) { //改变每个标准的状态
			$.ajax({
				url: "do?invoke=mymajor@loaddelete",
				type: 'POST',
				dataType: 'json',
				data: {
					major_no: major_no,
					major_na:major_na
				},
				success: function(rep) {
					if(rep.result==0){
						$.alert("删除失败");
					}else{
						$.alert
						$('#major'+major_no+major_na+'').remove();
					}
					
				}
			});
		}
	});
</script>
<!--这里引用其他JS-->
</html>