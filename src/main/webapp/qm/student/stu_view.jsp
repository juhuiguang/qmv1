<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp" %>
<!--这里引用其他样式-->
<title>欢迎使用-首页</title>
<style>
	.circular.ui.blue.basic.icon.button{
		margin-left: 10px;
	}
	.ui.header
	{
	margin-bottom:30px;
	}
</style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container" class="ui container">
			<h3  class="ui header "> 
		  			<i class="student icon"></i>
		  			<div class="content">评教概要信息 </div>
			</h3>
		<table class="ui compact blue table" id="tablepane">
		  <thead>
		    <tr>
		      <th>评教详情</th>
		      <th>课程名称</th>
		      <th>任课教师</th>
		      <th>状态</th>
		    </tr>
		  </thead>
		  <tbody>
		    
		  </tbody>
		</table>			
	</div>
	<!--这里绘制页面-->
</body>
<script src="script/common/alert/jquery.alert.js" type="text/javascript"></script>
<script>
	 $(function() {
		var SYSOBJCET=<%=SYSOBJCET%>;  
		var USEROBJECT=<%=USEROBJECT%>;    
		loadtable();
		function loadtable() {
			$.ajax({
				url:"do?invoke=studentView@getStuViewTable",
				type:'POST',
				dataType:'json',
				data:{
					stuno:USEROBJECT.loginname,
					termno:SYSOBJECT.term_no   
				},
				success:function(rep) {
					console.log(rep); 
					if(rep.result == 0) { 
						$('#tablepane').hide(); 
						 var dom='<div class="ui green large message" id="messageinf">'+
							'<i class="announcement large inverted yellow up circular icon"></i>'+
								' 抱歉！查询不到您本学期的课程。'+   
							'</div>';  

							$('#container').append($(dom));
					} else {
						var table = rep.data;
						
						for(var i = table.length-1; i >= 0; i--) {  
							var sta=parseInt(table[i].pj_no);
							var flag=0;
							if(sta>=0) {
								flag=1;
							}
							//console.log(table[i].pj_no);
							var dom= 
									'<tr>';	
									
									if(flag == 0) {
										bj=0; 
										dom += '<td>'+																                                                              						     	      		        																																
					                                 '<a href="'+BASE_PATH+'/qm/student/stu_comment.jsp?module=14&task_no='+table[i].task_no+'&flag='+bj+'">'+				         
						      		                 '<div class="btnfirst circular mini ui blue basic icon button" id="'+table[i].task_no+'" data-content="本门课程还没评，点击我，可以去评教~">'+
									                     '<i class="edit blue icon"></i>'+ 
									                 '</div>'+ 
									                 '</a>'+
							                       '</td>';
									} else {
										bj=1; 
										dom += '<td>'+							 			 						                                                              						     	      		        																																
					                                 '<a href="'+BASE_PATH+'/qm/student/stu_comment.jsp?module=14&task_no='+table[i].task_no+'&flag='+bj+'">'+
						      		                 '<div class="btnfirst circular mini ui blue basic icon button" id="'+table[i].task_no+'" data-content="本门课程已评过，点击我，可以查看！">'+
									                     '<i class="file blue text icon"></i>'+  
									                 '</div>'+  
									                 '</a>'+
							                       '</td>';
									}
									
								      
				                       
										dom+='<td>'+table[i].course_name+'</td>';
										dom+='<td>'+table[i].teacher_name+'</td>';
								       
								       if(sta>=0) {
								    	   dom+='<td><i class="large green checkmark icon"></i>'+
	                                       '</td>'; 
	                                       
								       } else {
								    	   console.log(sta);
								    	   dom+='<td><i class="large basic grey checkmark icon"></i>'+
	                                       '</td>';  
								       }
                                     dom+='</tr>';  		
							$("#tablepane").prepend($(dom));
							$('.btnfirst').popup();
						}
						
					}
				}
			});
		}
			
	 });
</script>
<!--这里引用其他JS-->
</html>