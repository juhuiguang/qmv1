<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <title>我的课程</title>
	<%@ include file="../common/header.jsp" %>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <style type="text/css">
    	.header{height:0.9138rem;}
    	#headSpan{
    	font-weight:700;
    	font-size:20px;
    	}
    	.fa-table{
    	position:relative;
    	top:2px;
    	margin-left:2%;
    	}
    	.main.dragloader .wrapper{
    	min-height:0px;
    	}
    	
    	#courses{
    		width:100%;
    		list-style:none;
    		padding:0;
    	}
    	
    	#courses li:first-child{
    		border-top:#e1e1e1 solid 2px;
    	}
    	
    	#courses li{
    		border-bottom:#e1e1e1 solid 2px;
    	}
    	
    	#courses .course_name{
    		font-weight:500;
    		color:#000;
    		overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
    		
    	}
    	
    	#courses .course_teacher{
    		color:#d3d3d3;
    	}
    	
    	#courses .course_info{
    		width:75%;
    		float:left;
    		min-height:60px;
    		border-right:#eaeaea 1px solid;
    		padding:10px;
    		
    	}
    	
    	#courses .rightdiv{
    		width:25%;
    		float:right;
    		background-color:#f6f6f6;
    		min-height:60px;
    		border-left:#eaeaea 1px solid;
    		padding:2px;
    	}
    	
    	.clear{
    		clear:both;
    	}
    	
    	#courses .button,.button{
         width:60%;
    		background-color:#e3e3e3;
    		/* float:left; */
    		margin-top:5px;
    		text-align:center;
    		border-radius:25px;
    		color:#fff;
    		font-size:110%;
    	   /*  margin-left:10px; */
    		opacity:1;
    	}
    	.change{
    	margin-top:0px;
    	     padding:5px;
    	     width:25%;
    	     margin-right:3%;
    		/*  margin-top:-5px;  */
    	}
    	
    	.green{
    		background-color:#43b930;	
    	}
    	#courses .button.green{
    		background-color:#43b930;	
    	}
    	
    	#courses .button.red{
    		background-color:#bd2d30;	
    	}
    	.col-4{
    	width:50%;
    	}
    	.hide{
    	display:none;
    	}
    	.spanleft{
    	margin-top:5px;
    	margin-left:3%;
    	}
    	.grey{
    	background-color:#CACBCD
    	}
    	#hiddenButton{
    	   float:right;
    	}
    	.col-4.check1{
    	    border-right:1px solid white
    	}
    </style>
