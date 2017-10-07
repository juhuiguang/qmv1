<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp" %>
<!--这里引用其他样式-->
<title>欢迎使用-首页</title>
<style>
	#addPost {
		float: right;
	}
	.bq {
		display: inline-block; 
		width:auto;
	    vertical-align: baseline;  
	    font-size: .92857143em;
	    font-weight: 700;
	    color: rgba(0,0,0,.87); 
	    text-transform: none; 
	    min-width: 120px !important; 
	}
	#postname {
		width: 300px;  
	}
	#posttimes {
		width: 300px;  
	}
	#panel {
		margin-left: 180px;  
	}
	#Updpostname {
		width: 300px;  
	}
	#Updposttimes {
		width: 300px;   
	}
	#Updpanel {
		margin-left: 180px; 
	}
</style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container" class="ui container"> 
		<h3  class="ui header "> 
	  			<i class="list layout icon"></i>
	  			<div class="content">岗位管理</div>
		</h3>
		<div id="addPost"> 
			<button class="ui blue labeled icon button" id="add_post"><i class="plus icon"></i> 添加新岗位</button>
		</div>
		<table class="ui compact blue table" id="tablepane">
		  <thead>
		    <tr>
		      <th>序号</th>
		      <th>岗位名称</th>
		      <th>规定听课节次</th>
		      <th>是否计分</th>
		      <th>操作</th>
		    </tr>
		  </thead>
		  <tbody id="PostTableD">
		  	   
		  </tbody>
		</table>			
		
		<div id="AddPostMod" class="ui modal">
			  <div class="header">
			  	新添岗位信息：      
			  	<i class="close icon" style="float: right;"></i>                
			  </div>
			    <div class="content">      
				  	<div class="description">
				  		<div id="panel">
							<div class="ui form">
								<div class="inline fields">
							      <label class="bq">岗位名称：</label> 
							      <input type="text" placeholder="填写岗位名称" id="postname" value="">
								</div> 
								<div class="inline fields">  
							      <label class="bq">规定听课次数：</label>
							      <input type="text" placeholder="所需听课次数" id="posttimes" value="">
								</div>
							</div>
						
							<div class="ui form" style="margin-top: 25px !important;">
							  <div class="inline fields"> 
							      <label class="bq">是否计分：</label> 
							      <div class="field">
							        <div class="ui radio checkbox" id="truescore">
							        	<input type="radio" name="ifscore" value="1">  
							        	<label> 计分 </label>
							        </div> 
							       </div>
							       <div class="field">
							         <div class="ui radio checkbox" id="flasescore">
								        <input type="radio" name="ifscore" value="0">
								        <label> 不计分 </label>
							         </div>
							      </div> 
							   </div>
							</div>
					</div>
				</div>    
				<div class="actions">   
				    <div class="ui positive right labeled icon button" id="AddSubmit"> 提 交 <i class="checkmark icon"></i></div>
				 </div>   
			</div>
		</div>
		
		
		<div id="UpdPostMod" class="ui modal">
			  <div class="header">
			  	修改岗位信息：      
			  	<i class="close icon" style="float: right;"></i>                
			  </div>
			    <div class="content">      
				  	<div class="description">
				  		<div id="Updpanel">
							<div class="ui form">
								<div class="inline fields">
							      <label class="bq">岗位名称：</label> 
							      <input type="text" placeholder="填写岗位名称" id="Updpostname" value="">
								</div> 
								<div class="inline fields">  
							      <label class="bq">规定听课次数：</label>
							      <input type="text" placeholder="所需听课次数" id="Updposttimes" value="">
								</div>
							</div>
						
							<div class="ui form" style="margin-top: 25px !important;">
							  <div class="inline fields"> 
							      <label class="bq">是否计分：</label> 
							      <div class="field">
							        <div class="ui radio checkbox" id="Updtruescore">
							        	<input type="radio" name="Updifscore" value="1">  
							        	<label> 计分 </label>
							        </div> 
							       </div>
							       <div class="field">
							         <div class="ui radio checkbox" id="Updflasescore">
								        <input type="radio" name="Updifscore" value="0">
								        <label> 不计分 </label>
							         </div>
							      </div> 
							   </div>
							</div>
					</div>
				</div>    
				<div class="actions">   
				    <div class="ui positive right labeled icon button" id="UpdSubmit"> 提 交 <i class="checkmark icon"></i></div>
				 </div>   
			</div>
		</div>
	<!--这里绘制页面-->
	</div>
