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
.ui.container.segment .button{ 
	margin-top:10px; 
	margin-right:10px;
} 
.ui.divider{
	 width:80%; 
 	 margin-left:10%;
 	 margin-top:30px;
  	 margin-bottom:30px;
 } 
.ui.segment >i{ 
 margin-left:10%; 
}

.ui.right.labeled.left.icon.input{
 margin-left:35%;
 width:20%;
}
li{
margin-bottom:30px;
}
.ui.piled.segment{
margin-top:15px;
}

.grandMax
{
display:none;
}
#tableinfo{
width：90%;
margin-left:5%; 
}
.ui.ribbon.label{
cursor:pointer;
}
.vk.button{
width:20%; 
}
#icon
{
margin-left:0px;
margin-right:5px;
}

</style>    
</head>   
<body>
<%@ include file="/commonjsp/header.jsp"%>
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
String kcb = null;
if (request.getParameter("kcb") != null) {
	kcb = (String) request.getParameter("kcb");                             
}
%>

	<!--这里绘制页面-->
	<div id="container" class="ui container">		
		<h3  class="ui header ">  
  			<i class="tasks icon small"></i> 
  			<div class="content">课 程 信 息 </div> 
		</h3>
		 
		 <div class="ui horizontal segments">
  			<div class="ui segment">
  			<i id="icon" class="sort numeric ascending large icon"></i>
   				 课程编号：
   				 <lable id="kcbh"></lable>	 
 			 </div>
 			 <div class="ui segment">
 			  <i id="icon" class="file text outline large icon"></i>
   				 课程名称:
   				 <lable id="kcmc"></lable>	 
 			 </div>
  			<div  class="ui segment">
  			<i id="icon" class="building large outline icon"></i>
  				  承担院系：
  				 <lable id="cdyx"></lable>	 
  			</div>
		</div>
		
		<div class="ui horizontal segments ">
  			<div class="ui segment">
  			<i id="icon" class="user large icon"></i>
   				 任课教师：
   				<lable id="rkjs"></lable>	 
 			 </div>
 		
 			 <div class="ui segment">
 			 <i id="icon" class="wait large icon"></i>
   				 评教时间：
   				 <lable id="pjsj"></lable> 	 
 			 </div>
		</div>
		<h4 class="ui horizontal divider header blue "><i class="tag icon"></i> 填写评教信息 </h4>
		<ul id="tableinfo">
			
			<li>
				<div class="ui container">
					<div class="ui form">
						 <div class="field">
						 <div class="ui blue ribbon label" id="aaa">教学评价</div>
						  <textarea id="txtjxpj"  rows="3"></textarea>
						  </div>
						  
						  <div class="field">
						   <div class="ui blue ribbon label">教学建议</div>
					   	 <textarea id="txtjxjy" rows="3"></textarea>
					  </div>
					</div>
				</div>
			</li>
			
		</ul>
		<div class="ui container center aligned">
			<button class="ui vk blue button" id="btnsubmit"><i class="checkmark icon"></i> 提 &nbsp;&nbsp;交 </button>
		</div>
	</div>
</body>
<script src="script/common/alert/jquery.alert.js" type="text/javascript"></script>

