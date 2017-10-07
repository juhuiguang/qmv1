<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <title>课程评教</title>
	<%@ include file="../common/header.jsp" %>
    <style type="text/css">
    	#header{
    		height:0.9138rem;
    	
    	}
		#commentItemArea{
			width:100%;
			
		}
		#score{
			position:absolute; 
			background:#fff;
			height:0.6rem;  
			width:23%;   
			border-radius:0.4rem; 
			top:0.15rem; 
			right:3%;  
			border:1.5px solid  #6bb6d3;
			color:#6bb6d3; 
			padding-top:0.062rem;
			text-align:center;  
			font-size:0.35rem;   
		}
    	#course_name{ 
    		padding:0.1rem 0.2rem; 
    		text-align:center;
    		position:absolute; 
    		color:#000;       
    		font-size:0.35rem;     
    		top:0.18rem;    
    		left:3%;   
    	} 
    	

		.gradediv.score{
			float:left;
			background:#E7C264;  
			padding:0.1rem;   
			text-align:center;   
			width:0.8rem;  
			heigth:0.8rem;    
			margin-top:0.1rem;
			margin-left:3%;
			border-radius:0.4rem;  
			border:1px solid  #E7C264;
			
		}
		.gradebar.middle.aligned{
			width:50%;
			float:left;
			margin-top:0.15rem;
		}

 		.repeat.item.ruleitem{ 
 			width:100%; 
 			height:0.8rem; 
 			margin-top:0.2rem;
 		}
 		.ruletitle{
 			float:left;
 			color:#000;     
 			margin-top:0.25rem; 
 			margin-left:5%;  
 			margin-right:3%;  
 		}
		.textArea{
			display:none;
			margin-left:5%;
			margin-top:0.2rem; 
			border-radius:0.1rem;   
			width:90%;
		}

    </style> 
    <link rel="stylesheet" href="mobile/common/fa/css/font-awesome.min.css"/>
    <script src="script/common/jquery/jquery.cookie.js" type="text/javascript"></script>
</head>
<body>
<%
//接收参数
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
String task_no = null;

