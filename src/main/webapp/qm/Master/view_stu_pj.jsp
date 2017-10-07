<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp" %>
<!--这里引用其他样式-->
<title>校内教学质量监控运行平台</title>


<style>

.ui.dropdown{
float:left
}
 .ui.small.circular.input{
 margin-left:2%
 }
.ui.blue.table{
margin-top:1%
}

.field{
margin-top:3%
}
#srchpnl .label{
   margin-top:5px;
}
div td{
vertical-align: middle!important;
}
.ui.blue.inverted.progress{

margin: 0!important;
}
#pjtable{
text-align:center;
} 
#wpjtable{
text-align:center;
}
.myprocess{
font-size:11px!important;
font-weight:550!important
}
.myprocess1{
font-size:12px!important;
font-weight:650!important
}
style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container" class="ui container">	
    <h3  class="ui header "> 
	  	<i class="ui  unordered list icon"></i>
	  	<div class="content" id="bt">学生评教详情 </div>
	</h3>
	<div id="srchpnl">
    </div>
		<div class= "field">
		<select class="ui mini dropdown" id="dropdown">
			</select>
		    <div class="ui small circular input" >
			  <input type="text" placeholder="搜索班级..." id="searchclass" >
		    <div class="ui small blue button " id="searchbutton" >
		    <i  class="search icon" ></i>搜索</div>
			</div>
			</div>
    	<table class="ui striped blue very compact table" id="pjtable">
		  <thead>
		    <tr>
		      <th>所属部门</th>
		      <th>班级名称</th>
		      <th>评教进度</th>
		      <th>查看详情</th>
		    </tr>
		  </thead>
		  <tbody id="classinformation">
		  </tbody>
		</table>
     
		  <div class="ui long modal">
		  <i class="close icon"></i>
		  <div class="ui header">
		        评教详情
		  </div>
		  <div class="content">		  	
				<table class="ui striped blue  very compact table" id="wpjtable">
				  <thead>
				    <tr>
				      <th>班级名称</th>
				      <th>课程名称</th>
				      <th>任课教师</th>
				      <th>应评人数</th>
				      <th>实评人数</th>
				      <th>未评人数</th>
				      <th>评教进度</th>
				    </tr>
				  </thead>
				  <tbody id="classdetails">	    
				  </tbody>
				</table>
				<div class="actions">
		              <div class="ui small blue button" id="closebutton">确定</div>
		        </div>		
		</div>
		</div>
		<div class="ui short modal">
		    <i class="close icon"></i>
		    <div class="ui header">
		                 未评教学生信息
		    </div>
		    <div class="content_wpj">		  	
				<table class="ui striped blue  very compact table">
				  <thead>
				    <tr>
				      <th>学生学号</th>
				      <th>学生姓名</th>
				    </tr>
				  </thead>
				  <tbody id="wpjstusdetails">	    
				  </tbody>
				</table>		
		</div>
	</div>
	</div>
	<!--这里绘制页面-->