</head>
<body>
	<div class="header" id="header">
	<i class="fa fa-2x fa-table"></i>
    	<span id="headSpan">我的课程</span>
    </div>
    
   	<div class="main dragloader" style="top:53px;top:0.9138rem;">
   		<div class="wrapper clearfix tab-content tab-checked" id="All">
    <span class="spanleft" id="class_name">
    </span>
    
     <span class="spanleft" id="time">
    </span>


    <div class="change button" id="hiddenButton">未评课程</div>
   			<ul id="courses">
   			</ul>
   		</div>
   		
		<div class="wrapper clearfix tab-content" id="Qy"></div>
	</div>
	<div class="footer">
		<div class="row tabs" style="">
			<div class="col-4 tab  flex-center tab-checked check1" content="#All">
				<div>
					<div class="size12 txt">全部课程</div>
				</div>
			</div>
			<div class="col-4 tab flex-center check2" content="#Qy">
				<div>
					<div class="size12 txt">查看考勤</div>
				</div>
			</div>
		</div>
    </div>
    <script type="text/javascript">
    $(function(){
    	var stu_no = USEROBJECT.loginname;
    	var term_no = SYSOBJCET.term_no;
    	var class_no =USEROBJECT.userinfo.class_no
    	
     	 loadCourse(); 
    	 function loadCourse(){
    			$.ajax({
					url:"do?invoke=studentKcb@getMoblieInfo",
					type:'POST',
					dataType:'json',
					data:{
						class_no:class_no,
						stu_no:stu_no,
						term_no:term_no
					},
					success:function(rep){
						if(rep.result==0){
							if(rep.message=="数据为空"){
								return;
							}else{
								
							$.alert("数据异常");
							return;
							}
						}
						var date = rep.data;
					/* 	var sumCheck = 0; */
						for(var i=0;i<date.length;i++){
							if(date[i].checktime=="" || date[i].checktime==null){
								date[i].checktime=0;
							}
							/* sumCheck+=parseInt(date[i].checktime); */
							var dom = '<li class="course animated">'+
						   					'<div class="course_info">'+
					   							'<div class="course_name">'+date[i].course_name+'</div>'+
					   							'<div class="course_teacher">'+date[i].teacher_name+'</div>'+
				   							'</div>'+
						   					'<div class="rightdiv">'+
						   					'<center>';
						   					if(date[i].total==""){
						   						dom+='<div class="btn_pj button grey "task_no="'+date[i].task_no+'" flag="0">评教</div>';
						   					}else{
						   						dom+='<div class="btn_pj button green" task_no="'+date[i].task_no+'" flag="1">'+date[i].total+'</div>';
						   					}
						   					if(date[i].checkTime==""||date[i].checkTime==null){
						   						dom+='<div class="btn_kq button green" task_no="'+date[i].task_no+'" teacher_name="'+date[i].teacher_name+'" course_name="'+date[i].course_name+'"">全勤</div>';
						   					}else{
						   						dom+='<div class="btn_kq button red" task_no="'+date[i].task_no+'" teacher_name="'+date[i].teacher_name+'" course_name="'+date[i].course_name+'"">缺勤</div>';
						   					}
						   					dom+='</center>';
						   						dom+='<div class="clear"></div>'+
						   					'</div>'+
				   							'<div class="clear"></div>'+
			   							'</li>';
										$('#courses').append(dom);
							}
						$("#class_name").text(USEROBJECT.userinfo.class_name);
						$('#time').text("第"+SYSOBJCET.currentweek+"周");
						$("#courses .button").each(function(){
				    		$(this).height($(this).width());
				    		$(this).css('line-height',$(this).height()+"px");
				    		$(this).css('border-radius',($(this).height()/2)+'px');
				    	});
						$('.btn_kq').hide();
						checkClick();
						buttonClick();
					}
    		});
    	 }
    	 function buttonClick(){
    		  $('.btn_pj').unbind('click').click(function(){
    			  $(this).animate({opacity:"0.6"},10);
    			  $(this).animate({opacity:"1"},50);
    			  $('.btn_pj').unbind('click')
    			  var task_no=$(this).attr('task_no');
    			  var flag=$(this).attr('flag');
    			  location.href=BASE_PATH+"/mobile/student/stu_pj.jsp?task_no="+task_no+"&flag="+flag+""
    			  setTimeout(function(){
    				  buttonClick();
    			  },100)
    		  })
    		   $('.btn_kq').unbind('click').click(function(){
    			  $(this).animate({opacity:"0.6"},10);
    			  $(this).animate({opacity:"1"},50);
    			  $('.btn_kq').unbind('click')
    			  var task_no = $(this).attr('task_no');
    			  var teacher_name =  $(this).attr('teacher_name')
    			  var course_name = $(this).attr('course_name')
    			    location.href=BASE_PATH+"/mobile/student/stu_kq.jsp?task_no="+task_no+"&teacher_name="+encodeURIComponent(teacher_name)+"&course_name="+encodeURIComponent(course_name)+""
    			  setTimeout(function(){
    				  buttonClick();
    			  },100)
    		  })
    	 }
    	 function checkClick(){
    		 $('.col-4').unbind('click').click(function(){
    			 $('.change').removeClass('green');
    			if($(this).find('.size12').text()=="全部课程"){
    				$('.change').fadeIn();
    					  $('.col-4').removeClass('tab-checked');
    		    		  $(this).addClass('tab-checked');
	    					 $('.btn_pj.green').parent().parent().parent().fadeIn();
    		    		  $('.btn_kq').fadeOut(); 
	    				  $('.col-4').unbind('click');
	    				  setTimeout(function(){
    					   $('.btn_pj').fadeIn(); 
    					   
    					  checkClick();
    				    }, 400);
    			}else{
    				$('.change').fadeOut();
    				 $('.col-4').removeClass('tab-checked');
        			 $(this).addClass('tab-checked');
        			 $('.btn_pj.green').parent().parent().parent().fadeIn();
        			  $('.btn_pj').fadeOut(); 
        			 $('.col-4').unbind('click');
  			  setTimeout(function(){
  				 $('.btn_kq').fadeIn();
  				 checkClick();
			    }, 400);
    				 
    			}
    			
    		 })
    		 $('.change').unbind('click').click(function(){
    			 $('.col-4').removeClass('tab-checked');
    			 $('.change').removeClass('green');
    			 $('.change').addClass('green');
    			 $('.btn_pj.green').parent().parent().parent().fadeOut();
    			 $('.change').unbind('click');
    			 setTimeout(function(){
      				 checkClick();
    			 },300);
    		 });
    	 }
    });
    


    </script>
</body>
</html>