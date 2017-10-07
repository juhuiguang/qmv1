<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>

<!--这里引用其他样式-->

<style>
#addform{
	display:none;
}
.nodata{
	display:none;
}
</style>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
		<h3 class="ui header">我的常用语</h3>
		<div class="ui  segment" id="mycontent">
				<button class="ui blue button" id="btnadd">添加一条</button>
				<div class="ui segment" id="addform">
					<form class="ui form" >
						<div class="field">
						    <label>常用语</label>
						    <textarea name="content" rows=3 id="inputcontent" placeholder="请输入常用语" ></textarea>
						  </div>
						  <div class="field">
						    <label>常用语类型</label>
							<div class="ui buttons">
						        <div class="ui icon button blue btntype"><i class="checkmark icon"></i>听课评价</div>
						        <div class="or"></div>
						    	<div class="ui icon button  btntype">教学建议</div>
	      					</div>
						  </div>
						  <div class="field" style="text-align:right;">
						  	<div id="btnaddsubmit" class="ui button green">提交</div>
						  </div>
					</form>
					<a class="ui yellow right corner label" id="closeadd">
				        <i class="delete icon"></i>
				      </a>
				</div>
				
				
				<div class="ui message error nodata">您还没有添加常用语，请点击添加一条，进行常用语设置。</div>
				
		</div>
	</div>	
</body>
<script>
	$(function() {
		$(".btntype").click(function(){
			$(".btntype i").remove();
			$(".btntype.blue").removeClass("blue");
			$(this).prepend($('<i class="checkmark icon"></i>')).addClass("blue");
		});
		$("#btnadd").click(function(){
			showForm();
		});
		$("#closeadd").click(function(){
			$("#addform").fadeOut();
		});
		
		$("#mycontent").on("click",".delcontent",function(){
			var content=$(this).parent();
			$.confirm({
				msg       :"您确定要删除这一句常用语吗？",
				btnSure   : '我要删除 ',
				btnCancel : '点错了',
				sureDo	  : function(){
					removeContent(content);
				},
				cancelDo:function(){
					
				}
			});
		});
		$("#mycontent").bind("DOMNodeRemoved", function () { 
			if($("#mycontent .contentitem").length<=1){
				$(".nodata").show();
			}
		});
		$("#mycontent").bind("DOMNodeInserted", function () { 
			if($("#mycontent .contentitem").length>0){
				$(".nodata").hide();
			}
		});
		$("#btnaddsubmit").click(function(){
			var content=$("#inputcontent").val();
			var type=$("#mycontent .btntype.blue").text();
			if(content==""){
				$.alert("您还没有输入常用语。");
			}else{
				saveContent(content,type);
			}
		});
		
		getConfig(function(data){
			for(var i=0;i<data.length;i++){
				var contentdiv='<div class="ui message contentitem" id="'+data[i].config_no+'">'+
					'<div class="ui green horizontal label">'+data[i].config_type+'</div>'+
					data[i].content+
					'<a class="ui red right corner label delcontent" >'+
				        '<i class="delete icon"></i>'+
				      '</a>'+
				'</div>';
				$("#mycontent").append($(contentdiv));
			}
		});
		
		function getConfig(callback){
			$.ajax({
				url: 'do?invoke=SupConfigAction@getConfig',
				dataType:"JSON",
				type:"POST",
				data:{
					master_no:USEROBJECT.userinfo.teacher_no
				},
				success:function(rep){
					if(rep.result>0){
						if(callback)callback(rep.data);
					}else{
						$(".nodata").show();
					}
				}
			});
		}
		
		function showForm(){
			if($("#addform").is(":hidden")){
				$("#addform").fadeIn();
				$("#addform textarea").val("");
			}else{
				return;
			}
		}	
		
		function saveContent(content,type){
			$.ajax({
				url: 'do?invoke=SupConfigAction@AddConfig',
				dataType:"JSON",
				type:"POST",
				data:{
					content:content,
					type:type,
					master_no:USEROBJECT.userinfo.teacher_no
				},
				success:function(rep){
					if(rep.result>0){
						var contentdiv='<div class="ui message contentitem" id="'+rep.message+'">'+
							'<div class="ui green horizontal label">'+type+'</div>'+
							content+
							'<a class="ui red right corner label delcontent" >'+
						        '<i class="delete icon"></i>'+
						      '</a>'+
						'</div>';
						$("#mycontent").append($(contentdiv));
					}else{
						$.alert("添加失败了，请重新添加。");
					}
				}
			});
			
		}
		
		function removeContent(content){
			$.ajax({
				url: 'do?invoke=SupConfigAction@removeConfig',
				dataType:"JSON",
				type:"POST",
				data:{
					configid:content.attr("id"),
					master_no:USEROBJECT.userinfo.teacher_no
				},
				success:function(rep){
					if(rep.result>0){
						content.remove();
					}else{
						$.alert("删除失败了，请重新删除。")
					}
				}
			});
			
		}
	});
</script>
<!--这里引用其他JS-->
</html>