<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>

<!--这里引用其他样式-->
<title></title>
<style>
	#teaname .label{
		margin-top:10px;
		margin-left:10px;
	}
	#teaname .tips{
		font-weight:normal;
		font-size:80%;
		color:#898989;
	}
	#teaname .depselect{
		font-weight:normal;
		font-size:100%;
		color:#333;
	}
	#depselect { 
		border: white;
	}
</style>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
			<h3  class="ui header "> 
		  			<i class="unordered list icon"></i>
		  			<div class="content">
		  				我关注的教师
		  			</div>
			</h3>
		
		<select class="ui mini dropdown" id="termdropdown">
		</select>
		
		<div class="ui  labels" id="teaname">
	  		<div class="ui segment marked">
	  			<div class="ui header">
	  				已关注的教师：
	  				<span class="tips">点选教师名称取消关注。</span>
	  					  				
	  			</div>
	  			
	  		</div>
	  		<div class="ui segment unmark">
	  			<div class="ui header">
	  				未关注的教师：
	  				<span class="depselect">
	  					<div class="ui mini selection dropdown" id="depselect"> 
						  <div class="text">选择部门</div> 
						  <i class="dropdown icon"></i>
						  <div class="menu">
						    						    
						  </div>
						</div>
	  				</span>
	  				<span class="tips">
	  					点选教师名称添加关注。
	  					
	  				</span>
	  			</div>
	  			
	  		</div>
		 </div>
	</div>

	<!--这里绘制页面-->