if (request.getParameter("task_no") != null) {
	task_no = (String) request.getParameter("task_no"); 
}
String status = null;
if (request.getParameter("flag") != null) {
	status = (String) request.getParameter("flag");                             
}
%>

	<!-- fixed定位的头部 --> 
	<div class="header" id="header">
    	<div id="course_name"></div> 
    	<div id="score">加载中</div> 
    </div> 
    <!-- 可以滚动的区域 -->
   	<div class="main dragloader" style="top:53px;top:0.9138rem;"> 
   		
			<div id = "commentItemArea">
			</div> 
			<div style="margin-top:0.2rem;">
				<span class="ruletitle jxpj" ></span> 
				<textarea class="textArea jxpj" rows="4" ></textarea>
			</div> 
			<div style="margin-top:0.1rem;">    
				<span class="ruletitle jxjy" ></span> 
				<textarea class="textArea jxjy" rows="4" ></textarea> 
			</div>
		
	</div>
	<div class="footer">
		<div class="row tabs" style=""> 
			<div class="col-5 tab  flex-center" content="#All" id = "commentBack">
				<div>
					<div class="size16 txt">
					<i class="fa fa-x fa-mail-reply"></i> 
						返&nbsp;回  
					</div> 
				</div> 
			</div>     
			<div class="col-7 tab flex-center tab-checked" content="#Qy" id = "commentSubmit">
				<div>  
					<div class="size16 txt">  
					<i class="fa fa-x fa-check"></i>
					提&nbsp;交   
					</div>
				</div>
			</div> 
			 
		</div>
    </div>
    <script type="text/javascript">
    $(function(){
    	var term_no=SYSOBJCET.term_no;//term_no 
    	var task_no='<%=task_no%>';//task_no     
    	var student_no=USEROBJECT.loginname;//student_no   
    	var currentweek=SYSOBJCET.currentweek;  
    	var commentFlag='<%=status%>'; 
    	prepareLoad(); 
    	$('#commentBack').unbind('click').click(function(){
    		if($(this).hasClass('loading')){
    			return;
    		}
    		$(this).addClass('loading');
    		var date = new Date();
			var datetime = date.getTime();
    		location.href=BASE_PATH+'/mobile/student/index.jsp?time='+datetime+'';//改变跳转位置
    	}) 
    	$('#commentSubmit').unbind('click').click(function(){
    	
    		if($(this).hasClass('loading')){ 
    			return;
    		}
    		$(this).addClass('loading');
    		postComment();
    		
    	})
    	function prepareLoad(){
    		$.ajax({
				url:"do?invoke=studentComment@getStuCommentInf",
				type:'POST',
				dataType:'json', 
				data:{
					class_no:task_no,
					term_no:term_no,
				},
				success:function(rep){
					
					if(rep.result==0){
						$('#header').empty();
						$('.main.dragloader').empty();
						$('.footer').empty();
						$.alert({
							msg  : "对不起，评教系统暂未开放",
							type : 'info',
							btnText : '我知道啦',
							callback: function(){
								var date = new Date();
								var datetime = date.getTime();
									location.href=BASE_PATH+'/mobile/student/index.jsp?time='+datetime+'';//改变跳转位置 
							}
						});
					}else{
						var weekstar="";  
						var weekend="";
						var infro=rep.data;
						var weeklimit=infro[0].course_week;
						var weeksegment=weeklimit.split(",");
						for(var i=0;i<weeksegment.length;i++){
							if(i==0){
								weekstar=weeksegment[i].split("-")[0];
							}
							if(i==weeksegment.length-1){
								if(weeksegment[i].split("-").length>1){
									weekend=weeksegment[i].split("-")[1];
								}else{
									weekend=weeksegment[i].split("-")[0];
								}  
							}
							
						}
						
						if(parseInt(currentweek)<parseInt(weekstar)){	
							$('#header').empty();
							$('.main.dragloader').empty(); 
							$('.footer').empty();
								$.alert({
										msg  : "对不起，该课程暂未开始评教",
										type : 'info',
										btnText : '我知道啦',
										callback: function(){   
											var date = new Date();
											var datetime = date.getTime();
												location.href=BASE_PATH+'/mobile/student/index.jsp?time='+datetime+'';//改变跳转位置
											}
								});
						}else{
							//赋值
							var course_name = infro[0].course_name; 
							if(course_name.length > 10){  
								course_name = course_name.substring(0,10) + '..';
							}  
							$('#course_name').text(course_name);
							//读取数据
							getTable();
						}
						
							
					}
				}
			}); 

    	}
    	
    	function getTable(){
    		$.ajax({
	    		url:"do?invoke=studentComment@getTableMobile",
				type:'POST',
				dataType:'json',
				data:{
					flag:commentFlag,
					student_no:student_no, 
					task_no:task_no, 
				},
				success:function(rep){
					if(rep.result == 0){ 
						$.alert("抱歉，评教系统维护中！");
					}else{
						console.log(rep);
						var tableInfo = rep.data;
						var length = 0;
						if(commentFlag == "0"){
							length = parseInt(tableInfo.length);   
						}else{
							length = parseInt(rep.message);
						}
						var total=0; 
						for(var i = 0 ; i < length ; i++){ 
							var score ;
							if(commentFlag == "0"){
								score = parseInt(tableInfo[i].rule_goal)/2;
							}else{
								score = parseInt(tableInfo[i].rule_score);
							} 
							total+=score; 
							var dom=  
								'<div class="repeat item ruleitem" rownumber="'+i+'" fieldname="'+tableInfo[i].rule_field+'"> '+
								
						 		'<div class="ruletitle" >'+(i+1)+'.'+tableInfo[i].rule_title+'</div>'+  
						 		 
								'<input class="gradebar middle aligned" type="range" name="item'+i+'" step=1 value='+score+' min="0" max="'+parseInt(tableInfo[i].rule_goal)+'" />'+
								'<div class="gradediv score">'+score+'</div>'+
								'</div>'; 
							$('#commentItemArea').append($(dom)); 
						}
						$('#score').text(total+'分');
						
						if(total < 60){
							$('#score').css({
								"color":"#D01919",
								"border":"1px solid  #D01919"
							});
						}else if(total < 80){
							$('#score').css({
								"color":"#F26202",
								"border":"1px solid  #F26202"
							});
						}else{
							$('#score').css({
								"color":"#21ba45",
								"border":"1px solid  #21ba45"
							});
						}
						
						//动态计算margin
						$('.gradebar.middle.aligned').css('margin-top' ,($('.ruletitle').eq(0).height() / 2 + parseInt($('.ruletitle').eq(0).css("margin-top")) - $('.gradebar.middle.aligned').eq(0).height() / 2) );
						 
						 $('.textArea').show(); 
						$('.ruletitle.jxpj').text((length+1)+'.教学评价');
						$('.ruletitle.jxjy').text((length+2)+'.教学建议');
						if(commentFlag != "0"){  
							$('.textArea.jxpj').text(tableInfo[length].jxpj); 
							$('.textArea.jxjy').text(tableInfo[length+1].jxjy); 
						}
						//界面逻辑
						$(".gradebar").unbind("change").change(function(a,b,c,d){
							//$(this).next().text($(this).val());
							$(this).next(".gradediv").text($(this).val());  
							var total=0;   
							$(".gradebar").each(function(index,element){   
								total+=parseInt($(this).val());
							});
							$("#score").text(total+'分');
							if(total < 60){ 
								$('#score').css({
									"color":"#D01919",
									"border":"1px solid  #D01919"
								});
							}else if(total < 80){
								$('#score').css({
									"color":"#F26202",
									"border":"1px solid  #F26202"
								});
							}else{
								$('#score').css({
									"color":"#21ba45",
									"border":"1px solid  #21ba45"
								});
							}
						});
						
					}
				}
    		});
    	}
    	
    	function postComment(){
    		var jxjy = $('.textArea.jxjy').val();
    		var jxpj = $('.textArea.jxpj').val();
    		var per =[];
    		$(".gradebar").each(function(index , event){
    			per.push($(".gradebar").eq(index).val());
    		})
    		var perAll = "";
    		if(per.length > 0){
    			perAll = per.join('-'); 
    		}
    		$.ajax({
	    		url:"do?invoke=studentComment@postCommentMobile",
				type:'POST',
				dataType:'json',
				data:{
					task_no:task_no,
					flag:commentFlag,
					student_no:student_no,  
					jxjy:jxjy,
					jxpj:jxpj,  
					perAll:perAll
				},
				success:function(rep){
					if(rep.result == 0){
						$.alert("提交失败");
					}else{ 
						var date = new Date();
						var datetime = date.getTime(); 
							location.href=BASE_PATH+'/mobile/student/index.jsp?time='+datetime+'';//改变跳转位置
					} 
					$('.col-7.tab.flex-center.tab-checked.loading').removeClass('loading');
				}
    		});
    	}
    });
    
    </script>
</body>
</html>