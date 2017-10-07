<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp" %>
<!--这里引用其他样式-->
<title>校内教学质量监控运行平台</title>


<style>
	.field{
		margin-top:1%;
	}
	.dropclass{
		float:left;
		margin-bottom:1%;
	}
	.secondfiled{
	    margin-left:2%;
	}
</style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container" class="ui container">

    <h3  class="ui header "> 
	  	<i class="ui  unordered list icon"></i>
	  	<div class="content" id="bt">教师评学详情 </div>
	</h3>

	<div id="table">
  </div>
    
    <div class="fields">
		<div class= "field dropclass">
			<select class="ui dropdown" id="dropdown">
			</select>
		</div>
		<div class= "field dropclass secondfiled">
			<select class="ui dropdown" id="classdropdown">
			</select>
		</div>
	</div>
    	<table class="ui compact blue table">
		  <thead>
		    <tr>
		      <th>班级名称</th>
		      <th>任课教师</th>
		      <th>评分课程</th>
		      <th>评分</th>
		      <th>评学时间</th>
		    </tr>
		  </thead>
		  <tbody id="classinformation">
		  </tbody>
		</table>
	</div>
	<!--这里绘制页面-->
</body>
<script>
$(function(){
	var class_no="";
	loadclass();
    //读取所有的学期信息放入下拉框
    function loadterm(){
    	$.ajax({
			url:"do?invoke=classcheckpx@gettermnoinformation",
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
				loadtable();
			}
    	});
    }
   
    
    //读取创建表格所需的数据
    function loadclass(){
    	if(USEROBJECT.usertype!='学生'){
    		$.ajax({
    			url:"do?invoke=classcheckpx@getteaclass",
    			type:'POST',
    			dataType:'json',
    			data:{
    				teacher_no:USEROBJECT.loginname
    			},
    			success:function(message){
    				if(message.result==0){
    					if(message.message=='数据为空'){
    						$('#container').empty();
    						var dom='<div class="ui green large message">'+
							'<i class="frown large inverted yellow circular icon"></i> 抱歉！您不是班主任或信息员，不能使用此功能！'+
						'</div>';
    						$('#container').append(dom);
    					}else
    					$.alert("",message.message);
    					}
    					else{
    						temp=message.data
    						class_no=temp[0].class_no
    						for(var i=0;i<temp.length;i++){
    							var dom= ' <option value="'+temp[i].class_no+'">'+temp[i].class_name+'</option>';
    							$("#classdropdown").append(dom)
    						}
    						$("#classdropdown").change(function(){
    						    class_no=$("#classdropdown").val();
    							$("#classinformation").html("");
    							loadtable();
    						});
    						loadterm();
    					}
    			}
    		});
    }else{
    	$('#classdropdown').hide();
    	$.ajax({
			url:"do?invoke=classcheckpx@getstuclass",
			type:'POST',
			dataType:'json',
			data:{
				stu_no:USEROBJECT.loginname
			},
			success:function(message){
				temp=message.data
				class_no=temp[0].class_no
				loadterm();
			}
		});
    }
    }
    function loadtable(){
    	$.ajax({
			url:"do?invoke=classcheckpx@gettableinformation",
			type:'POST',
			dataType:'json',
			data:{
				term_no:SYSOBJECT.term_no,
				class_no:class_no
			},
			success:function(message){
				if(message.result==0){
				$.alert("",message.message);
				return;
				}
				else{
					console.log(message.data)
					createtable(message.data);
				}
			}
    	}); 
    };
    //建造表格
    function createtable(a){
    	$("#classinformation").html("");
    	var temp=a;
		for(var i=0;i<temp.length;i++){
			var dom= 
				'<tr>';	
					dom += '<td >'+																                                                              						     	      		        																																			         
	      		                 '<div>'+
	      		                     temp[i].class_name+
				                 '</div>'+ 
		                       '</td>';       
					dom+='<td>'+temp[i].teacher_name+'</td>';
					dom+='<td>'+temp[i].course_name+'</td>';
					if(temp[i].px_time==""){
					dom+='<td>尚未评学</td>';
					dom+='<td>尚未评学</td>';
					}else{
					dom+='<td>'+temp[i].total+'</td>';
					dom+='<td>'+temp[i].px_time+'</td>';
					}
                   $("#classinformation").append(dom);
		} 
    };

});

</script>

<!--这里引用其他JS-->
</html>