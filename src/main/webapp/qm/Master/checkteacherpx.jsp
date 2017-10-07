<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp" %>
<!--这里引用其他样式-->
<title>校内教学质量监控运行平台</title>


<style>
#top2{
margin-top:20px
}

.field{
margin-top:2%;
}
.ui.dropdown{
float:left
}
 .ui.small.circular.input{
 margin-left:1%
 }
 .ui.blue.table{
margin-top:2%
} 
.ui.mini.blue.celled.table{
	text-align:center;
}
#table .label{
	margin-top:5px;
}
#temptable{
text-align:center;
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
    
    
		<div class= "field">
		<select class="ui small dropdown" id="dropdown">
			</select>
		    <div class="ui small circular input" >
			  <input type="text" placeholder="搜索班级..." id="searchlocalteacher" >
		    <div class="ui small blue button " id="searchbutton" >
		    <i  class="search icon" ></i>搜索</div>
			</div>
			</div>
    	<table class="ui  very compact striped blue  table" id="temptable">
		  <thead>
		    <tr>
		      <th>班级名称</th>
		      <th>班级均分</th>
		      <th>查看详情</th>
		    </tr>
		  </thead>
		  <tbody id="classinformation">
		  </tbody>
		</table>
     
		  <div class="ui long modal">
		  <i class="close icon"></i>
		  <div class="ui header">
		        评学详情
		  </div>
		  <div class="content">		  	
				<table class="ui very compact blue celled table">
				  <thead>
				    <tr>
				      <th>班级名称</th>
				      <th>评学教师</th>
				      <th>所带课程</th>
				      <th>评分</th>
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
	</div>
	<!--这里绘制页面-->
</body>
<script>
$(function(){
	var dep_no=null;
	$("#closebutton").click(function(){
		$('.ui.long.modal')
		.modal({
		    transition:'fly down',
	     })
		.modal('hide');
	});
	loadbutton();
    //点击改变部门时
    function loadbutton(){
    if(USEROBJECT.userpurview=="ALL"){
    	var departments=SYSOBJECT.departments;
    	dep_no=departments[0].dep_no
    	for(var i=0;i<departments.length;i++){
    		if(departments[i].dep_name=="外语系"){
    			
    		}else{
				if(departments[i].dep_type!="行政") {
    		var dep=$("<div class='ui label srchdep' dep_no='"+departments[i].dep_no+"'>"+departments[i].dep_name+"</div>");
    		$("#table").append(dep);
				}
    		}
    	}
    	$(".srchdep:first-child").addClass('blue');
    	$(".srchdep").hover(function(){
    		$(this).css("cursor","pointer");
    	});
    	 
    }
    	else{
    		dep_no=USEROBJECT.userinfo.dep_no
    	}
    $("#table .srchdep").bind("click",function(){
    	$("#table .srchdep.blue").removeClass("blue");
    	$(this).addClass("blue");
    	if(dep_no==$(this).attr("dep_no")){
    		return ;
    	}
    	 $("#classinformation").html("");
    	 dep_no=$(this).attr("dep_no");
    	 loadtable();
    });
    };
    loadterm();
    //读取所有的学期信息放入下拉框
    function loadterm(){
    	$.ajax({
			url:"do?invoke=checkteacherpx@gettermnoinformation",
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
    function loadtable(){
    	$.ajax({
			url:"do?invoke=checkteacherpx@gettableinformation",
			type:'POST',
			dataType:'json',
			data:{
				term_no:SYSOBJECT.term_no,
				dep_no:dep_no
			},
			success:function(message){
				if(message.result==0){
					if(message.message=="数据为空")
						 $.alert("","没有符合的班级数据");
					else
				   $.alert("",message.message);
				
				}
				else{
					createtable(message.data);
				}
			}
    	}); 
    };
    //搜索功能
    $("#searchbutton").bind("click",function(){
    	if($("#searchlocalteacher").val()==""){
    		$("#classinformation").html('')
    		loadtable()
    		
    	}else{
    		var class_name=$("#searchlocalteacher").val()
    		$("#classinformation").html("")
    		$.ajax({
    			url:"do?invoke=checkteacherpx@getdetailclassinformation",
    			type:'POST',
    			dataType:'json',
    			data:{
    				term_no:SYSOBJECT.term_no,
    				class_name:class_name,
    				dep_no:dep_no,
    			},
    			success:function(message){
    				if(message.result==0){
    				if(message.message=="数据为空"){
    					$.alert("","没有符合的班级数据")
    				}else{
    				$.alert("",message.message);
    				}
    				}
    				else{
    					createtable(message.data);
    				}
    			}
        	});
    	}
    })
    //建造表格
    function createtable(a){
    	var temp=a;
		for(var i=0;i<temp.length;i++){
			var dom= 
				'<tr>';	     
					dom+='<td>'+temp[i].class_name+'</td>';
					if(temp[i].avgmark==""){
					dom+='<td>尚未被评学</td>';
					}else{
					dom+='<td>'+temp[i].avgmark+'</td>';
					}
                   dom += '<td>'+																                                                              						     	      		        																																			         
	                 '<div class="addclick btnfirst circular ui mini blue basic icon button"  class_no="'+temp[i].class_no+'" data-content="查看详细评学信息">'+
	                     '<i class="plus icon"></i>'+
	                 '</div>'+ 
                   '</td>';
                   $("#classinformation").append(dom);
		}
		  $('.circular.ui.blue.basic.icon.button').popup();
		  $("#temptable").transition("fly left in")
		  $('.circular.ui.blue.basic.icon.button').click(function(){
			  var class_no=$(this).attr('class_no');
			  $.ajax({
					url:"do?invoke=checkteacherpx@getclassdetailinformation",
					type:'POST',
					dataType:'json',
					data:{
						term_no:SYSOBJECT.term_no,
						class_no:class_no
					},
					success:function(rep){
						if(rep.result==0){
						$.alert("",rep.message);
						return;
						}
						else{
							$("#classdetails").html("")
							var temp1=rep.data;
							for(var i=0;i<temp1.length;i++){
								var deom= 
									'<tr id="trtable2'+i+'">';	
										deom += '<td >'+																                                                              						     	      		        																																			         
						      		                 '<div>'+
						      		                     temp1[i].class_name+
									                 '</div>'+ 
							                       '</td>';       
										deom+='<td>'+temp1[i].teacher_name+'</td>';
										deom+='<td>'+temp1[i].course_name+'</td>';
										if(temp1[i].total==""){
											deom+='<td class="negative">尚未评学</td>';
										}else{
										deom+='<td class="positive">'+temp1[i].total+'</td>';
										}
					                   $("#classdetails").append(deom);
							}
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
		  });
    };

});

</script>

<!--这里引用其他JS-->
</html>