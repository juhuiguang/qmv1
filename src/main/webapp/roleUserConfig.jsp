<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>
<script src="script/common/datepicker/jquery.datetimepicker.js" type="text/javascript"></script>
<link rel="stylesheet" href="script/common/datepicker/jquery.datetimepicker.css" />
<title>校内教学质量监控运行平台</title>
<style> 


 #yhlb{  
 width:100%; 
 margin-left:30px;
 } 
 #jspz{    
  width:70%;
 display:none;  
 margin-top:130px;    
 clear:both; 
 border:#dff0ff 1px solid;
 border-radius:5px;
 padding:10px;
 position:relative;
 margin-left:20px;
 }  
 #jspz .button{
 	margin:5px;
 }
 #jspztitle{
font-weight:900;   
color:#52A0DA;   
position:absolute;
left:0;
top:-20px;
 }  
.attached.segment{  
height:380px;  
} 
 
.active.item.yhlb{ 
width:14%;    
 border:none!important; 

}
.ui.user.button{
margin-top:50px;
margin-left:120px;           
width:300px;     
}
#icontitle{ 
margin-left:0;
margin-right:0;
}
.results{ 
margin-left:10%; 
overflow-y:scroll; 
height:300px;    
} 
.ui.top.attached.tabular.menu{
    box-shadow:none!important;
    border:none!important;
}
 .centerSearch{
/*    margin-left:40%;  */
 width:70%;     
 margin-top:30px; 
  margin-left:2%; 
}

  .searchPrompt{
width:210%;
max-width:500%!important;
}
.iconC{
position:relative!important;
right:30px!important;
top:19px!important;
}
.postbtn{
display:none!important;
}

.leftD{
margin-top:1%;
float:left; 
font-weight: 700;
font-size:19px;
} 
.activeed{
width:40%;

float:left;
}
#curruser{
	width:100%;
	margin-top:20px;
	display:block;
	margin-left:20px;
}
#postbtn{
	float:left;
	margin-left:40px;
}
</style>       
</head>   
<body>
<%@ include file="/commonjsp/header.jsp"%> 
	<div id="container">
	
		    <h3 class="ui header" id='yhjspz'>  
			  <i class="settings icon"></i>   
			  <div class="content">用户角色配置 </div>       
			</h3>               
			   
		 
		<div id="yhlb" style="margin-bottom:300px; ">    
		  
			  	
			  	
					<div style="margin-left:20px;" class="ui input small searchInput">
					  <input type="text" placeholder="输入工号 / 姓名">
					</div>
					<button class= "ui button blue small" id= "searchUser">搜索</button>
				<div>
				 
				
			</div>  
			<div id="curruser">
				<div class="activeed">
				</div>
				<div class="postbtn ui tj green  button" id="postbtn"><i class="send outline icon"></i>提 交 </div>
			</div>
			
			<div id="jspz"> 
				<lable id="jspztitle"> 角 色 配 置</lable> 
				<div class="" id="vertical_div"> 
				
				      
				</div>   
			</div> 
			
		</div> 
		
		
	</div> 