</body>
<script>
$(function(){
	var departments=SYSOBJECT.departments;
	var dep_name=null;
	var dep_no=null;
	dep_no=departments[0].dep_no
	dep_name=departments[0].dep_name
	for(var i=0;i<departments.length;i++){
		if(departments[i].dep_name=="外语系"){
			
		}else{
          if(departments[i].dep_type!="行政") {
		var dep=$("<div class='ui gary label srchdep' dep_no='"+departments[i].dep_no+"'>"+departments[i].dep_name+"</div>");
		$("#srchpnl").append(dep);
}
		}
	}
	$(".srchdep:first-child").addClass('blue');
	$(".srchdep").hover(function(){
		$(this).css("cursor","pointer");
	});
	$("#closebutton").click(function(){
		$('.ui.long.modal')
		.modal({
		    transition:'fly down',
	     })
		.modal('hide');
	});
	 $("#srchpnl .srchdep").bind("click",function(){
		 $("#srchpnl .srchdep.blue").removeClass("blue");
		 $(this).addClass("blue");
	    	if(dep_no==$(this).attr("dep_no")){
	    		return ;
	    	}
	    	 $("#classinformation").html("");
	    	 dep_no=$(this).attr("dep_no")
	    	 dep_name=$(this).text();
	    	 loadtable();
	    });
	 $('#searchbutton').unbind('click').bind('click',function(){
		var class_name= $('#searchclass').val();
		if(class_name==""){
			 $("#classinformation").html("");
			 loadtable()
		}
			
			else{
				
				$.ajax({
					url:"do?invoke=view_stu_pj@getsearchinformation",
					type:'POST',
					dataType:'json',
					data:{
						dep_no:dep_no,
						class_name:class_name,
						term_no:SYSOBJECT.term_no
					},
					success:function(rep){
						if(rep.result==0){
							if(rep.message=='数据为空')
								$.alert("数据错误或没有符合的班级数据");
							else
						    $.alert("",rep.message);
						}
						else{
							
							var temp=rep.data
							$('#classinformation').html('');
							for(var i=0;i<temp.length;i++){
								
								var dom= '<tr><td >'+dep_name+'</td>'+      
									'<td>'+temp[i].class_name+'</td>';
								if((temp[i].minpxperson/temp[i].class_stu_amount)>1){
									dom+=' <td> <div class="ui blue inverted progress" data-percent="100">'+
									'<div class="bar" style=" width: 20%;">';
								    	dom+='<div class="myprocess1 progress">100%</div>'+
								    	'</div>'+
										  '</div></td>';
								    }else if(temp[i].class_stu_amount=="" || temp[i].class_stu_amount==null){
								    	dom+=' <td> <div class="ui blue inverted progress" data-percent="">'+
										'<div class="bar" style=" width: 10%;">';
									      dom+='<div class="progress">0</div>'+
									      '</div>'+
										  '</div></td>';
								    }
								else{
								    	dom+=' <td> <div class="ui blue inverted progress" data-percent="'+parseInt((temp[i].minpxperson/temp[i].class_stu_amount)*100)+'">'+
										'<div class="bar" style=" width: 10%;">';
							      dom+='<div class="myprocess1 progress">'+parseInt((temp[i].minpxperson/temp[i].class_stu_amount)*100)+'%</div>'+
							      '</div>'+
								  '</div></td>';
							      }
							   
					                   dom += '<td>'+																                                                              						     	      		        																																		         
						                 '<div class="addclick1 btnfirst circular ui mini blue basic icon button"  class_no="'+temp[i].class_no+'" data-content="查看班级评教详情">'+
						                     '<i class="ellipsis horizontal icon"></i>'+
						                 '</div>'+ 
					                   '</td></tr>';
					                   $("#classinformation").append(dom);

							}
							$('.ui.blue.inverted.progress').progress({
								showActivity:false
					});
							$('.addclick1.btnfirst.circular.ui.blue.basic.icon.button').popup();
							$('.addclick1.btnfirst.circular.ui.blue.basic.icon.button').bind('click',function(){
								var class_no=$(this).attr('class_no');
			                    $("#classdetails").html('')
								cratemodeltable(class_no);
							});
						}
					}
				});
				
			}
	 });
	 loadterm();
	    function loadterm(){
	    	$.ajax({
				url:"do?invoke=view_stu_pj@gettermnoinformation",
				type:'POST',
				dataType:'json',
				success:function(rep){
					if(rep.result==0){
					$.alert("",rep.message);
					return;
					}
					else{
						var temp=rep.data
						for(var i=0;i<temp.length;i++){
							var dom= ' <option value="'+temp[i].term_no+'">'+temp[i].term_name+'</option>';
							$("#dropdown").append(dom)
						}
						$('.ui.dropdown').dropdown();
					}
					$("#dropdown").change(function(){
						SYSOBJECT.term_no=$("#dropdown").val();
						$("#classinformation").html("");
						loadtable();
						
					});
				}
	    	});
	    };
	    loadtable();
	 function loadtable(){
		 $.ajax({
				url:"do?invoke=view_stu_pj@gettableinformation",
				type:'POST',
				dataType:'json',
				data:{
					dep_no:dep_no,
					term_no:SYSOBJECT.term_no
				},
				async: false,
				success:function(rep){
					if(rep.result==0){
						if(rep.message=='数据为空')
							$.alert("数据错误或没有符合的班级数据");
						else
					    $.alert("",rep.message);
	
					}
					else{
						console.log(1111)
						var temp=rep.data
						for(var i=0;i<temp.length;i++){
							var dom= '<tr><td >'+dep_name+'</td>'+      
								'<td>'+temp[i].class_name+'</td>';
							if((temp[i].minpxperson/temp[i].class_stu_amount)>1){
								dom+=' <td> <div class="ui blue inverted progress" data-percent="100">'+
								'<div class="bar" style=" width:20%;">';
							    	dom+='<div class="myprocess1 progress">100%</div>'+
							    	'</div>'+
									  '</div></td>';
							    }else if(temp[i].class_stu_amount=="" || temp[i].class_stu_amount==null){
							    	dom+=' <td> <div class="ui blue inverted progress" data-percent="">'+
									'<div class="bar" style=" width: 10%;">';
								      dom+='<div class="progress">0</div>'+
								      '</div>'+
									  '</div></td>';
							    }
							else{
							    	dom+=' <td> <div class="ui blue inverted progress" data-percent="'+parseInt((temp[i].minpxperson/temp[i].class_stu_amount)*100)+'">'+
									'<div class="bar" style=" width: 10%;">';
						      dom+='<div class="myprocess1 progress">'+parseInt((temp[i].minpxperson/temp[i].class_stu_amount)*100)+'%</div>'+
						      '</div>'+
							  '</div></td>';
						      }
				                   dom += '<td>'+																                                                              						     	      		        																																		         
					                 '<div class="addclick1 btnfirst circular ui mini blue basic icon button"  class_no="'+temp[i].class_no+'" data-content="查看班级评教详情">'+
					                     '<i class="ellipsis horizontal icon"></i>'+
					                 '</div>'+ 
				                   '</td></tr>';
				                   $("#classinformation").append(dom);

						}
						$('.ui.blue.inverted.progress').progress({
								showActivity:false
					});
						$('.addclick1.btnfirst.circular.ui.blue.basic.icon.button').popup();
						$('.addclick1.btnfirst.circular.ui.blue.basic.icon.button').bind('click',function(){
							var class_no=$(this).attr('class_no');
							console.log(class_no);
		                    $("#classdetails").html('')
							cratemodeltable(class_no);
		                    
						});
					}
				}
		 });
	 };
	 function cratemodeltable(class_no){
		 $.ajax({
				url:"do?invoke=view_stu_pj@getmodeltableinformation",
				type:'POST',
				dataType:'json',
				data:{
					class_no:class_no,
					term_no:SYSOBJECT.term_no,
				},
				success:function(message){
					if(message.result==0){
					$.alert("",message.message);
					}
					else{
						var temp1=message.data
						for(var i=0;i<temp1.length;i++){
							var dom='<tr><td>'+temp1[i].class_name+'</td>'+
							        '<td>'+temp1[i].course_name+'</td>'+
							        '<td>'+temp1[i].teacher_name+'</td>'+
							        '<td>'+temp1[i].class_stu_amount+'</td>';
							        if(temp1[i].totalcount=='')
							        dom+='<td>尚无人评教</td></tr>';
							        else
							        	dom+='<td>'+temp1[i].totalcount+'</td>';
							            var wpj_stus=temp1[i].class_stu_amount-temp1[i].totalcount;
							        	if(wpj_stus > 0)
								            	 dom += '<td>'+																                                                              						     	      		        																																		         
								                 '<div id="wpj_stus" class="addclick1 btnfirst circular ui blue basic  icon wpj_stus button" class_no="'+class_no+'" task_no="'+temp1[i].task_no+'" data-content="查看未评教学生信息">'+wpj_stus+
								                 '</div>'+ 
							                     '</td>';
							            else
							                     dom+='<td>0</td>';
							           if((temp1[i].totalcount/temp1[i].class_stu_amount)>1){
							            dom+=' <td> <div class="ui blue inverted progress" data-percent="100">'+
									    '<div class="bar" style=" width: 30%;">'+
								      '<div class="myprocess progress">100%</div>';
						              }else if(temp1[i].class_stu_amount==""||temp1[i].class_stu_amount==null ){
						            	  dom+=' <td> <div class="ui blue inverted progress" data-percent="">'+
										    '<div class="bar" style=" width: 10%;">'+
									      '<div class=" progress">0</div>';
						              }
							          else{
							        console.log((temp1[i].totalcount/temp1[i].class_stu_amount)*100)
						            	  dom+=' <td> <div class="ui blue inverted progress" data-percent="'+parseInt((temp1[i].totalcount/temp1[i].class_stu_amount)*100)+'">'+
										    '<div class="bar" style=" width:30%;">'+
									      '<div class="myprocess progress">'+(temp1[i].totalcount/temp1[i].class_stu_amount)*100+'%</div>';
						              }
								   dom+='</div>'+
								  '</div></td></tr>';
				                   $("#classdetails").append(dom);
						}
						$('.addclick1.btnfirst.circular.ui.blue.basic.icon.wpj_stus.button').popup();
						$('.addclick1.btnfirst.circular.ui.blue.basic.icon.wpj_stus.button').bind('click',function(){
							var class_no=$(this).attr('class_no');
							var task_no=$(this).attr('task_no');
		                    $("#wpjstusdetails").html('')
							wpjstusinfo(class_no,task_no);
						});
						$('.ui.blue.inverted.progress').progress({
							showActivity:false
				});
						$('.ui.long.modal')
						.modal({
							transition:'slide down',
							observeChanges:true,
							closable: false
						  })
						.modal('show');
					}
				}
		 });
	 };
	 function wpjstusinfo(class_no,task_no){
		 $.ajax({
			    url:"do?invoke=view_stu_pj@getwpjstusinfo",
				type:'POST',
				dataType:'json',
				data:{
					class_no:class_no,
					term_no:SYSOBJECT.term_no,
					task_no:task_no
				},
				success:function(rep){
					console.log(rep);
					var data=rep.data;
					var len=data.length;
					for(var i=0;i<len;i++){
						var dom=
							'<tr><td>'+data[i].stu_no+'</td>'+
					        '<td>'+data[i].stu_name+'</td></tr>';
					    $('#wpjstusdetails').append(dom);
					}
				}
		 });
		 $('.ui.short.modal')
			.modal({
				transition:'slide down',
				observeChanges:true,
				closable: false
			  })
			.modal('show');
	 }
});
</script>

<!--这里引用其他JS-->
</html>