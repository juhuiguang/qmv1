<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp" %>
<!--这里引用其他样式-->
<title>校内教学质量监控运行平台</title>


<style>
.display{
	 color:black;
	 pointer-events:none;
	color:#afafaf;
	cursor:default
	}
.marginField{
    margin-top:1%
}
</style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container" class="ui container">	
<h3  class="ui header "> 
	  	<i class="ui  unordered list icon"></i>
	  	<div class="content" id="bt">未评学教师表 </div>
	</h3>
	<div id="srchpnl">
    </div>
		<div class= "field marginField">
		<select class="ui mini dropdown" id="dropdown">
			</select>
		    <div class="ui small circular input" >
			  <input type="text" placeholder="搜索教师姓名..." id="searchclass" >
		    <div class="ui small blue button " id="searchbutton" >
		    <i  class="search icon" ></i>搜索</div>
			</div>
			</div>
    	<table class="ui striped blue very compact table" id="pjtable">
		  <thead>
		    <tr class=" aligned">
		      <th>所属部门</th>
		      <th>教师名称</th>
		      <th>课程名称</th>
		      <th>教授班级</th>
		    </tr>
		  </thead>
		  <tbody id="classinformation">
		  </tbody>
		</table>
     <center>
		<div id="spanbutton">			
			<div class="ui  horizontal divided list">  
			  <div class="item">
			    <a  id="spanFirst" page="1">第一页</a> 
			  </div>
			  <div class="item">  
			    <a  id="spanPre" page="1">上一页</a> 
			  </div>
			  <div class="item">
			    <a  id="spanNext" page="2">下一页</a>
			  </div>
			   <div class="item">
			   <a  id="spanLast">最后一页</a> 
			  </div>  
			   <div class="item">
			   第<span id="spanPageNum"></span>页 /共<span id="spanTotalPage"></span>页
			  </div>
			   
			</div> 
			</div>
		 </center>   
	</div>
	<!--这里绘制页面-->