</body>
<script>
	$(function(){
		var judgeSubmit = 0;
		var post_user='';
		var post_role=[]; 
		load_initInf();//所有角色 
		$('#searchUser').unbind('click').click(function(){
			$('.searchInput').removeClass('error');
			if($(this).hasClass('loading')){
				return;
			}
			$(this).addClass('loading')
			var userInfo = $('.searchInput').find('input').val();
			if(userInfo == '' || userInfo == null){
				$('.searchInput').addClass('error')
				$('#searchUser').removeClass('loading')
				return;
			}
			//查询教师（成功后 去掉loadding）
			new $.getPort({
				config:{ 
					tourl:"basicdata/user/getUserByUnLn.interface", 
					userInfo:userInfo
				},
				callback:function(rep){
					if(rep.result == '0'){
						$.alert('查询教师失败')
					}else{
						//查询role信息
						drawpln(rep.data[0].user_name ,rep.data[0].user_loginname , rep.data[0].user_id)
					} 
				}
			}); 
			$('#searchUser').removeClass('loading')
		})
		function load_initInf(){  
			$.ajax({  
				url:"do?invoke=roleUserConfig@get_initInf",     
				type:'POST',
				dataType:'json',    
				success:function(rep){  
					if(rep.result==0){
						$.alert("暂无用户数据");
					}else{
						var initInf=rep.data[0];
						var button=''; 
						for(var i=0;i<initInf.tb_role.length;i++){
							button+='<div class="ui button small role" id="role'+initInf.tb_role[i].role_id+'">'+initInf.tb_role[i].role_name+'</div>';
						} 
						$('#vertical_div').append($(button));
						
					}	 
				}
			});
		}
		
		function drawpln(name , no , id){  
	 
			$('#postbtn').removeClass('postbtn');    
			judgeSubmit=0;
			$('.activeed').empty(); 
			var user='<div class="ui message user" name="'+id+'">'+name+'/'+no+'</div>';
			$('.activeed').append($(user)); 
			click_user(); 
			$('.ui.message.user').trigger('click');   
		}
		function click_user(){
			$('.user.message').unbind('click').click(function(){ //点击user
				judgeSubmit=1;
				post_role.splice(0,post_role.length);  //清空post_role 
				if($('#jspz').css("display")=='none'){
					$('#jspz').css("display","block"); 
				}
				   
				$('.ui.button.role').removeClass('active'); 
				$('.checkmark.green.icon').remove();  
				$('.user.button').removeClass("blue");
				$(this).addClass("blue"); 
				var user_id=$(this).attr("name");   
				load_identity(user_id);//初始化用户角色    
			})
		}
		function load_identity(user_id){ 		//初始化用户角色
			$.ajax({  
				url:"do?invoke=roleUserConfig@get_role",     
				type:'POST',
				dataType:'json', 
				data:{
					user_id:user_id,
				},
				success:function(rep){  
					var role_no=rep.data;
					for(var i=0;i<role_no.length;i++){  				 //添加用户角色信息
						post_role.push(role_no[i].role_id); 
						$('#role'+role_no[i].role_id+'').addClass('teal');
						var icon='<i class="checkmark green icon"></i>';  
						$('#role'+role_no[i].role_id+'').prepend($(icon));  
					}
					post_user=user_id;
					click_role();//绑定角色点击事件 
				}
			});
		}
		function click_role(){
			$('.ui.button.role').unbind().click(function(){
				var roleid=$(this).attr('id');//
				var role_id=(roleid.split("e"))[1]; 
				if($(this).hasClass("teal")){ 
					$(this).removeClass("teal");
					$(this).find('i').remove(); 
					if($.inArray(role_id,post_role)>=0){
						post_role.splice($.inArray(role_id,post_role),1); 
					}; 
					  
				}else{ 
					$(this).addClass("teal"); 
					var icon='<i class="checkmark green icon"></i>'; 
					$(this).prepend($(icon)); 
					
					post_role.push(role_id);
				}
			})
		}
		$('#postbtn').unbind('click').click(function(){//绑定提交按钮点击事件
			if($(this).hasClass("loading")){
				return;
			}
			if(judgeSubmit==0){
				$.alert("请先选择操作的用户")
				return;
			}
			if(judgeSubmit == 2){
				$.alert("请勿重复提交");
				return;
			}
			$(this).addClass("loading");
			var post_Role=post_role.join('-');
			$.ajax({
				url:"do?invoke=roleUserConfig@post_role",     
				type:'POST',
				dataType:'json', 
				data:{
					post_user:post_user,
					post_Role:post_Role 
				},
				success:function(rep){  
					$.alert("用户角色配置成功"); 
					judgeSubmit = 2;
					$('#postbtn').removeClass("loading");  
				} 
			})
		})
		
	});

</script>
<!--这里引用其他JS-->
</html> 