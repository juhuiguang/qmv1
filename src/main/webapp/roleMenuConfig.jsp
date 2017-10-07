<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<html>
<head>
<%@include file="/commonjsp/meta.jsp" %>
<link rel="stylesheet"
	href="script/common/datepicker/jquery.datetimepicker.css" />
<!--这里引用其他样式-->
<title>角色菜单配置</title>
<style>
 	#com_option li{
		margin-top:5px;
	}
	.sss{
	text-align:center
	}
    #accordion{
    margin-top:3%
    }
    #accordion{
    width:300px!important
    } 
</style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
<div id="container">
		<h3  class="ui header "> 
	  	<i class="ui unordered list icon"></i>
	  	 角色菜单配置 
	</h3>
    <div class="ui three column grid">
		  <div class="column">
		        <h3>角色列表</h3>
				<div class="ui vertical menu" id="rolemenudiv1">
		        </div>
		  </div>
		  <div class="ui styled accordion" id="accordion">
			</div>
		  
	</div> 
</div>
</body>
<script>
 	$(function(){
		var role_id='';
		$('#accordion')
		  .accordion({
		    selector: {
		      trigger: '.title .icon'
		    }
		  })
		;
		<!--这里编写页面JS代码-->
		initUserMenuData();
		loadtable();
		function initUserMenuData(){
			var url="do?invoke=roleMenuConfig@getRoleMenuData";
			$.ajax({
				url:url,
				type:'POST',
				dataType:'json',
				success:function(rep){
					$("#rolemenudiv1").children().remove();
					var headers = rep.tableHeader;
					var rows=rep.tableRows;
					var roleid=headers.indexOf("ROLE_ID");
					var rolename=headers.indexOf("ROLE_NAME");
					var rolemenuHtml = "";
					for(var i=0;i<rows.length;i++){
						if(i==0){
						}else{
							rolemenuHtml += "<a class=\"sss item\" rel=\""+rows[i][roleid]+"\">"+rows[i][rolename]+"</a>";
						} 
					}
					$("#rolemenudiv1").append(rolemenuHtml);
					$("#rolemenudiv1 a").unbind('click').click(function(obj){
						$(".judgeicon").remove();
						$("#rolemenudiv1 a").removeClass("active");
						obj.target.className = "sss active item";
						role_id=$(this).attr('rel')
						createmenu(role_id)
					}); 
				}
			});
		}
		
		//进入页面的绘制表格
		function loadtable(){
			$.ajax({
				url:"do?invoke=ROLEMENUCONFIG@loadtable",
				type:'POST',
				dataType:'json',
				success:function(rep){
					 if(rep.result==0){
				        	$.alert("数据错误")
				        }else{
				        	var temp=rep.data;
				        	for(var i=0;i<temp.length;i++){
				        		if(temp[i].menu_name2=="首页"){
				        			
				        		}
				        		else{
					        		if(temp[i].menu_type=='模块'){
					        			var dom='<div class="title" id="title'+temp[i].bmenu_id+'"><i class="dropdown icon"></i>'+temp[i].menu_name2+'</div>'+
					      			  '<div class="content" id="content'+temp[i].bmenu_id+'">'+
					      			    '<div class="mkid ui vertical menu" id="menu'+temp[i].bmenu_id+'" menu_id="'+temp[i].bmenu_id+'">'+
					      		        '</div>'+
					      			   '</div>';
					      			   $('#accordion').append(dom)
					        		}else{
					        			dom='<a class="addordelete  ui olive item"   menu_id="'+temp[i].bmenu_id+'">'+
					        			'<label class="removeicon ui negative" id="label'+temp[i].bmenu_id+'" menu_id="'+temp[i].bmenu_id+'">'+temp[i].menu_name2+'</label>'+
										'</a>';
										$('#menu'+parseInt(temp[i].amenu_id)+'').append(dom)
				        		}
				        		}
				        	}
				        }
				}
			});
		};
        //点击按钮创建表格
		function createmenu(role_id){
			$.ajax({
				url:"do?invoke=ROLEMENUCONFIG@gettableinformation",
				type:'POST',
				dataType:'json',
				data:{
					role_id:role_id
				},
				success:function(rep){
					 $(".title").removeClass("active")
					  $(".content").removeClass("active")
                   var temp=rep.data
					for(var i=0;i<temp.length;i++){
				      $('#label'+parseInt(temp[i].amenu_id)+'').html('<i class="judgeicon icon green checkmark"></i>'+temp[i].menu_name+'')
				      if($('#title'+parseInt(temp[i].menu_pid)+'').hasClass('active')){
				    	  
				      }else{
				    	  $('#title'+parseInt(temp[i].menu_pid)+'').addClass("active");
				    	  $('#content'+parseInt(temp[i].menu_pid)+'').addClass("active");
				      }
					}
			
                    $('.addordelete').unbind('click').click(function(){
						var menu_id=$(this).attr('menu_id');
                    	var menu_mkid=$($(this).parent()).attr("menu_id");
                    	if(typeof($(this).find('i').attr('class'))=='undefined')
                    		addmenutable(menu_id)
                    	else
                    	    deletemenu(menu_id,menu_mkid)
                    	
					});
				    
				}
			});
		}
		
		//删除功能模块
		function deletemenu(menu_id,menu_mkid){
			$.confirm({
				msg       :"确定要删除此功能吗？",
				btnSure   : '确定',
				btnCancel : '取消',
				sureDo	  : function(){
			$.ajax({
				url:"do?invoke=ROLEMENUCONFIG@deletemenu",
				type:'POST',
				dataType:'json',
				data:{
					role_id:role_id,
					menu_id:menu_id,
					menu_mkid:menu_mkid
				},
				success:function(rep){
			        if(rep.result==0 ||rep.message=='删除失败'){
			        	$.alert(rep.message)
			        }else{
			        	$('#label'+parseInt(menu_id)+'').find('i').remove();
			        }
				}
			});
				},
				cancelDo:function(){
					return;
				}
			});
			
		}
		
		//增加功能模块
		function addmenutable(menu_id){
			$.confirm({
				msg       :"确定添加此功能吗？",
				btnSure   : '确定',
				btnCancel : '取消',
				sureDo	  : function(){
			$.ajax({
				url:"do?invoke=ROLEMENUCONFIG@addmenu",
				type:'POST',
				dataType:'json',
				data:{
					role_id:role_id,
					menu_id:menu_id
				},
				success:function(rep){
					 if(rep.result==0 ||rep.message=='添加失败'){
				        	$.alert(rep.message)
				        }else{
				        	$('#label'+parseInt(menu_id)+'').prepend('<i class="judgeicon icon green checkmark"></i>');
				        }
				}
			});
				},
				cancelDo:function(){
					return;
				}
			});
		}
	}); 
</script>
<script type="text/javascript"
	src="script/common/datepicker/jquery.datetimepicker.js"></script>
</html>