</body>
<script>
	$(function() {
		var termno=SYSOBJECT.term_no;
		var dqdepno="";
		var depi="";
		AllDeps();
		function AllDeps() {
			$.ajax({
				url:"do?invoke=supervisorMarkAdd@getAllDeps",
				type:'POST',
				dataType:'json',
				success:function(rep) {
					if(rep.result == 0) {  
						$.alert("很抱歉，没有取到院系相关信息！");
						return;
					} else {
						var departments = rep.data;
						renderDepSelect(departments, rep.data.length);	
					}
				}
			});
		}         
		
		function renderDepSelect(departments,length){
			console.log(USEROBJECT.userinfo.dep_no);  
			for(var i=0;i<length;i++){
				var dom=$('<div class="item" id="dep_'+departments[i].dep_no+'" data-value="'+departments[i].dep_no+'"> '+departments[i].dep_name+'</div>');
				if(USEROBJECT.userpurview=="ALL"){
		 			if(USEROBJECT.userinfo.dep_no == departments[i].dep_no) {
		 				depi = i;
		 			} else if(i == length){ 
		 				depi = 0;
		 			}   
					$("#depselect .menu").append(dom);
				}else{					
					if(departments[i].dep_no==USEROBJECT.userpurview){
						depi = i;
						$("#depselect .menu").append($('<div class="item" id="dep_'+departments[i].dep_no+'" data-value="'+departments[i].dep_no+'"> '+departments[i].dep_name+'</div>'));
					}
				}
			}
			console.log(depi);    
			$('#depselect').dropdown({
				maxSelections: 5,
				onChange:function(value,text){ 
					dqdepno=value;
					getTeachers(dqdepno);
				}
		//	
			}).dropdown("set selected",departments[depi].dep_no);
		}
		
		getMarked();
		
		//获取我关注的教师
		function getMarked(){         
			$('.ui.segment.marked').empty();       
			var tep = 
				'<div class="ui header">'+
	  				'已关注的教师：'+
	  				'<span class="tips">点选教师名称取消关注。</span>'+
	  					  				
	  			'</div>';
	  			$('.ui.segment.marked').append($(tep));               
			$.ajax({
				url:"do?invoke=supervisorMarkAdd@getMyMarked",
				type:'POST',
				dataType:'json',
				data:{
					supno:USEROBJECT.loginname,
					termno:termno
				},
				success:function(rep){
					console.log(rep); 
					if(rep.result>0){
						renderTeachers("marked",rep.data);
					} else {
						$('.ui.segment.marked').empty();      
						var tep = 
							'<div class="ui header">'+
				  				'已关注的教师：'+
				  				'<span class="tips">点选教师名称取消关注。</span>'+
				  					  				
				  			'</div>';
				  		$('.ui.segment.marked').append($(tep));       
					}
				}
			});
		}
		
		function getTeachers(depno){
			$.ajax({
				url:"do?invoke=supervisorMarkAdd@getTeachers",
				type:'POST',
				dataType:'json',
				data:{
					supno:USEROBJECT.loginname,
					depno:depno,
					termno:termno
				},
				success:function(rep){
					if(rep.result>0){
						renderTeachers("unmark",rep.data);
					}else{
						$("#teaname .unmark").find(".label").remove();
						
					}
				}
			});
		}   
		
		//渲染教师名称
		function renderTeachers(type,teachers){
			var target=null;
			if(type=="marked"){
				target=$("#teaname .marked");
				
			}else{        
				target=$("#teaname .unmark");
				target.find(".label").remove();
			}
			for(var i=0;i<teachers.length;i++){
				var cls="five";
				if(type=="marked"){
					cls="six blue";
				}
				var dom ='<a class="'+cls+' ui large label" id="'+teachers[i].teacher_no+'">'+ teachers[i].teacher_name +'</a>';		
				target.append($(dom));
			}
			bindDblclick();
		}
		
		
		function bindDblclick(){
			$('.six').unbind("dblclick").dblclick(function(){
				moveTeacher(this.id);
			});
			
			//添加关注  
			$('.five').unbind("dblclick").dblclick(function(){
				moveTeacher(this.id);
			});
		}
		
		
		//将教师从关注与未关注之间移动
		function moveTeacher(teacher_no){
			var teacherdom=$("#"+teacher_no);
			var container=teacherdom.parent();
			var target=null;
			var type="add";
			//如果在已关注中
			if(container.hasClass("marked")){
				target=$("#teaname .unmark");  
				if(teacherdom.hasClass("blue")){
					teacherdom.removeClass("blue");
				}       

				type="del";
				ChangeAddTea(teacher_no,type,target,teacherdom);  
			}else{ //如果在未关注中
				target=$("#teaname .marked");
				if(!teacherdom.hasClass("blue")){
					teacherdom.addClass("blue");
				}
				ChangeAddTea(teacher_no,type,target,teacherdom);
			}

			bindDblclick();   
		}
		
		function ChangeAddTea(teacher_no,type,target,teacherdom) {  
			$.ajax({
				url:"do?invoke=supervisorMarkAdd@getSupMarkAdd",
				type:'POST',
				dataType:'json',
				data:{
					supno:USEROBJECT.loginname,
					teano:teacher_no,
					termno:termno,
					type:type
				},
				success:function(rep) {
					if(rep.result>0){
						teacherdom.transition("fade left out",300,function(){
							target.append(teacherdom);
							teacherdom.transition("fly up in",500);
						});      
					}

				}
			});
			bindDblclick();
		}
		
		downAllTerm();
	     function downAllTerm(){
	    	$.ajax({
				url:"do?invoke=supervisorMarkAdd@getAllTerm",
				type:'POST',
				dataType:'json',
				success:function(rep){
					if(rep.result==0){
						$.alert("",rep.message);
						return;
					} else {
						var temp=rep.data;
						for(var i=0;i<temp.length;i++){
							var dom= '<option value="'+temp[i].term_no+'">'+temp[i].term_name+'</option>';
							$("#termdropdown").prepend(dom);
						}
						$("#termdropdown").dropdown();
					}
					$("#termdropdown").change(function(){
						termno=$("#termdropdown").val();
						console.log(termno);   
						getMarked();   
						getTeachers(dqdepno);			
					});
				}
	    	});
	    }
		
	});
</script>
<!--这里引用其他JS-->
</html>