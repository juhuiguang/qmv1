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


.ui.fluid.selection.dropdown{ 
width:30%;
margin-left:70%;
}
#grbtkjl{  
float:left;
}
.ui.blue.striped.table{ 
width:100%;  
}  

</style>    
</head>   
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container" >
		<div class="ui segment">
	    <h3 class="ui header" id='grbtkjl'> 
		  <i class="tasks icon"></i>
		  <div class="content">学生评教情况 </div>   
		</h3> 
	   	   
		
		<div class="ui fluid selection dropdown"  > 
		  <i class="dropdown icon"></i> 
		  <span class="default text">请先选择课程</span> 
		  <div class="menu infro">
		   
		  </div>  
		</div> 
		</div> 
		
		<table class="ui blue striped table">
		 <tbody>
		    <tr>	      
		      <td>课程名称</td> 
		      <td>评教班级</td>  
		      <td>班级人数</td>
		      <td>已评人数</td>
		      <td>查看详情</td> 
		    </tr>
		  

		  </tbody> 
		</table> 
		<div class="ui  modal long"> 
		  <i class="close icon"></i> 
		  <div class="header">  
		  <i class="unordered list icon"></i>
		   	学生评价与建议 
		  </div>  
		  <div class="content pbl">
		  
		    <div class="ui four cards"> 
		    
		    </div>
		    
		  </div> 
		</div>    
		
	</div>
	<!--这里绘制页面-->
</body> 
<script>  
	$(function() { 
		var SYSOBJCET=<%=SYSOBJCET%>;  
		var USEROBJECT=<%=USEROBJECT%>;  
		var term_no=SYSOBJCET.term_no;
		var tea_no=USEROBJECT.loginname; 
		
		
		loadDropdown(tea_no);  //初始化下拉框和当前学期信息  
		
		function loadDropdown(tea_no){   //提取学期   
			
			$.ajax({
				url:"do?invoke=teacherViewCheck@getTermInf", 
				type:'POST',  
				dataType:'json',  
				success:function(rep){ 			 	  
						console.log(rep);  
						var termInf=rep.data;
						for(var i=0;i<termInf.length;i++) 
							{
								var dom='<div class="item termInf" name="'+termInf[i].term_no+'">'+
										termInf[i].term_name +
				  			  			'</div>';
				  					$(".menu.infro").append($(dom)); 
									if(parseInt(termInf[i].term_status)==1){ 
										loadtable(termInf[i].term_no ,tea_no);
										$(".default.text").text(termInf[i].term_name);
									}	 					
							}  
						 
							$('.ui.dropdown') 
						  	.dropdown();   
							
							$(".termInf").click(function(){  //更换学期 
								$('.listenInf').remove();   
							
								var term_No=$(this).attr("name");   
								loadtable(term_No,tea_no); 
							})	
							
				} 
			}); 
		} 
		function loadtable(term_no,tea_no){			//点击学期刷新表单学期  
			$.ajax({
				url:"do?invoke=teacherViewCheck@getTableInf",  
				type:'POST',  
				dataType:'json',
				data:{
					term_no:term_no, 
					tea_no:tea_no, 
				},
				success:function(rep){ 		 	  	  
						console.log(rep);  
						var tableInf=rep.data;   
						for(var j=0;j<tableInf.length;j++)
							{    
							var table='<tr class="listenInf" name="'+tableInf[j].task_no+'">'+    
						     	 '<td>'+tableInf[j].course_name+'</td>'+ 
						      	'<td>'+tableInf[j].class_name+'</td>'+ 
						     	 '<td>'+tableInf[j].class_stu_amount+'</td>'+     
						     	 '<td>'+tableInf[j].class_stu_check+'</td>' +  
						     	 '<td >'+ 
						     	 '<div class="btnfirst circular ui small blue basic icon button"  >'+
		                     		'<i class="file text icon"></i>'+
			                 	'</div>'+   
						   	   '</td>' +      
						   	 '</tr>';
						    $('.ui.blue.striped.table').append($(table));
							}   
						
						$('.btnfirst.circular.ui').click(function(){ //点击查看详情        
							$(".ui.four.cards").empty();//清空弹出层  
							var task_no=$(this).parents(".listenInf").attr("name");
							loadDetail(task_no);//加载弹出层 
						}) 
				}
				
				
			}); 
		}
		function loadDetail(task_no){  
			$.ajax({
					url:"do?invoke=teacherViewCheck@getTableDetail",  
					type:'POST',  
					dataType:'json',
					data:{
						task_no:task_no, 
					},
					success:function(rep){ 
						console.log(rep);  
						var stu_pj=rep.data;
						if(stu_pj.length==0) 
							{
							var dom='<h3 class="ui header">'+ 
									'暂无学生评价或者建议'+  
									'</h3>'; 
								$(".ui.four.cards").append($(dom));
							}
						for(var m=0;m<stu_pj.length;m++){
							var dom="";
							if(stu_pj[m].jxpj!="")
								{
								dom+='<a class="orange card">'+
							    		'<div class="content">'+
							    			stu_pj[m].jxpj +
							    			'</div>'+  
							 			' </a>';			
								}
							if(stu_pj[m].jxjy!="") 
								{
								dom+='<a class="teal card">'+ 
				    						'<div class="content">'+
				    						stu_pj[m].jxjy +
				    						'</div>'+
				 						' </a>'; 
								}  
						$(".ui.four.cards").append($(dom));
						} 
						
						$('.modal.long') //弹出层初始化 
						  .modal('show')    
						; 
					}
			});
		}

	});//JQ
	//--------------------------

</script>
<!--这里引用其他JS-->
</html>