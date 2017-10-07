<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp" %>
<!--这里引用其他样式-->
<link rel="stylesheet"  href="script/common/datepicker/jquery.datetimepicker.css"></link>
<script src="script/common/datepicker/jquery.datetimepicker.js"></script>
<script src="qm/js/loadListen.js" type="text/javascript"></script>
<title>校内教学质量监控运行平台</title>
<style>
	.display{
	 color:black;
	}
	.ui.form.attached.fluid.segment{
	border-radius: 10px;
	}
	.ui.attached.segments{
	 margin-bottom:4%;
	}
	.datepropose{
	margin-top:12px;
	}
	#datepropose{
	margin-left:4%;
	
	}
	.ui.selectable.celled.table{

	text-align:center;
	}
	.ui.dropdown.selection{
	 min-width:123%!important;
	}
	#selectfield{
	width:12%!important;
	}
</style>
</head>
<body> 
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container" class="ui container">	
	<h3  class="ui header "> 
	  	<i class="ui  unordered list icon"></i>
	  	管理听课记录
	</h3>
	<div>
		<div class="ui form" id="form">
		<div class="five fields">
		<div class="field">
		<select class="ui dropdown" id="selectbutton">
		</select>
		</div>
		<div class="datepropose" id="datepropose">
		  搜索日期: &nbsp;
		  </div>
		  <div class="field">
          <div class="ui input circulari   " >
			  <input id="date_timepicker_start" type="text" placeholder="起始日期">
			</div>
		 </div>
			 <div class="datepropose">
		  —
		  </div>
			 <div class="field">
			<div class="ui input circulari    " >
			  <input id="date_timepicker_end" type="text" placeholder="终止日期">
			</div>

        </div>
        <div class=" field">
        <div class="ui input circulari  basic icon " data-content="任课教师可为空">
			  <input id="rkjs" type="text" placeholder="任课教师">
			</div>
		</div>
          <div class="field" id="selectfield"> 
		    <div class="ui circulari blue icon button" id="searchbutton">
		    <i class="search icon" ></i>搜索</div>
		</div>
        </div>