<script>
	$(function(){
		var class_No='<%=task_no%>';
		var status_='<%=status%>';
		var kcb='<%=kcb%>';     
		 
		var SYSOBJCET=<%=SYSOBJCET%>;   
		var USEROBJECT=<%=USEROBJECT%>; 
		var term_no=SYSOBJCET.term_no;  
		var currentweek=SYSOBJCET.currentweek;    
		var student_no=USEROBJECT.loginname;//学生学号    
		
	 
		loadtable();
		
		function loadtable(){
			
			
			$.ajax({
				url:"do?invoke=studentComment@getStuCommentInf",
				type:'POST',
				dataType:'json', 
				data:{
					class_no:class_No,
					term_no:term_no,
				},
				success:function(rep){
					if(rep.result==0){
						
						$.alert({
							msg  : "对不起，评教系统暂未开放",
							type : 'info',
							btnText : '我知道啦',
							callback: function(){  
								if(kcb=='1'){ 
									location.href=BASE_PATH+'/qm/student/stu_kcb.jsp?module=14&menu=43';
								}else{  
									location.href=BASE_PATH+'/qm/student/stu_view.jsp?module=14&menu=44';
								}
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
						
						if(parseInt(currentweek)>=parseInt(weekstar))
						{	 
						}
						else{
							  console.log(currentweek); 
							  console.log(weekstar);
							  console.log(weekend);
							$.alert({
								msg  : "对不起，该课程评教暂未开放",
								type : 'info',
								btnText : '我知道啦',
								callback: function(){ 
									if(kcb=='1'){ 
										location.href=BASE_PATH+'/qm/student/stu_kcb.jsp?module=14&menu=43';
									}else{  
										location.href=BASE_PATH+'/qm/student/stu_view.jsp?module=14&menu=44';
									}
								}
							});
						}
						
						
						$("#kcbh").text(infro[0].course_no);
						$("#kcmc").text(infro[0].course_name);
			 			$("#cdyx").text(infro[0].dep_name);
						$("#rkjs").text(infro[0].teacher_name); 
						$("#pjsj").text(infro[0].nowdate); 
					}
				}
			}); 

			$.ajax({
					url:"do?invoke=studentComment@getStuCommentTable",
					type:'POST',
					dataType:'json',
					data:{
						flag:'PJ_PJ',
					},
					success:function(rep){
						if(rep.result==0){
							  
							$.alert("",rep.message);
						}else{
							
							var table=rep.data;
								for(var i=table.length-1;i>=0;i--)  
								{
										var dom='<li class="liclass" fieldname="'+table[i].rule_field+'">'+
											'<div class="ui blue left ribbon label" data-content='+table[i].rule_content+'  >'+
												(i+1)+'、'+table[i].rule_title+'('+table[i].rule_goal+')'+
										 	'</div>'+
											'<div class="ui piled segment" >'+
												'<b>请 您 打 分：</b>&nbsp; &nbsp;&nbsp; &nbsp;'+
												'<div class="ui huge star rating " ></div>'+
												'<div class="grandMax">'+table[i].rule_goal+'</div>'+
												'<div class="ui right labeled left icon input">'+
												  '<i class="tags icon"></i>'+
												  '<input type="text" class="manInput" id="commentscore'+i+'" placeholder="手动输入...">'+
												 ' <a class="ui tag blue label">得 分</a>'+ 
												'</div>'+
											'</div>'+ 
										'</li>';
									$("#tableinfo").prepend($(dom));
					
								}
								if(parseInt(status_)!=0)
								{
									$.ajax({ 
										url:"do?invoke=studentComment@getStuCommentResult",
										type:'POST',
										dataType:'json', 
										data:{
											student_no:student_no,
											Class_no:class_No,
										},
										success:function(re){
											if(re.result==0){
												$.alert("",re.message); 
											}else{
												console.log(re); 
												var result=re.data;  
												for(var i=0;i<table.length;i++){      
													$('#commentscore'+i+'').val(result[0]["per1"+(i+1)]);   
													var grandMax=parseInt($('#commentscore'+i+'').parent().prev().text());
													var result_;
													if(result[0]["per1"+(i+1)]/(grandMax/5)==parseInt(result[0]["per1"+(i+1)]/(grandMax/5)))
														{
															result_=result[0]["per1"+(i+1)]/(grandMax/5);
														}
													else{
														result_=parseInt(result[0]["per1"+(i+1)]/(grandMax/5))+1;
													} 
													$('#commentscore'+i+'').parent().prevAll('.ui.huge.star.rating').rating('set rating',result_);
												}
														
												$("#txtjxpj").val(result[0].jxpj);
												$("#txtjxjy").val(result[0].jxjy);
											}
										}
									});
							}
						
						
						$('.ui.ribbon.label') //初始化泡泡框
						  .popup({
						  }); 
						
						$('.manInput').blur(function(){  //控制input框
							var grand=parseInt($(this).val());
							var grandMax=parseInt($(this).parent().prev().text());
						
							  
							if(grand>=0)
								{
									if(grand>=grandMax)
										{
											$(this).val(grandMax);
											$(this).parent().prevAll('.ui.huge.star.rating').rating('set rating',5);
										}
									else{
										var result;
										if(grand/(grandMax/5)==parseInt(grand/(grandMax/5)))
											{
												result=grand/(grandMax/5);
											}
										else{
											result=parseInt(grand/(grandMax/5))+1;
										}
										$(this).val(grand);
										$(this).parent().prevAll('.ui.huge.star.rating').rating('set rating',result);
									}
								}
							else
								{
									$(this).val("");
								}
						});
						$('.ui.rating') //评分星
						 .rating({  
						  maxRating: 5,
					     initialRating:0,
			
					     onRate:function(value){
					    	 var grandMax=parseInt($(this).next().text());
					    	 var grand=grandMax/5*value;
					    	if(grand!=0)
								  $(this).mousemove(function(){
									 $(this).nextAll('.ui.right.labeled.left.icon.input').find('.manInput').val(grand);
							})
					     }
				    });
					}
				}
			});	
			
		}
		
		
		function postFormData(){
			var o={
					stu_no:"",
					task_no:"",
					fields:"",
					total:0,
					jxpj:"",
					jxjy:"",
					status:""
				};
			
			var items=$(".liclass");
			for(var i=0;i<items.length;i++){

				var rowfield= $(items[i]).attr("fieldname");
					 var rowfield=  $(items[i]).attr("fieldname");
						if(o.fields=="")
						{
							o.fields+=rowfield;
						}
						else
						{
							o.fields+=","+rowfield;
						}
						var Da=$('#commentscore'+i+'').val();
						if(Da>0)
							{
							}
						else
							{
								Da=0;
							}
					 o[rowfield]=parseInt(Da);
					 o.total+=parseInt(Da);
			}
			o.stu_no=student_no;
			o.task_no=class_No;
			o.jxpj=$('#txtjxpj').val();
			o.jxjy=$('#txtjxjy').val();
			o.status=status_;
	
			
			if(o.jxpj==""||o.jxjy==""){
				$.confirm({
					msg       :"您没有填写听课评价或教学建议，确认给该老师评 <b>"+o.total+"</b> 分吗？",
					btnSure   : '确认提交 ',
					btnCancel : '继续填写',
					sureDo	  : function(){
						postdata(o);

					},
					cancelDo:function(){
						$("#btnsubmit").removeClass("loading");
					}
				});
				return ;
			}else{
				$.confirm({
					msg       :"您确定要给该老师评 "+o.total+" 分吗？",
					btnSure   : '确认提交 ',
					btnCancel : '重新填写',
					sureDo	  : function(){
						postdata(o);
					
					},
					cancelDo:function(){
						$("#btnsubmit").removeClass("loading");
						
					}
				});
			}
		}
		function postdata(o){
			$.ajax({
				url:"do?invoke=studentComment@postComment",
				type:'POST',
				dataType:'json',
				data:o,
				success:function(rep){
					$.alert({
						
							msg  : rep.message,
							type : 'info',
							btnText : '我知道啦',
							callback: function(){
								if(kcb=='1'){ 
									location.href=BASE_PATH+'/qm/student/stu_kcb.jsp?module=14&menu=43';
								}else{  
									location.href=BASE_PATH+'/qm/student/stu_view.jsp?module=14&menu=44';
								}
								 
							}
						});
					$("#btnsubmit").removeClass("loading");
					
					
				
				}
			});SS
		}
	
		$("#btnsubmit").click(function(){
			
			if($(this).hasClass("loading"))return;
			$("#btnsubmit").addClass("loading");
			postFormData();	
				
		});
	});


</script>
<!--这里引用其他JS-->
</html>