</body>
<script>
$(function(){
	var departments=SYSOBJECT.departments;
	console.log(USEROBJECT)
	var dep_name = null;
	var dep_no = null;
	var pageindex = 1;
	var pagelength = 20;
	var totaltemp = 1;
	 var totalpage =0;
	 if(USEROBJECT.userpurview=="ALL"){
		dep_no=departments[0].dep_no
		dep_name=departments[0].dep_name
	for(var i=0;i<departments.length;i++){
		if(departments[i].dep_name=="外语系"){
			
		}else{
		var dep=$("<div class='ui gary label srchdep' dep_no='"+departments[i].dep_no+"'>"+departments[i].dep_name+"</div>");
		$("#srchpnl").append(dep);
		}
	}
	 }else{
		 $('#srchpnl').hide();
		 dep_no=USEROBJECT.userinfo.dep_no
		 dep_name=USEROBJECT.userinfo.dep_name
	 }
	 $('.srchdep').eq(0).addClass("blue");
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
	    	 pageindex = 1;
			 totaltemp =1;
			 loadtable();
	    });
	 $('#searchbutton').unbind('click').bind('click',function(){
		 pageindex = 1;
		 totaltemp =1;
		 searchtable();
	 });
	 function searchtable(){
		var teacher_name= $('#searchclass').val();
		if(teacher_name==""){
			 $("#classinformation").html("");
			 pageindex = 1;
			 totaltemp =1;
			 loadtable();
		}
			
			else{
				 $("#classinformation").html("");
				 $("#spanFirst").attr("temp",'1');
					$("#spanNext").attr("temp",'1');
					$("#spanPre").attr("temp",'1');
					$("#spanLast").attr("temp",'1');
				$.ajax({
					url:"do?invoke=ViewTeaPx@getTableInfo",
					type:'POST',
					dataType:'json',
					data:{
						
						teacher_name:teacher_name,
						dep_no:dep_no,
						term_no:SYSOBJECT.term_no,
						pageindex:pageindex,
						pagelength:pagelength,
						totaltemp:totaltemp,
					},
					success:function(rep){
						if(rep.result==0){
							if(rep.message=='数据为空')
								$.alert("没有相关教师信息");
							else
						    $.alert("",rep.message);
						}
						else{
							
							var temp=rep.data
							$('#classinformation').html('');
							if(totaltemp==1){
							for(var i=0;i<temp.length-1;i++){     
								var dom= '<tr class="center aligned"><td >'+dep_name+'</td>'+  
					            '<td>'+temp[i].teacher_name+'</td>'+
					            '<td>'+temp[i].course_name+'</td>'+      
					            '<td>'+temp[i].class_name+'</td>'+
			                   '</td></tr>';
			                   $("#classinformation").append(dom);
							}
								var count=0;
								console.log(temp[temp.length-1].total)
								if(((temp[temp.length-1].total)%pagelength)!=0)count=1;
								console.log(parseInt((temp[temp.length-1].total)/pagelength))
							   totalpage=parseInt(temp[temp.length-1].total/pagelength) +count;
							   console.log(totalpage)
								$("#spanLast").attr("page",totalpage);
								$('#spanPageNum').text(pageindex);
								$("#spanTotalPage").text(totalpage)
							totaltemp++;
							}else{
								console.log(temp)
								for(var i=0;i<temp.length;i++){
									var dom= '<tr class="center aligned"><td >'+dep_name+'</td>'+  
						            '<td>'+temp[i].teacher_name+'</td>'+
						            '<td>'+temp[i].course_name+'</td>'+
						            '<td>'+temp[i].class_name+'</td>'+
				                   '</td></tr>';      
				                   $("#classinformation").append(dom);
								}
							}
						}
						changepage();
					}
				});
				
			}
	 };
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
						 pageindex = 1;
						 totaltemp =1;
						loadtable();
						
					});
				}
	    	});
	    };
	    loadtable();
	 function loadtable(){
		 $("#classinformation").html("");
		 $("#spanFirst").attr("temp",'0');
			$("#spanNext").attr("temp",'0');
			$("#spanPre").attr("temp",'0');
			$("#spanLast").attr("temp",'0');
		 $.ajax({
				url:"do?invoke=ViewTeaPx@getTableInfo",
				type:'POST',
				dataType:'json',
				data:{
					dep_no:dep_no,
					term_no:SYSOBJECT.term_no,
					pageindex:pageindex,
					pagelength:pagelength,
					totaltemp:totaltemp,
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
						var temp=rep.data
						$('#classinformation').html('');
						if(totaltemp==1){
						for(var i=0;i<temp.length-1;i++){
							var dom= '<tr class=" aligned"><td >'+dep_name+'</td>'+  
						            '<td>'+temp[i].teacher_name+'</td>'+
						            '<td>'+temp[i].course_name+'</td>'+
						            '<td>'+temp[i].class_name+'</td>'+
				                   '</td></tr>';
				                   $("#classinformation").append(dom);

						}
							var count=0;
							if(((temp[temp.length-1].total)%pagelength)!=0)count=1;
						   totalpage=parseInt(temp[temp.length-1].total%pagelength) +count;
							$("#spanLast").attr("page",totalpage);
							$('#spanPageNum').text(pageindex);
							$("#spanTotalPage").text(totalpage)
						totaltemp++;
						}else{
							for(var i=0;i<temp.length;i++){
								var dom= '<tr class=" aligned"><td >'+dep_name+'</td>'+  
							            '<td>'+temp[i].teacher_name+'</td>'+
							            '<td>'+temp[i].course_name+'</td>'+
							            '<td>'+temp[i].class_name+'</td>'+
					                   '</td></tr>';
					                   $("#classinformation").append(dom);

							}
						}
					}
					changepage();
				}
		 });
	 };
	 function changepage(){
		 if(totalpage==0)
			  $("#spanPageNum").text(0);
			else
				$("#spanPageNum").text(pageindex);
			//判断按钮是否禁用 
			if(pageindex==1 ||totalpage==0)
				{
				    $("#spanPre").removeAttr("href"); 
				    $("#spanPre").addClass("display")
				}
			if(totalpage>1){
			if(pageindex==2 ||pageindex==totalpage)
			{
				if(typeof($("#spanPre").attr("href"))=="undefined"){
			    $("#spanPre").attr("href","javascript:void(0);");
			    $("#spanPre").removeClass("display")
				}
			}
			}
			if(pageindex==1 ||totalpage==0)
			{
			    $("#spanFirst").removeAttr("href");
			    $("#spanFirst").addClass("display")
			}
			if(totalpage>1){
				if(pageindex==2 ||pageindex==totalpage) 
				{
					if(typeof($("#spanFirst").attr("href"))=="undefined"){
				    $("#spanFirst").attr("href","javascript:void(0);");
				    $("#spanFirst").removeClass("display")
					}
				}
			}
			if(pageindex==totalpage ||totalpage==0)
			{
			    $("#spanNext").removeAttr("href");
			    $("#spanNext").addClass("display")
			} 
		  if(totalpage>1){
				if(pageindex==totalpage-1 ||pageindex==1)
				{
					if(typeof($("#spanNext").attr("href"))=="undefined"){ 
				    $("#spanNext").attr("href","javascript:void(0);");
				    $("#spanNext").removeClass("display")
					}
				}
			}
		if(pageindex==totalpage ||totalpage==0)
		{
		    $("#spanLast").removeAttr("href");
		    $("#spanLast").addClass("display")
		}
		if(totalpage>1){
			if(pageindex==totalpage-1 ||pageindex==1)
			{
				if(typeof($("#spanLastt").attr("href"))=="undefined"){
				    $("#spanLast").attr("href","javascript:void(0);");
				    $("#spanLast").removeClass("display")
				}
			}
		}               

			
		
		$("#spanFirst").unbind('click').bind("click",function(){
			if(pageindex==1)return;
			if(totalpage>1)
			if($(this).attr('temp')==1)
			{
			    pageindex=1;
			    searchtable();
			}
			else
			{
			pageindex=1;
			loadtable();
			}
		});
		$("#spanLast").unbind('click').bind("click",function(){
			if(pageindex==totalpage)return;
			if(totalpage>1){
			if($(this).attr('temp')==1)
			{
				pageindex=totalpage;
			    searchtable();
			}
			else
			{
			pageindex=totalpage;
			loadtable();
			}
			}
		});
			$("#spanNext").unbind('click').bind("click",function(){
				if(pageindex==totalpage)return;
				if(totalpage>1){
				if($(this).attr('temp')==1)
				{
					pageindex++;
				    searchtable();
				}
				else
				{
					pageindex++;
					loadtable();
				}
			}
			});
			$("#spanPre").unbind('click').bind("click",function(){
				if(pageindex==1)return;
				if(totalpage>1){
				if($(this).attr('temp')==1)
				{
					pageindex--;
				    searchtable();
				}
				else
				{
				pageindex--;
				loadtable();
				}
				}
			});
	 }

});
</script>

<!--这里引用其他JS-->
</html>