</div>
    	<table class="ui very compact blue striped table">
		  <thead>
		    <tr>
		      <th>任课教师</th>
		      <th>课程名称</th>
		      <th>课程类型</th>
		      <th>评分</th>		      
		      <th>听课日期</th>
		      <th>修改评教</th>
		      <th id="scpjjl">删除评教记录</th>
		    </tr> 
		  </thead>
		  <tbody id="tablepane">		    
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
$(function() {
	var term_no = SYSOBJCET.term_no;
	 load();
	    function load(){
	    $.ajax({
			url:"do?invoke=checkteacherlisten@getTermno",
			type:'POST',
			dataType:'json',
			async: false,
			data:{
				term_no:term_no
			},
			success:function(inf) {
				 term=inf.data;
				for( var i=0;i<term.length;i++){
					console.log(term[i].term_name)
				var dom='<option value="'+term[i].term_no+'">'+term[i].term_name+'</option>';    					 
				$("#selectbutton").append(dom)
				}
				$('#selectbutton').dropdown(); 
			}
			});
	    };
		$('#selectbutton').change(function(){
		   term_no=$('#selectbutton').val();
		   if(term_no!=SYSOBJCET.term_no){
			   $('#scpjjl').hide();
		   }else{
			   $('#scpjjl').show();
		   }
		   $("#tablepane").html("");
		   pageindex=1;
			temppage=1
			settable();
			$('#date_timepicker_start').val();
			$('#date_timepicker_end').val();
			loadTermData();
	    });
		loadTermData();
		function loadTermData(){
			 $.ajax({
					url:"do?invoke=marsterLiten@getTermData",
					type:'POST',
					dataType:'json',
					async: false,
					data:{
						term_no:term_no
					},
					success:function(inf) {
						if(inf.result==0 || inf.message=="数据错误"){
							$.alert(inf.message)
						}else{
							var temp = inf.data;
							$('#date_timepicker_start').val(temp[0].term_startdate);
							$('#date_timepicker_end').val(temp[0].term_enddate);
						}
					}
					});
		}
	jQuery('#date_timepicker_start').datetimepicker({
		  format:'Y/m/d',
		  lang:'zh',
		  onShow:function( ct ){
		   this.setOptions({
		    maxDate:0,
		   })
		  },
		  timepicker:false
		 });
	jQuery('#date_timepicker_end').datetimepicker({
		  format:'Y/m/d',
		   maxDate:0,   
		   lang:'zh',
		  onShow:function( ct ){
		   this.setOptions({
		    minDate:$('#date_timepicker_start').val()?jQuery('#date_timepicker_start').val():false
		   })
		  },
		  timepicker:false
		 });
	$('.ui.input.circulari.basic.icon').popup();
	//加载表格数据
	var totalpage;
	var pageindex=1;
	var temppage=1
	settable();
	function settable(){
		$("#spanFirst").attr("temp",'0');
		$("#spanNext").attr("temp",'0');
		$("#spanPre").attr("temp",'0');
		$("#spanLast").attr("temp",'0');
		var pagelength=5;
		$.ajax({
			url:"do?invoke=marsterLiten@getMasterLisInf",
			type:'POST',
			dataType:'json',
			data:{
                  pageindex:pageindex,
                  pageLength:pagelength,
                  master_no:USEROBJECT.userinfo.teacher_no,
                  term_no:term_no,
                  temppage:temppage       
			},
			success:function(rep){
				if(typeof(USEROBJECT.userinfo.teacher_no)=="undefined"){
					$.alert("","未能检测到督学编号")
					return;
				}
				if(rep.result==0 || rep.message=="数据为空"){
					$.alert("",rep.message);
					return;
					}
				if(temppage==1){
					var count=0;
					if(rep.total%pagelength!=0)count=1;
				    totalpage=parseInt(rep.total/5) +count;
					$("#spanLast").attr("page",totalpage);
					$("#spanTotalPage").text(totalpage)
				}
				temppage++;
				renderTable(rep.rows);
			}
			
		});
	}
		//3、绘制表格 
	
	function renderTable(tabledata){
			var temp=tabledata;
		for(var i=0;i<temp.length;i++){
			var dom= 
				'<tr id="tr'+temp[i].task_no+'">';	
					dom+='<td id="teacher_name'+i+'">'+temp[i].teacher_name+'</td>'
					dom+='<td id="course_name'+i+'">'+temp[i].course_name+'</td>';
					dom+='<td id="course_type'+i+'">'+temp[i].course_type+'</td>';
			        dom += '<td>'+																                                                              						     	      		        																																			         
	                 '<div id="listen'+parseInt(temp[i].listen_no)+'">'+
	                     temp[i].total+
	                 '</div>'+ 
                   '</td>';
					dom += '<td>'+																                                                              						     	      		        																																			         
	      		                 '<div id="listen_time'+i+'">'+
	      		                     temp[i].listen_time+
				                 '</div>'+ 
		                       '</td>';       
                   dom += '<td>'+																                                                              						     	      		        																																			         
	                 '<div class="clickbuttton btnfirst circular ui small blue basic icon button" listen_no="'+temp[i].listen_no+'" id="'+temp[i].task_no+'" data-content="点击修改听课评价">'+
	                     '<i class="edit icon"></i>'+
	                 '</div>'+  
                   '</td>';
                   if(term_no==SYSOBJCET.term_no){
                   dom+='<td>'+																                                                              						     	      		        																																			         
	                 '<div class="removebutton btnfirst circular ui small blue basic icon button" task_no="'+temp[i].task_no+'" listen_time="'+temp[i].listen_time+'"  data-content="删除该条记录">'+
                     '<i class="remove icon"></i>'+
                 '</div>'+  
               '</td>';
        		   }
                   $("#tablepane").append(dom);
               
		}
		$("#tablepane").transition("fly left in")
		$(".clickbuttton").unbind('click').bind('click',function(){
			var modal=new loadListen();
			var listen_no=$(this).attr('listen_no')	
			var term_no=SYSOBJECT.term_no 
			modal.showModal(listen_no,term_no);  
			
		})
		$('.removebutton').unbind('click').bind('click',function(){
			var task_no=$(this).attr('task_no')
			var listen_time=$(this).attr('listen_time')
			$.confirm({
				msg       :"您确定删除该条记录么吗？",
				btnSure   : '确定',
				btnCancel : '取消',
				sureDo	  : function(){
					$.ajax({
						url:"do?invoke=marsterLiten@deletemasterlisten",
						type:'POST',
						dataType:'json',
						data:{
			                  task_no:task_no,
			                  master_no:USEROBJECT.userinfo.teacher_no,
			                  listen_time:listen_time       
						},
						success:function(rep){
							$.alert(rep.message, function returntable(){
								location.href=BASE_PATH+'/qm/Master/MasterListen.jsp?module=11&menu=29';
							 });
						}
					});
				},
				cancelDo:function(){
				}
			});
		});
		$('.btnfirst.circular.ui.blue.basic.icon.button').popup();
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

		
	}
	$("#spanFirst").bind("click",function(){
		if(pageindex==1)return;
		if(totalpage>1)
		if($(this).attr('temp')==1)
		{
			$("#tablepane").html("");
		    pageindex=1;
		    searchtable();
		}
		else
		{
			$("#tablepane").html("");
		pageindex=1;
		settable();
		}
	});
	$("#spanLast").bind("click",function(){
		if(pageindex==totalpage)return;
		if(totalpage>1){
		if($(this).attr('temp')==1)
		{
			$("#tablepane").html("");
			pageindex=totalpage;
		    searchtable();
		}
		else
		{
			$("#tablepane").html("");
		pageindex=totalpage;
		settable();
		}
		}
	});
		$("#spanNext").bind("click",function(){
			if(pageindex==totalpage)return;
			if(totalpage>1){
			if($(this).attr('temp')==1)
			{
				$("#tablepane").html("");
				pageindex++;
			    searchtable();
			}
			else
			{
				$("#tablepane").html("");
			pageindex++;
			settable();
			}
		}
		});
		$("#spanPre").bind("click",function(){
			if(pageindex==1)return;
			if(totalpage>1){
			if($(this).attr('temp')==1)
			{
				$("#tablepane").html("");
				pageindex--;
			    searchtable();
			}
			else
			{
				$("#tablepane").html("");
			pageindex--;
			settable();
			}
			}
		});
$("#searchbutton").unbind('click').click(function(){
		//1、获得查询条件
		pageindex=1;
		temppage=1;
		searchtable();
	});
	function searchtable(){
		var param={
			    master_no:USEROBJECT.userinfo.teacher_no,
				teacher_name:$("#rkjs").val(),
				strart_date:$("#date_timepicker_start").val(),
				end_date:$("#date_timepicker_end").val(),
				term_no:term_no,
				pageindex:pageindex,
				pageLength:5,
				temppage:temppage
		};
		
		if( param.teacher_name =="" && param.strart_date==""  && param.end_date==""){
			$("#tablepane").html("");
			settable();
			return ;
		}
		else{
		$.ajax({
			url:"do?invoke=marsterLiten@getMasterSearchLisInf",
			type:'POST',
			dataType:'json',
			data:param,
			success:function(rep){
				if(typeof(param.teacher_name)=="undefined"||typeof(param.strart_date)=="undefined"||typeof(param.end_date)=="undefined"){
					$.alert("","搜索条件传入错误");
					return ;
				}
				if(rep.result == 0) {
					$.alert("",rep.message);
					return ;
				}
				else{
					$("#tablepane").html("");
				if(temppage==1){
					var count=0;
					if(rep.total%5!=0)count=1;
				    totalpage=parseInt(rep.total/5) +count;
					$("#spanLast").attr("page",totalpage);
					$("#spanTotalPage").text(totalpage)
				}
				temppage++;
				renderTable(rep.rows);
				$("#spanFirst").attr("temp",'1');
				$("#spanNext").attr("temp",'1');
				$("#spanPre").attr("temp",'1');
				$("#spanLast").attr("temp",'1');
			    }
			}
		});	
		}
		
	}
	
 });
		

</script>

<!--这里引用其他JS-->
</html>