</body>
<script src="script/common/alert/jquery.alert.js" type="text/javascript"></script>
<script>
	 $(function() {
		var PostD = "";
		
		//取岗位具体数据
		readPostData();
		
		//新添岗位
		AddPostDat();
		
		function AddPostDat(){
			$("#addPost").unbind('click').click(function(){
				$("#postname").val("");
				$("#posttimes").val("");
				$("#truescore").checkbox("set checked",""); 
				$("#AddPostMod").modal({
    				transition:'slide down',
    				observeChanges:true, 
    				closable:false                
    			}).modal('show');

				$("#AddSubmit").unbind('click').click(function(){
					var post_name = $("#postname").val();
					var post_times = $("#posttimes").val();
					var status =$("input[name='ifscore'][type='radio']:checked").val(); 
					
					if(post_name == null || post_name == "") {
						$.alert("岗位名称不能为空！"); 
						
					} else if(post_times == null || post_times == "") {
						$.alert("听课次数设置不能为空！"); 
						
					} else {
						//检查听课次数输入内容格式	
						if(CheckTimes(post_times)) { 
							
							//提交保存新添岗位数据 
							savePostInfor(post_name,post_times,status);
						}
					}
					
				}); 
			});
		}
		
		function CheckTimes(posttimes) {
			var r = /^\+?[1-9][0-9]*$/;
			if(r.test(posttimes)){
				return true;
			} else { 
				$.alert("听课次数设置内容格式错误！"); 
				return false;
			}
		} 
		
		function savePostInfor(post_name,post_times,status) {
			$.ajax({
				url: "do?invoke=postSetManage@savePostData",
				type: 'POST',
				dataType: 'json',
				data:{ 
					post_name:post_name,
					post_times:post_times, 
					status:status
				},
				success: function(rep) { 
					if(rep.result == 0) {
				//		$.alert("添加新岗位失败！");
						$.alert("",rep.message);
						return; 
					} else {
						$.alert("添加新岗位成功！"); 
						$("#PostTableD").empty();
						readPostData();
					}
				} 
			});
		}
		
		function readPostData() {
			$.ajax({
				url: "do?invoke=postSetManage@getPostInfor",
				type: 'POST',
				dataType: 'json',
				success: function(rep) {
					if(rep.result == 0) {
						$.alert("岗位相关数据获取失败！");
					} else {
						console.log(rep);
						PostD = rep.data;
						//画岗位信息至页面上
						drawPostInfor();
					}
					
				}
			});
		}
		
		function drawPostInfor() {
			for(var i=0; i<PostD.length; i++){
				dom =
					'<tr>'+
						'<td>'+PostD[i].job_no+'</td>'+
						'<td>'+PostD[i].job_name+'</td>'+
						'<td>'+PostD[i].job_listen_times+'</td>'+
						'<td>';
						if(PostD[i].job_kh == 1) {
							dom +=
								  '<i class="checkmark green large icon"></i>'+ 
								'</td>';
						} else {
							dom +=
								  '<i class="remove red large icon"></i>'+  
								'</td>'; 
						} 
					dom +=
						'<td>'+ 
							'<div class="upd circular ui blue basic icon mini button" id="'+PostD[i].job_no+'" name="'+PostD[i].job_name+'" times="'+PostD[i].job_listen_times+'" status="'+PostD[i].job_kh+'">'+
		                        '<i class="edit blue large icon"></i>'+ 
			                '</div>'+
			                '<div class="del circular ui red basic icon mini button" id="'+PostD[i].job_no+'">'+ 
		                        '<i class="trash red large icon"></i>'+   
			                '</div>'+
						'</td>'+
					 '</tr>';
				$("#PostTableD").append($(dom));
			}
			$('.upd.circular').unbind('click').click(function(){
				var post_no = $(this).attr("id");
				var post_name = $(this).attr("name");
				var post_times = $(this).attr("times");
				var post_status = $(this).attr("status");
				//修改某个岗位的数据
				UpdPostData(post_no,post_name,post_times,post_status);
			});
			$('.del.circular').unbind('click').click(function(){
				var post_no = $(this).attr("id");
				//删除某个岗位的数据
				DelPostData(post_no);
			});
		}
		
		function UpdPostData(post_no,post_name,post_times,post_status) {
			$("#UpdPostMod").modal({
				transition:'slide down',
				observeChanges:true, 
				closable:false                
			}).modal('show');  
			$("#Updpostname").val(post_name);
			$("#Updposttimes").val(post_times);
			if(post_status == "1") {
				$("#Updtruescore").checkbox("set checked",""); 
			} else {
				$("#Updflasescore").checkbox("set checked",""); 
			} 
			
			$("#UpdSubmit").unbind('click').click(function(){
				var postname = $("#Updpostname").val();
				var posttimes = $("#Updposttimes").val();
				var poststatus = $("input[name='Updifscore'][type='radio']:checked").val(); 
				
				if(post_no == null || post_no == "") {
					$.alert("没有取到该岗位编号！"); 
					
				} else if(postname == null || postname == "") {
					$.alert("岗位名称不能为空！"); 
					
				} else if(posttimes == null || posttimes == "") {
					$.alert("听课次数设置不能为空！"); 
					
				} else {
					//检查听课次数输入内容格式	
					if(CheckTimes(posttimes)) {  
						
						//提交保存修改的岗位数据 
						UpdPostInfor(post_no,postname,posttimes,poststatus);
					}
				}
			});
			
		}
		
		function UpdPostInfor(post_no,postname,posttimes,poststatus) {
			$.ajax({
				url: "do?invoke=postSetManage@UpdPostSinglData", 
				type: 'POST',
				dataType: 'json',
				data:{ 
					post_no:post_no,
					post_name:postname,
					post_times:posttimes,  
					status:poststatus
				},
				success: function(rep) { 
					if(rep.result == 0) {
				    	$.alert("岗位修改失败！");
				//		$.alert("",rep.message);
						return; 
					} else {
				//		$.alert("岗位修改成功！"); 
						$("#PostTableD").empty(); 
						readPostData();
					}
				} 
			});
		} 
			
		function DelPostData(post_no) {
			if(post_no == null || post_no == "") {
				$.alert("没有取到该岗位编号！"); 
			}
			
			$.confirm({
				msg          :"您确定要删除此岗位么？",
				btnSure     :'确定',
				btnCancel  :'取消',
				sureDo       : function(){		
					$.ajax({
						url: "do?invoke=postSetManage@DelPostSinglData", 
						type: 'POST',
						dataType: 'json',
						data:{ 
							post_no:post_no
						},
						success: function(rep) { 
							if(rep.result == 0) {
								$.alert("此岗位删除失败！");
							} else {
								$('#'+post_no+'').parents('tr').remove();    

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